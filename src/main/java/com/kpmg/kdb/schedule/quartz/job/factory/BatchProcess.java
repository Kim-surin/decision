package com.kpmg.kdb.schedule.quartz.job.factory;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;

import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLogger;
import com.kpmg.kdb.schedule.quartz.job.logger.TransferBatchLoggerImpl;
import com.kpmg.kdb.schedule.quartz.job.service.BatchService;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.schedule.quartz.job.vo.TransferJobValueObject;
import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.StringUtil;

public abstract class BatchProcess {

	protected Log log = LogFactory.getLog(this.getClass());

	protected BatchService batchService;

	protected TransferBatchLogger logger;

	protected TransferJobValueObject transferJobVo;

	protected BatchJobValueObject batchJobVo;

	public BatchProcess() {
	}

	protected BatchProcess(TransferBatchLogger logger) {
		this(logger, null);
	}

	protected BatchProcess(TransferBatchLogger blogger, BatchService target) {
		if (target != null) {
			this.batchService = target;
		} else {
			ApplicationContext ctx = ApplicationContextAwareExtends.getApplicationContext();

			batchService = (BatchService) ctx.getBean("batchService");
		}

		if (blogger != null) {
			this.logger = blogger;
		} else {
			if (transferJobVo.getBatchLogger() != null) {
				this.logger = transferJobVo.getBatchLogger();
			} else {
				this.logger = new TransferBatchLoggerImpl();
			}
		}
	}

	protected void setJobVo(TransferJobValueObject vo) {
		this.transferJobVo = vo;
	}

	protected void setBatchVo(BatchJobValueObject vo) {
		this.batchJobVo = vo;
	}

	public boolean startBatch() throws Exception {
		boolean checker = true;

		try {
			if (log.isDebugEnabled()) {
				log.debug("startBatch() job info : " + transferJobVo.toString() + " / batch info : " + batchJobVo.toString());
			}

			// 상위 배치 수행이 정상적으로 완료되었지는 체크
			checker = batchRunable(transferJobVo, batchJobVo);

			if (checker)
				checker = this.executeBatch();

			if (checker) { // 배치 실행결과
				batchJobVo.setTransStatus("1");
				batchJobVo.setBatchStatus("S");
			} else {
				batchJobVo.setTransStatus("2");
				batchJobVo.setBatchStatus("E");
			}

			transferJobVo.setBatchList(transferJobVo.getBatchVoSize(), batchJobVo);
		} catch (Exception exp) {
			try {
				logger.logMessage("[ERROR] " + exp.getMessage());
				checker = false;
			} catch (Exception ex) {
				throw ex;
			}

			throw exp;
		}
		return checker;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Boolean executeBatch() throws Exception {
		String message = null;
		int rstCnt = 0;

		try {
			Map paramMap = null;

			if (batchJobVo.getParameter() != null) {
				paramMap = batchJobVo.getParameter().getMap();
			} else {
				throw new AllInOneException("JCO Inerface Error : not found input paramter.");
			}

			// 1. Set 이관 관련 설정 정보
			Map interfaceMst = batchService.selectSchedulerItemMstMap(paramMap);

			batchJobVo.setFunctionName(StringUtil.null2String(interfaceMst.get(Consistent.IF_BATCH_FUNCTION_NAME))); // ERP
																														// 프로그램명
			batchJobVo.setSourceTable(StringUtil.null2String(interfaceMst.get(Consistent.IF_BATCH_SOURCE_TABLE))); // ERP
																													// 이관테이블명
			batchJobVo.setHistoyTable(StringUtil.null2String(interfaceMst.get(Consistent.IF_BATCH_HISTORY_TABLE))); // K-Origin
																													// 이력
																													// 테이블
																													// INTG_INTERFACE_TRANS_DTL
			batchJobVo.setTargetTable(StringUtil.null2String(interfaceMst.get(Consistent.IF_BATCH_TARGET_TABLE))); // K-Origin
																													// 대상
																													// 테이블
																													// _INF

			// 2. input parameter (INTERFACE_ITEM_DTL.COLUMN_TRANS_TYPE ==> I)
			batchJobVo.setColumnTransType("I");
			List<Object> inputParamList = batchService.selectSchedulerItemDtlList(batchJobVo.getMap());

			// 3. output parameter (INTERFACE_ITEM_DTL.COLUMN_TRANS_TYPE ==> O)
			batchJobVo.setColumnTransType("O");
			List<Object> outputParamList = batchService.selectSchedulerItemDtlList(batchJobVo.getMap());

			// 4. ERP데이터 추출
			List<Object> sourceList = batchService.selectRemoteObject(batchJobVo, interfaceMst, inputParamList, outputParamList);

			log.debug("call selectRemoteObject count =" + sourceList.size());

			// ERP데이터의 유효성 검증
			if (sourceList != null && sourceList.size() > 0) {
				//sap jco 인터페이스 사용 X
				//SapJcoMapValidator.check(outputParamList, sourceList);
			} else {
				sourceList = new ArrayList();
			}

			log.debug("call JcoMapValidator.check() count =" + sourceList.size());

			// ERP데이터에서 추출한 데이터 건수 업데이트
			if (sourceList != null && sourceList.size() > 0) {
				batchJobVo.setTotalRows(sourceList.size() + "");

				rstCnt = batchService.updateJcoCountData(batchJobVo);
			}

			log.debug("call updateJcoCountData count =" + rstCnt);

			// ERP에서 획득한 데이터을 전송테이블에 이관
			if (rstCnt > 0) {
				// log.debug("******************* sourceList = " + sourceList);
				rstCnt = batchService.insertTransDtlData(batchJobVo, sourceList); // 성공시 0이 리턴된다.
			}

			log.debug("call insertTransDtlData count =" + rstCnt);

			// 이관결과 업데이트
			if (rstCnt > 0) {
				rstCnt = batchService.updateTransInfoData(batchJobVo.getMap());
			} else {
 				return false;
			}

			if (rstCnt > 0) {
				// 대상 테이블의 컬럼, 속성 조회하는 매소드
				batchJobVo.setColumnTransType("O");
				List<Object> result = batchService.selectSchedulerItemList(batchJobVo.getMap());

				// 8. 에러가 0개인 경우 데이터를 인터페이스 테이블에 등록
				if (result != null && result.size() > 0) {
					String ransId = batchJobVo.getTransId();

					batchJobVo.setTransId("");
					rstCnt = batchService.deleteInterfaceTable(batchJobVo.getMap());

					batchJobVo.setTransId(ransId);
					rstCnt = batchService.insertToTargetData(batchJobVo, result);

					batchJobVo.setBatchStatus("S");
				} else {
					return false;
				}
			} else {
				return false;
			}

			if ("S".equals(batchJobVo.getBatchStatus())) {
				message = "success";
			} else {
				if ("E".equals(batchJobVo.getBatchStatus())) {
					message = batchJobVo.getErrorMessage();

					throw new AllInOneException(message);
				} else {
					message = "input data is empty(0).";
				}
			}
		} catch (Exception exp) {
			log.error("executeBatch - exception = " + exp.getMessage());

			try {
				message = exp.getMessage();
				batchJobVo.setErrorMessage(message);

				batchService.updateProcedureResult(batchJobVo.getMap());
			} catch (Exception ex) {
				throw ex;
			}
			throw exp;
		} finally {
			logger.logMessage("(interfacetrandtl) result message = " + message);
		}

		return true;
	}

	@SuppressWarnings("rawtypes")
	protected List userCertify(Map<String, Object> map) throws Exception {
		List<Map> resultList = batchService.checkMemberInfo(map);

		if (resultList == null || resultList.size() < 1) {
			logger.logMessage("[ERROR] User authentication failed. The reason is empty user's information.");
			throw new Exception("User authentication failed. user info is null");
		}

		return resultList;
	}

	@SuppressWarnings("rawtypes")
	protected List getInterfaceMappingList(Map map) throws Exception {
		return batchService.selectInterfaceMappingList(map);
	}

	protected boolean batchRunable(TransferJobValueObject transferJobVo, BatchJobValueObject batchJobVo) throws Exception {
		boolean execResult = true;

		String if_parent = batchJobVo.getParentCode();

		if (if_parent != null && !if_parent.isEmpty()) {
			List<BatchJobValueObject> batchList = transferJobVo.getBatchList();

			// 인터페이스 실행 전 상위 인터페이스가 있다면 실행 결과를 체크하여 성공했을 경우 본 인터페이스를 실행한다.
			for (int k = 0; k < batchList.size(); k++) {
				BatchJobValueObject completeVo = batchList.get(k);

				if (completeVo.getInterfaceCode() != null) {
					// 상위 인터페이스의 실행결과를 확인한 후 실행
					if (if_parent.equals(completeVo.getInterfaceCode())) {
						if (!"E".equals(completeVo.getBatchStatus())) {
							logger.logMessage("Import Map Data(IF_CODE:" + batchJobVo.getInterfaceCode() + " / IF_PARENT_CODE:" + if_parent + ")");
						} else {
							execResult = false;
							logger.logMessage("Parent interface is failed.");

							break;
						}
					}
				}
			}

		} else {
			logger.logMessage("Import Map Data(IF_CODE:" + batchJobVo.getInterfaceCode() + " / IF_PARENT_CODE:" + if_parent + ")");
		}

		return execResult;
	}

	@SuppressWarnings("rawtypes")
	protected void updateInterfaceScheduleDate(Map map) throws Exception {
		batchService.updateInterfaceScheduleDate(map);
	}

	@SuppressWarnings("rawtypes")
	protected void updateExceptionResult(Map map) throws Exception {
		batchService.updateProcedureResult(map);
	}

	@SuppressWarnings("rawtypes")
	protected void updateFinishedTime(Map map) throws Exception {
		batchService.updateFinishedTime(map);
	}

	@SuppressWarnings("rawtypes")
	protected List<Object> selectBatchYYYYMM(Map map) throws Exception {
		return batchService.selectBatchYYYYMM(map);
	}

	public abstract boolean applyBatch() throws Exception;

}
