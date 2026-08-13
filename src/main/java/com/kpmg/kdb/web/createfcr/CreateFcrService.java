package com.kpmg.kdb.web.createfcr;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.createfcr.dto.BomAvailability;
import com.kpmg.kdb.web.createfcr.dto.BomLeafRow;
import com.kpmg.kdb.web.createfcr.dto.DomesticSalesLine;
import com.kpmg.kdb.web.createfcr.dto.ExportSalesLine;
import com.kpmg.kdb.web.createfcr.dto.FcrDtlInsertRow;
import com.kpmg.kdb.web.createfcr.dto.FcrMstInsertRow;
import com.kpmg.kdb.web.createfcr.dto.FtaMasterActive;
import com.kpmg.kdb.web.createfcr.dto.ProductFcrDtlSourceRow;
import com.kpmg.kdb.web.createfcr.dto.SalesDtlBomTarget;
import com.kpmg.kdb.web.createfcr.dto.SalesInvoiceHeader;
import com.kpmg.kdb.web.originbasis.HsCodeService;
import com.kpmg.kdb.web.originbasis.IncotermsRateService;
import com.kpmg.kdb.web.originbasis.ItemOriginRateService;
import com.kpmg.kdb.web.originbasis.ItemPriceService;
import com.kpmg.kdb.web.originbasis.dto.HsCodeCriteria;
import com.kpmg.kdb.web.originbasis.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.originbasis.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.originbasis.dto.OriginRatePrecheck;
import com.kpmg.kdb.web.originbasis.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.originbasis.dto.PurchaseLedgerSummary;
import com.kpmg.kdb.web.origindecision.FcrCreator;

/**
 * 레거시 CREATE_FCR(P_COMPANY_CODE, P_DIVISION_CODE, P_SALES_NO, P_BOM_TYPE, P_ERR_CODE) 프로시저 이관.
 *
 * 원본은 FS03_GET_HS_CODE / GET_INCOTERMS_CHANGE_RATE / FC10_GET_ITEM_PRICE / FC10_GET_ITEM_ORIGIN_RATE
 * / FC10_GET_ITEM_PRICE_NOTE 를 대량 INSERT...SELECT 문 안에서 행마다 스칼라 함수로 호출했다. Java
 * 이관에서는 이 함수들이 이미 Layer3 서비스({@link HsCodeService} 등)로 옮겨져 있으므로, SQL 은
 * 순수 집합 연산(조인/집계)만 담당하고 함수 호출이 필요한 부분은 Java 스트림에서 처리한다.
 *
 * <p>이 클래스는 FCR_MST/FCR_DTL 데이터 생성까지만 담당한다. 원본에서 CREATE_FCR 안에 있던 상품
 * (PRODUCT_ASSETS_TYPE IN ('M','R','B')) 원산지 판정(과거 3-5/3-6 단계)은 판정 관련 로직을 한 곳에
 * 모으기 위해 {@link com.kpmg.kdb.web.coodecision.OriginDeterminationService#determineOrigin} 으로
 * 옮겼다 — 제품(P,H) 판정(PKG99_COO_DECISION.COO_DECISION)과 상품 판정이 이제 그 메서드 하나에서
 * 함께 처리된다.
 *
 * <p>같은 (회사/사업부/품목/FTA/기준일) 조합이 BOM 전개 과정에서 여러 행에 반복 등장하는 경우가 흔해
 * (동일 원자재가 여러 완제품 BOM 에 공통으로 쓰임) {@link #createFcr} 호출 1건 동안만 유효한 로컬
 * 메모이제이션 맵을 사용해 반복 DB 호출을 제거한다. Spring 전역 캐시(@Cacheable)를 쓰지 않는 이유는
 * 이 조회들이 대량 배치에서 카디널리티가 매우 높아 전역 캐시로 두면 힙이 계속 쌓이기 때문이다
 * (originbasis 5개 서비스에서 이미 @Cacheable 을 제거한 것과 같은 이유) — 이 로컬 맵은 메서드
 * 종료와 함께 GC 되므로 그 문제가 없다.
 *
 * <p>대용량 대응: BOM 리프 자재/FCR_MST 후보(내수는 SALES×FTA_MASTER 교차곱) 등은 한 매출건 내에서
 * 처리 가능한 크기로 자연히 제한되므로 전체를 리스트로 들고 있어도 안전하지만, INSERT 는 청크
 * 단위({@link #INSERT_CHUNK_SIZE})로 나눠 한 번에 다건을 저장해 라운드트립을 최소화한다.
 *
 * <p><b>원본과 동일하게 이 메서드는 예외를 흡수하지 않는다.</b> CREATE_FCR 원본 프로시저에는 최상위
 * EXCEPTION 블록이 없어 DB 오류가 호출자(MONTHLY_DECISION_PROC)까지 그대로 전파된다 — COO_DECISION
 * 과 다른 부분이니 유의(그쪽은 자체적으로 예외를 흡수한다). 매출 1건 처리 실패를 배치 전체 중단 없이
 * 넘기는 책임은 호출자(MonthlyDecisionService)에 있다.
 */
@Service
public class CreateFcrService extends GeneralService implements FcrCreator {

	private static final int INSERT_CHUNK_SIZE = 500;
	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	@Autowired
	private HsCodeService hsCodeService;
	@Autowired
	private IncotermsRateService incotermsRateService;
	@Autowired
	private ItemPriceService itemPriceService;
	@Autowired
	private ItemOriginRateService itemOriginRateService;

	/**
	 * @param productCodes 판정 대상 제품 코드 목록. null/빈 리스트면 salesNo 의 전체 제품(월 판정),
	 *                      값이 있으면 그 제품들만(개별 판정) 대상으로 한다. 예전에는 호출 전 SALES_DTL.
	 *                      DECISION_YN='Y' 를 세팅해두는 방식으로 이 스코프를 전달했는데, 이 스코프를
	 *                      메서드 파라미터로 직접 받도록 바꿔 그 마킹-조회 2단계 과정 자체를 없앴다
	 *                      (DECISION_YN 값을 다른 화면/리포트가 읽지 않는 것을 확인함).
	 * @return 원본 P_ERR_CODE 와 동일한 상태 문자열: "successed" / "semisuccess" / "failed"
	 */
	@Override
	public String createFcr(String companyCode, String divisionCode, String salesNo, String bomTypeParam,
			List<String> productCodes) {
		CreateFcrDao dao = sqlSession.getMapper(CreateFcrDao.class);

		// 1. 파라미터 셋업 작업
		SalesInvoiceHeader header = dao.selectSalesInvoiceHeader(companyCode, divisionCode, salesNo);
		String exportFlag = header.getExportFlag();
		String invoiceDate = header.getInvoiceDate();
		String yyyymm = invoiceDate.substring(0, 6);
		String bomPreviousYyyymm = minusMonthsYyyymm(invoiceDate, 60);
		String virtualYn = header.getVirtualYn();

		String bomType;
		if ("X".equals(bomTypeParam)) {
			long mfCnt = dao.countIntermediateApplyFcrMst(companyCode, divisionCode, salesNo);
			bomType = mfCnt > 0 ? "MF" : "F";
		} else {
			bomType = bomTypeParam;
		}

		// 2. 실적 BOM 및 표준 BOM 확인 작업
		int errCnt = checkBomAvailability(dao, companyCode, divisionCode, salesNo, bomType, bomPreviousYyyymm, yyyymm,
				productCodes);

		// 3. FCR 생성 작업 (BOM 오류가 없거나, 포괄건이면 오류가 있어도 진행)
		if (errCnt != 0 && !"Y".equals(virtualYn)) {
			return "failed";
		}

		dao.deleteFcrDtl(salesNo, divisionCode, companyCode, productCodes);
		dao.deleteFcrResult(salesNo, divisionCode, companyCode, productCodes);
		dao.deleteFcrMst(salesNo, divisionCode, companyCode, productCodes);

		Map<String, String> hsCodeCache = new LinkedHashMap<>();
		Map<String, BigDecimal> incotermsCache = new LinkedHashMap<>();

		if ("D".equals(exportFlag)) {
			createDomesticFcrMst(dao, companyCode, divisionCode, salesNo, bomType, invoiceDate, productCodes,
					hsCodeCache, incotermsCache);
		} else {
			createExportFcrMst(dao, companyCode, divisionCode, salesNo, bomType, invoiceDate, productCodes,
					hsCodeCache, incotermsCache);
		}

		// 3-3(BOM 리프 자재)/3-4(상품·부산물) 두 단계가 각자 따로 selectNonCertifiedOriginSummary/
		// selectLastInputYyyyMm 를 선조회하던 것을(createFcr() 1회당 최대 2회 배치조회) 대상 행을 먼저
		// 모두 조회해 하나로 합친 뒤 createFcr() 1회당 딱 1번만 배치조회하도록 통합했다. 두 조회
		// (selectBomLeafRows/selectProductFcrDtlSourceRows) 는 서로 다른 테이블(FCR_DTL 미참조)만
		// 읽어 순서를 바꿔도 결과에 영향이 없다.
		List<BomLeafRow> leafRows = dao.selectBomLeafRows(salesNo, divisionCode, companyCode, bomType, productCodes);
		List<ProductFcrDtlSourceRow> productRows = dao.selectProductFcrDtlSourceRows(salesNo, divisionCode, companyCode,
				productCodes);

		List<ItemOriginRateCriteria> combinedOriginRateLookups = new ArrayList<>(leafRows.size() + productRows.size());
		for (BomLeafRow leaf : leafRows) {
			combinedOriginRateLookups.add(new ItemOriginRateCriteria(leaf.getCompanyCode(), leaf.getFromDivisionCode(),
					leaf.getItemCode(), leaf.getFtaCode(), invoiceDate));
		}
		for (ProductFcrDtlSourceRow src : productRows) {
			// "B"(부산물)는 originRate 조회 자체가 필요 없어(항상 ONE) 배치 요청 대상에서 제외한다.
			if (!"B".equals(src.getProductAssetsType())) {
				combinedOriginRateLookups.add(new ItemOriginRateCriteria(src.getCompanyCode(), src.getProdDivisionCode(),
						src.getProductCode(), src.getFtaCode(), invoiceDate));
			}
		}
		Map<String, OriginRatePrecheck> originRatePrecheckCache = new LinkedHashMap<>();
		Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache = itemOriginRateService
				.prefetchNonCertifiedOriginSummaries(combinedOriginRateLookups, originRatePrecheckCache);

		// 3단계(구매단가) selectRecentPurchasePrice 도 BOM 리프 자재 수만큼 반복 호출되던 것을 leafRows
		// 전체 기준 배치 1회로 선조회한다(3-4 상품/부산물 쪽은 재료 단가를 조회하지 않아 대상이 아니다).
		List<ItemPriceCriteria> priceLookups = new ArrayList<>(leafRows.size());
		for (BomLeafRow leaf : leafRows) {
			priceLookups.add(new ItemPriceCriteria(leaf.getCompanyCode(), leaf.getFromDivisionCode(), leaf.getItemCode(),
					leaf.getFtaCode(), invoiceDate));
		}
		Map<String, PoLedgerPriceRow> purchasePriceCache = itemPriceService.prefetchRecentPurchasePrices(priceLookups);

		createBomLeafFcrDtl(dao, leafRows, invoiceDate, originRatePrecheckCache, nonCertifiedSummaryCache,
				purchasePriceCache);
		createProductFcrDtl(dao, productRows, invoiceDate, originRatePrecheckCache, nonCertifiedSummaryCache);

		dao.mergeFcrMstMaterialAmountTotals(salesNo, divisionCode, companyCode, productCodes);

		return errCnt > 0 ? "semisuccess" : "successed";
	}

	private int checkBomAvailability(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String bomPreviousYyyymm, String yyyymm, List<String> productCodes) {
		int errCnt = 0;
		for (SalesDtlBomTarget target : dao.selectSalesDtlBomTargets(companyCode, divisionCode, salesNo,
				productCodes)) {
			String status = "5".equals(target.getStatus()) ? "1" : "0";
			String bomStatus;
			String bomYyyymm = null;
			String bomDivisionCode = null;

			BomAvailability own = dao.selectOwnDivisionBom(companyCode, target.getProdDivisionCode(),
					target.getProductCode(), bomType, bomPreviousYyyymm, yyyymm);
			if (own != null) {
				bomStatus = "0";
				bomYyyymm = own.getYyyymm();
				bomDivisionCode = own.getDivisionCode();
			} else {
				BomAvailability other = dao.selectAnyDivisionBom(companyCode, target.getProductCode(), bomType,
						bomPreviousYyyymm, yyyymm);
				if (other != null) {
					bomStatus = "2";
					bomYyyymm = other.getYyyymm();
					bomDivisionCode = other.getDivisionCode();
				} else {
					bomStatus = "1";
					errCnt++;
				}
			}

			dao.updateSalesDtlBomStatus(salesNo, target.getSalesSeq(), divisionCode, companyCode,
					target.getProductCode(), status, bomStatus, bomYyyymm, bomDivisionCode);
		}
		return errCnt;
	}

	/** 3-2(내수, EXPORT_FLAG='D'): SALES × 활성 FTA_MASTER 교차곱으로 FCR_MST 생성 */
	private void createDomesticFcrMst(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String invoiceDate, List<String> productCodes, Map<String, String> hsCodeCache,
			Map<String, BigDecimal> incotermsCache) {
		List<DomesticSalesLine> salesLines = dao.selectDomesticSalesLines(companyCode, divisionCode, salesNo,
				productCodes);
		List<FtaMasterActive> ftaMasters = dao.selectActiveFtaMasters(companyCode);
		String stdYyyy = invoiceDate.substring(0, 4);

		List<FcrMstInsertRow> chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
		for (DomesticSalesLine sales : salesLines) {
			for (FtaMasterActive fta : ftaMasters) {
				FcrMstInsertRow row = new FcrMstInsertRow();
				row.setFtaCode(fta.getFtaCode());
				row.setSalesNo(sales.getSalesNo());
				row.setSalesSeq(sales.getSalesSeq());
				row.setProductCode(sales.getProductCode());
				row.setDivisionCode(sales.getDivisionCode());
				row.setCompanyCode(sales.getCompanyCode());

				String hsCode = resolveHsCodeCached(hsCodeCache, sales.getCompanyCode(), sales.getProdDivisionCode(),
						sales.getDeliveryCustomerCode(), sales.getProductCode(), sales.getArrivalNation(),
						fta.getFtaCode(), sales.getInvoiceDate());
				row.setHsCode(substr(hsCode, 6));
				row.setStandard(sales.getStandard());
				row.setAmount(sales.getAmount());
				row.setNetCostAmount(BigDecimal.ZERO);

				BigDecimal exworkRate = resolveIncotermsRateCached(incotermsCache, stdYyyy, sales.getCompanyCode(),
						sales.getDivisionCode(), sales.getExportFlag(), "KR", "FOB", "EXW");
				row.setExworkAmount(nvl(exworkRate).multiply(nvl(sales.getAmount())));
				row.setFobAmount(sales.getAmount());
				row.setSpCooYn(sales.getSpCooYn());
				row.setWoCooYn(sales.getWoCooYn());
				row.setProductUnit(sales.getProductUnit());
				row.setProductAssetsType(sales.getProductAssetsType());
				row.setProdDivisionCode(sales.getProdDivisionCode());
				row.setImApplyYn(resolveImApplyYn(bomType, fta.getIntermediateYn()));

				chunk.add(row);
				if (chunk.size() >= INSERT_CHUNK_SIZE) {
					dao.insertFcrMstRows(chunk);
					chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
				}
			}
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrMstRows(chunk);
		}
	}

	/**
	 * 3-2(수출): SALES × FTA_APPLY_NATION × FTA_MASTER(FTA_STATUS='4') 매칭 결과로 FCR_MST 생성.
	 *
	 * <p><b>원본 결함 의심(그대로 이관):</b> 원본 SQL 의 수출 분기 FS03_GET_HS_CODE 호출은
	 * {@code FS03_GET_HS_CODE(SM.COMPANY_CODE, SD.PROD_DIVISION_CODE, SD.DELIVERY_CUSTOMER_CODE,
	 * SD.PRODUCT_CODE, SM.ARRIVAL_NATION, SM.INVOICE_DATE)} 로 인자를 6개만 넘기지만, 함수 정의
	 * (FS03_GET_HS_CODE.sql)는 P_FTA_CODE 를 포함해 7개 인자를 요구한다(P_YYYYMMDD 만 기본값 있음).
	 * Oracle 위치기반 바인딩 특성상 6번째 인자(SM.INVOICE_DATE)가 P_FTA_CODE 자리에 들어가고
	 * P_YYYYMMDD 는 공급되지 않아 기본값(SYSDATE, 오늘 날짜)으로 대체된다 — 즉 수출 HS코드 조회가
	 * 실제 판정 대상 FTA_CODE 로도, 매출 발생일자로도 조회되지 않고 있을 가능성이 높다(내수 분기는
	 * 7개 인자를 모두 정확히 넘긴다). 이 메서드는 운영 결과와 100% 동일하게 유지하기 위해 이 호출을
	 * "고치지 않고" 그대로 재현했다 — 업무팀 확인 후 필요 시 별도로 수정 요청 바람.
	 */
	private void createExportFcrMst(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String invoiceDate, List<String> productCodes, Map<String, String> hsCodeCache,
			Map<String, BigDecimal> incotermsCache) {
		List<ExportSalesLine> salesLines = dao.selectExportSalesLines(companyCode, divisionCode, salesNo,
				productCodes);
		String stdYyyy = invoiceDate.substring(0, 4);

		List<FcrMstInsertRow> chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
		for (ExportSalesLine sales : salesLines) {
			FcrMstInsertRow row = new FcrMstInsertRow();
			row.setFtaCode(sales.getFtaCode());
			row.setSalesNo(sales.getSalesNo());
			row.setSalesSeq(sales.getSalesSeq());
			row.setProductCode(sales.getProductCode());
			row.setDivisionCode(sales.getDivisionCode());
			row.setCompanyCode(sales.getCompanyCode());

			// 원본 결함 재현: P_FTA_CODE 자리에 invoiceDate 가 들어가고 P_YYYYMMDD 는 오늘 날짜로 기본값 처리됨(위 클래스 주석 참고)
			String hsCode = resolveHsCodeCached(hsCodeCache, sales.getCompanyCode(), sales.getProdDivisionCode(),
					sales.getDeliveryCustomerCode(), sales.getProductCode(), sales.getArrivalNation(),
					sales.getInvoiceDate(), null);
			row.setHsCode(substr(hsCode, 6));
			row.setStandard(sales.getStandard());
			row.setAmount(sales.getAmount());
			row.setNetCostAmount(BigDecimal.ZERO);

			BigDecimal exworkRate = resolveIncotermsRateCached(incotermsCache, stdYyyy, sales.getCompanyCode(),
					sales.getDivisionCode(), sales.getExportFlag(), sales.getFtaCode(), sales.getInkoterms(), "EXW");
			BigDecimal fobRate = resolveIncotermsRateCached(incotermsCache, stdYyyy, sales.getCompanyCode(),
					sales.getDivisionCode(), sales.getExportFlag(), sales.getFtaCode(), sales.getInkoterms(), "FOB");
			row.setExworkAmount(nvl(exworkRate).multiply(nvl(sales.getAmount())));
			row.setFobAmount(nvl(fobRate).multiply(nvl(sales.getAmount())));
			row.setSpCooYn(sales.getSpCooYn());
			row.setWoCooYn(sales.getWoCooYn());
			row.setProductUnit(sales.getProductUnit());
			row.setProductAssetsType(sales.getProductAssetsType());
			row.setProdDivisionCode(sales.getProdDivisionCode());
			row.setImApplyYn(resolveImApplyYn(bomType, sales.getIntermediateYn()));

			chunk.add(row);
			if (chunk.size() >= INSERT_CHUNK_SIZE) {
				dao.insertFcrMstRows(chunk);
				chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
			}
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrMstRows(chunk);
		}
	}

	/**
	 * 3-3: BOM 최말단 자재를 (itemCode,ftaCode,salesNo,salesSeq,productCode,divisionCode,companyCode,hsCode) 로
	 * 집계해 FCR_DTL 생성. selectNonCertifiedOriginSummary/selectLastInputYyyyMm 배치 사전조회는
	 * createFcr() 가 3-4(상품) 대상과 합쳐 한 번만 수행해 원본/사전조회 캐시를 그대로 넘겨받는다.
	 */
	private void createBomLeafFcrDtl(CreateFcrDao dao, List<BomLeafRow> leafRows, String invoiceDate,
			Map<String, OriginRatePrecheck> originRatePrecheckCache,
			Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache,
			Map<String, PoLedgerPriceRow> purchasePriceCache) {
		Map<String, BigDecimal> priceCache = new LinkedHashMap<>();
		Map<String, BigDecimal> originRateCache = new LinkedHashMap<>();
		Map<String, String> priceNoteCache = new LinkedHashMap<>();

		Map<String, List<ResolvedLeaf>> grouped = new LinkedHashMap<>();
		for (BomLeafRow leaf : leafRows) {
			BigDecimal unitPrice = resolveItemPriceCached(priceCache, purchasePriceCache, leaf.getCompanyCode(),
					leaf.getFromDivisionCode(), leaf.getItemCode(), leaf.getFtaCode(), invoiceDate);
			BigDecimal originRate = resolveOriginRateCached(originRateCache, originRatePrecheckCache,
					nonCertifiedSummaryCache, leaf.getCompanyCode(), leaf.getFromDivisionCode(), leaf.getItemCode(),
					leaf.getFtaCode(), invoiceDate);
			String priceNote = resolvePriceNoteCached(priceNoteCache, purchasePriceCache, leaf.getCompanyCode(),
					leaf.getFromDivisionCode(), leaf.getItemCode(), leaf.getFtaCode(), invoiceDate);
			String hsCodeYn = leaf.getItemHsCode() == null ? "N" : "Y";

			String key = String.join("|", nz(leaf.getItemCode()), nz(leaf.getFtaCode()), nz(leaf.getSalesNo()),
					String.valueOf(leaf.getSalesSeq()), nz(leaf.getProductCode()), nz(leaf.getDivisionCode()),
					nz(leaf.getCompanyCode()), nz(leaf.getHsCode()));
			grouped.computeIfAbsent(key, k -> new ArrayList<>())
					.add(new ResolvedLeaf(leaf, unitPrice, originRate, priceNote, hsCodeYn));
		}

		List<FcrDtlInsertRow> chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
		for (List<ResolvedLeaf> group : grouped.values()) {
			chunk.add(aggregateLeafGroup(group));
			if (chunk.size() >= INSERT_CHUNK_SIZE) {
				dao.insertFcrDtlRows(chunk);
				chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
			}
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrDtlRows(chunk);
		}
	}

	private static final class ResolvedLeaf {
		final BomLeafRow leaf;
		final BigDecimal unitPrice;
		final BigDecimal originRate;
		final String priceNote;
		final String hsCodeYn;

		ResolvedLeaf(BomLeafRow leaf, BigDecimal unitPrice, BigDecimal originRate, String priceNote,
				String hsCodeYn) {
			this.leaf = leaf;
			this.unitPrice = unitPrice;
			this.originRate = originRate;
			this.priceNote = priceNote;
			this.hsCodeYn = hsCodeYn;
		}
	}

	/** 레거시 3-3 단계 GROUP BY 집계식 이관 */
	private FcrDtlInsertRow aggregateLeafGroup(List<ResolvedLeaf> group) {
		BomLeafRow first = group.get(0).leaf;

		BigDecimal sumReqQtyFiltered = BigDecimal.ZERO;
		BigDecimal weightedSum = BigDecimal.ZERO;
		BigDecimal minOriginRate = null;
		String maxHsCodeYn = "N";
		LinkedHashSet<String> notes = new LinkedHashSet<>();

		for (ResolvedLeaf r : group) {
			BigDecimal reqQty = nvl(r.leaf.getRequirementQty());
			BigDecimal unitPrice = nvl(r.unitPrice);
			BigDecimal reqQtyFiltered = unitPrice.signum() == 0 ? BigDecimal.ZERO : reqQty;
			sumReqQtyFiltered = sumReqQtyFiltered.add(reqQtyFiltered);
			BigDecimal unitPriceFiltered = reqQty.signum() == 0 ? BigDecimal.ZERO : unitPrice;
			weightedSum = weightedSum.add(unitPriceFiltered.multiply(reqQtyFiltered));

			BigDecimal originRate = nvl(r.originRate);
			if (minOriginRate == null || originRate.compareTo(minOriginRate) < 0) {
				minOriginRate = originRate;
			}
			if ("Y".equals(r.hsCodeYn)) {
				maxHsCodeYn = "Y";
			}
			if (r.priceNote != null && !r.priceNote.isBlank()) {
				notes.add(r.priceNote);
			}
		}

		BigDecimal requirementQty = sumReqQtyFiltered;
		BigDecimal unitPrice = requirementQty.signum() == 0 ? BigDecimal.ZERO
				: weightedSum.divide(requirementQty, 10, RoundingMode.HALF_UP);
		BigDecimal originRate = (minOriginRate == null || minOriginRate.signum() == 0) ? BigDecimal.ZERO
				: BigDecimal.ONE;

		FcrDtlInsertRow row = new FcrDtlInsertRow();
		row.setItemCode(first.getItemCode());
		row.setFtaCode(first.getFtaCode());
		row.setSalesNo(first.getSalesNo());
		row.setSalesSeq(first.getSalesSeq());
		row.setProductCode(first.getProductCode());
		row.setDivisionCode(first.getDivisionCode());
		row.setCompanyCode(first.getCompanyCode());
		row.setHsCode(first.getHsCode());
		row.setRequirementQty(requirementQty);
		row.setInputAmount(requirementQty.multiply(unitPrice));
		BigDecimal originatingQty = requirementQty.multiply(originRate);
		row.setOriginatingQty(originatingQty);
		row.setOriginatingAmount(unitPrice.multiply(originatingQty));
		BigDecimal nonOriginatingQty = requirementQty.multiply(BigDecimal.ONE.subtract(originRate));
		row.setNonOriginatingQty(nonOriginatingQty);
		row.setNonOriginatingAmount(unitPrice.multiply(nonOriginatingQty));
		row.setHsCodeYn(maxHsCodeYn);
		// FC00_STRING_AGG_OR 이관: 원본 소스가 제공되지 않아 "중복 제거 후 콤마로 연결"로 재구현했다
		// (표시용 참고 문구일 뿐 판정 로직에는 영향이 없어 위험도가 낮다고 판단).
		row.setPriceNote(notes.isEmpty() ? null : String.join(", ", notes));
		return row;
	}

	/**
	 * 3-4: 상품/부산물(원자재가 아닌 완제품 자체)을 자재 1건처럼 취급해 FCR_DTL 생성.
	 * selectNonCertifiedOriginSummary/selectLastInputYyyyMm 배치 사전조회는 createFcr() 가 3-3(BOM
	 * 리프) 대상과 합쳐 한 번만 수행해 원본/사전조회 캐시를 그대로 넘겨받는다.
	 */
	private void createProductFcrDtl(CreateFcrDao dao, List<ProductFcrDtlSourceRow> rows, String invoiceDate,
			Map<String, OriginRatePrecheck> originRatePrecheckCache,
			Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache) {
		Map<String, BigDecimal> originRateCache = new LinkedHashMap<>();

		List<FcrDtlInsertRow> chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
		for (ProductFcrDtlSourceRow src : rows) {
			BigDecimal originRate = "B".equals(src.getProductAssetsType()) ? BigDecimal.ONE
					: nvl(resolveOriginRateCached(originRateCache, originRatePrecheckCache, nonCertifiedSummaryCache,
							src.getCompanyCode(), src.getProdDivisionCode(), src.getProductCode(), src.getFtaCode(),
							invoiceDate));
			BigDecimal inputAmount = nvl(src.getUnitPrice());
			boolean fullyOriginating = originRate.compareTo(BigDecimal.ONE) == 0;

			FcrDtlInsertRow row = new FcrDtlInsertRow();
			row.setItemCode(src.getProductCode());
			row.setFtaCode(src.getFtaCode());
			row.setSalesNo(src.getSalesNo());
			row.setSalesSeq(src.getSalesSeq());
			row.setProductCode(src.getProductCode());
			row.setDivisionCode(src.getDivisionCode());
			row.setCompanyCode(src.getCompanyCode());
			row.setHsCode(src.getHsCode());
			row.setRequirementQty(BigDecimal.ONE);
			row.setInputAmount(inputAmount);
			row.setOriginatingQty(fullyOriginating ? BigDecimal.ONE : BigDecimal.ZERO);
			row.setOriginatingAmount(row.getOriginatingQty().multiply(inputAmount));
			row.setNonOriginatingQty(fullyOriginating ? BigDecimal.ZERO : BigDecimal.ONE);
			row.setNonOriginatingAmount(row.getNonOriginatingQty().multiply(inputAmount));
			row.setHsCodeYn(src.getItemHsCode() == null ? "N" : "Y");
			row.setPriceNote(null);

			chunk.add(row);
			if (chunk.size() >= INSERT_CHUNK_SIZE) {
				dao.insertFcrDtlRows(chunk);
				chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
			}
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrDtlRows(chunk);
		}
	}

	private static String resolveImApplyYn(String bomType, String intermediateYn) {
		if ("F".equals(bomType)) {
			return "F";
		}
		return "Y".equals(intermediateYn) ? "MF" : "F";
	}

	private String resolveHsCodeCached(Map<String, String> cache, String companyCode, String divisionCode,
			String customerCode, String itemCode, String nationCode, String ftaCode, String baseDate) {
		String key = String.join("|", nz(companyCode), nz(divisionCode), nz(customerCode), nz(itemCode),
				nz(nationCode), nz(ftaCode), nz(baseDate));
		return cache.computeIfAbsent(key, k -> hsCodeService
				.resolveHsCode(new HsCodeCriteria(companyCode, divisionCode, customerCode, itemCode, nationCode,
						ftaCode, baseDate)));
	}

	private BigDecimal resolveIncotermsRateCached(Map<String, BigDecimal> cache, String stdYyyy, String companyCode,
			String divisionCode, String exportFlag, String ftaCode, String fromIncoterms, String toIncoterms) {
		String key = String.join("|", nz(stdYyyy), nz(companyCode), nz(divisionCode), nz(exportFlag), nz(ftaCode),
				nz(fromIncoterms), nz(toIncoterms));
		return cache.computeIfAbsent(key, k -> incotermsRateService.calculateChangeRate(new IncotermsChangeRateCriteria(
				stdYyyy, companyCode, divisionCode, exportFlag, ftaCode, fromIncoterms, toIncoterms)));
	}

	/**
	 * ItemPriceCriteria.ftaCode 는 실제 조회 조건에 쓰이지 않는다(원본 FC10_GET_ITEM_PRICE 도 마찬가지 —
	 * {@link ItemPriceCriteria} 클래스 주석 참고). 그래서 캐시 키에서 ftaCode 를 뺀다 — BOM 리프
	 * 자재는 같은 품목이 협정(FTA) 수만큼 반복 등장하므로, 뺴지 않으면 이 캐시가 사실상 항상 miss 난다.
	 */
	private BigDecimal resolveItemPriceCached(Map<String, BigDecimal> cache, Map<String, PoLedgerPriceRow> purchasePriceCache,
			String companyCode, String divisionCode, String itemCode, String ftaCode, String baseDate) {
		String key = String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
		return cache.computeIfAbsent(key, k -> itemPriceService.resolveItemPrice(
				new ItemPriceCriteria(companyCode, divisionCode, itemCode, ftaCode, baseDate), purchasePriceCache));
	}

	/** ftaCode 를 캐시 키에서 빼는 이유는 {@link #resolveItemPriceCached} 참고. */
	private String resolvePriceNoteCached(Map<String, String> cache, Map<String, PoLedgerPriceRow> purchasePriceCache,
			String companyCode, String divisionCode, String itemCode, String ftaCode, String baseDate) {
		String key = String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
		return cache.computeIfAbsent(key, k -> itemPriceService.resolveItemPriceNote(
				new ItemPriceCriteria(companyCode, divisionCode, itemCode, ftaCode, baseDate), purchasePriceCache));
	}

	/**
	 * FTA_CODE 별 최종 원산지비율은 (companyCode, divisionCode, itemCode, ftaCode, baseDate) 로 캐싱하고,
	 * 그 계산에 필요한 FTA_CODE 무관 사전조회(precheck)는 (companyCode, divisionCode, itemCode, baseDate)
	 * 로 별도 캐싱한다 — 같은 품목이 협정(FTA) 수만큼 반복되는 BOM 리프 루프에서 사전조회를 한 번만
	 * 하도록 하기 위함이다({@link ItemOriginRateService} 클래스 주석 참고).
	 *
	 * <p>nonCertifiedSummaryCache 는 {@link ItemOriginRateService#prefetchNonCertifiedOriginSummaries} 로
	 * 루프 시작 전에 미리 배치 조회해둔 결과다 — 캐시 적중 시 resolveOriginRate 내부에서 추가 DB 호출이
	 * 전혀 발생하지 않는다.
	 */
	private BigDecimal resolveOriginRateCached(Map<String, BigDecimal> cache,
			Map<String, OriginRatePrecheck> precheckCache, Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache,
			String companyCode, String divisionCode, String itemCode, String ftaCode, String baseDate) {
		String key = String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(ftaCode), nz(baseDate));
		return cache.computeIfAbsent(key, k -> {
			String precheckKey = ItemOriginRateService.precheckKey(companyCode, divisionCode, itemCode, baseDate);
			OriginRatePrecheck precheck = precheckCache.computeIfAbsent(precheckKey, pk -> itemOriginRateService
					.precheckOriginRate(new ItemOriginRateCriteria(companyCode, divisionCode, itemCode, ftaCode, baseDate)));
			return itemOriginRateService.resolveOriginRate(
					new ItemOriginRateCriteria(companyCode, divisionCode, itemCode, ftaCode, baseDate), precheck,
					nonCertifiedSummaryCache);
		});
	}

	private static String minusMonthsYyyymm(String invoiceDateYyyymmdd, int months) {
		LocalDate date = LocalDate.parse(invoiceDateYyyymmdd, DateTimeFormatter.BASIC_ISO_DATE);
		return date.minusMonths(months).format(DateTimeFormatter.ofPattern("yyyyMM"));
	}

	private static String substr(String value, int length) {
		if (value == null) {
			return null;
		}
		return value.length() <= length ? value : value.substring(0, length);
	}

	private static String nz(String value) {
		return value == null ? "" : value;
	}

	private static BigDecimal nvl(BigDecimal value) {
		return value == null ? BigDecimal.ZERO : value;
	}
}
