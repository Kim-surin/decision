package com.kpmg.kdb.web.common;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ErrorHandler implements ErrorController {
	
    @GetMapping("/common/error500")
    public String handleError(HttpServletRequest request) {
        
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        return "error/error500";
    }
}