<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>5555</title>
        <link href="/rcs/ui5x/css/bootstrap.css" rel="stylesheet">
        <link href="/rcs/ui5x/css/smartapp.css" rel="stylesheet">
        <link href="/rcs/ui5x/css/authentication.css" rel="stylesheet">
        <style type="text/css">
        	.hero-section{
        		background: linear-gradient(110deg, #4100ff, #947bb5, #9e83b3);
        	}
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark position-fixed w-100 py-3" style="z-index: 1000;">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="/rcs/img/kpmg_logo.svg" alt="logo">
                </a>
                <div class="ms-auto d-flex gap-2">
                    <!-- <a href="login.html" class="btn btn-link text-white border-0 text-decoration-none">Login</a> -->
                    <a href="javascript:void(0);" class="btn btn-link text-white border-0 text-decoration-none">Contact us</a>
                </div>
            </div>
        </nav>
        <!-- Login Page -->
        <section class="hero-section position-relative overflow-hidden">
            <div class="container" style="position: relative; z-index: 1;">
                <div class="row justify-content-center">
                    <div class="col-11 col-md-8 col-lg-6 col-xl-4">
                        <div id="regular-login" class="login-card p-4 p-md-5 bg-dark bg-opacity-50 translucent-dark rounded-4">
                            <h2 class="text-center mb-4">Login</h2>
                            <p class="text-center text-white opacity-50 mb-4">&nbsp;</p>
                            <form id="loginPage_form" name="loginPage_form" return="false">
                            	<input type="hidden" id="ENC_PASSWORD" name="ENC_PASSWORD"/>
                                <div class="d-grid mb-3">
                                    <label for="COMPANY_CODE" class="form-label">Company</label>
                                    <input type="text" class="form-control form-control-lg text-white bg-dark border-light border-opacity-25 bg-opacity-25" id="COMPANY_CODE" name="COMPANY_CODE" value="ADMIN1000">
                                </div>
                                <div class="divider small text-white opacity-25">And</div>
                                <div class="mb-3">
                                    <label for="USER_ID" class="form-label">Account</label>
                                    <input type="text" class="form-control form-control-lg text-white bg-dark border-light border-opacity-25 bg-opacity-25" id="USERID" name="USERID" value="fta">
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control form-control-lg text-white bg-dark border-light border-opacity-25 bg-opacity-25" id="PASSWORD" name="PASSWORD" value="fta">
                                    </div>
                                </div>
                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-primary btn-lg bg-primary bg-opacity-75">Sign In</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <script src="/rcs/ui5x/scripts/smartApp.js"></script>
        <script src="/rcs/ui5x/scripts/bootstrap.bundle.js"></script>
        
        <script src="/rcs/js/libs/jquery-2.1.1.min.js"></script>
		<script src="/rcs/js/libs/jquery-ui-1.10.3.min.js"></script>
		<script src="/rcs/js/login/style_01/tilt/tilt.jquery.min.js"></script>
		<script src="/rcs/js/security/encrypt.js"></script>
		<script src="/rcs/js/utils.common.js"></script>
		<script src="/rcs/js/package.common-v2.3.js"></script>
		
        <script>
	        var oLoginPage = new function() {
	            
	            $('#loginPage_form').submit(function(event) {
	                
					event.preventDefault();
					var postData = {
					        "COMPANY_CODE" : KpackageOBJ.object.getFormValue("loginPage_form", "COMPANY_CODE")
							,"USERID" : KpackageOBJ.object.getFormValue("loginPage_form", "USERID")
							,"ENC_PASSWORD" : encryptStr(KpackageOBJ.object.getFormValue("loginPage_form", "PASSWORD")).toString()
					}; 
					
					KpackageOBJ.ajax.doSubmit("/common/retrieveUserCheck", postData, oLoginPage.login, null, false); 
				});
	            
	            
				this.login = function(data) {
					if (data.value.login_cnt > 0) {
						KpackageOBJ.object.setFormValue("loginPage_form"
								, "ENC_PASSWORD"
								, encryptStr(KpackageOBJ.object.getFormValue("loginPage_form", "PASSWORD")).toString());
						
						loginPage_form.action = "/login";
						loginPage_form.submit();
					}
				};
	            
	        } //var oLoginPage = new function() {

        </script>
    </body>
</html>