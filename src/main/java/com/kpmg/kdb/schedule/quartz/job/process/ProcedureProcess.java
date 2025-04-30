package com.kpmg.kdb.schedule.quartz.job.process;

import java.util.HashMap;
import java.util.Map;

import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.schedule.quartz.job.exception.AllInOneException;
import com.kpmg.kdb.schedule.quartz.job.factory.BatchProcess;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.schedule.quartz.job.vo.ParameterVo;
import com.kpmg.kdb.schedule.quartz.job.vo.TransferJobValueObject;
import com.kpmg.kdb.util.StringUtil;



public class ProcedureProcess extends BatchProcess {
    
    public ProcedureProcess() {
    }
    
    public ProcedureProcess(TransferJobValueObject job, BatchJobValueObject batch) {
        super(job.getBatchLogger());
        
        this.setJobVo(job);
        this.setBatchVo(batch);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public boolean applyBatch() throws Exception {
        boolean result = true;
        Map resultMap = new HashMap();
        String resultValue = new String();
        String transID = new String();
        
        try {
            if (!transferJobVo.getScheduleType().equals("M")) { // 스케줄 타입 (A or null:자동, M:수동), 수동인 경우 먼저 INTG_INTERFACE_TRANS 테이블을 생성 하고 온다.
                // 인터페이스의 마스터Key 조회
                String transId = batchService.selectTransKey();
                batchJobVo.setTransId(StringUtil.null2String(transId));
                
                transID = StringUtil.null2String(batchJobVo.getTransId());
                if (log.isDebugEnabled()) {
                    log.debug("1.Get trans number : " + transID);
                }
                
                // 초기값 설정
                batchJobVo.setTotalRows("0");
                batchJobVo.setJobInfo(transferJobVo.getMap());
                
                Map map = new HashMap();
                ParameterVo parameter = batchJobVo.getParameter();
                
                map.putAll(batchJobVo.getMap());
                
                if (parameter != null) {
                    parameter.setTransId(transID);
                    
                    map.put(Consistent.IF_PARAMETER_FROM_DATE, parameter.getFromDate());
                    map.put(Consistent.IF_PARAMETER_TO_DATE, parameter.getToDate());
                }
                
                // 소스데이터 이관 마스터 정보 셋팅
                if (!transID.isEmpty()) {
                    batchService.insertTransInfoData(map);
                }
            }
            
            if (!batchJobVo.getJcoId().equals("RFC902")) { // 월 판정 제외
                result = startBatch();
            }

            if (result) {
                Map paramMap = null;
                
                if (batchJobVo.getParameter() != null) {
                    paramMap = batchJobVo.getParameter().getMap();
                    paramMap.put("P_YYYYMM", paramMap.get("FROM_DATE").toString().substring(0, 6));
                    paramMap.put(Consistent.IF_BATCH_PROCEDURE_ID, batchJobVo.getProcedureId().toString());
                } else {
                    throw new AllInOneException("Inerface Error : not found input paramter.");
                }

                if (!StringUtil.null2String(batchJobVo.getProcedureId()).isEmpty()) {
                    batchService.executeProcedureProcess(paramMap);
                    resultValue = String.valueOf(paramMap.get("R_ERROR_MSG"));
                    
                    if (log.isDebugEnabled()) {
                        log.debug("procedure Map = " + resultMap);
                    }
                }

                if ("successed".equals(resultValue) || StringUtil.null2String(resultValue).equals("")) { // 성공
                    result = true;
                    batchJobVo.setTransStatus("1");
                } else { // 실패
                    result = false;
                    batchJobVo.setTransStatus("2");
                    batchJobVo.setErrorMessage(resultValue);
                }
            }
            
        } catch (Exception e) {
            batchJobVo.setErrorMessage(e.getMessage());
            
            result = false;
        }
        
        return result;
    }
    
}
