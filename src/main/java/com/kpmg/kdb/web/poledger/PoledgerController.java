package com.kpmg.kdb.web.poledger;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PoledgerController {
    @RequestMapping(value="/origin/compliance/poledger/poledgerList") 
    public String poledger_view(Model model, HttpSession session){
        return "poledger/poledger_view";
    }
}
