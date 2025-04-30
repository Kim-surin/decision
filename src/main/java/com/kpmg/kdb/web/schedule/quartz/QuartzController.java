package com.kpmg.kdb.web.schedule.quartz;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kpmg.kdb.schedule.quartz.job.QuartzManger;
import com.kpmg.kdb.core.generic.GenericController;
import com.kpmg.kdb.core.form.Result;


@Controller
public class QuartzController extends GenericController  {


    protected Logger logger = LoggerFactory.getLogger(QuartzController.class);

    @Autowired
    protected QuartzService service;

    @RequestMapping(value="/common/quartzTest")    
    public void retrieveTreeData(Map param) {
        Result rs = new Result();
        
        try {
        	QuartzManger.startBatch(param);
        	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			
		}
        
    }
    
}
