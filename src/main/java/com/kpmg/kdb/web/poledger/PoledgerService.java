package com.kpmg.kdb.web.poledger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kpmg.kdb.core.generic.GeneralService;

@Service
public class PoledgerService extends GeneralService {
	public List retrievPoledger(Map<String, Object> param) throws Exception {
		List data = new ArrayList<Map>();

		try {
			data = sqlSession.getMapper(PoledgerDao.class).retrievPoledger(param);
		} catch (Exception e) {

		}

		return data;
	}
	
	 public List poLedgerDtlList(Map<String, Object> param) throws Exception {
		List data = new ArrayList<Map>();

    	try {
    		data = sqlSession.getMapper(PoledgerDao.class).poLedgerDtlList(param);
    	} catch (Exception e) {
    		
    	}
    	
    	return data;
    }
}
