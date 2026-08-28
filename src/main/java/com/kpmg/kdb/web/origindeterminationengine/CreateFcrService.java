package com.kpmg.kdb.web.origindeterminationengine;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.web.origindeterminationengine.dto.BomAvailabilityBatchResult;
import com.kpmg.kdb.web.origindeterminationengine.dto.BomAvailabilityRequest;
import com.kpmg.kdb.web.origindeterminationengine.dto.BomLeafRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.DomesticSalesLine;
import com.kpmg.kdb.web.origindeterminationengine.dto.ExportSalesLine;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrDtlInsertRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.FcrMstInsertRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.FtaMasterActive;
import com.kpmg.kdb.web.origindeterminationengine.dto.ProductFcrDtlSourceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesDtlBomStatusUpdateRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesDtlBomTarget;
import com.kpmg.kdb.web.origindeterminationengine.dto.SalesInvoiceHeader;
import com.kpmg.kdb.web.origindeterminationengine.MaterialHsCodeService;
import com.kpmg.kdb.web.origindeterminationengine.IncotermsRateService;
import com.kpmg.kdb.web.origindeterminationengine.ItemOriginRateService;
import com.kpmg.kdb.web.origindeterminationengine.ItemPriceService;
import com.kpmg.kdb.web.origindeterminationengine.dto.HsCodeCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.IncotermsChangeRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemOriginRateCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemPriceCriteria;
import com.kpmg.kdb.web.origindeterminationengine.dto.ItemPriceWithNote;
import com.kpmg.kdb.web.origindeterminationengine.dto.MaterialBalanceTierRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.OriginRatePrecheck;
import com.kpmg.kdb.web.origindeterminationengine.dto.PoLedgerPriceRow;
import com.kpmg.kdb.web.origindeterminationengine.dto.PurchaseLedgerSummary;
import com.kpmg.kdb.web.origindeterminationengine.dto.StandardCostRow;
import com.kpmg.kdb.web.origindeterminationengine.FcrCreator;

/**
 * FCR_MST/FCR_DTL 생성 (레거시 CREATE_FCR 프로시저).
 *
 * 매출(SALES_NO) 1건에 대해 BOM/표준 BOM 존재를 확인하고, FCR_MST(제품×FTA 후보)를 생성한 뒤
 * BOM 최말단 자재와 상품/부산물을 집계해 FCR_DTL(원산지 판정용 원재료 명세)을 생성한다. 
 * 에서 처리한다.
 *
 * <p>원본과 동일하게 이 메서드는 예외를 흡수하지 않는다 — 매출 1건 처리 실패를 배치 전체 중단
 * 없이 넘기는 책임은 호출자({@link BulkPipelineRunner})에 있다.
 */
@Service
public class CreateFcrService extends GeneralService implements FcrCreator {

	private static final int INSERT_CHUNK_SIZE = 500;
	private static final BigDecimal HUNDRED = BigDecimal.valueOf(100);

	@Autowired
	private MaterialHsCodeService hsCodeService;
	@Autowired
	private IncotermsRateService incotermsRateService;
	@Autowired
	private ItemPriceService itemPriceService;
	@Autowired
	private ItemOriginRateService itemOriginRateService;
	@Autowired
	private CreateFcrReferenceDataService referenceDataService;

	/**
	 * @param productCodes 판정 대상 제품 코드. null/빈 리스트면 salesNo 전체(월 판정), 값이 있으면
	 *                      그 제품들만(개별 판정) 대상으로 한다.
	 * @return "successed" / "semisuccess" / "failed"
	 */
	@Override
	public String createFcr(String companyCode, String divisionCode, String salesNo, String bomTypeParam,
			List<String> productCodes) {
		CreateFcrDao dao = sqlSession.getMapper(CreateFcrDao.class);

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

		int errCnt = checkBomAvailability(dao, companyCode, divisionCode, salesNo, bomType, bomPreviousYyyymm, yyyymm,
				productCodes);

		// BOM 오류가 없거나 포괄건(가상 매출)이면 오류가 있어도 진행
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

		List<BomLeafRow> leafRows = dao.selectBomLeafRows(salesNo, divisionCode, companyCode, bomType, productCodes);
		List<ProductFcrDtlSourceRow> productRows = dao.selectProductFcrDtlSourceRows(salesNo, divisionCode, companyCode,
				productCodes);

		List<ItemOriginRateCriteria> combinedOriginRateLookups = new ArrayList<>(leafRows.size() + productRows.size());
		for (BomLeafRow leaf : leafRows) {
			combinedOriginRateLookups.add(new ItemOriginRateCriteria(leaf.getCompanyCode(), leaf.getFromDivisionCode(),
					leaf.getItemCode(), leaf.getFtaCode(), invoiceDate));
		}
		for (ProductFcrDtlSourceRow src : productRows) {
			// 부산물(B)은 원산지비율 조회가 필요 없다(항상 100%)
			if (!"B".equals(src.getProductAssetsType())) {
				combinedOriginRateLookups.add(new ItemOriginRateCriteria(src.getCompanyCode(), src.getProdDivisionCode(),
						src.getProductCode(), src.getFtaCode(), invoiceDate));
			}
		}
		Map<String, OriginRatePrecheck> originRatePrecheckCache = new LinkedHashMap<>();
		Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache = itemOriginRateService
				.prefetchNonCertifiedOriginSummaries(combinedOriginRateLookups, originRatePrecheckCache);

		List<ItemPriceCriteria> priceLookups = new ArrayList<>(leafRows.size());
		for (BomLeafRow leaf : leafRows) {
			priceLookups.add(new ItemPriceCriteria(leaf.getCompanyCode(), leaf.getFromDivisionCode(), leaf.getItemCode(),
					leaf.getFtaCode(), invoiceDate));
		}
		Map<String, PoLedgerPriceRow> purchasePriceCache = itemPriceService.prefetchRecentPurchasePrices(priceLookups);
		Map<String, StandardCostRow> standardCostCache = itemPriceService.prefetchStandardCostByDivision(priceLookups);
		Map<String, MaterialBalanceTierRow> divisionBalanceCache = itemPriceService
				.prefetchDivisionBalanceForPrice(priceLookups);

		createBomLeafFcrDtl(dao, leafRows, invoiceDate, originRatePrecheckCache, nonCertifiedSummaryCache,
				divisionBalanceCache, purchasePriceCache, standardCostCache);
		createProductFcrDtl(dao, productRows, invoiceDate, originRatePrecheckCache, nonCertifiedSummaryCache);

		dao.mergeFcrMstMaterialAmountTotals(salesNo, divisionCode, companyCode, productCodes);

		return errCnt > 0 ? "semisuccess" : "successed";
	}

	/** 제품별 실적/표준 BOM 존재 여부를 확인하고 SALES_DTL.BOM_STATUS를 갱신한다. BOM이 없으면 errCnt 증가. */
	private int checkBomAvailability(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String bomPreviousYyyymm, String yyyymm, List<String> productCodes) {
		List<SalesDtlBomTarget> targets = dao.selectSalesDtlBomTargets(companyCode, divisionCode, salesNo,
				productCodes);
		if (targets.isEmpty()) {
			return 0;
		}

		Map<String, BomAvailabilityRequest> distinctLookups = new LinkedHashMap<>();
		for (SalesDtlBomTarget target : targets) {
			distinctLookups.putIfAbsent(bomAvailabilityKey(target.getProdDivisionCode(), target.getProductCode()),
					new BomAvailabilityRequest(target.getProdDivisionCode(), target.getProductCode()));
		}

		Map<String, BomAvailabilityBatchResult> availabilityCache = new LinkedHashMap<>();
		for (BomAvailabilityBatchResult result : dao.selectBomAvailabilityBatch(companyCode, bomType,
				bomPreviousYyyymm, yyyymm, new ArrayList<>(distinctLookups.values()))) {
			availabilityCache.put(bomAvailabilityKey(result.getReqProdDivisionCode(), result.getReqProductCode()),
					result);
		}

		int errCnt = 0;
		List<SalesDtlBomStatusUpdateRow> updateRows = new ArrayList<>(targets.size());
		for (SalesDtlBomTarget target : targets) {
			String status = "5".equals(target.getStatus()) ? "1" : "0";
			String bomStatus;
			String bomYyyymm = null;
			String bomDivisionCode = null;

			BomAvailabilityBatchResult availability = availabilityCache
					.get(bomAvailabilityKey(target.getProdDivisionCode(), target.getProductCode()));

			if (availability != null && availability.getOwnDivisionCode() != null) {
				bomStatus = "0";
				bomYyyymm = availability.getOwnYyyymm();
				bomDivisionCode = availability.getOwnDivisionCode();
			} else if (availability != null && availability.getAnyDivisionCode() != null) {
				bomStatus = "2";
				bomYyyymm = availability.getAnyYyyymm();
				bomDivisionCode = availability.getAnyDivisionCode();
			} else {
				bomStatus = "1";
				errCnt++;
			}

			updateRows.add(new SalesDtlBomStatusUpdateRow(target.getSalesSeq(), target.getProductCode(), status,
					bomStatus, bomYyyymm, bomDivisionCode));
		}

		dao.updateSalesDtlBomStatusBatch(salesNo, divisionCode, companyCode, updateRows);
		return errCnt;
	}

	private static String bomAvailabilityKey(String prodDivisionCode, String productCode) {
		return prodDivisionCode + "|" + productCode;
	}

	/** 내수(EXPORT_FLAG='D'): SALES × 활성 FTA_MASTER 교차곱으로 FCR_MST 생성 */
	private void createDomesticFcrMst(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String invoiceDate, List<String> productCodes, Map<String, String> hsCodeCache,
			Map<String, BigDecimal> incotermsCache) {
		List<DomesticSalesLine> salesLines = dao.selectDomesticSalesLines(companyCode, divisionCode, salesNo,
				productCodes);
		List<FtaMasterActive> ftaMasters = referenceDataService.selectActiveFtaMasters(companyCode);
		String stdYyyy = invoiceDate.substring(0, 4);

		List<HsCodeCriteria> hsCodeLookups = new ArrayList<>(salesLines.size() * ftaMasters.size());
		for (DomesticSalesLine sales : salesLines) {
			for (FtaMasterActive fta : ftaMasters) {
				hsCodeLookups.add(new HsCodeCriteria(sales.getCompanyCode(), sales.getProdDivisionCode(),
						sales.getDeliveryCustomerCode(), sales.getProductCode(), sales.getArrivalNation(),
						fta.getFtaCode(), sales.getInvoiceDate()));
			}
		}
		hsCodeCache.putAll(hsCodeService.prefetchHsCode(hsCodeLookups));

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
				chunk = flushIfFull(chunk, dao::insertFcrMstRows);
			}
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrMstRows(chunk);
		}
	}

	/** 수출: SALES × FTA_APPLY_NATION × FTA_MASTER(FTA_STATUS='4') 매칭 결과로 FCR_MST 생성. */
	private void createExportFcrMst(CreateFcrDao dao, String companyCode, String divisionCode, String salesNo,
			String bomType, String invoiceDate, List<String> productCodes, Map<String, String> hsCodeCache,
			Map<String, BigDecimal> incotermsCache) {
		List<ExportSalesLine> salesLines = dao.selectExportSalesLines(companyCode, divisionCode, salesNo,
				productCodes);
		String stdYyyy = invoiceDate.substring(0, 4);

		List<HsCodeCriteria> hsCodeLookups = new ArrayList<>(salesLines.size());
		for (ExportSalesLine sales : salesLines) {
			hsCodeLookups.add(new HsCodeCriteria(sales.getCompanyCode(), sales.getProdDivisionCode(),
					sales.getDeliveryCustomerCode(), sales.getProductCode(), sales.getArrivalNation(),
					sales.getFtaCode(), sales.getInvoiceDate()));
		}
		hsCodeCache.putAll(hsCodeService.prefetchHsCode(hsCodeLookups));

		List<FcrMstInsertRow> chunk = new ArrayList<>(INSERT_CHUNK_SIZE);
		for (ExportSalesLine sales : salesLines) {
			FcrMstInsertRow row = new FcrMstInsertRow();
			row.setFtaCode(sales.getFtaCode());
			row.setSalesNo(sales.getSalesNo());
			row.setSalesSeq(sales.getSalesSeq());
			row.setProductCode(sales.getProductCode());
			row.setDivisionCode(sales.getDivisionCode());
			row.setCompanyCode(sales.getCompanyCode());

			String hsCode = resolveHsCodeCached(hsCodeCache, sales.getCompanyCode(), sales.getProdDivisionCode(),
					sales.getDeliveryCustomerCode(), sales.getProductCode(), sales.getArrivalNation(),
					sales.getFtaCode(), sales.getInvoiceDate());
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
			chunk = flushIfFull(chunk, dao::insertFcrMstRows);
		}
		if (!chunk.isEmpty()) {
			dao.insertFcrMstRows(chunk);
		}
	}

	/** BOM 최말단 자재를 (자재,FTA,매출라인) 단위로 집계해 FCR_DTL 생성 */
	private void createBomLeafFcrDtl(CreateFcrDao dao, List<BomLeafRow> leafRows, String invoiceDate,
			Map<String, OriginRatePrecheck> originRatePrecheckCache,
			Map<String, PurchaseLedgerSummary> nonCertifiedSummaryCache,
			Map<String, MaterialBalanceTierRow> divisionBalanceCache, Map<String, PoLedgerPriceRow> purchasePriceCache,
			Map<String, StandardCostRow> standardCostCache) {
		Map<String, ItemPriceWithNote> priceWithNoteCache = new LinkedHashMap<>();
		Map<String, BigDecimal> originRateCache = new LinkedHashMap<>();

		Map<String, List<ResolvedLeaf>> grouped = new LinkedHashMap<>();
		for (BomLeafRow leaf : leafRows) {
			ItemPriceWithNote priceWithNote = resolveItemPriceWithNoteCached(priceWithNoteCache, divisionBalanceCache,
					purchasePriceCache, standardCostCache, leaf.getCompanyCode(), leaf.getFromDivisionCode(),
					leaf.getItemCode(), leaf.getFtaCode(), invoiceDate);
			BigDecimal unitPrice = priceWithNote.getPrice();
			BigDecimal originRate = resolveOriginRateCached(originRateCache, originRatePrecheckCache,
					nonCertifiedSummaryCache, leaf.getCompanyCode(), leaf.getFromDivisionCode(), leaf.getItemCode(),
					leaf.getFtaCode(), invoiceDate);
			String priceNote = priceWithNote.getPriceNote();
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
			chunk = flushIfFull(chunk, dao::insertFcrDtlRows);
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

	/** 자재 그룹의 소요량 가중평균 단가/원산지비율(최저값 기준 전량 인정/불인정)을 계산해 FCR_DTL 1행으로 집계 */
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
		row.setPriceNote(notes.isEmpty() ? null : String.join(", ", notes));
		return row;
	}

	/** 상품/부산물을 자재 1건처럼 취급해 FCR_DTL 생성. 부산물(B)은 원산지비율을 항상 100%로 본다. */
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
			chunk = flushIfFull(chunk, dao::insertFcrDtlRows);
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
		String key = MaterialHsCodeService.hsCodeKey(companyCode, divisionCode, customerCode, itemCode, nationCode, ftaCode,
				baseDate);
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

	/** ftaCode는 실제 조회 조건에 쓰이지 않아 캐시 키에서 제외한다(같은 품목이 협정 수만큼 반복 등장하므로). */
	private ItemPriceWithNote resolveItemPriceWithNoteCached(Map<String, ItemPriceWithNote> cache,
			Map<String, MaterialBalanceTierRow> divisionBalanceCache, Map<String, PoLedgerPriceRow> purchasePriceCache,
			Map<String, StandardCostRow> standardCostCache, String companyCode, String divisionCode, String itemCode,
			String ftaCode, String baseDate) {
		String key = String.join("|", nz(companyCode), nz(divisionCode), nz(itemCode), nz(baseDate));
		return cache.computeIfAbsent(key, k -> itemPriceService.resolveItemPriceWithNote(
				new ItemPriceCriteria(companyCode, divisionCode, itemCode, ftaCode, baseDate), divisionBalanceCache,
				purchasePriceCache, standardCostCache));
	}

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

	/** chunk가 INSERT_CHUNK_SIZE에 도달하면 즉시 반영하고 새 청크를 돌려준다. */
	private static <T> List<T> flushIfFull(List<T> chunk, Consumer<List<T>> insert) {
		if (chunk.size() < INSERT_CHUNK_SIZE) {
			return chunk;
		}
		insert.accept(chunk);
		return new ArrayList<>(INSERT_CHUNK_SIZE);
	}

	private static BigDecimal nvl(BigDecimal value) {
		return value == null ? BigDecimal.ZERO : value;
	}
}
