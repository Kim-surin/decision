package com.kpmg.kdb.web.poledger;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kpmg.kdb.core.form.GridOutputData;
import com.kpmg.kdb.core.generic.GenericController;

@Controller
public class PoledgerController extends GenericController {
    @Autowired
    protected PoledgerService poledgerService;

    @RequestMapping(value="/origin/compliance/poledger/poledger") 
    public String poledger_view(Model model, HttpSession session) {
        return "poledger/poledger_view";
    }
    
    @RequestMapping(value = "/origin/compliance/poledger/poledgerList")
    @ResponseBody
    public GridOutputData poledger_list(@RequestBody Map param) throws Exception {

        GridOutputData gridData = null;
        try {
            // rs.setValue(poledgerService.retrievPoledger(param));
            // rs.setSuccess(true);
            gridData = new GridOutputData(poledgerService.retrievPoledger(this.extendsMap(param)), 1, 1, 1);
        } catch (Exception e) {

        }

        return gridData;
    }
    
    @RequestMapping(value = "/origin/compliance/poledger/poLedgerDtlList")
    @ResponseBody
    public GridOutputData poledger_dtl_list(@RequestBody Map param) throws Exception {
        
        GridOutputData gridData = null;
        try{
            gridData = new GridOutputData(poledgerService.poLedgerDtlList(this.extendsMap(param)), 1, 1, 1);
        } catch (Exception e) {

        }  
        return gridData;
    }
}
