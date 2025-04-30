package com.kpmg.kdb.schedule.quartz.job.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;
import com.kpmg.kdb.schedule.quartz.job.common.Consistent;
import com.kpmg.kdb.schedule.quartz.job.transfer.ProcedureTransfer;
import com.kpmg.kdb.schedule.quartz.job.vo.BatchJobValueObject;
import com.kpmg.kdb.util.ApplicationContextAwareExtends;
import com.kpmg.kdb.util.StringUtil;



@Service("batchService")
public class BatchService extends GeneralService {
	
	private static Log log = LogFactory.getLog(BatchService.class);
	private ProcedureTransfer procedureTransfer;
	
    
	public BatchService() {}
    
	
    @SuppressWarnings({ "rawtypes" })
    public List<Map> checkMemberInfo(Map<String, Object> map) throws Exception {
        return null;//mainDAO.selectMember(map);
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectRemoteObject(BatchJobValueObject batchVo, Map interfaceMst, List inputParamList, List outputParamList) throws Exception {
        List list = new ArrayList();
        List<Object> transData = null;
        
        try {
        	list.add(batchVo.getMap());
        	
        	
        	// INTERFACE_SCHEDULE_MAPPING.IF_METHOD (인터페이스 타입(S:SAP, O:Oracle, E:Excel, M:MS-SQL))
            String method = StringUtil.null2String(batchVo.getInterfaceMethod());	
            if(log.isDebugEnabled()) {log.debug("Interface Mathod = " + method);}            

            ApplicationContext ctx = ApplicationContextAwareExtends.getApplicationContext();
            
        	// 1. RFC인터페이스을 통해 ERP데이터를 구한다.
			/*
			 * if("S".equals(method)) { // SAP sapJcoTransfer = (SapJcoTransfer)
			 * ctx.getBean("sapJcoTransfer"); transData =
			 * sapJcoTransfer.callRemoteFunction(batchVo, interfaceMst, inputParamList,
			 * outputParamList); } else
			 */if("O".equals(method) || "M".equals(method) ) {	// Oracle
        		procedureTransfer = (ProcedureTransfer) ctx.getBean("procedureTransfer");
        		
        		transData = procedureTransfer.retrieveTransData(batchVo, inputParamList, outputParamList);
        	}
            
        	if(log.isDebugEnabled()) {log.debug("call remote function's result : " + batchVo.toString());}
        	
            if (transData == null || transData.size() < 1) {
                log.debug("RFC Data : null or empty");
            }
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            throw exp;
        }

        return transData;
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateScheduleBatchDate(Map map) throws Exception {
        int rstCnt = 0;

        try {
            rstCnt = this.modifyScheduleBatchDate(map);
        } catch (Exception exp) {
            throw exp;
        }

        return rstCnt;
    }
    
    
    public String selectTransKey() throws Exception {
        String key = null;

        try {
            key = this.retrieveTransKey();
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            throw exp;
        }
        
        return key;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int insertTransInfoData(Map map) throws Exception {
        int rstCnt = 0;

        try {
            rstCnt = this.createTransInfoData(map);
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            throw exp;
        }

        return rstCnt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateJcoCountData(BatchJobValueObject batchVo) throws Exception {
        
        
        int rstCnt = 0;

        try {
        	Map paramMap = new HashMap(); 
        			
        	paramMap.putAll(batchVo.getMap());
        	
        	if(batchVo.getParameter() != null) {
        		paramMap.put("FROM_DATE", batchVo.getParameter().getFromDate());
        		paramMap.put("TO_DATE", batchVo.getParameter().getToDate());
        	}
        	
            rstCnt = this.modifyJcoCountData(paramMap);

            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            throw exp;
        }

        return rstCnt;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int insertTransDtlData(BatchJobValueObject batchVo, List<Object> source) throws Exception {
        
        int rstCnt = -1;

        try {
        	
        	Iterator<Object> iter = source.iterator();
        	
        	
        	//Execute Batch 
        	while(iter.hasNext()){
        		Map rowMap = (Map)iter.next();
        		rstCnt += this.createTransDtlData(rowMap); 
        	}
            

            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            throw exp;
        }

        return rstCnt;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateTransInfoData(Map map) throws Exception {
        
        int rstCnt = 0;
        try {
            rstCnt = this.modifyTransInfoData(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            throw exp;
        }

        return rstCnt;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectSchedulerItemList(Map map) throws Exception {
        
        List rstList = null;
        
        try {
            rstList = this.retrieveSchedulerItemList(map);
            
            
            log.debug("target info : " + rstList.get(0));
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }

    
    public int insertToTargetData(BatchJobValueObject batchVo, List<Object> target) throws Exception {
        int rstCnt = 0;

        try {
            if (target.size() > 0) {
            	Map<String, Object> inMap = new HashMap<String, Object>();
                
                inMap.put(Consistent.IF_BATCH_HISTORY_TABLE, batchVo.getHistoyTable());
                inMap.put(Consistent.IF_BATCH_TARGET_TABLE, batchVo.getTargetTable());
                inMap.put(Consistent.IF_BATCH_TRANS_ID, batchVo.getTransId());
                inMap.put(Consistent.IF_JOB_CREATE_BY, batchVo.getMap().get(Consistent.IF_JOB_CREATE_BY));
                inMap.put(Consistent.IF_JOB_COMPANY_CODE, batchVo.getMap().get(Consistent.IF_JOB_COMPANY_CODE));
                inMap.put("itemList", target);
                            
                log.debug("insertToTargetData parameter : "+inMap);
                
                rstCnt = this.createToTargetData(inMap);
            } else {
                if (log.isErrorEnabled()) {
                    log.error("not found schedule Info.");
                }
            }
            
        } catch (Exception exp) {
            throw exp;
        }
        return rstCnt;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectInterfaceScheduleList(Map map) throws Exception {
        
        List rstList = null;
        
        try {
            rstList = this.retrieveInterfaceScheduleList(map);
            
            
            log.debug("schedule info" + rstList.toString());
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        return rstList;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectInterfaceMappingList(Map map) throws Exception {
        
        List rstList = null;
        
        try {
            rstList = this.retrieveInterfaceMappingList(map);
            
            
            log.debug("schedule-interface mapping info : " + rstList.toString());
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }

    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectBatchResultInfo(Map map) throws Exception {
        
        List rstList = null;
        
        try {
            rstList = this.retrieveBatchResultInfo(map);
            
            
            log.debug("batch result info : " + rstList.toString());
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deleteInterfaceTable(List<Object> target) throws Exception {
         // 수행 시간 계산용
        
        int rstCnt = 0;
        
        try {
        	Iterator<Object> iter = target.iterator();
        	
        	while(iter.hasNext()){
        		Map rowMap = (Map)iter.next();
        		this.deleteInterfaceTableBatch(rowMap);
        	}
            
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }

        return rstCnt;
    }
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deleteInterfaceTable(Map map) throws Exception {
        
        
        int rstCnt = 0;
        
        try {
        	this.deleteInterfaceTableBatch(map);
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }

        return rstCnt;
    }

    
   @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateInterfaceScheduleDate(Map map) throws Exception {
        
        int rstCnt = 0;
        
        try {
            rstCnt = this.modifyInterfaceScheduleDate(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }

        return rstCnt;
    }

    
   @SuppressWarnings({ "rawtypes", "unchecked" })
    public void executeProcedureProcess(Map map) throws Exception {
	   this.executeProcedure(map);	
    }
    
    
   @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateProcedureResult(Map map) throws Exception {
        int rstCnt = 0;
        
        try {
            rstCnt = this.modifyProcedureResult(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }

        return rstCnt;
    }

    
   @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateFinishedTime(Map map) throws Exception {
        int rstCnt = 0;
        
        try {
            rstCnt = this.modifyFinishedTime(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }

        return rstCnt;
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectResultMessage(Map map) throws Exception {
        List rstList = null;
        
        try {
            rstList = this.retrieveResultMessage(map);
            
            
            log.debug("batch result info : " + rstList.toString());
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectBatchYYYYMM(Map map) throws Exception {
        List rstList = null;
        
        try {
            rstList = this.retrieveBatchDate(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }
    
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map selectSchedulerItemMstMap(Map map) throws Exception {
        Map returnValue = null;
        
        try {
        	returnValue = this.retrieveDataTransferMaster(map);
            
            
        } catch (Exception exp) {
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return returnValue;
    }    
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List<Object> selectSchedulerItemDtlList(Map map) throws Exception {
        
        List rstList = null;
        
        try {
            rstList = this.retrieveDataTransferDetail(map);
            
            
            
        } catch (Exception exp) {
        	// exp.printStackTrace();
            log.debug(exp.getMessage());
            // logger.logEnd(false);
            
            throw exp;
        }
        
        return rstList;
    }

	public int modifyFinishedTime(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).modifyFinishedTime(param);
    }
	public int modifyProcedureResult(Map<String, Object> param){
    	return  sqlSession.getMapper(BatchDao.class).modifyProcedureResult(param);
    }
	
	
	public Map<String,Object> retrieveDataTransferMaster(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveDataTransferMaster(param);
    }
    public List<Map<String,Object>> retrieveDataTransferDetail(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveDataTransferDetail(param);
    }
    
    public List<Map<String,Object>> retrieveBatchDate(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveBatchDate(param);
    }
    public List<Map<String,Object>> retrieveResultMessage(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveResultMessage(param);
    }
    
    @SuppressWarnings({"unchecked" })
    public void executeProcedure(Map<String, Object> param) throws Exception {
    	
    	if("BATCH_MASTER".equalsIgnoreCase(String.valueOf((param.get(Consistent.IF_BATCH_PROCEDURE_ID))))){
    		sqlSession.getMapper(BatchDao.class).executeProcedureMaster(param);
    		
    	}else if("MONTHLY_BATCH".equalsIgnoreCase(String.valueOf((param.get(Consistent.IF_BATCH_PROCEDURE_ID))))){
    		sqlSession.getMapper(BatchDao.class).executeProcedureMonthly(param);
    		
    	}else if("DAILY_BATCH".equalsIgnoreCase(String.valueOf((param.get(Consistent.IF_BATCH_PROCEDURE_ID))))){
    		sqlSession.getMapper(BatchDao.class).executeProcedureDaily(param);
    	}
    }
    
    
    public int modifyInterfaceScheduleDate(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).modifyInterfaceScheduleDate(param);
    }
    
    
    
    
    public int deleteInterfaceTableBatch(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).deleteInterfaceTable(param);
    }
    
    
    public List<Map<String, Object>> retrieveBatchResultInfo(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveBatchResultInfo(param);
    }
    
    
    public List<Map<String, Object>> retrieveInterfaceMappingList(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveInterfaceMappingList(param);
    }
    
    public List<Map<String, Object>> retrieveInterfaceScheduleList(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveInterfaceScheduleList(param);
    }
    
    
    public int createToTargetData(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).createToTargetData(param);
    }
    
    
    public List<Map<String, Object>> retrieveSchedulerItemList(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveSchedulerItemList(param);
    }
    
    
    int modifyTransInfoData(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).modifyTransInfoData(param);
    }
    
    
    public int createTransDtlData(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).createTransDtlData(param);
    }
    
    
    int modifyJcoCountData(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).modifyJcoCountData(param);
    }
    
    
    public int createTransInfoData(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).createTransInfoData(param);
    }
    
    
    public String retrieveTransKey() throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).retrieveTransKey();
    }
    
    
    int modifyScheduleBatchDate(Map<String, Object> param) throws Exception {
    	return  sqlSession.getMapper(BatchDao.class).modifyScheduleBatchDate(param);
    }
}
