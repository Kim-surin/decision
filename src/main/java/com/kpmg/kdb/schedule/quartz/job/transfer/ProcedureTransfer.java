package com.kpmg.kdb.schedule.quartz.job.transfer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.util.StringUtil;

@Service("procedureTransfer")
public class ProcedureTransfer extends GeneralService {


	public ProcedureTransfer() {
	}

	/**
	 * ERP DATA를 생성한 뒤 해당데이터를 조회하여 리턴합니다.
	 * 
	 * @param map
	 * @return List ERP데이터의 유효성 검증결과을 포함한 ERP데이터
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Object> retrieveTransData(BatchJobValueObject batchVo, List inputParamList, List outputParamList) throws Exception {

		List<Object> data = null;
		try {

			Map paramMap = null;
			if (batchVo.getParameter() != null) {
				paramMap = batchVo.getParameter().getMap();
			} else {
				throw new AllInOneException("RPC Inerface Error : not found input paramter.");
			}

			paramMap.put("FUNCTION_NAME", StringUtil.null2String(batchVo.getFunctionName()));
			paramMap.put("BATCH_DATE", ((String) paramMap.get("FROM_DATE")).substring(0, 6));

			if (batchVo.getItemType().equals("B")) {
				this.executeRemoteProcedure(paramMap);
			}

			// 인터페이스 처리 방법
			if (batchVo.getItemType().equals("B") || batchVo.getItemType().equals("C")) {
				Map rpcMap = new HashMap();

				// ERP 이관 테이블 조회문 설정
				rpcMap.put(Consistent.IF_JOB_COMPANY_CODE, batchVo.getMap().get(Consistent.IF_JOB_COMPANY_CODE));
				rpcMap.put(Consistent.IF_BATCH_TRANS_ID, batchVo.getMap().get(Consistent.IF_BATCH_TRANS_ID));
				rpcMap.put(Consistent.IF_JOB_CREATE_BY, batchVo.getMap().get(Consistent.IF_JOB_CREATE_BY));
				rpcMap.put(Consistent.IF_JOB_UPDATE_BY, batchVo.getMap().get(Consistent.IF_JOB_UPDATE_BY));
				rpcMap.put(Consistent.IF_PARAMETER_IF_CODE, batchVo.getMap().get(Consistent.IF_PARAMETER_IF_CODE));
				rpcMap.put(Consistent.IF_PARAMETER_FROM_DATE, batchVo.getMap().get(Consistent.IF_PARAMETER_FROM_DATE));
				rpcMap.put(Consistent.IF_PARAMETER_TO_DATE, batchVo.getMap().get(Consistent.IF_PARAMETER_TO_DATE));

				rpcMap.put("SOURCE_TABLE", batchVo.getSourceTable()); // ERP 이관
																		// 테이블
				rpcMap.put("COLUMN_LIST", outputParamList); // 컬럼명 List
				
				rpcMap.put("PARAM_LIST", inputParamList); // 컬럼명 List

				
				data = this.retrieveGeneratedData(rpcMap);
			}

		} catch (Exception e) {
			
		}

		return data;
	}

	/**
	 * 외부 프로시저를 호출합니다. anotherSqlSession 는 외부 DataSource를 사용합니다.
	 * 
	 * @author Damned.Cat
	 * @param map
	 * @return returnMap (Procedure Result Map)
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	public void executeRemoteProcedure(Map map) throws Exception {

		//아모래 사용안함 : anotherSqlSession.getMapper(ProcedureTransWorker.class).executeRemoteProcedure(map);
	}

	/**
	 * 외부 프로시저를 호출하여 생성되어진 데이터를 조횝니다.
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Object> retrieveGeneratedData(Map<String, Object> param) throws Exception {
		return null; //아모래 사용안함 : anotherSqlSession.getMapper(ProcedureTransWorker.class).retrieveGeneratedData(param);
	}

}
