
/*******************************************************************************************
 * 
 * package.common.js
 * 
 * @since 2018.02.01
 * @author 망할고양이
 *
 * 시스템 공통 함수 구현 Jquery,Js
 * 
 ********************************************************************************************/

/***************************************************************************************************************
 * jQgrid Default Css Remove Function
 ***************************************************************************************************************/
function jQgrid_Common_Css(){
	$(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
    $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
    $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
    $(".ui-jqgrid-pager").removeClass("ui-state-default");
    $(".ui-jqgrid").removeClass("ui-widget-content");
    
    // add classes
    $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
    $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");
   
   
    $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
    $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");
    $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");
    $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");
    $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
    $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
    $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
    $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
  
	$( ".ui-icon.ui-icon-seek-prev" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
	$(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");
	
	$( ".ui-icon.ui-icon-seek-first" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
  	$(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");		  	

  	$( ".ui-icon.ui-icon-seek-next" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
  	$(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");
  	
  	$( ".ui-icon.ui-icon-seek-end" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
  	$(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
}


var KpackageOBJ = {
		
		"prototype" : {
			"unipass_local_dir" : "C:\\KCSAPI4\\KPMG\\log\\"
			,"seperator" : "-"
			,"errorClass" : "validatebox-invalid"
			,"errorElement" : "div"
			,validation_highlight: function(element) {
		        $(element).parent().removeClass('state-success').addClass("state-error");
		        $(element).removeClass('valid');
		    }
			,validation_unhighlight: function(element) {
		        $(element).parent().removeClass("state-error").addClass('state-success');
		        $(element).addClass('valid');
		    }
			,"topDownPx" : -60
			,"USER" : "사용자 조회"
			,"MAX_EMAIL_ATTACH_SIZE" : 5000000 
			,"unKnown" : false	//우측의 설정모드를 활성화 합니다.
			,"regexp_notPaging" : /^((?!paging).)*$/
			,"minusHeight" : 250
			,"minimumHeight" : 150
			,"pop_L_Width" : $(window).width() - 100
			,"pop_L_Height" : $(window).height() - 100
			,"pop_M_Width" : $(window).width() * 0.7
			,"pop_M_Height" : $(window).height()* 0.7 
			,"pop_S_Width" : $(window).width() * 0.3 
			,"pop_S_Height" : $(window).height() * 0.3
		},
		"pieChart" : {
			chartColor01 : ["#0091da","#00338d"]
			,chartColor02 : ["#00338d","#0091da"]
			,chartColor03 : ['#00338d','#005eb8','#0091da','#483698','#470a68','#85468d','#00a3a1','#009a44','#43b02a','#eaaa00','#f68d2e','#c2345b',
							'#e36877','#00338d','#0091da','#6d2077','#005eb8','#00a3a1','#eaaa00','#43b02a','#c6007e','#753f19','#9b642e','#9d9375',
							'#e3bc9f','#e36877']
				
		},
		"chart" : {
			create : function (p_Type, p_CanvasId, p_Data, p_Title, p_Responsive, customOption){
				
				var l_Responsive = true;
				
				
				if(p_Type == undefined){return null;}
				if(p_Data == undefined){return null;}
				if(p_Title == undefined){return null;}
				
				if(p_Responsive != undefined){
					l_Responsive = p_Responsive;
				}
				
				if(customOption == undefined || customOption == null){
					if("doughnut" == p_Type){
						return  new Chart(document.getElementById(p_CanvasId),{
							type: p_Type,
							data: p_Data,
							options: {
								responsive: l_Responsive,
				                title: {
									display: true,
									text: p_Title,
									fontSize: 15,
									padding: 20
								},
								
								legend: {
									display: false, 
									position: 'bottom',
									reverse: true
						        },
						        layout: {
						        	padding: {
						        		bottom : 10
						        	}
						        }
						        
							}
						});
					}else if("bar" == p_Type){
						return new Chart(document.getElementById(p_CanvasId), {
				            type: p_Type,
				            data: p_Data,
				            
				            options: {
				                responsive: l_Responsive,
				                title: {
									display: true,
									text: p_Title,
									fontSize: 15,
									padding: 20
								},
								layout: {
									padding: {
										top: 0	
									}
								},
								scales: {
									xAxes: [{
										display: true,
										maxBarThickness: 20 
										}],
									yAxes: [{
										display: true,
										position: 'left',
										scaleLabel: {
											display: false,
											labelString: ''
										},						
										ticks: {
											callback: function(value, index, values) {
						                        return KpackageOBJ.formatter.commas(value);
						                    }
										}
									}]
								},
								legend: {
									position: 'bottom'
						        }
				            }
				        });
					}
				}else{
					if("doughnut" == p_Type){
						return  new Chart(document.getElementById(p_CanvasId),{
							type: p_Type,
							data: p_Data,
							options: {
								responsive: l_Responsive,
				                title: {
									display: true,
									text: p_Title,
									fontSize: 15,
									padding: 20
								},
								
								legend: {
									display: false, 
									position: 'bottom',
									reverse: true
						        },
						        layout: {
						        	padding: {
						        		bottom : 10
						        	}
						        },
						        tooltips: customOption
						        
							}
						});
					}else if("bar" == p_Type){
						return new Chart(document.getElementById(p_CanvasId), {
				            type: p_Type,
				            data: p_Data,
				            
				            options: {
				                responsive: l_Responsive,
				                title: {
									display: true,
									text: p_Title,
									fontSize: 15,
									padding: 20
								},
								layout: {
									padding: {
										top: 0	
									}
								},
								scales: {
									xAxes: [{
										display: true,
										maxBarThickness: 20 
										}],
									yAxes: [{
										display: true,
										position: 'left',
										scaleLabel: {
											display: false,
											labelString: ''
										},						
										ticks: {
											callback: function(value, index, values) {
						                        return KpackageOBJ.formatter.commas(value);
						                    }
										}
									}]
								},
								legend: {
									position: 'bottom'
						        }
				            }
				        });
					}
				}
				
				
				return null;
			}
		},
		"object" : {
			/** 작은 사이즈의 알림창을 호출합니다. */
			alert : function (confrim_Message){ /** bootboxjs.com/examples.html */
				if("" == confrim_Message || null == confrim_Message || confrim_Message == undefined){
					confrim_Message = "No Message";
				}
				bootbox.alert({
				    message: confrim_Message,
				    size: 'small'
				});
			},
			/** 큰 사이즈의 알림창을 호출합니다.(confirm text가 길 경우 사용하세요) */
			largeAlert : function (confrim_Message){ /** bootboxjs.com/examples.html */
				if("" == confrim_Message || null == confrim_Message || confrim_Message == undefined){
					confrim_Message = "No Message";
				}
				bootbox.alert({
				    message: confrim_Message
				});
			},
			/** 작은 사이즈의 확인창을 호출합니다. */
			confirm : function (confrim_Message, trueFunc){ /** bootboxjs.com/examples.html */
				if("" == confrim_Message || null == confrim_Message || confrim_Message == undefined){
					confrim_Message = "No Message";
				}
				
				bootbox.confirm({
				    message: confrim_Message,
				    size: 'small',
				    buttons: {
				        cancel: {
				            label: '<i class="fa fa-times"></i> Cancel'
				        },
				        confirm: {
				            label: '<i class="fa fa-check"></i> Confirm'
				        }
				    },
				    callback: function (result) {
				    	if(result){
							if(trueFunc instanceof Function){
								trueFunc(result);
							}else{
								new Function(trueFunc+"(result)")();
							}
				    	}
				    }
				});
			},
			/** 큰 사이즈의 확인창을 호출합니다.(confirm text가 길 경우 사용하세요) */ 
			largeConfirm : function (confrim_Message, trueFunc){ /** bootboxjs.com/examples.html */
				if("" == confrim_Message || null == confrim_Message || confrim_Message == undefined){
					confrim_Message = "No Message";
				}
				
				bootbox.confirm({
				    message: confrim_Message,
				    buttons: {
				        cancel: {
				            label: '<i class="fa fa-times"></i> Cancel'
				        },
				        confirm: {
				            label: '<i class="fa fa-check"></i> Confirm'
				        }
				    },
				    callback: function (result) {
				    	if(result){
				    		if(trueFunc instanceof Function){
								trueFunc(result);
							}else{
								new Function(trueFunc+"(result)")();
							}
				    	}
				    }
				});
			},
			
			getFormObject : function(ofmId, _i) {
		        var obj;
		        if (typeof ofmId == "object") {
		            return ofmId;
		        } else if (typeof ofmId == "string") {
		            if (oUtil.isNull(_i)){ 
		            	obj = $("#" + ofmId);
		            }else{
		            	obj = $("#" + ofmId+" [name='" + _i+"']");
		            }
		            
		            return obj;
		        }
		    },
			setFormValue : function(ofmId, _i, _v) {
		        if($("#"+ofmId+" #"+_i+"").length > 0){
	        		$("#"+ofmId+" #"+_i+"").val(_v);
	        	}else{
	        		$("#"+ofmId+" [name="+_i+"]").val(_v);	
	        	}
		    },
		    
		    getFormValue : function(ofmId, _i) {
		        if($("#"+ofmId+" #"+_i+"").length > 0){
	        		return $("#"+ofmId+" #"+_i+"").val();
	        	}else{
	        		return $("#"+ofmId+" [name="+_i+"]").val();
	        	}
		    },
		    
		    getFormRadioValue : function(ofmId, _i) {
		    	return $("#"+ofmId+" input:radio[name='"+_i+"']:checked").val();
		    },
		    
		    readOnly : function(ofmId, objId, flag){
		    	
		    	if(flag){
		    		if("SELECT" == $("#"+ofmId+" #"+objId+"").prop("tagName")){
		    			$("#"+ofmId+" #"+objId+"").attr("disabled", "disabled");
		    		}else{
		    			$("#"+ofmId+" #"+objId+"").attr("readonly", "readonly");	
		    		}
		    		
		    	}else{
		    		if("SELECT" == $("#"+ofmId+" #"+objId+"").prop("tagName")){
		    			$("#"+ofmId+" #"+objId+"").removeAttr("disabled");
		    		}else{
		    			$("#"+ofmId+" #"+objId+"").removeAttr("readonly");	
		    		}
		    		
		    	}
				
			},
			show : function(ofmId, objId, flag){
				if("" == ofmId){
					if(flag){
			    		$("#"+objId).show();
			    	}else{
			    		$("#"+objId).hide();
			    	}
				}else{
					if(flag){
			    		$("#"+ofmId+" #"+objId).show();
			    	}else{
			    		$("#"+ofmId+" #"+objId).hide();
			    	}	
				}
		    	
				
			},
			
			
			getExtension : function(file_path){
				var type = "";
			    var inx = -1;
			    
			    inx = file_path.lastIndexOf('.');
			    
					if(inx != -1) {
					  type = file_path.substring(inx+1, file_path.length);
					} else {
					  type = "";
					}
				
				return type.toUpperCase();
			},
			
			setCheckBox : function(ofmId, objId, flag){
				KpackageOBJ.object.getFormObject(ofmId,objId).prop("checked",flag);	
			},
			
			switchFilter : function(obj, arg){
				
				if($("#"+arg+"-HIDDEN-FILTER").is(':visible')){
					$("#"+arg+"-HIDDEN-FILTER").hide();	
					$(obj).children(0).removeClass("fa-arrow-up");
					$(obj).children(0).addClass("fa-arrow-down");
				}else{
					$("#"+arg+"-HIDDEN-FILTER").show();
					$(obj).children(0).removeClass("fa-arrow-down");
	                $(obj).children(0).addClass("fa-arrow-up");
				}
				
			}
			
		},
		/**
		 * 3단위별로 콤마를 찍습니다.
		 * 소수점 이하는 콤마를 찍지 않습니다. 
		 * 마이너스 숫자의 경우도 콤마를 찍습니다.
		 */
		"formatter" : {
			"commas" : function(x){
				var rtnVal = "";
				var decPre, decNext, decDot;
				var sapMinus_Yn = false;
				try{
					if((x.toString()).indexOf("-") > -1){
						rtnVal = x.toString().replace(/-/gi, "").toString();
						rtnVal = Number(rtnVal);
						rtnVal = rtnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
						sapMinus_Yn = true;
					}else{
						rtnVal = x.toString();
						rtnVal = Number(rtnVal);
						rtnVal = rtnVal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					}
					
					if(rtnVal.indexOf(".") > -1){
						decDot = rtnVal.indexOf(".");
						decPre = rtnVal.substring(0, decDot);
						decNext = rtnVal.substring(decDot+1, rtnVal.length);
						rtnVal = decPre + "." + decNext.replace(/,/gi,"");
					}
					if(sapMinus_Yn){
						rtnVal = "-" + rtnVal;
					}
				}catch(e){
					rtnVal = "";
				}
				return $.trim(rtnVal);
			},
			"hscode10" : function(x){
				var rtnVal = "";
				
				if(oUtil.isNull(x)){
					return "";
				}
				if(x.length != 10){return x;}
				
				var tmp1, tmp2,tmp3;
				try{
					tmp1 = x.substring(0,4);
					tmp2 = x.substring(4,6);
					tmp3 = x.substring(6,10);

					rtnVal = tmp1 + "." + tmp2 +"-"+ tmp3;
				}catch(e){
					rtnVal = "";
				}
				return $.trim(rtnVal);
			}
			,
			"hscode6" : function(x){
				var rtnVal = "";
				if(x.length != 6){return x;}
				
				var tmp1, tmp2,tmp3;
				try{
					tmp1 = x.substring(0,4);
					tmp2 = x.substring(4,6);

					rtnVal = tmp1 + "." + tmp2;
				}catch(e){
					rtnVal = "";
				}
				return $.trim(rtnVal);
			}
			,
			"rawmtrl_se" : function(x){
				var rtnVal = "";
				if(x.length != 2){return x;}
				
				try{
					if(x == "00"){
						rtnVal = "수입신고필증";
					}else if(x == "02"){
						rtnVal = "기납증";
					}else if(x == "03"){
						rtnVal = "평사증";
					}else if(x == "04"){
						rtnVal = "분증";
					}else if(x == "05"){
						rtnVal = "부산물";
					}
				}catch(e){
					rtnVal = "";
				}
				return $.trim(rtnVal);
			}
			,
			"month" : function(){
		    	var arg = arguments;
                return arg[0].substring(0,4) + "-" + arg[0].substring(4,6);
                
		    },
		    
		    "date" : function(){
		    	var arg = arguments;
                return KpackageOBJ.date.makeDateFormat(arg[0]);
                
		    },
			
			
		},
		"selectbox" : {
			
			create  :  function(ofmId, objId, _url, _pd, _cp, _np, data, p_width, _sel_value_, chg_HandlerFnc){
				
				var tag = $("#"+ofmId +" #"+objId);
				var panelWidth = null;
				if (oUtil.isNull(p_width) || p_width <= 0) {
					if(!oUtil.isNull(tag.css("width"))){
						panelWidth = tag.css("width");
					}else{
						panelWidth = "auto";
					}
		        } else {
		            panelWidth = p_width+"px";
		        }
				tag.css("width",panelWidth);
				$("#"+ofmId +" #"+objId+" option").remove();
				
				var params = {};
		        var url = "";
				if (!oUtil.isNull(_url)) {
		            if (typeof _url == "string") {
		                url = _url;
		                params = {}
		            } else {
		                url = _url.href;
		                params = _url.queryParams
		            }
		        }

				if(!oUtil.isNull(chg_HandlerFnc)){
					tag.attr('onChange','javascript:'+chg_HandlerFnc+'();');
				}
				chageFlag = false;
				
				if(oUtil.isNull(url)){
					if (!oUtil.isNull(data) && data.length > 0) {
		                $.each (data, function (i) {
		                	var item = data[i];
				  			var code = item[_cp];
				  			var name = item[_np];
		                	var select = "";
		                	
		                	if(oUtil.isNull(_sel_value_) && i==0){
		                		select = "selected";
		                	}
		                	if(!oUtil.isNull(_sel_value_) && code == _sel_value_){
			  	  				select = "selected";
			  	  			}
		                	
		                	tag.append("<option value='"+code+"' "+select+">"+name+"</option>");
		                	
		                	if(i == data.length -1){
		                		var maxLen = getMaxDataLength(data, _np);
		                    	if (tag.width() < maxLen) {
		                    		//tag.css("width",maxLen+10);
		                    	}
		                    	
				  				if(!oUtil.isNull(chg_HandlerFnc)){
				  					new Function(chg_HandlerFnc+'("'+tag.val()+'")')();
				  				}
				  			}
		                });
		            } 
				}else{
					
					_pd = JSON.stringify(_pd);
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					var doAjax = $.ajax({
						url : url,
						data : _pd,
						type        : 'POST',
						contentType : 'application/json; charset=utf-8',
						cache       : false,
				        traditional : true,
				        dataType    : 'json',
				        async : false,
				        beforeSend: function( xhr ) {
				        	if(token != "" && header != "" && token != undefined && header != undefined){
				        		xhr.setRequestHeader(header, token);
				        	}
				        }
					});
					doAjax.done(function(data, textStatus) {
							var array = data.value;
							var htmlBox = [];
							$.each (array, function (i) {
								var item = array[i];
					  			var code = item[_cp];
					  			var name = item[_np];
					  			var select = "";
					  			
					  			if(oUtil.isNull(_sel_value_) && i==0){
		                    		select = "selected";
		                    	}
					  			if(!oUtil.isNull(_sel_value_) && code == _sel_value_){
					  	  			select = "selected";
					  	  		}
					  			if(oUtil.isNull(code)){
					  				code = "";
					  			}
		                    	
					  			tag.append("<option value='"+code+"' "+select+">"+name+"</option>");
					  			if(i == array.length -1){
					  				var maxLen = getMaxDataLength(array, _np);
			                    	if (tag.width() < maxLen) {
			                    		//tag.css("width",maxLen+10);
			                    	}
					  				if(!oUtil.isNull(chg_HandlerFnc)){
					  					new Function(chg_HandlerFnc+'("'+tag.val()+'")')();
					  				}
					  			}
							});						
					});
				}
				
		  		
				return true;

			},
			
			setValue : function(ofmId, objId, selectValue){
		    	
		    	if(!oUtil.isNull(selectValue)){
		    		$("#"+ofmId+" #"+objId+"").val(selectValue);
		    	}else{
		    		$("#"+ofmId+" #"+objId+"").val($("#"+ofmId+" #"+objId+" option:first").val());	
		    	}
		    }, 
		    readOnly : function(ofmId, objId, flag) {
		        var tagCurrObj = $("#"+ofmId+" #"+objId+"");
		        if(flag){
		        	tagCurrObj.addClass("input_readonly");
		        }else{
		        	tagCurrObj.not(":selected").removeAttr("disabled");
		        	tagCurrObj.removeClass("input_readonly");
		        }
		    },
		    
		    getText : function(ofmId, objId){
		    	return $("#"+ofmId+" #"+objId+" option:selected").text();
		    },
		    
		    changeItem  : function(ofmId, objId, url, param, _cp, _np) {
		    	var _url = url;
		    	
		    	var params = param;
		    	var tag = $("#"+ofmId+" #"+objId+"");
		    	$("#"+ofmId +" #"+objId+" option").remove();//option초기화
		    	var oAjax = $.ajax({
					url : _url,
					data : JSON.stringify(params),
					contentType : 'application/json; charset=utf-8',
					type: 'post',
					async : false
		    	});
		    	oAjax.done(function(data, textStatus, jqXHR) {
					var array = data.value;
					$.each (array, function (i) {
						var item = array[i];
				  		var code = item[_cp];
				  		var name = item[_np];
				  		var select = "";
				  		
				  		tag.append("<option value='"+code+"'>"+name+"</option>");	
					});
				});
		    }
			
		},  // selectbox End
		
		
		"monthPicker" : {
			
			create : function(ofmId, objId, startYear){
				if (oUtil.isNull(startYear)) {
					startYear = KpackageOBJ.date.getCurrYear();
				}
				$("#"+ ofmId+" #"+ objId).MonthPicker({
					StartYear: startYear,
			        Button: '<img src="/rcs/img/cal_btn_001.png" style="margin-left: -30px;vertical-align: text-bottom;"/>',
			        MonthFormat: 'yy-mm',
			        UseInputMask: true
			    });
			},
			
			
			getValue : function(ofmId, _i){
				var rtnVal = KpackageOBJ.object.getFormValuen(ofmId, _i);
				return rtnVal.replace(/-/gi, "");
			},
			
			setValue : function(ofmId, objId, dateValue) {
		    	var tagCurrObj = $("#"+ofmId+" #"+objId+"");
		        var y = dateValue.substring(0, 4);
		        var m = dateValue.substring(4, 6);
		        tagCurrObj.val(y + KpackageOBJ["prototype"]["seperator"] + m);
		    },
			
			disable : function(ofmId, _i, _bl){
				if (oUtil.isNull(_bl)) {
					_bl = true;
				}
				$("#"+ ofmId+" #"+ _i).MonthPicker('option', 'Disabled', _bl);
			}
			
		},
		"calendar" : {
			
			create :  function(ofmId, objId, seperator, func, editable) {
		        var tagCurrObj = $(document).find("#"+ofmId + " input[name="+objId+"]");
		    	if (oUtil.isNull(seperator)) {
		            KpackageOBJ["prototype"]["seperator"] = '-';
		        } else {
		            KpackageOBJ["prototype"]["seperator"] = seperator;
		        }
		        if (oUtil.isNull(editable)) editable = true;
		        
		        $.datepicker.regional['ko'] = {
		  			  closeText: '닫기',
		  			  prevText : '<i class="fa fa-chevron-left"></i>',
					  nextText : '<i class="fa fa-chevron-right"></i>',
		  			  currentText: '오늘',
		  			  //monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		  			  monthNamesShort: ["01","02","03","04","05","06","07","08","09","10","11","12"],
		  			  //dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		  			  weekHeader: 'Wk',
		  			  firstDay: 0,
		  			  isRTL: false,
		  			  showMonthAfterYear: true,
		  			  changeMonth: true,
		  			  changeYear: true
		        }; 

		        tagCurrObj.datepicker({
		        	dateFormat: 'yy-mm-dd',
		    		buttonImage: '/rcs/img/cal_btn_001.png',
		    		buttonImageOnly: true,
		    		buttonText: "달력",
		    		showOn: 'both',
		    		beforeShow: function(el) {
		    	        setTimeout(function(){
		    	            $('.ui-datepicker').css('z-index', 999);
		    	        }, 0);

		    	    },
		    		onSelect: function(dateText, inst) {
		    			var date = KpackageOBJ.calendar.getDateValue(dateText);
		                var year = date.getFullYear();
		                var month = (date.getMonth()+1);
		                var day = date.getDate();
		                if (month < 10) month = "0" + month;
		                if (day < 10) day = "0" + day;
		                $(document).find("input[name="+objId+"]").val(year + KpackageOBJ["prototype"]["seperator"] + month + KpackageOBJ["prototype"]["seperator"] + day);
		                if(objId != objId.replace("_CALENDAR", "").replace("CAL_", "")){
		                	$(document).find("input[name="+objId.replace("_CALENDAR", "").replace("CAL_", "")+"]").val(year + "" + month + "" + day);
		                }
		                
		                if(!oUtil.isNull(func)){
		                	new Function(func+"()")();
		                }

		            },
		            formatter: function(date) {
		                var y = date.getFullYear();
		                var m = date.getMonth() + 1;
		                var d = date.getDate();
		                return y + KpackageOBJ["prototype"]["seperator"] + (m < 10 ? ('0' + m) : m) + KpackageOBJ["prototype"]["seperator"] + (d < 10 ? ('0' + d) : d)
		            }
		        }).inputmask('yyyy-mm-dd').on("change",function (){ 
		        	if($(this).val() != ""){
		        		var date = KpackageOBJ.calendar.getDateValue($(this).val());
		                var year = date.getFullYear();
		                var month = (date.getMonth()+1);
		                var day = date.getDate();
		                if (month < 10) month = "0" + month;
		                if (day < 10) day = "0" + day;
		                $(document).find("input[name="+objId+"]").val(year + KpackageOBJ["prototype"]["seperator"] + month + KpackageOBJ["prototype"]["seperator"] + day);
		                if(objId != objId.replace("_CALENDAR", "").replace("CAL_", "")){
		                	$(document).find("input[name="+objId.replace("_CALENDAR", "").replace("CAL_", "")+"]").val(year + "" + month + "" + day);
		                }
		        	}else{
		        		$(document).find("input[name="+objId+"]").val("");
		                if(objId != objId.replace("_CALENDAR", "").replace("CAL_", "")){
		                	$(document).find("input[name="+objId.replace("_CALENDAR", "").replace("CAL_", "")+"]").val("");
		                }
		        	}
		        	
	                if(!oUtil.isNull(func)){
	                	new Function(func+"()")();
	                }
		        });
		        
		        
		        $(".datePicker").keypress(function(event) {event.preventDefault();});
		    	$.datepicker.setDefaults($.datepicker.regional['ko']);
		        $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'-30px'});  //아이콘(icon) 위치
		    	$('img.ui-datepicker-trigger').attr('align', 'absmiddle');
		    	if($("#"+ofmId).attr("class").indexOf("form-dialog") > -1){
		    		$('img.ui-datepicker-trigger').css({"margin-top" : "8px"});  //dialog 아이콘(icon) 위치
		    	}
		    },
		    
		    getDateValue : function(dateString){
		    	var year = dateString.substr(0,4);
		    	var month = parseInt(dateString.substr(5,2));
		    	if(month == 0){
		    		month = dateString.substr(5,2).replace("0","");
		    	}
		    	month = (parseInt(month)-1).toString();
		    	var day = dateString.substr(8,2);
		    	return new Date(year, month, day);
		    },
		    
		    setValue : function(ofmId, objId, dateValue) {
		    	var tagCurrObj = $("#"+ofmId+" #"+objId+"");
		        var y = dateValue.substring(0, 4);
		        var m = dateValue.substring(4, 6);
		        var d = dateValue.substring(6, 8);
		        tagCurrObj.datepicker('setDate', y + KpackageOBJ["prototype"]["seperator"] + m + KpackageOBJ["prototype"]["seperator"] + d);
		    },
		    
		    getValue : function(ofmId, objId) {
		    	var tagCurrObj = $("#"+ofmId+" #"+objId+"").val();
		        return replaceAll(tagCurrObj,KpackageOBJ["prototype"]["seperator"],'');
		    },
		    
		    disabled : function(ofmId, objId, flag) {
		    	var tagCurrObj = $("#"+ofmId+" #"+objId+"");
		        if (oUtil.isNull(flag)){
		        	flag = false;
		        }
		        if(flag){
		        	tagCurrObj.datepicker("option", "disabled", true);
		        	tagCurrObj.next("img").css("cursor","pointer");
		        	tagCurrObj.next("img").css("margin-left","-30px");
		        }else{
		        	tagCurrObj.datepicker("option", "disabled", false);
		        }
		    }
		    
			
		}, // calendar End
			
		"data" : {
			
			makePostData : function(ofmId){
				return $("#"+ofmId).serializeObject(); 
			},
			
			setFormData :  function(ofmId,jsondata){
		    	if(!oUtil.isNull(ofmId)){
		    		for (var property in jsondata) {
		    			var value = jsondata[property];
		    			var objId = property.toString();
		    			//라디오 박스 체크
		    			if($("#"+ofmId+" input[name="+objId+"]:radio").length > 0){
		    				$("#"+ofmId+" input[name="+objId+"]:radio:input[value="+value+"]").attr("checked", true);
		    				
		    			}else{
		    				$("#"+ofmId+" [name="+objId+"]").val(value);
		    			}
		    				
			    	}
		    	}
			},
			makeGetData : function(ofmId){
				var returnParam = "";
				var getFormData = $("#"+ofmId).serializeArray();
				$.each(getFormData,function(key,data) {
					returnParam += data.name+"="+data.value+"&";
				});
				return returnParam.substring(0, returnParam.length -1);
			},
			object2parameter : function(params){
				return Object.keys(params).map(function(key){ 
					  return encodeURIComponent(key) + '=' + encodeURIComponent(params[key]); 
					}).join('&');
			}
			
			
			

		}, // data End
		"validation"  : function(ofmId) {
	    	var obj =  $("#"+ofmId+"");
	    	
	    	
	    	$.validator.addMethod("month", function(value, element) {
	    		 return this.optional(element) ||  /^[\d]{4}(0[1-9]|1[0-2])$/.test(value);
	    	}, "달력(월) 양식에 맞지 않습니다.");
	    	
	    	$.validator.setDefaults({
	    		errorClass : 'validatebox-invalid',
	    		messageClass : 'isc-valid-tooltip',
	    		errorElement : 'b',
	    		meta		 : "validate"
	        });
	    	
	    	$.extend(jQuery.validator.messages, {
	    		required: "필수입력 항목 입니다.",//required:true
	    		email: "이메일을 입력하세요",//email:true
	    		url: "Please enter a valid URL.",//url:true
	    		date: "달력(날짜)형식에 맞지 않습니다.",//date:true
	    		number: "숫자 형식에 맞지 않습니다.",//number:true Integer로 되어있는거는 number로 사용
	    		digits: "Please enter only digits.",//digits:true
	    		equalTo: $.validator.format("{1} 의 값과 입력한 값이 일치하지 않습니다."),//equalTo:['#PASSWORD',PWD] 기준이 되는 필드ID, 제목
	    		maxlength: $.validator.format( "최대 {0}자까지 입력하실수 있습니다. " ),//maxlength:10
	    		minlength: $.validator.format( "최소 {0}자 이상 입력해주세요." ),//minlength:10
	    		rangelength: $.validator.format( "최소 {0}자이상 최대{1}자 이하까지만 입력가능합니다." ),//rangelength:[1,10]
	    		max: $.validator.format( "Please enter a value less than or equal to {0}." ),//max:1
	    		min: $.validator.format( "Please enter a value greater than or equal to {0}." ),//min:1
	    		step: $.validator.format( "Please enter a multiple of {0}." )//step:1
	    	});
	        return obj.valid();
	    },
		"ajax" : {
			doSubmit : function(requrl, _pd, successHandler, errorHandler, useProgress) {
				if(useProgress == undefined){
					useProgress = true;
				}
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				$.ajax({
					url : requrl,
					type : 'POST',
					cache : false,
					data : JSON.stringify(_pd),
					contentType : 'application/json; charset=utf-8',
					traditional : true,
					async : true,
					dataType : 'json',
					beforeSend: function( xhr ) {
						if(useProgress){
							load_BlockUI2(true);	
						}
						if(token != "" && header != "" && token != undefined && header != undefined){
							xhr.setRequestHeader(header, token);	
						}
						
						
					},
					success : function(result) {
						load_BlockUI2(false);
						
						if (typeof (successHandler) == "function") {
							successHandler(result);
						} else if (typeof (successHandler) == "string") {
							var callBackFunc = new Function('result', successHandler+"(result)");
							callBackFunc(result);
						}

					},
					error : function(result,a,b,c,d) {
						load_BlockUI2(false);
						if("error" == a && "Forbidden" == b){
							alert("사용자 정보가 불일치하여 로그인화면으로 돌아갑니다.");
							$(location).attr('href', '/loginform');
						}else if("/sys/runInterfaceItem" == this.url && "parsererror" == result.statusText && 200 == result.status){
							alert("인터페이스 수행을 요청하였습니다.");
						}else{
							alert("서버와 통신 중 오류가 발생하였습니다.");	
						}
						
						
					}
				});

			},
			doFormSubmit : function(ofmId, urlParam, successHandler) {
				var frm = $("#"+ofmId);
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				frm.ajaxSubmit({
					  url : urlParam,
					  dataType : 'json',
					  type: 'post',
					  contentType : "application/x-www-form-urlencoded;charset=UTF-8",
					  beforeSubmit : function(formData, jqForm, options){

						  if(token != "" && header != "" && token != undefined && header != undefined){
							  	options.headers = {header: token};
  						  }
						  
						  load_BlockUI2(true);
					  },
					  success: function(result, status) {
						  load_BlockUI2(false);
						  
						  if (typeof (successHandler) == "function") {
								successHandler(result);
						  }else if (typeof (successHandler) == "string") {
								var callBackFunc = new Function('result', successHandler+"(result)");
								callBackFunc(result);
						  }
					  },
					  error : function(result) {
							load_BlockUI2(false);
							alert("서버와 통신 중 오류가 발생하였습니다.");
					  }
				});
			},
			doFileDownload : function(formId, url, data, method){
				if(oUtil.isNull(method)){
					method = 'post';
				}
				
				// url과 data를 입력받음
			    if( url && data ){ 
			    	data = data+"&"+KpackageOBJ.data.makeGetData(formId);
			        // data 는  string 또는 array/object 를 파라미터로 받는다.
			        data = typeof data == 'string' ? data : jQuery.param(data);
			        // 파라미터를 form의  input으로 만든다.
			        var inputs = '';
			        var array = [];
			        var token = $("meta[name='_csrf']").attr("content");
			        jQuery.each(data.split('&'), function(){ 
			            var pair = this.split('=');
			            if(!oUtil.isNull(pair[0]) && !oUtil.isNull(pair[1])){
			            	if(array.indexOf(pair[0]) == -1){
				            	array.push(pair[0]);
				            	if(!oUtil.isNull(pair[1]) && pair[1].substring(0,1) == "'"){
				            		inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1].replace(/%2C/g, ',') +'" />';
				            	}else{
				            		inputs+='<input type="hidden" name="'+ pair[0] +'" value=\''+ pair[1].replace(/%2C/g, ',') +'\' />';
				            	}
				            }
			            }
			        });
			        inputs += "<input type=\"hidden\" name=\"_csrf\" value=\""+token+"\">";
			        // request를 보낸다.
			        jQuery('<form id="'+formId+'" action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>').appendTo('body').submit().remove();
			    };
			}
		}, // ajax End
		"date" : {
			getCurrDay: function(pDelimiter) {
		    	if( pDelimiter == undefined || pDelimiter == null){
		    		pDelimiter = "";
		    	}
		        var today = new Date();
		        var yyyy, mm, dd;
		        
		        yyyy = today.getFullYear();
		        mm = today.getMonth() + 1;
		        dd = today.getDate();
		        mm = mm < 10 ? "0" + mm : mm;
		        dd = dd < 10 ? "0" + dd : dd;
		        
		        return yyyy + pDelimiter + mm + pDelimiter + dd;
		    },
		    getCurrMonth: function(pDelimiter) {
		    	if( pDelimiter == undefined || pDelimiter == null){
		    		pDelimiter = "";
		    	}
		        var today = new Date();
		        var yyyy, mm;
		        
		        yyyy = today.getFullYear();
		        mm = today.getMonth() + 1;
		        mm = mm < 10 ? "0" + mm : mm;
		        
		        return yyyy + pDelimiter + mm; 
		        
		    },
		    getCurrYear: function() {
		        var today = new Date();
		        var yyyy;
		        
		        yyyy = today.getFullYear();
		        
		        return yyyy;
		    },
		    addDate: function(pInterval, pAddVal, pYyyymmdd, pDelimiter) {
		        var cDate;
		        var yyyy, mm, dd;
		        var cYear, cMonth, cDay;
		        var rtnValue;
		        
		        if (pDelimiter != "") {
					var chExp = new RegExp(`${pDelimiter}`, 'g');
					pYyyymmdd = pYyyymmdd.replace(chExp, "");
		        }
		        yyyy = pYyyymmdd.substr(0, 4);
		        mm = pYyyymmdd.substr(4, 2);
		        dd = pYyyymmdd.substr(6, 2);
		        if (pInterval == "yyyy") {
		            yyyy = (yyyy * 1) + (pAddVal * 1);
		        } else if (pInterval == "m") {
		            mm = (mm * 1) + (pAddVal * 1);
		        } else if (pInterval == "d") {
		            dd = (dd * 1) + (pAddVal * 1);
		        }
		        cDate = new Date(yyyy, mm - 1, dd);
		        cYear = cDate.getFullYear();
		        cMonth = cDate.getMonth() + 1;
		        cDay = cDate.getDate();
		        cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
		        cDay = cDay < 10 ? "0" + cDay : cDay;
		        if (pDelimiter != "") {
		            rtnValue = cYear.toString() + pDelimiter.toString() + cMonth.toString() + pDelimiter.toString() + cDay.toString();
		        } else {
		            rtnValue = cYear.toString() + cMonth.toString() + cDay.toString();
		        }
		        
		        return rtnValue;
		    },
		    
		    
		    
		    lastDay: function(pYyyymm) {
		        var yyyy, mm, cDate, lastDay;
		        
		        yyyy = pYyyymm.substr(0, 4);
		        mm = pYyyymm.substr(4, 2);
		        lastDay = new Date((new Date(yyyy, mm, 1)) - 1).getDate();
		        
		        return lastDay;
		    },
		    
		    
		    
		    getDiffDay: function(pStartYyyymmdd, pEndYyyymmdd, pDelimiter){
		        var yyyyS, mmS, ddS, yyyyE, mmE, ddE;
		        if (pDelimiter != "") {
					var chExp = new RegExp(`${pDelimiter}`, 'g');
					
		        	pStartYyyymmdd = pStartYyyymmdd.replace(chExp, "");
		        	pEndYyyymmdd = pEndYyyymmdd.replace(chExp, "");
		        }
		        yyyyS = pStartYyyymmdd.substr(0, 4);
		        mmS = pStartYyyymmdd.substr(4, 2);
		        ddS = pStartYyyymmdd.substr(6, 2);
		        
		        yyyyE = pEndYyyymmdd.substr(0, 4);
		        mmE = pEndYyyymmdd.substr(4, 2);
		        ddE = pEndYyyymmdd.substr(6, 2);        
		        
		        var startDay = new Date(parseInt(yyyyS),parseInt(mmS)-1,parseInt(ddS));       
		        var endDay = new Date(parseInt(yyyyE),parseInt(mmE)-1,parseInt(ddE));
		        
		        var diffTime = endDay.getTime() - startDay.getTime();
		        return Math.floor(diffTime / (1000 * 60 * 60 * 24));     
		    }, 
		    getDiffMonth: function(pStartYyyymmdd, pEndYyyymmdd, pDelimiter){
		        var yyyyS, mmS, ddS, yyyyE, mmE, ddE;
		        if (pDelimiter != "") {
					var chExp = new RegExp(`${pDelimiter}`, 'g');
		        	pStartYyyymmdd = pStartYyyymmdd.replace(chExp, "");
		        	pEndYyyymmdd = pEndYyyymmdd.replace(chExp, "");
		        }
		        yyyyS = pStartYyyymmdd.substr(0, 4);
		        mmS = pStartYyyymmdd.substr(4, 2);
		        ddS = pStartYyyymmdd.substr(6, 2);
		        
		        yyyyE = pEndYyyymmdd.substr(0, 4);
		        mmE = pEndYyyymmdd.substr(4, 2);
		        ddE = pEndYyyymmdd.substr(6, 2); 

		        var startDay = new Date(parseInt(yyyyS),parseInt(mmS)-1,parseInt(ddS));       
		        var endDay = new Date(parseInt(yyyyE),parseInt(mmE)-1,parseInt(ddE));

		        var diffTime = endDay.getTime() - startDay.getTime();

		        return diffTime / (1000 * 60 * 60 * 24 * 30);
		    },
		    f_sys_between_ymd : function(c_sta_ymd, c_end_ymd, c_gubun, c_sta_yn){
		    	var v_sta_ymd, v_end_ymd;
		    	var v_yy, v_mm, v_dd;
		    	var v_yy_t, v_mm_t, v_mm_mod, v_dd_t, v_dd_y_mod, v_mdd_m_mod;
		    	var v_yy_pos, v_mm_pos, v_dd_pos;
		    	var day_value = 24*60*60*1000;
		    	var v_ret = c_gubun;

		    	if (c_sta_ymd == "" || c_end_ymd == "") {
		    	    return "";
		    	}

		    	v_sta_ymd = this.makeDateFormat(c_sta_ymd); 
		    	v_end_ymd = this.makeDateFormat(c_end_ymd); 

		    	if (v_sta_ymd == "") return "";
		    	if (v_end_ymd == "") return "";

		    	if (c_sta_yn.toUpperCase() == "Y") {
		    	   v_sta_ymd = new Date(v_sta_ymd.getYear(), v_sta_ymd.getMonth(), v_sta_ymd.getDate()-1);
		    	}

		    	v_yy_t = parseInt(this.months_between(c_end_ymd, c_sta_ymd)/12);
		    	v_mm_t = parseInt(this.months_between(c_end_ymd, c_sta_ymd)); 
		    	v_mm_mod = parseInt(this.months_between(c_end_ymd, c_sta_ymd))%12; 
		    	v_dd_t = parseInt((v_end_ymd - v_sta_ymd)/day_value);
		    	v_dd_y_mod = parseInt((v_end_ymd - this.add_months(c_sta_ymd, v_yy_t * 12))/day_value);
		    	v_dd_m_mod = parseInt((v_end_ymd - this.add_months(c_sta_ymd, (v_yy_t * 12) + v_mm_mod))/day_value); 
		    	v_yy_pos = c_gubun.indexOf('yy'.toLowerCase(),0); 
		    	v_mm_pos = c_gubun.indexOf('mm'.toLowerCase(),0); 
		    	v_dd_pos = c_gubun.indexOf('dd'.toLowerCase(),0); 

		    	if (v_yy_pos > -1 && v_mm_pos > -1 && v_dd_pos > -1) { 
		    	    v_yy = v_yy_t;
		    	    v_mm = v_mm_mod;
		    	    v_dd = v_dd_m_mod;
		    	} else if (v_yy_pos > -1 && v_mm_pos > -1 && v_dd_pos == -1) { 
		    	    v_yy = v_yy_t;
		    	    v_mm = v_mm_mod;
		    	} else if (v_yy_pos > -1 && v_mm_pos == -1 && v_dd_pos > 0) { 
		    	    v_yy = v_yy_t;
		    	    v_dd = v_dd_y_mod;
		    	} else if (v_yy_pos > -1 && v_mm_pos == -1 && v_dd_pos == -1) {
		    	    v_yy = v_yy_t;
		    	} else if (v_yy_pos == -1 && v_mm_pos > -1 && v_dd_pos > -1) { 
		    	    v_mm = v_mm_t;
		    	    v_dd = v_dd_m_mod;
		    	} else if (v_yy_pos == -1 && v_mm_pos == -1 && v_dd_pos > -1) {
		    	    v_dd = v_dd_t;
		    	} else if (v_yy_pos == -1 && v_mm_pos > -1 && v_dd_pos == -1) {
		    	    v_mm = v_mm_t;
		    	}

		    	if (v_mm < 10) v_mm = v_mm;
		    	v_ret = v_ret.replace('yy', v_yy);
		    	v_ret = v_ret.replace('mm', v_mm);
		    	v_ret = v_ret.replace('dd', v_dd);

		    	return v_ret;
		    },
		    makeDateToString : function(pdate, pDelimiter){
				if( pDelimiter == undefined || pDelimiter == null){
		    		pDelimiter = "";
		    	}
				
				yyyy = pdate.getFullYear();
		        mm = pdate.getMonth() + 1;
		        dd = pdate.getDate();
		        mm = mm < 10 ? "0" + mm : mm;
		        dd = dd < 10 ? "0" + dd : dd;
		        
		        return yyyy + pDelimiter + mm + pDelimiter + dd;
				
			},
		    makeDateFormat : function(pdate,type){
		    	if (oUtil.isNull(pdate)) {
		    		return "";
		    	}
		    	if("00000000" == pdate){
		    		return "";
		    	}
		    	var yy, mm, dd, yymmdd;
		    	var ar;
		    	if (pdate.indexOf(".") > -1) { 
		    	    ar = pdate.split(".");
		    	    yy = ar[0];
		    	    mm = ar[1];
		    	    dd = ar[2];

		    	    if (mm < 10) mm = "0" + mm;
		    	    if (dd < 10) dd = "0" + dd;
		    	} else if (pdate.indexOf("-") > -1) {
		    	    ar = pdate.split("-");
		    	    yy = ar[0];
		    	    mm = ar[1];
		    	    dd = ar[2];

		    	    if (mm < 10) mm = "0" + mm;
		    	    if (dd < 10) dd = "0" + dd;
		    	} else if (pdate.length == 8) {
		    	    yy = pdate.substr(0,4);
		    	    mm = pdate.substr(4,2);
		    	    dd = pdate.substr(6,2);
		    	}

		    	if(type == "DATE"){
		    		yymmdd = yy+"/"+mm+"/"+dd;

			    	yymmdd = new Date(yymmdd);

			    	if (isNaN(yymmdd)) {
			    	    return false;
			    	}

			    	return yymmdd;	
		    	}else{
		    		return yy+"-"+mm+"-"+dd;
		    	}
		    	
		    },
		    add_months : function(pdate, diff_m){
		    	var add_m;
		    	var lastDay; 
		    	var pyear, pmonth, pday;

		    	pdate = this.makeDateFormat(pdate,"DATE"); 
		    	if (pdate == "") return "";

		    	pyear = pdate.getFullYear();
		    	pmonth= pdate.getMonth() + 1;
		    	pday = pdate.getDate();

		    	add_m = new Date(pyear, pmonth + diff_m, 1); 

		    	lastDay = new Date(pyear, pmonth, 0).getDate(); 
		    	if (lastDay == pday) {
		    	    pday = new Date(add_m.getFullYear(), add_m.getMonth(), 0).getDate();
		    	}

		    	add_m = new Date(add_m.getFullYear(), add_m.getMonth()-1, pday);

		    	return add_m;
		    },
		    months_between : function(edate, sdate){
		    	var syear, smonth, sday;
		    	var eyear, emonth, eday;
		    	var diff_month = 1;

		    	sdate = this.makeDateFormat(sdate); 
		    	edate = this.makeDateFormat(edate); 

		    	if (sdate == "") return "";
		    	if (edate == "") return "";

		    	syear = sdate.getYear();
		    	eyear = edate.getYear();
		    	smonth= sdate.getMonth() + 1;
		    	emonth= edate.getMonth() + 1;
		    	sday = sdate.getDate();
		    	eday = edate.getDate();

		    	while (sdate < edate) { 
		    	    sdate = new Date(syear, smonth - 1 + diff_month, 0);
		    	    //alert(sdate);
		    	    diff_month++;
		    	}
		    	
		    	if (sday > eday) diff_month--; 

		    	diff_month = diff_month - 2;

		    	return diff_month;
		    },
		    checkDateBefore : function (pStartYyyymmdd, pEndYyyymmdd, pDelimiter){
		    	var diffDay = this.getDiffDay(pStartYyyymmdd, pEndYyyymmdd, pDelimiter);
		    	if (diffDay >= 0) {
		    		return true;
		    	} else {
		    		return false;
		    	}
		    }
		}, // Date End
		
		"dialog" :{
			open : function(id, title, url_opts, width, height, closeFunc, modalFlag, openFunc, previewer) {
				var resizeyn = false;
			    var closable = true;
			    var lyH = $(window).height();
			    var lyW = $(window).width();
			    var ly = $('#' + id).attr("alt");
			    var barW = $('.' + ly).width();
			    var barH = $('.' + ly).height();
			    this.createPopupDiv(id);
			    if (width == null || width == "") {
			    	width = 400;
			    }
			    if (height == null || height == "") {
			        height = 500
			    } else {
			        //if (height > (lyH - barH)) height = (lyH - barH) * 0.97;
			        //if (width > (lyW - barW)) width = (lyW - barW) * 0.97
			    }
			    if (oUtil.isNull(modalFlag)) {
			        modalFlag = true
			    }
			    var params = "";
			    var url = "";
			    
			    var dialogZindex = $('.ui-dialog').eq($('.ui-dialog').length-1).css("z-index");
		    	var overlayZindex = $('.ui-widget-overlay').eq($('.ui-widget-overlay').length-1).css("z-index");
			    if(!oUtil.isNull(previewer)){
			    	$("#" +id+"").html(previewer);
			    }else{
			    	if (typeof url_opts == "string") {
				        url = url_opts;
				    } else {
				        url = url_opts.href;
				        params = makeStringParameter(url_opts.queryParams, true);
				    }
			    	var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
			    	var promise = $.ajax({
			    		
			    		 url: url,
			             data: params,
			             type: 'post',
			             beforeSend: function( xhr ) {
							if(token != "" && header != "" && token != undefined && header != undefined){
								xhr.setRequestHeader(header, token);	
							}
						}
			            	 
			    	});
			    	promise.done(function(content) {
			    		$("#" +id+"").append(content);
			    	});
			    }
			    
			    $('#' + id).dialog({
			        title: title,
			        width: width+10,
			        height: height+40,
			        resizable: resizeyn,
			        closable: closable,
			        modal: modalFlag,
			        open: function (event, ui) {
			        	if(($('.ui-dialog').length-1) == 0){
			        		dialogZindex = 998;
			        		overlayZindex = 1000;
			        	}else{
			        		dialogZindex = dialogZindex+3;
			        		overlayZindex = overlayZindex+3;
			        	}
			        	$('.ui-dialog').eq($('.ui-dialog').length-1).css('z-index',dialogZindex);
			        	$('.ui-widget-overlay').eq($('.ui-widget-overlay').length-1).css('z-index',overlayZindex);
			        	
			        	if($(window).height() < height+40){
			        		$('.ui-widget-overlay').eq($('.ui-widget-overlay').length-1).css('height',height+50); //회색배경을 팝업사이즈에 맞춘다.
			        	}
			        	
		        		if (!oUtil.isNull(openFunc)) {
			                new Function(openFunc + "()")();
			            } 
		        		$(".ui-dialog[aria-describedby='"+id+"'] .ui-dialog-titlebar-close").prev().prepend("<i class='fa fa-edit'></i>") /* 타이틀 아이콘 추가 */
		        		$(".ui-dialog[aria-describedby='"+id+"'] .ui-dialog-titlebar-close").hide(); //기존 버튼 숨김
		        		$(".ui-dialog[aria-describedby='"+id+"'] .ui-dialog-titlebar").append('<a href="javascript:void(0)" class="close" onClick="javascript:KpackageOBJ.dialog.close(\''+id+'\');"><i class="fa fa-times"></i></a>');
		        		// escape key maps to keycode '27'
		        		$("#"+id).append('<script>$(document).keyup(function(e) {if (e.keyCode == 27) {KpackageOBJ.dialog.close("'+id+'");}});</script>')
					},
			        close : function() {
			            if (!oUtil.isNull(closeFunc)) {ss
			                new Function(closeFunc + "()")();
			            }
			        }
			    });
			},
			
			close : function(id) {
				$(".ui-dialog[aria-describedby='"+id+"'] .ui-dialog-titlebar-close").trigger('click');
				$(".ui-dialog[aria-describedby='"+id+"']").remove();
				$("#"+id+"").remove();
			},
			
			createPopupDiv : function(objId) {
		        var div = '<div id="' + objId + '" name="' + objId + '" style="overflow: auto;"></div>';
		        var tagCurrObj = "#" + objId;
		        $(tagCurrObj).remove();
		        $("body").append(div);
		    },
		    commonPopup : function(type, retunFuncName){
		    	
		    	if( type == undefined) return;
		    	
		    	if("USER" === type){
		    		var params = "RETUN_FUNCTION_NAME=" + "openUserSearchDialog_return";
		    		KpackageOBJ.dialog.open("dialog_UserSearchPopup",KpackageOBJ["prototype"][type] , "/common/viewUserSearch?" + params, 600, 400);
		    	}else if("ITEM" === type){
		    		//TODO : 추후 개발 예정
		    	}
		    },
		    setButton : function(dialog_Id, buttonObject) {
		    	if(dialog_Id == "" || dialog_Id == undefined || dialog_Id == null){return;}
		    	if(buttonObject == "" || buttonObject == undefined || buttonObject == null){return;}
		    	
		    	var contentWidth = $("#"+dialog_Id).children("#content").css("width").replace("px", "");
				//var oPreToolbar = "<div class=\"widget-body-toolbar\" style=\"position: fixed;width:"+(Number(contentWidth)+10)+"px;z-index: 1;margin-top: -3px;margin-left: -8px;height: 36px;padding: 2px 10px;\">"
				var oPreToolbar = "<div class=\"widget-body-toolbar\" style=\"position: fixed;width:inherit;z-index: 1;margin-top: -3px;margin-left: -8px;height: 36px;padding: 2px 10px;\">"
								+ "<div class=\"btn-group\" style=\"float: right;margin-top: 3px;\">";
				var oButtonLoop = "";
				for (var i = 0; i < buttonObject.length; i++) {
	                var text = buttonObject[i].text;
	                var func = buttonObject[i].func;
	                var icon = buttonObject[i].icon;
	                var title = buttonObject[i].title;
	                
	                if("none" == icon){
	                	icon = "";
	                }else if("delete" == icon){
	                	icon = "glyphicon glyphicon-remove";
	                }else if("insert" == icon){
	                	icon = "glyphicon glyphicon-plus";
	                }else if("edit" == icon){
	                	icon = "glyphicon glyphicon-edit";
	                }else if("excel" == icon){
	                	//icon = "fa fa fa-file-excel-o";
	                	icon = "fa fa-file-excel-o";
	                	
	                }else if("save" == icon){
	                	//icon = "fa fa fa-file-excel-o";
	                	icon = "glyphicon glyphicon-floppy-save";
	                	
	                }else{
	                	icon = icon;
	                }
	                oButtonLoop += "<button type='button'class='btn grid-add-btn btn-primary btn-border tuiGrid-toolbar-button' id='"+dialog_Id+text+func+"' onClick='javascript:"+func+"()' title='"+title+"'><i class='"+icon+"'></i> <span>"+text+"</span></button>";
	            }
				var oNextToolbar ="</div></div>";
				var oToolbar = oPreToolbar + oButtonLoop + oNextToolbar;
				
				$("#"+dialog_Id+" #content").prepend(oToolbar);
				$("#"+dialog_Id).children("#content").css("width", $("#"+dialog_Id).children("#content").css("width"));
				$("#"+dialog_Id+" .widget-body").css("padding-top", "35px");
		    }
		        
		},
		
		"util" : {
			doc: document || window.document || document.all,
		    isArray: function (o) {
		        if (Object.prototype.toString.call(o) == "[object Array]") {
		            return true;
		        } else {
		            return false;
		        }
		    },
		    isBoolean: function (o) {
		        return typeof o === 'boolean';
		    },
		    isFunction: function (o) {
		        return typeof o === 'function';
		    },
		    isHTMLElement: function (o) {
		        if (this.isObject(o) || this.isFunction(o)) {
		            if (o.nodeName) {
		                return true;
		            }
		        }
		        return false;
		    },
		    isNull: function (o) {
		        return o === null || this.trim(o) === "" || typeof o === 'undefined';
		    },
		    isNumber: function (o) {
		        return typeof o === 'number' && isFinite(o);
		    },
		    isObject: function (o) {
		        return (o && (typeof o === 'object' || L.isFunction(o))) || false;
		    },
		    isString: function (o) {
		        return typeof o === 'string';
		    },
		    isUndefined: function (o) {
		        return typeof o === 'undefined';
		    },
		    isValue: function (o) {
		        var L = this;
		        return (L.isObject(o) || L.isString(o) || L.isNumber(o) || L.isBoolean(o));
		    },
		    ltrim: function (s) {
		        if (!this.isString(s)) {
		            return null;
		        }
		        return s.replace(/\s*((\S+\s*)*)/, "$1");
		    },
		    rtrim: function (s) {
		        if (!this.isString(s)) {
		            return null;
		        }
		        return s.replace(/((\s*\S+)*)\s*/, "$1");
		    },
		    trim: function (s) {
		        if (!this.isString(s)) {
		            return null;
		        }
		        return this.ltrim(this.rtrim(s));
		    },
		    isEmpty: function (o) {
		        if ((typeof o != "undefiend") && (o.length > 0)) {
		            return false;
		        } else {
		            return true;
		        }
		    }
		},
		"tree":{
			"create" : function(tree_ID){
			    var mytreebranch = $(tree_ID).find("li:has(ul)").addClass("parent_li").attr("role", "treeitem").find(" > span").attr("title", "Collapse this branch");
			    $(tree_ID + " > ul").attr("role", "tree").find("ul").attr("role", "group"), mytreebranch.on("click", function(a) {
			        var b = $(this).parent("li.parent_li").find(" > ul > li");
			        b.is(":visible") ? (b.hide("fast"), $(this).attr("title", "Expand this branch").find(" > i").addClass("icon-plus-sign").removeClass("icon-minus-sign")) : (b.show("fast"), $(this).attr("title", "Collapse this branch").find(" > i").addClass("icon-minus-sign").removeClass("icon-plus-sign")), a.stopPropagation()
			    })
			}
		},
		
		"tuiGrid": {
			"prototype" :{
				"defaultPageSize" : 50
				,"defaultPageNumber" : 1
				
			},
		
			/**
			 * @Desc 지정한 tuiGrid Object를 반환합니다. 
			 * @param  tui로 생성한 grid Id
			 * 
			 * @since  2018.06.08
			 * @author 망할고양이
			 * 
			 */
			"getGrid" : function(tuiGrid_ID){
				if(tuiGrid_ID == undefined || tuiGrid_ID == null){
					return null;
				}
				var Grid = tui.Grid;
				return Grid.getInstanceById($("#"+tuiGrid_ID).data("grid-id"));
			},
			/**
		     * Function Name : KpackageOBJ.tuiGrid.create( grid_Id, url, column_model, headerType, clickEvnet, dblClickEvent, scrollX, p_ScrollY )
		     * 
		     * Description   : tui Grid를 생성합니다.
		     *                 gridId + "_paging"에 해당하는 ID를 가진 DIV가 있을경우 페이징을 생성합니다.
		     *                 Paging을 사용하지 않을경우 최대 99999 row까지 조회합니다.
		     *                 
		     * Parameters    : grid_Id               - <String> 그리드로 생성할 div 객체의 Element ID
		     * 				   url                   - <String> 조회시 요청할 URL 
		     * 				   column_model          - <String> 컬럼 구조 배열
		     * 				   headerType            - <String>   <optional> Row Header에 대한 설정값 ( number, multi, single 소문자주의)
		     *  			   p_onClick_Handler     - <Function> <optional> 클릭 이벤트시 동작할 Function
		     *   			   p_onDblclick_Handler  - <Function> <optional> 더블 클릭 이벤트시 동작할 Function
		     *    			   p_ScrollX             - <Boolean>  <optional> 가로 스크롤 default true
		     *     			   p_ScrollY             - <Boolean>  <optional> 세로 스크롤 default true
		     * 
		     * 사용예시*****
		     * *** 예시 #1  **************************************************************************************************************
		     *        var colInfoModel = [
		     *                      { title: '컬럼1', name: 'COL_01', width : 100, align: "center", hidden:false },
			 *	                    { title: '컬럼2', name: 'COL_02', width : 100, align: "center", hidden:false },
			 *	                    { title: '컬럼3', name: 'COL_03', width : 100, align: "center", hidden:false }
			 *                    ];
			 *                    
		     *         KpackageOBJ.tuiGrid.create("grid1", "/test/retrieveTestData", colInfoModel);  // <optional> argument는 작성하지않아도 됨
		     *         
		     *         
		     * *** 예시 #2  **************************************************************************************************************
		     *         KpackageOBJ.tuiGrid.create("grid1", "/test/retrieveTestData", colInfoModel, "check", onClick_Grid_01, onDblclick_Grid_01, true, false); 
		     *
		     */
			"create" : function(p_TargetGridId, p_RetrieveUrl, p_ColinfoArray, p_headerType, p_onClick_Handler, p_onDblclick_Handler, p_ScrollX, p_ScrollY, colGroupArr ){
				var arg = arguments;
				var uRf = false;
				if(arg[0] == undefined || arg[0] == null || arg[1] == undefined || arg[1] == null || arg[2] == undefined || arg[2] == null ){
					return false;
				}
				
				if("number" == arg[3] || "rowNum" == arg[3] || "n" == arg[3]){
					p_headerType = "rowNum";
					uRf = true;
				}else if("checkbox" == arg[3] || "check" == arg[3] || "c" == arg[3] ||  "multi" == arg[3]){
					p_headerType = "checkbox";
					uRf = true;
				}else if("radio" == arg[3] || "r" == arg[3] || "c" == arg[3] || "single" == arg[3]){
					p_headerType = "radio";
					uRf = true;
				}
				
				p_ScrollX = p_ScrollX || true;
				p_ScrollY = p_ScrollY || true;

				
				
				var returnGrid = null;
				if(uRf){
					returnGrid = new tui.Grid({el: $('#'+ p_TargetGridId),header : { complexColumns: colGroupArr}, data : [],scrollX: p_ScrollX,scrollY: p_ScrollY,rowHeaders: [p_headerType],columns : p_ColinfoArray});	
				}else{
					returnGrid = new tui.Grid({el: $('#'+ p_TargetGridId),header: { complexColumns: colGroupArr}, data : [],scrollX: p_ScrollX,scrollY: p_ScrollY,columns : p_ColinfoArray});
				}
				tui.Grid.applyTheme("default", {cell : {normal : {background :"#FFF"}}});
				if($(returnGrid.$el.selector).data("fixedHeight") == undefined){
					
					
					
					if(($(window).height()-$(returnGrid.$el.selector).data("minusHeight") || $(window).height() - KpackageOBJ.prototype.minusHeight) > KpackageOBJ.prototype.minimumHeight ){
						returnGrid.setBodyHeight($(window).height()-$(returnGrid.$el.selector).data("minusHeight") || $(window).height() - KpackageOBJ.prototype.minusHeight);
					}else{
						returnGrid.setBodyHeight(KpackageOBJ.prototype.minimumHeight);	
					}
					
				}else{
					returnGrid.setBodyHeight($(returnGrid.$el.selector).data("fixedHeight"));	
				}
				
				
				
				// Toast Default Grid Setting
				$('#'+ p_TargetGridId).data("page",KpackageOBJ.tuiGrid.prototype.defaultPageNumber);
				$('#'+ p_TargetGridId).data("url",p_RetrieveUrl);
				$('#'+ p_TargetGridId).data("object-id",p_TargetGridId);
				
				//Toast Grid Paging Use Check
				var pagingYn = $('#'+ p_TargetGridId+"_paging").length > 0;
				
				if(pagingYn){
					$('#'+ p_TargetGridId+"_paging").paging({current:1,max:1,onclick:KpackageOBJ.tuiGrid.movepage});
					if($(returnGrid.$el.selector).data("pageSize") != undefined && $(returnGrid.$el.selector).data("pageSize") != "" && $(returnGrid.$el.selector).data("pageSize") > 0) {
						$('#'+ p_TargetGridId).data("rows",$(returnGrid.$el.selector).data("pageSize"));
					}else{
						$('#'+ p_TargetGridId).data("rows",KpackageOBJ.tuiGrid.prototype.defaultPageSize);	
					}
					
					$('#'+ p_TargetGridId).data("paging-yn",pagingYn);
				}else{
					$('#'+ p_TargetGridId).data("paging-yn",pagingYn);
					$('#'+ p_TargetGridId).data("rows",99999);
				}
				
				if("function" === typeof(p_onClick_Handler)){
					returnGrid.on('click', function(ev) {
						if(ev.rowKey != undefined && ev.columnName != undefined){
							p_onClick_Handler(ev.instance.el.id, ev.rowKey, ev.columnName);
						}
						
					});
				}
				
				if("function" === typeof(p_onDblclick_Handler)){
					returnGrid.on('dblclick', function(ev) {
						if(ev.rowKey != undefined && ev.columnName != undefined){
							p_onDblclick_Handler(ev.instance.el.id, ev.rowKey, ev.columnName);	
						}
						
					    //console.log(ev); // GridEvent object
					    //console.log(ev.nativeEvent); // browser's native event object
					});
				}
				
				
				return returnGrid;
			},
			/**
			 * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum)
		     * 
		     * Description   : tui Grid를 이용하여 조회를 수행합니다.
		     *                 
		     * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
		     * 				   url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
		     * 				   params       - <jsonObject> 조회조건
		     * 				   startPageNum - <Number> 시작 페이지 default 1
			 */
			"retrieve" : function(p_TargetGridId, p_RetrieveUrl, params, p_TargetPage){
				if("" == p_TargetGridId || null == p_TargetGridId || undefined == p_TargetGridId){
					return false;
				}
				
				if("" == params || null == params || undefined == params || {} == params){
					params = {"DUMMY" : "DUMMY"};
				}
				
				
				if(oUtil.isNull(p_RetrieveUrl)){
		    		p_RetrieveUrl = $('#'+ p_TargetGridId).data("url");
		    	}else{
		    		$('#'+ p_TargetGridId).data("url",p_RetrieveUrl);
		    	}
				params["rows"] = $('#'+ p_TargetGridId).data("rows");
				
				if(oUtil.isNull(p_TargetPage)){
					params["page"] = $('#'+ p_TargetGridId).data("page");	
				}else{
					params["page"] = p_TargetPage;
				}
				
				$("#"+p_TargetGridId).data("sp", JSON.stringify(params));
				
				if("" == p_RetrieveUrl || null == p_RetrieveUrl || undefined == p_RetrieveUrl){
					return false;
				}
		    	
				if($(".switchFilter").length > 0){
					$(".switchFilter").hide();
					$("button[name='switchFilterBtn']").children(0).removeClass("fa-arrow-up");
					$("button[name='switchFilterBtn']").children(0).addClass("fa-arrow-down");
				}
				
		    	KpackageOBJ.ajax.doSubmit(p_RetrieveUrl, params, function(arg){	// success Handler
		    				KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).setData(arg.gridData);
		    				if($("#"+p_TargetGridId+"_page_info").length > 0 ){
		    					$("#"+p_TargetGridId+"_page_info").remove();
		    				}
		    				
		    				if($('#'+ p_TargetGridId).data('pagingYn')){
		    					$('#'+ p_TargetGridId+"_paging").paging('destroy');	
		    					$('#'+ p_TargetGridId+"_paging").paging({current:arg.page,max:arg.total,onclick:KpackageOBJ.tuiGrid.movepage});
		    					$('#'+ p_TargetGridId+"_paging").append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;margin-top: -12px;position: absolute;right: 16px;'>"+KpackageOBJ.formatter.commas(arg.page)+" / "+KpackageOBJ.formatter.commas(arg.total)+" Page :: Total count:"+KpackageOBJ.formatter.commas(arg.records)+"</sapn>");
		    				}else{
		    					$('#'+ p_TargetGridId).append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;position: absolute;right: 16px;'>Total count : "+KpackageOBJ.formatter.commas(arg.records)+"</sapn>");
		    				}
		    			}
		    		
		    	);	
		    	
		    },
		    /**
			 * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum, p_TargetHeaderWorks_Func)
		     * 
		     * Description   : tui Grid를 이용하여 조회를 수행합니다.
		     *                 
		     * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
		     * 				   url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
		     * 				   params       - <jsonObject> 조회조건
		     * 				   startPageNum - <Number> 시작 페이지 default 1
		     *                 p_TargetHeaderWorks_Func - <String> 그리드 조회시 같이 가져올 Header Data를 처리하는 Function Name
			 */
			"retrieveWithHeader" : function(p_TargetGridId, p_RetrieveUrl, params, p_TargetPage, p_TargetHeaderWorks_Func){
				if("" == p_TargetGridId || null == p_TargetGridId || undefined == p_TargetGridId){
					return false;
				}
				
				if("" == params || null == params || undefined == params || {} == params){
					params = {"DUMMY" : "DUMMY"};
				}
				
				
				if(oUtil.isNull(p_RetrieveUrl)){
		    		p_RetrieveUrl = $('#'+ p_TargetGridId).data("url");
		    	}else{
		    		$('#'+ p_TargetGridId).data("url",p_RetrieveUrl);
		    	}
				params["rows"] = $('#'+ p_TargetGridId).data("rows");
				
				if(oUtil.isNull(p_TargetPage)){
					params["page"] = $('#'+ p_TargetGridId).data("page");	
				}else{
					params["page"] = p_TargetPage;
				}
				
				$("#"+p_TargetGridId).data("sp", JSON.stringify(params));
				
				if("" == p_RetrieveUrl || null == p_RetrieveUrl || undefined == p_RetrieveUrl){
					return false;
				}
		    	
		    	KpackageOBJ.ajax.doSubmit(p_RetrieveUrl
		    			, params
		    			, function(arg){	// success Handler
		    				KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).setData(arg.gridData);
		    				if($("#"+p_TargetGridId+"_page_info").length > 0 ){
		    					$("#"+p_TargetGridId+"_page_info").remove();
		    				}
		    				/** Header 처리 로직 추가 **/
		    				//if(arg.headerData != null || arg.headerData != undefined ){
		    				if(p_TargetHeaderWorks_Func != undefined){
		    					new Function(p_TargetHeaderWorks_Func+"(arg.headerData)")();
		    					
		    				}
		    				
		    				if($('#'+ p_TargetGridId).data('pagingYn')){
		    					$('#'+ p_TargetGridId+"_paging").paging('destroy');	
		    					$('#'+ p_TargetGridId+"_paging").paging({current:arg.page,max:arg.total,onclick:KpackageOBJ.tuiGrid.movepage});
		    					$('#'+ p_TargetGridId+"_paging").append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;margin-top: -12px;'>"+arg.page+" / "+arg.total+" Page :: Total count:"+arg.records+"</sapn>");
		    				}else{
		    					$('#'+ p_TargetGridId).append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;'>Total count : "+arg.records+"</sapn>");
		    				}
		    			}
		    		
		    	);	
		    	
		    },
		    /**
			 * Function Name : KpackageOBJ.tuiGrid.retrieve( grid_Id, url, params, startPageNum, p_CallBackWorks_Func)
		     * 
		     * Description   : tui Grid를 이용하여 조회를 수행합니다.
		     *                 
		     * Parameters    : grid_Id      - <String> 그리드로 생성할 div 객체의 Element ID
		     * 				   url          - <String> 조회시 요청할 URL default 그리드 정보에 있는 URL
		     * 				   params       - <jsonObject> 조회조건
		     * 				   startPageNum - <Number> 시작 페이지 default 1
		     *                 p_CallBackWorks_Func - <String> 그리드 조회시 같이 가져올 Header Data를 처리하는 Function Name
			 */
			"retrieveWithCallBack" : function(p_TargetGridId, p_RetrieveUrl, params, p_TargetPage, p_CallBackWorks_Func){
				if("" == p_TargetGridId || null == p_TargetGridId || undefined == p_TargetGridId){
					return false;
				}
				
				if("" == params || null == params || undefined == params || {} == params){
					params = {"DUMMY" : "DUMMY"};
				}
				
				
				if(oUtil.isNull(p_RetrieveUrl)){
		    		p_RetrieveUrl = $('#'+ p_TargetGridId).data("url");
		    	}else{
		    		$('#'+ p_TargetGridId).data("url",p_RetrieveUrl);
		    	}
				params["rows"] = $('#'+ p_TargetGridId).data("rows");
				
				if(oUtil.isNull(p_TargetPage)){
					params["page"] = $('#'+ p_TargetGridId).data("page");	
				}else{
					params["page"] = p_TargetPage;
				}
				
				$("#"+p_TargetGridId).data("sp", JSON.stringify(params));
				
				if("" == p_RetrieveUrl || null == p_RetrieveUrl || undefined == p_RetrieveUrl){
					return false;
				}
		    	
		    	KpackageOBJ.ajax.doSubmit(p_RetrieveUrl
		    			, params
		    			, function(arg){	// success Handler
		    				KpackageOBJ.tuiGrid.getGrid(p_TargetGridId).setData(arg.gridData);
		    				if($("#"+p_TargetGridId+"_page_info").length > 0 ){
		    					$("#"+p_TargetGridId+"_page_info").remove();
		    				}
		    				/** Callback Works 처리 로직 추가 **/
		    				if(p_CallBackWorks_Func != null || p_CallBackWorks_Func != undefined){
		    					new Function(p_CallBackWorks_Func+"()")();
		    				}
		    				
		    				if($('#'+ p_TargetGridId).data('pagingYn')){
		    					$('#'+ p_TargetGridId+"_paging").paging('destroy');	
		    					$('#'+ p_TargetGridId+"_paging").paging({current:arg.page,max:arg.total,onclick:KpackageOBJ.tuiGrid.movepage});
		    					$('#'+ p_TargetGridId+"_paging").append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;margin-top: -12px;'>"+arg.page+" / "+arg.total+" Page :: Total count:"+arg.records+"</sapn>");
		    				}else{
		    					$('#'+ p_TargetGridId).append("<sapn id='"+p_TargetGridId+"_page_info' style='float:right;margin-right:5px;'>Total count : "+arg.records+"</sapn>");
		    				}
		    			}
		    		
		    	);	
		    	
		    },
		    /**
		     * Paging 에서 사용하는 함수
		     * 
		     */
		    "movepage" : function(){
		    	var arg = arguments;
		    	var c = ($(arg[2].origin).prev()).data();
		    	if(c.sp != undefined){
		    		var sp = JSON.parse(c.sp);
			    	KpackageOBJ.tuiGrid.retrieve(c.objectId, c.url, sp, arg[1]);
			    	
		    	}
		    	event.preventDefault();
				event.stopPropagation();
		    },
		    
		    /**
		     * 마지막에 검색한 검색 파라메터를 Object 형태로 리턴합니다.
		     */
		    "getRetrieveParams" : function(){
		    	var arg = arguments;
		    	var returnJsonObject;
		    	try{
		    		returnJsonObject = JSON.parse($("#"+ arg[0]).data("sp"));
		    	}catch(e){
		    		returnJsonObject = {"ERROR" : e};
		    	}
		    	return returnJsonObject;
		    },
		    
		    "monthFormatter" : function(){
		    	var arg = arguments;
                return arg[0].substring(0,4) + "-" + arg[0].substring(4,6);
                
		    },
		    
		    "dateFormatter" : function(){
		    	var arg = arguments;
                return KpackageOBJ.date.makeDateFormat(arg[0]);
                
		    },
		    
		    "commas" : function(){
		    	var arg = arguments;
		    	
                return KpackageOBJ.formatter.commas(arg[0]);
                
		    },
		    "hscode10" : function(){
		    	var arg = arguments;
		    	
                return KpackageOBJ.formatter.hscode10(arg[0]);
                
		    },
		    "hscode6" : function(){
		    	var arg = arguments;
		    	
                return KpackageOBJ.formatter.hscode6(arg[0]);
                
			},
			"rawmtrl_se" : function(){
				var arg = arguments;
				
				return KpackageOBJ.formatter.rawmtrl_se(arg[0]);
				
			},
		    "percent" : function(){
		    	var arg = arguments;
		    	
                return arg[0] + "%";
                
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setUrl( grid_Id, url )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             url - <String> 검색시 사용 될 URL 주소
		     * 
		     */
		    "setUrl" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	$('#'+ arg[0]).data("url",arg[1]);
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setUrl( grid_Id, pageSize )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             pageSize - <Number> 페이징될 사이즈
		     * 
		     */
		    "setPagingSize" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	$('#'+ arg[0]).data("rows",arg[1]);
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getSelectedRowKey( grid_Id )
		     * 
		     * 현재 선택되어진 row의 KeyValue를 리턴합니다. 
		     * 0 부터 시작합니다.
		     * 
		     * 선택된 Cell이나 row가 없을경우 Null 리턴
		     * 
		     */
		    "getSelectedRowKey" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getFocusedCell();
		    	
		    	return rJson.rowKey;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getSelectedCellValue( grid_Id )
		     * 현재 선택되어진 Cell의 Value를 리턴합니다.
		     * 
		     * 선택된 Cell이나 row가 없을경우 Null 리턴
		     * 
		     */
		    "getSelectedCellValue" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getFocusedCell();
		    	
		    	return rJson.value;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getSelectedRowlValue( grid_Id )
		     * 현재 선택되어진 Cell의 Value를 리턴합니다.
		     * 
		     * 선택된 Cell이나 row가 없을경우 Null 리턴
		     * 
		     * return JsonType
		     */
		    "getSelectedRowlValue" : function(){
				var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getFocusedCell();
		    	
		    	return (KpackageOBJ.tuiGrid.getGrid(arg[0])).getRow(rJson["rowKey"]);
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getSelectedCellName( grid_Id )
		     * 현재 선택되어진 Cell의 Name을 리턴합니다.
		     * 
		     * 선택된 Cell이나 row가 없을경우 Null 리턴
		     * 
		     */
		    "getSelectedCellName" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getFocusedCell();
		    	
		    	return rJson.columnName;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getRowValues( grid_Id, rowKeyValue, isJsonType )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          rowKeyValue - <int> Target Row Index
		     *          (opt) isJsonType - [boolean] default false, true시 String형태로 리턴
		     *          
		     * 지정한 인덱스에 해당하는 Row 값을 리턴합니다. 
		     * 
		     * 선택된 Cell이나 row가 없을경우 Null 리턴
		     * 
		     */
		    "getRowValues" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getRow(arg[1], arg[2]);
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getCheckedRows( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * 체크된 Row 값을 모두 리턴합니다. 
		     * 
		     * return Array[JsonType]
		     * 
		     */
		    "getCheckedRows" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getCheckedRows();
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getCheckedRowKeys( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * 체크된 Row의 rowKeyValue 값을 모두 리턴합니다. 
		     * 
		     * return Array<int>
		     * 
		     */
		    "getCheckedRowKeys" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getCheckedRowKeys();
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getCellModel( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * Grid에 설정된 현제 Column Model 정보를 리턴합니다.
		     * 
		     * return Array[JsonType]
		     * 
		     */
		    "getCellModel" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getColumns();
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getCellModel( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             column_name - <String> Target Column Name
		     *          
		     * Grid에 설정된 현제 Column Model 정보중 해당이름을 가지는 Column Model의 Index를 반환합니다.
		     * 
		     * return int
		     * 
		     */
		    "getCellModelIndex" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var r = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getIndexOfColumn(arg[1]);
		    	
		    	return r;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getColValues( grid_Id, column_name, isJsonType )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          column_name - <String> Target Column Name
		     *          (opt) isJsonType - [boolean] default false, true시 String형태로 리턴
		     *          
		     * 지정한 컬럼에 대한 모든 값을 리턴합니다.
		     * 
		     * return Array
		     */
		    "getColValues" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getColumnValues(arg[1], arg[2]);
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getModifiedRows( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * 추가,수정,삭제된 모든 Row를 리턴합니다. 
		     * 
		     * return Json - {createdRows: Array(n), updatedRows: Array(n), deletedRows: Array(n)}
		     * 
		     */
		    "getModifiedRows" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getModifiedRows();
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getRowCount( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * Total Row Count 리턴합니다.
		     * 
		     * return int
		     * 
		     */
		    "getRowCount" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var r = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getRowCount();
		    	
		    	return r;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getRowsData( grid_Id )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *          
		     * Returns a list of all rows.
		     * 
		     * return Array - A list of all rows
		     * 
		     */
		    "getRowsData" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getRows();
		    	
		    	return rJson;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getRowsData( grid_Id, rowKey, columnName )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             rowKey - <Number> rowKey Value
		     *             columnName - <String> Column Name
		     *          
		     * Returns the value of the cell identified by the rowKey and columnName.
		     * 
		     * return The value of the cell
		     * 
		     */
		    "getCellValue" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	if(oUtil.isNull(arg[2])){return null;}
		    	var r = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getValue(arg[1],arg[2]);
		    	
		    	return r;
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.getOriginalCellValue( grid_Id, rowKey, columnName )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             rowKey - <Number> rowKey Value
		     *             columnName - <String> Column Name
		     *          
		     * Returns the original value of the cell identified by the rowKey and columnName.
		     * 
		     * return The original value of the cell
		     * 
		     */
		    "getOriginalCellValue" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	if(oUtil.isNull(arg[2])){return null;}
		    	var r = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getValue(arg[1],arg[2], true);
		    	
		    	return r;
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.hideCol( grid_Id, target_colName  )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             target_colName - <String> hide column name
		     *          
		     */
		    "hideCol" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).hideColumn(arg[1]);
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.showCol( grid_Id, target_colName  )
		     * 
		     * parameter : grid_Id - <String> Grid ID
		     *             target_colName - <String> show column name
		     *          
		     */
		    "showCol" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var rJson = (KpackageOBJ.tuiGrid.getGrid(arg[0])).showColumn(arg[1]);
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.isModify( grid_Id )
		     * Description   : Returns true if there are at least one row modified.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 
		     * Returns: boolean - True if there are at least one row modified.
		     * 
		     */
		    "isModified" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var r_default_true = (KpackageOBJ.tuiGrid.getGrid(arg[0])).isModified();
		    	
		    	return r_default_true;
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.removeRow( grid_Id, rowKey )
		     * Description   : Removes the row identified by the specified rowKey.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 rowKey  - <Numner> Row Key
		     * 
		     */
		    "removeRow" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).removeRow(arg[1], {removeOriginalData: true, keepRowSpanData:true});
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.resetData( grid_Id, data )
		     * Description   : Removes the row identified by the specified rowKey.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 data  - <Array> A list of new rows
		     * 
		     */
		    "resetData" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).resetData([]);	
		    	}else{
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).resetData(arg[1]);
		    	}
		    	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.resetData( grid_Id, data )
		     * Description   : Replace all rows with the specified list. This will not change the original data.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 data  - <Array> A list of new rows
		     * 
		     */
		    "resetData" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).resetData([]);	
		    	}else{
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).resetData(arg[1]);
		    	}
		    	
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.restore( grid_Id )
		     * Description   : Restores the data to the original data. (Original data is set by setData )
		     * Parameters    : grid_Id - <String> Grid ID
		     * 
		     */
		    "restore" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).restore();	
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.selection( grid_Id, range )
		     * Description   : Select cells or rows by range
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 range   - <jsonObject> Selection range  :  start - <Array> Index info of start selection (ex: [rowIndex, columnIndex])
		     *                                                            end   - <Array> Index info of start selection (ex: [rowIndex, columnIndex])
		     *                                                            
		     * ex : KpackageOBJ.tuiGrid.selection( grid_Id, {start:[2,0],end:[3,3]} );
		     * 
		     */
		    "selection" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).selection(arg[1]);	
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setBodyHeight(( grid_Id, value )
		     * Description   : Sets the height of body-area.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 value   - <Number> The number of pixel
		     *                                                            
		     * ex : KpackageOBJ.tuiGrid.setBodyHeight( grid_Id, 500 );
		     * 
		     */
		    "setBodyHeight" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).setBodyHeight(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setColumns( grid_Id, colModel )
		     * Description   : Sets the list of column model.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                 colModel   - <Array> A new list of column model
		     *                                                            
		     */
		    "setColumns" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).setColumns(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setData( grid_Id, data, callbackHandler )
		     * Description   : Replace all rows with the specified list. This will change the original data.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   data : <Array> A list of new rows
		     *                 callbackHandler   - <Function> The function that will be called when done.
		     *                                                            
		     */
		    "setData" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).setData(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setValue( grid_Id, rowKey, columnName, columnValue )
		     * Description   : Sets the value of the cell identified by the specified rowKey and columnName.
		     * Parameters    : grid_Id     - <String> Grid ID
		     * 				   rowKey      - <String> The unique key of the row
		     * 				   columnName  - <String> The name of the column
		     * 				   columnValue - <String> The value to be set
		     * 
		     */
		    "setValue" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	if(oUtil.isNull(arg[2])){return null;}
		    	if(oUtil.isNull(arg[3])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).setValue(arg[1], arg[2], arg[3]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.setWidth( grid_Id, width )
		     * Description   : Set the width of the dimension.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   width : <Number> The width of the dimension
		     *                                                            
		     */
		    "setWidth" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).setWidth(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.sort( grid_Id, columnName, ascendingopt )
		     * Description   : Sorts all rows by the specified column.
		     * Parameters    : grid_Id      - <String> Grid ID
		     * 				   columnName   - <String> The width of the dimension
		     *                 ascendingopt - <booolean> <optional> Whether the sort order is ascending.If not specified, use the negative value of the current order.
		     *                                                            
		     */
		    "sort" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	if(oUtil.isNull(arg[1])){
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).sort(arg[1], true);
		    	}else{
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).sort(arg[1], arg[2]);
		    	}
		    		
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.unSort( grid_Id )
		     * Description   : Unsorts all rows. (Sorts by rowKey).
		     * Parameters    : grid_Id      - <String> Grid ID
		     *                                                            
		     */
		    "unSort" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).unSort();
		    	
		    		
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.clear( grid_Id )
		     * Description   : Removes all rows.
		     * Parameters    : grid_Id      - <String> Grid ID
		     *                                                            
		     */
		    "clear" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).clear();
		    	
		    		
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.copyToClipboard( grid_Id )
		     * Description   : Copy to clipboard
		     * Parameters    : grid_Id      - <String> Grid ID
		     *                                                            
		     */
		    "copyToClipboard" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).copyToClipboard();
		    	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.destroy( grid_Id )
		     * Description   : Destroys the instance.
		     * Parameters    : grid_Id      - <String> Grid ID
		     *                                                            
		     */
		    "destroy" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).destroy();
		    		
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.uncheck( grid_Id, rowKey )
		     * Description   : Checks the row identified by the specified rowKey.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "check" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).check(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.uncheckAll( grid_Id)
		     * Description   : Checks all rows.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "checkAll" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).checkAll();	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.uncheck( grid_Id, rowKey )
		     * Description   : Set the width of the dimension.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "uncheck" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	if(oUtil.isNull(arg[1])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).uncheck(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.uncheckAll( grid_Id)
		     * Description   : Set the width of the dimension.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     */
		    "uncheckAll" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).uncheckAll();	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.appendRow(grid_Id, rowcount, addIndex)
		     * Description   : Set the width of the dimension.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowcount  - <Integer> The data for the new row
		     * 				   addIndex - <Integer> <optional>                                                            
		     */
		    "appendRow" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var appendTempRow = [];
		    	for(var i = 0; i < arg[1]; i++){
		    		appendTempRow.push({});
		    	}
		    	if(arg[2] != undefined && arg[1] != null){
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).appendRow(appendTempRow,{"at" : arg[2]});
		    	}else{
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).appendRow(appendTempRow);
		    	}
		    		
		    },
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.insertRow(grid_Id, rowData, addIndex)
		     * Description   : 값이 들어 있는 ROW를 추가한다.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowData  - <Json> The data for the new row
		     * 				   addIndex - <Integer> <optional> 
		     */
		    "insertRow" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	var appendTempRow = arg[1];
		    	if(arg[2] != undefined && arg[1] != null){
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).appendRow(appendTempRow,{"at" : arg[2], "extendPrevRowSpan" : true} );
		    	}else{
		    		(KpackageOBJ.tuiGrid.getGrid(arg[0])).appendRow(appendTempRow);
		    	}
		    		
		    },
		    
		    "getRowIndex" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}	// grid Id
		    	if(oUtil.isNull(arg[1])){return null;}	// rowKey
	    		return (KpackageOBJ.tuiGrid.getGrid(arg[0])).getIndexOfRow(arg[1]);
		    		
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.disableCheck(grid_Id, rowKey)
		     * Description   : Disables the row identified by the spcified rowKey to not be abled to check.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "disableCheck" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).disableCheck(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.disableCheck(grid_Id, rowKey)
		     * Description   : Disables the row identified by the rowkey.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "disableCheck" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).disableCheck(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.enableCheck(grid_Id, rowKey)
		     * Description   : Disables the row identified by the spcified rowKey to not be abled to check.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "enableCheck" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).enableCheck(arg[1]);	
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.enableRow(grid_Id, rowKey)
		     * Description   : Disables the row identified by the rowkey.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "enableRow" : function(){
		    	var arg = arguments;
		    	if(oUtil.isNull(arg[0])){return null;}
		    	(KpackageOBJ.tuiGrid.getGrid(arg[0])).enableRow(arg[1]);	
		    },
		    "setButton" : function(gridId, buttonObject) {
		    	
		    	if(gridId == "" || gridId == undefined || gridId == null){return;}
		    	if(buttonObject == "" || buttonObject == undefined || buttonObject == null){return;}
		    	
		    	//<a class="btn btn-default DTTT_button_xls" id="ToolTables_datatable_tabletools_2"><span>Excel</span></a>
		    	var iconValue = "<div id='button_"+gridId+"' class='tui-grid-head-area' style='float:right;'><div class='tuiGrid-toobar-group btn-group'>";
		        if (oUtil.isArray(buttonObject)) {
		            if (buttonObject.length < 1) {
		                return;
		            }
		            for (var i = 0; i < buttonObject.length; i++) {
		                var text = buttonObject[i].text;
		                var func = buttonObject[i].func;
		                var icon = buttonObject[i].icon;
		                var title = buttonObject[i].title;
		                
		                if("none" == icon){
		                	icon = "";
		                }else if("delete" == icon){
		                	icon = "glyphicon glyphicon-remove";
		                }else if("insert" == icon){
		                	icon = "glyphicon glyphicon-plus";
		                }else if("edit" == icon){
		                	icon = "glyphicon glyphicon-edit";
		                }else if("excel" == icon){
		                	//icon = "fa fa fa-file-excel-o";
		                	icon = "fa fa-file-excel-o";
		                }else if("save" == icon){
		                	icon = "glyphicon glyphicon-floppy-save";
		                }else{
		                	icon = icon;
		                }
//		                iconValue += "<a class='btn grid-add-btn btn-border tuiGrid-toolbar-button' id='"+gridId+text+func+"' href='javascript:"+func+"(\""+gridId+"\")' title='"+title+"'><i class='"+icon+"'></i> <span>"+text+"</span></a>";
		                iconValue += "<a class='btn grid-add-btn btn-border tuiGrid-toolbar-button' id='"+gridId+text+func+"' href='javascript:"+func+"(\""+gridId+"\")' title='"+title+"'> <span>"+text+"</span></a>";
		            }
		            iconValue = iconValue + "</div></div>";
		            $("#"+gridId).parent().prepend(iconValue);
		            
		            if($("#caption_"+gridId).length > 0){
			    		$("#button_"+gridId).css({"margin-top" : "5px","margin-right" : "5px", "background-color" : "initial"});
			    	}
		        }
		        
			},
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.enableRow(grid_Id, rowKey)
		     * Description   : Disables the row identified by the rowkey.
		     * Parameters    : grid_Id - <String> Grid ID
		     * 				   rowKey  - <String> The unique key of the row
		     *                                                            
		     */
		    "setCaption" : function(){
		    	var arg = arguments;
		    	var captionOBJ = "<div id=\"caption_"+arg[0]+"\" class=\"tui-caption\"><span><i class=\"fa fa-align-justify txt-color-darken\"></i> </span><h2>"+arg[1]+"</h2></div>";
		    	$("#"+arg[0]).parent().prepend(captionOBJ);
		    	
		    	if($("#button_"+arg[0]).length > 0){
		    		$("#button_"+arg[0]).css({"margin-top" : "5px","margin-right" : "5px", "background-color" : "initial"});
		    	}
		    },
		    /**
		     * ##############   2019.05.09 Function Add Patch ####################
		     * Tab 안의 Toast Grid를 생성할 경우 display None일때 
		     * 사이즈가 불량한 Toast Grid를 생성할경우 이를 Refresh하는 Fucntion
		     * ################################################################### 
		     */
		    "reSizingGrid" : function(){
		    	var arg = arguments;
		    	
		    	try{
					var tgt;
					if(KpackageOBJ.prototype.regexp_notPaging.test($("#"+arg[0]).attr("id"))){
						tgt = KpackageOBJ.tuiGrid.getGrid($("#"+arg[0]).attr("id"));
						if(tgt != null && $("#"+arg[0]).data("fixedHeight") == undefined){
							tgt.setBodyHeight($(window).height()-$("#"+arg[0]).data("minusHeight") || $(window).height() - KpackageOBJ.prototype.minusHeight);
						}else if(tgt != null && $("#"+arg[0]).data("fixedHeight") != undefined){
							tgt.setBodyHeight($("#"+arg[0]).data("fixedHeight"));	
						}
					}
					tgt.refreshLayout();
				}catch(e){
					
				}
		    },
		    
		    /**
		     * Function Name : KpackageOBJ.tuiGrid.validation(grid_Id)
		     * Description   : Grid data validation check.
		     * Parameters    : grid_Id - <String> Grid ID
		     *                                                            
		     */
		    "validation" : function(){
		    	var arg = arguments;
		    	
	    		var errArr = (KpackageOBJ.tuiGrid.getGrid(arg[0])).validate();
				var colArr = (KpackageOBJ.tuiGrid.getGrid(arg[0])).getColumns();
				var errMsg = "";
				
				if(errArr.length > 0){
					if(errArr[0].errors[0].errorCode == "REQUIRED"){
						errMsg = "필수입력";
					} else {
						errMsg = errArr[0].errors[0].errorCode;
					}
					
					for(var i=0; i < colArr.length; i++){
						if(colArr[i].name == errArr[0].errors[0].columnName){
							errMsg = ((KpackageOBJ.tuiGrid.getGrid(arg[0])).getIndexOfRow(errArr[0].rowKey)+1) + "행 " + colArr[i].title + "은(는) " + errMsg + " 항목입니다.";
							
							return errMsg;
						}
					}
				}
		    		
				return errMsg;
		    }
		    
		    
		    
		    
		    
		},
		
		"grid" : {
			
			"def_Height" : 150,
			
			/**
			 * *************   Grid Render Function   ********************************************************** 
			 * Parameter Descriptions 
			 *     - gridId <String> Grid Id
			 *     - colInfoArray <Array> Grid Header model +  p_colName <Array> Grid Header Name
			 *     - p_autowidth <boolean> Grid Auto Width Set Value
			 *     - height <String> height
			 *     - p_click_function <String> onSelectRow Event Function Name
			 *     - p_dblClick_function <String> onDblClickRow Event Function Name
			 *     - p_loadComplete_Callback <String> Grid Data Load Compleate Callback Function
			 * 
			 **/
			"create" : function(gridId, p_url, p_params, p_colInfoArray, p_autowidth, p_height, p_click_function, p_dblClick_function, p_loadComplete_Callback){
				
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				if(p_height == undefined || p_height == null || p_height == "" ){
					p_height = KpackageOBJ.grid.def_Height;
				}
				var l_colNames = [];
				var l_colModel = [];
				for(var inx=0; inx < p_colInfoArray.length; inx++){
					l_colNames.push(p_colInfoArray[inx]["header"]);
					p_colInfoArray[inx]["index"] = p_colInfoArray[inx]["name"];  
					l_colModel.push(p_colInfoArray[inx]);
				}
				var addOptObject = $("#" + gridId).data();
				var defaultRowSize = 100;
				if(addOptObject["rownum"] != null && addOptObject["rownum"] != undefined){
					defaultRowSize = addOptObject["rownum"];
				}
				var gridOptObject = {
						caption : "Default Grid Caption",
						url:p_url,
						mtype: 'POST',
						postData : p_params,
						datatype: "json",
						colNames: l_colNames,
						colModel: l_colModel,
						viewrecords: true,
						loadonce : false,
						gridview : true,
						loadui : "enable",
						rowNum : defaultRowSize,
						rowList : [defaultRowSize, defaultRowSize*2, defaultRowSize*3],
						rownumbers: true,
						autowidth: p_autowidth ? true : false,
						height : p_height,
						pager: "p_"+ gridId,
						shrinkToFit: false,
						loadBeforeSend: function (xhr, settings) {
							
							if("" == p_url){
								//server sise call cancel
								this.p.loadBeforeSend = null; //remove event handler
								return false; // dont send load data request
							}
							if(token != "" && header != "" && token != undefined && header != undefined){
								xhr.setRequestHeader(header, token);	
							}
						},
						loadComplete : function(data){
							/*IE Cross Browsing Patch*/
							if ($.browser.msie) {
								var patchWidth = $("[aria-labelledby='gbox_"+$(this).prop("id")+"']").css("width");
								var patchTarget = $(this).parent();
								$(patchTarget).css("width", patchWidth);
							}
							if(p_loadComplete_Callback != null && p_loadComplete_Callback != undefined && p_loadComplete_Callback != ""){
								new Function(p_loadComplete_Callback +"(data,$(this).prop('id'))")();;	
							}
						},
						 onSelectRow: function(rowid, status, e) {
							 if(p_click_function != null && p_click_function != undefined && p_click_function != ""){
									new Function(p_click_function +"(rowid ,$(this).prop('id'))")();	
							 }
					          		
						}, 
						ondblClickRow: function(rowid){ //grid double click evnet
							if(p_dblClick_function != null && p_dblClick_function != undefined && p_dblClick_function != ""){
								new Function(p_dblClick_function +"(rowid ,$(this).prop('id'))")();	
							}
							
					    },
					    formatter : {
					    	number : {decimalSeparator:",", thousandsSeparator: ".", decimalPlaces: 2, defaultValue: '0,00'}
					    	,count : {decimalSeparator:",", thousandsSeparator: ".", decimalPlaces: 0, defaultValue: '0'}
					    	}};
				$("#" + gridId).jqGrid($.extend({},addOptObject, gridOptObject));
		  		// remove classes
		  		jQgrid_Common_Css();
		  		
		  		// Caption Hide Default
		  		$(">div.ui-jqgrid-titlebar", $("#" + gridId).closest('div.ui-jqgrid-view')).hide();

				
			},
			"retrieve" : function(gridId, urlParams, params, dataType){
		    	if(oUtil.isNull(dataType)){
		    		dataType = "json";
		    	}
		    	
		    	var token = $("meta[name='_csrf']").attr("content");
				params["_csrf"] = token;
				
		    	$("#"+gridId+"").jqGrid('setGridParam', { url:urlParams, 
				    datatype:dataType,
				    postData: params
				}).trigger('reloadGrid');     
		    },
		    "reload" : function(gridId){
		    	$("#"+gridId+"").trigger('reloadGrid');
		    },
		    "clear" : function(gridId){
		    	var grid = $('#'+gridId+'');
		    	grid.jqGrid('clearGridData');
		    },
		    "resetSelection" : function(gridId){
		    	var grid = $('#'+gridId+'');
		    	grid.jqGrid('resetSelection');
		    },
		    "getIndexArray" : function(gridId){
		    	var grid = $('#'+gridId+'');
		    	return grid.jqGrid("getDataIDs");
		    },
		    "getData" : function(gridId){
		    	var grid = $('#'+gridId+'');
		    	return grid.jqGrid("getRowData");
		    },
		    "getRetrieveParam" : function(gridId){
		    	var grid = $('#'+gridId+'');
		    	return grid.jqGrid('getGridParam','postData');
		    	
		    },
		    "getSelectedRow" : function(gridId){
				return KpackageOBJ.grid.getSelectedRow(gridId,'','');
			},
			"getSelectedRow" : function(gridId, rowid){
				return KpackageOBJ.grid.getSelectedRow(gridId,rowid,'');
			},
			"getSelectedRow" : function(gridId, rowid, fieldID){
				var grid = $('#'+gridId+'');
				var data = null;
				if(oUtil.isNull(rowid)){
					var rowid = grid.getGridParam('selrow');
				}
				if(oUtil.isNull(fieldID)){
					data =  grid.jqGrid('getRowData', rowid);
				}else{
					data =  grid.jqGrid('getRowData', rowid)[fieldID];
				}
				return data;
			},
			"getSelectedIndex" : function (gridId){
				var grid = $('#'+gridId+'');
				var rowid = grid.getGridParam('selrow');
				return rowid;
			},
			
			"getCheckedRows" : function(){
				var dataList = new Array();
		    	var grid = $("#"+gridId+"");
		    	var selRow = checkRow;
		    	
		    	if(oUtil.isNull(checkRow)){
		    		selRow = KpackageOBJ.grid.getCheckedRowIndex(gridId);
		    	}
		    	//alert("selRow : "+selRow+", selRow.length : "+selRow.length);
		    	for(var i=0;i<selRow.length;i++)  //iterate through array of selected rows
		    	{
		    		dataList.push(grid.jqGrid('getRowData',selRow[i]));
		    	}
		    	return dataList;
			},
			"setCheck" : function(gridId, checkTargetRowIndex){
				$("#"+gridId+"").jqGrid('setSelection',checkTargetRowIndex);
			},
			"setSelection" : function(gridId, targetRowIndex){
				$("#"+gridId+"").jqGrid('setSelection',targetRowIndex);
			},
			"getCheckedRowIndex" : function(){
				var grid = $("#"+gridId+"");
		    	var checkRowIndex = grid.jqGrid('getGridParam', 'selarrrow');
		        return checkRowIndex;
			},
			
			
			"getRowLength" : function(gridId){
				return jQuery("#"+gridId+"").jqGrid('getGridParam', 'records');
			},
			"getJosnTypeData" : function(gridData) {
		        if (!oUtil.isNull(gridData)) {
		            return changDatagridToJson(gridData);
		        } else {
		            return "[]";
		        }
		    },
		    "changDatagridToJson" : function(gridData) {
		        var key;
		        var value;
		        var toList = "[";
		        var gridDataArray = new Array();
		        if (gridData != null && gridData != 'undefined' && (gridData.length == null || gridData.length == 'undefined')) {
		            gridDataArray[0] = gridData
		        } else {
		            gridDataArray = gridData
		        }
		        for (var i = 0; i < gridDataArray.length; i++) {
		            var rowData = gridDataArray[i];
		            var toMap = "{";
		            var rowCnt = 0;
		            for (var j in rowData) {
		                rowCnt++;
		                key = j;
		                try {
		                    value = rowData[key];
		                } catch (e) {
		                    //alert(value);
		                    return
		                }
		                var values = new String(value);
		                values = values.replace(/\"/g, "＂");
		                if (oUtil.isNull(values) || values == 'null') {
		                    toMap += '"' + key + '":"",'
		                } else {
		                    toMap += '"' + key + '":"' + values + '",'
		                }
		            }
		            toMap = toMap.substring(0, toMap.length - 1);
		            toMap += "},";
		            toList += toMap;
		        }
		        toList = toList.substring(0, toList.length - 1);
		        toList += "]";
		        return toList;
		    },
		    
		    "getCheckedRowsData" : function(gridId) {
		        return getCheckedRowsData(gridId, null, null);
		    },
		    
		    "getCheckedRowsData" : function(gridId, checkRow, fieldID) {
		    	var dataList = new Array();
		    	var grid = $("#"+gridId+"");
		    	var selRow = checkRow;
		    	if(oUtil.isNull(checkRow)){
		    		selRow = KpackageOBJ.grid.getCheckedRowsIndex(gridId);
		    	}
		    	
		    	for(var i=0;i<selRow.length;i++)  //iterate through array of selected rows
		    	{
		    		dataList.push(grid.jqGrid('getRowData',selRow[i]));
		    	}
		    	return dataList;
		    },
		    "getCheckedRowsIndex" : function(gridId) {
		    	var grid = $("#"+gridId+"");
		    	var checkRowIndex = grid.jqGrid('getGridParam', 'selarrrow');
		        return checkRowIndex;
		    },
		    
		    "getData" : function(gridId){
		    	var grid = $("#"+gridId+"");
		    	return  grid.getRowData();
		    },
		    
		    "getDataGrid" : function(gridId){
				var grid = $("#"+gridId+"");
		    	return  grid.getRowData();
		    },
		    
		    "getRowIndex" : function(gridId) {
		    	var grid = $("#"+gridId+"");
		    	var getRowIndex = grid.getGridParam('selrow');
		        return getRowIndex;
		    },
		    
		    "setCaption" : function(gridId, captionText) {
		    	var grid = $("#"+gridId+"");
		    	grid.jqGrid('setCaption', captionText);
		    	$(">div.ui-jqgrid-titlebar", $("#" + gridId).closest('div.ui-jqgrid-view')).show();
		    },
		    "setButton" : function(gridId, buttonObject) {
		    	
		    	if(gridId == "" || gridId == undefined || gridId == null){return;}
		    	if(buttonObject == "" || buttonObject == undefined || buttonObject == null){return;}
		    	
		    	//<a class="btn btn-default DTTT_button_xls" id="ToolTables_datatable_tabletools_2"><span>Excel</span></a>
		    	var iconValue = "<div class='DTTT btn-group'>";
		        if (oUtil.isArray(buttonObject)) {
		            if (buttonObject.length < 1) {
		                return;
		            }
		            for (var i = 0; i < buttonObject.length; i++) {
		                var text = buttonObject[i].text;
		                var func = buttonObject[i].func;
		                var icon = buttonObject[i].icon;
		                var title = buttonObject[i].title;
		                
		                if("none" == icon){
		                	icon = "";
		                }else if("delete" == icon){
		                	icon = "glyphicon glyphicon-remove";
		                }else if("insert" == icon){
		                	icon = "glyphicon glyphicon-plus";
		                }else if("edit" == icon){
		                	icon = "glyphicon glyphicon-edit";
		                }else if("excel" == icon){
		                	//icon = "fa fa fa-file-excel-o";
		                	icon = "fa fa-file-excel-o";
		                	
		                }else if("save" == icon){
		                	icon = "glyphicon glyphicon-floppy-save";
		                }else{
		                	icon = icon;
		                }
		                iconValue += "<a class='btn grid-add-btn btn-default btn-border' id='"+gridId+text+func+"' href='javascript:"+func+"()' title='"+title+"'><i class='"+icon+"'></i> <span>"+text+"</span></a>";
		            }
		            iconValue = iconValue + "</div>";
		            $("#p_"+gridId+"_left").append(iconValue);
		        }
		        
			},
			"setBgColor" : function(gridId, targetRow, colId, colorCode) {
				if(gridId == "" || gridId == undefined || gridId == null){return;}
				try{
					$("#"+ gridId).jqGrid('setCell',targetRow,colId,"",{background:colorCode});	
				}catch(e){}
				
				
			},
			"setFontColor" : function(gridId, targetRow, colId, colorCode) {
				if(gridId == "" || gridId == undefined || gridId == null){return;}
				try{
					$("#"+ gridId).jqGrid('setCell',targetRow,colId,"",{color:colorCode});	
				}catch(e){}
				
			},
			"getGridColumns" : function(gridId){
				var colModel = $("#"+gridId+"").jqGrid('getGridParam','colModel');
			    var colName = $("#"+gridId+"").jqGrid('getGridParam','colNames');
				var returnVal = [ "[" ];
				var tmpList = [];
				
				tmpList.push("[");
				for (var i = 0; i < colModel.length; i++) {
					var colData = colModel[i];
					var field = colData.name;
					var title = colName[i];
					var width = colData.width;
					var align = colData.align;
					var halign = "center";
					var sortable = colData.sortable;
					var hidden = colData.hidden;
					var editor = null;
					var checkbox = null;
					var formatter = colData.formatter;
					var rowspan = null;
					var colspan = null;
					if(field == 'rn' || field == 'cb'){//rownum하고 체크박스는 해더로 만들지 않는다.
						continue;
					}
					
					var toMap = [ "" ];
					toMap.push("{");
					//if (!oUtil.isNull(title))
						//toMap.push("{");
					if (!oUtil.isNull(field))
						toMap.push('"field":"' + field + '",');
					if (!oUtil.isNull(title))
						toMap.push('"title":"' + title.toString().replace("<br>", "") + '",');
					if (!oUtil.isNull(width))
						toMap.push('"width":"' + (parseInt(width * 32)) + '",');
					if (!oUtil.isNull(align))
						toMap.push('"align":"' + align + '",');
					if (!oUtil.isNull(halign))
						toMap.push('"halign":"' + halign + '",');
					if (!oUtil.isNull(sortable))
						toMap.push('"sortable":"' + sortable + '",');
					if (!oUtil.isNull(hidden)) {
						if(field == "CHECK" || field == "CHECKED") hidden = "true";
						if(field == "COMPANY_NAME") hidden = "false";
						if(field == "DIVISION_NAME") hidden = "false";
						
						toMap.push('"hidden":"' + hidden + '",');
					}
					if (!oUtil.isNull(editor))
						toMap.push('"editor":"' + editor + '",');
					if (!oUtil.isNull(checkbox))
						toMap.push('"checkbox":"' + checkbox + '",');
					if (!oUtil.isNull(formatter))
						toMap.push('"formatter":"",');
					if (!oUtil.isNull(rowspan))
						toMap.push('"merge_row":"' + rowspan + '",');
					if (!oUtil.isNull(colspan))
						toMap.push('"merge_col":"' + colspan + '",');
					var lastMapVal = toMap[toMap.length - 1];
					toMap[toMap.length - 1] = lastMapVal.substring(0,
							lastMapVal.length - 1);
						if (i == (colModel.length - 1)) {
							toMap.push("}");
						} else {
							toMap.push("},");
						}
						tmpList.push(toMap.join(""));
				}
				tmpList.push("],");
				var tmpListStr = tmpList.join("");
				returnVal += tmpListStr.substring(0, tmpListStr.length - 1);
				returnVal += "]";
				return returnVal;
			},
			"deleteRow" : function(gridId, rowIdx){
				if(gridId == "" || gridId == undefined || gridId == null){return;}
				$("#"+ gridId).jqGird('delRowData', rowid)
			},
			/** 그리드를 접거나 펼친 상태로 변경합니다. */
			"toggleGrid" : function(gridId){
				if(gridId == "" || gridId == undefined || gridId == null){return;}
				$("#gview_"+gridId+" > div.ui-jqgrid-titlebar.ui-corner-top.ui-helper-clearfix > a > span").trigger("click");
			},
			
			"setSelectBox" : function(gridId, url, codeParam, nameParam, data, colModel){
		    	var returnData = "";
		    	var grid = $("#"+gridId+"");
		    	if (!oUtil.isNull(data)) {
		    		var array = data;
		    		for (var i = 0; i < array.length; i++) {
		    			var item = array[i];
		    			returnData += item[codeParam]+":"+item[nameParam]+";";
		    		}
		    		return returnData.slice(0,-1);
		    	}else{
		    		
		    		grid.setColProp(colModel, {edittype:"select" 
						,editoptions: {
	            			dataUrl : url
	            			,buildSelect:function (selectBoxData){
	            				var rtSlt = '<select name="'+colModel+'">';
	            				selectBoxData = $.parseJSON(selectBoxData);
	            				if(selectBoxData.length == 0){//검색데이터 0개 처리
	            					rtSlt += '<option value=""></option>';
	            				}
	            				$.each(selectBoxData,function(i1,v1){
	            					rtSlt += '<option value="' +v1[codeParam] + '">' + v1[nameParam] + '</option>';
	            				});
	            				rtSlt +='</select>';
	            				return rtSlt;
	            			}
	            		},editrules:{edithidden:true}
		    		});
		    	}
		    },
		    
		    "editMode" : function(gridId, lastSel, activeFlag){
		    	var grid = $("#"+gridId+"");
		    	if(activeFlag){
		    		
		    	}else{
		    		grid.saveRow(lastSel);
			    	grid.restoreRow(lastSel);	
		    	}
		    	
		    }
			
			
			
		}
}



$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();

    $.each(a, function() { 
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });

    return o;
};

function load_BlockUI(t){
	if(t){
		var target = $("body");
	    
		if ( $("#messageDIV").length > 0 ) {
			if($("div[class='messageDIV']").length == 0){
				target = $("#messageDIV");
			}else{
				target = $("div[class='messageDIV']").eq(($("div[class='messageDIV']").length-1));
			}
		}
		
		var $DisableDiv = "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
		var $LoadingDiv = "<div id='viewLoading' class='viewLoading'><img src='/resources/images2/loding_img/round_loading3.gif'></div> ";	
		
		target.append($DisableDiv);
		target.append($LoadingDiv);
		
		var yp=target.scrollTop();
		var xp=target.scrollLeft();

		var ws=target.innerWidth();
		var hs=target.innerHeight();
		target.find("#disableDiv").css({'width':'100%','height':hs});
		target.find("#viewLoading").css("top",yp+hs/2-100);
		target.find("#viewLoading").css("left",xp+ws/2-100);
		target.find("#disableDiv").show();
		target.find("#viewLoading").show();
	}else{
		$('#disableDiv').hide().remove();
		$('#viewLoading').hide().remove();		
	}

}





function load_BlockUI2(t){
	
	if(t == undefined){
		t = true;
	}
	if(t){
		var target = $("body");
	    
		if ( $("#messageDIV").length > 0 ) {
			if($("div[class='messageDIV']").length == 0){
				target = $("#messageDIV");
			}else{
				target = $("div[class='messageDIV']").eq(($("div[class='messageDIV']").length-1));
			}
		}
		var $DisableDiv = "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
		/*var $LoadingDiv = "<div id='viewLoading' class='loading_spinner'></div> ";*/
		var $LoadingDiv = "<div id='viewLoading' class='loader_box'><div class='loader3'>" +
				/* Loading Image Area  Start */
				"<div class='spinner'>" +
				"<div class='piece a'></div><div class='piece b'></div><div class='piece c'></div><div class='piece d'> </div><div class='piece e'></div><div class='piece f'></div><div class='piece g'></div><div class='piece h'></div><div class='piece i'></div><div class='piece j'></div><div class='piece k'></div><div class='piece l'></div><div class='piece m'></div><div class='piece n'></div><div class='piece o'></div><div class='piece p'></div>" +
				"</div>" +
				/* Loading Image Area  End*/
				"</div></div> ";
		
		target.append($DisableDiv);
		target.append($LoadingDiv);
		
		var yp=target.scrollTop();
		var xp=target.scrollLeft();

		var ws=target.innerWidth();
		/*
		var hs=target.innerHeight();
		*/
		// 화면 세로 사이즈를 오버하는 경우에 대한 케이스 적용
		var hs = $("#left-panel").height() + 48;
		
		target.find("#disableDiv").css({'width':'100%','height':hs});
		target.find("#viewLoading").css("top",(yp+hs/2)-40);
		target.find("#viewLoading").css("left",xp+ws/2-70);
		
		target.find("#viewLoading").css("position","absolute");
		target.find("#viewLoading").css("z-index","999");
		
		target.find("#disableDiv").show();
		target.find("#viewLoading").show();
	}else{
		$('#disableDiv').hide().remove();
		$('#viewLoading').hide().remove();		
	}

}
function load_BlockUI3(targetId, t) {

	if (targetId == undefined) {
		load_BlockUI2();
		return;
	}

	if (t == undefined) {
		t = true;
	}

	if (t) {
		var target = $("#" + targetId);
		var $DisableDiv = "<div id='disableDiv' class='disableDiv' style='display:none'></div>";
		var $LoadingDiv = "<div id='viewLoading' class='loader_box'><div class='loader3'>" +
			/* Loading Image Area  Start */
			"<div class='spinner'>" +
			"<div class='piece a'></div><div class='piece b'></div><div class='piece c'></div><div class='piece d'> </div><div class='piece e'></div><div class='piece f'></div><div class='piece g'></div><div class='piece h'></div><div class='piece i'></div><div class='piece j'></div><div class='piece k'></div><div class='piece l'></div><div class='piece m'></div><div class='piece n'></div><div class='piece o'></div><div class='piece p'></div>" +
			"</div>" +
			/* Loading Image Area  End*/
			"</div></div> ";

		var yp = target.scrollTop();
		var xp = target.scrollLeft();
		var ws = target.innerWidth();
		var hs = $("#" + targetId).height() - 5;

		target.append($DisableDiv);
		target.append($LoadingDiv);
		target.find("#disableDiv").css({ 'width': '100%', 'height': hs });
		target.find("#viewLoading").css("top", (yp + hs / 2) - 40);
		target.find("#viewLoading").css("left", xp + ws / 2 - 70);

		target.find("#viewLoading").css("position", "absolute");
		target.find("#viewLoading").css("z-index", "999");

		target.find("#disableDiv").show();
		target.find("#viewLoading").show();
	} else {
		$("#" + targetId + " #disableDiv").hide().remove();
		$("#" + targetId + " #viewLoading").hide().remove();
	}
}
$("body.menu-on-top .dspp_panel div.dspp_step").hover(function(){
	if("dashBoard" !== $(this).prop("id")){
		$(this).css("background-position","-251px -55px");
		$(this).children("div").eq(0).addClass("subOn");
	}
	
	
});

$("body.menu-on-top .dspp_panel div.dspp_step").mouseleave(function(){
	if("dashBoard" !== $(this).prop("id")){
		$(this).children("div").eq(0).removeClass("subOn");
		
		
		if($(this).hasClass("active") !== true) {
			$(this).css("background-position","-251px -109px");
		}	
	}
	
});

$("body.menu-on-top .dspp_panel div.dspp_step").click(function(){
	
		$("body.menu-on-top .dspp_panel div.dspp_step").each(function(){
			if("dashBoard" !== $(this).prop("id")){
				$(this).removeClass("active");	
				$(this).css("background-position","-251px -109px");	
			}
			
		});
		if("dashBoard" !== $(this).prop("id")){
			$(this).css("background-position","-251px -55px");
			$(this).addClass("active");	
		}
});
