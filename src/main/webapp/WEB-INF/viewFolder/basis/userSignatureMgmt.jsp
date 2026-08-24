<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		
		.add-user-card {
		    cursor: pointer;
		    border-style: dashed !important;
		    transition: all 0.2s ease-in-out;
		}
		
		.add-user-card:hover {
		    transform: translateY(-3px);
		    box-shadow: 0 .125rem .25rem rgba(0,0,0,.15) !important;
		    background-color: #f8f9fa;
		}
		
		.add-user-card .card-body {
		    min-height: 155px;
		}
		
		.add-user-card.table-mode .card-body {
		    min-height: auto !important;
		    padding: 20px !important;
		}
		
		.add-user-card.table-mode .add-icon-wrap {
		    margin-bottom: 8px !important;
		}
		
		.add-user-card.table-mode .fs-lg {
		    font-size: 1rem !important;
		}
		
		.add-user-card.table-mode .text-muted {
		    font-size: 0.875rem !important;
		}
		
		.user-info-card {
		    border-radius: 12px;
		    transition: all 0.2s ease-in-out;
		    overflow: hidden;
		}
		
		.user-info-card:hover {
		    transform: translateY(-2px);
		    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.12) !important;
		}
		
		.user-name-link {
		    font-size: 1.15rem;
		    font-weight: 700;
		    color: #3b7ddd;
		    text-decoration: none;
		    display: inline-block;
		    margin-bottom: 4px;
		}
		
		.user-name-link:hover {
		    text-decoration: underline;
		}
		
		.user-position {
		    font-size: 0.95rem;
		    color: #6c757d;
		    font-weight: 500;
		}
		
		.user-info-item {
		    display: flex;
		    align-items: center;
		    gap: 10px;
		    padding: 8px 0;
		    font-size: 0.95rem;
		    color: #495057;
		    border-bottom: 1px dashed #eef1f5;
		}
		
		.user-info-item:last-child {
		    border-bottom: none;
		}
		
		.user-info-item i {
		    width: 18px;
		    color: #7b8aa0;
		    font-size: 1rem;
		}
		
		.badge-user-status {
		    font-size: 0.75rem;
		    padding: 6px 10px;
		    border-radius: 999px;
		}
		.userinfo-photo-icon{
		    font-size: 3.3rem;
    		color: #cbcbcb;
		}
		
	</style>

	<script src="/rcs/ui5x/scripts/smartFilter.js"></script>

</head>
<body>
	<div class="content-wrapper">
		<div class="row">
			<div class="content-wrapper col-3">
				<h1 class="subheader-title mb-1">사용자 관리</h1>
				<nav class="app-breadcrumb" aria-label="breadcrumb">
					<ol class="breadcrumb ms-0 text-muted mb-0">
						<li class="breadcrumb-item">Home</li>
						<li class="breadcrumb-item" aria-current="page">기초정보관리</li>
						<li class="breadcrumb-item active" aria-current="page">사용자 관리</li>
					</ol>
				</nav>
			</div>
			<div class="row col-9"></div>
	    </div>
	    <div class="row">
		    <div class="col-xl-12">
	            <div class="border-faded bg-faded p-3 mb-g d-flex">
	                <div class="position-relative flex-grow-1">
	                    <input type="text" id="js-filter-contacts" name="filter-contacts" class="form-control shadow-inset-2 form-control-lg" placeholder="사용자명, 사번, 이메일, 전화전호, 직급 필터링">
	                    <button id="js-clear-filter" type="button" class="btn btn-sm btn-danger position-absolute top-50 end-0 translate-middle-y me-2 d-none waves-effect waves-themed">
	                        <i class="fal fa-times"></i>
	                    </button>
	                </div>
	                <div class="btn-group btn-group-lg hidden-lg-down ms-3" role="group" aria-label="Change list &amp; grid view">
	                    <input type="radio" class="btn-check" name="contactview" id="grid" value="grid" checked="checked">
	                    <label class="btn btn-outline-secondary waves-effect waves-themed" for="grid" style="padding-top: 10px;"><i class="sa sa-grid" style="font-size: 1.5rem;"></i></label>
	                    <input type="radio" class="btn-check" name="contactview" id="table" value="table">
	                    <label class="btn btn-outline-secondary waves-effect waves-themed" for="table" style="padding-top: 10px;"><i class="sa sa-list" style="font-size: 1.5rem;"></i></label>
	                </div>
	            </div>
	            <div id="filter-result-counter" class="ms-auto fs-sm text-muted mb-g"></div>
	        </div>
	    </div>
	    <div class="row" id="js-userinfo-list">
	        
	    </div>
	</div>
</body>
<script>
	var BASIS001 = new function() {

		// AUIGrid 생성 후 반환 ID
		this.grid_BASIS001_01 = null;
		this.grid_BASIS001_02 = null;

		// 시작점
		this.Initialize_viewObject = function() {

			BASIS001.retrieveUserInfoList();
		}
		
		this.retrieveUserInfoList = function(){
			var params = {
					"dummy" : "dummy"
			};
			
			KpackageOBJ.ajax.doSubmit("/basis/retrieveUserinfoList", params, BASIS001.retrieveUser_CallbackHandler);
		}
		
		this.retrieveUser_CallbackHandler = function(result){
			
			
			BASIS001.renderUserCard(result.value);
			
		    // Use direct filtering implementation instead of SmartFilter
		    implementDirectFiltering();
		    
		    // Function to remove classes with a specific prefix
		    function removeClassPrefix(elements, prefix) {
		        elements.forEach(element => {
		            const classes = Array.from(element.classList);
		            classes.forEach(cls => {
		                if (cls.startsWith(prefix)) {
		                    element.classList.remove(cls);
		                }
		            });
		        });
		    }

		    // Select all radio inputs with name="contactview"
		    const radioButtons = document.querySelectorAll('input[type="radio"][name="contactview"]');

			radioButtons.forEach(radio => {
			    radio.addEventListener('change', function() {
			        const jsContacts = document.querySelector('#js-userinfo-list');
			        const cards = jsContacts.querySelectorAll('.card');
			        const colXlElements = jsContacts.querySelectorAll('[class*="col-xl-"]');
			        const expandButtons = jsContacts.querySelectorAll('.js-expand-btn');
			        const doubleCardBodies = jsContacts.querySelectorAll('.card-body + .card-body');
			        const addUserCards = jsContacts.querySelectorAll('.add-user-card');
			
			        if (this.value === 'grid') {
			            removeClassPrefix(cards, 'mb-');
			            cards.forEach(card => card.classList.add('mb-g'));
			
			            removeClassPrefix(colXlElements, 'col-xl-');
			            colXlElements.forEach(el => el.classList.add('col-xl-4'));
			
			            expandButtons.forEach(btn => btn.classList.add('d-none'));
			
			            doubleCardBodies.forEach(body => body.classList.add('show'));
			
			            addUserCards.forEach(card => card.classList.remove('table-mode'));
			        }
			        else if (this.value === 'table') {
			            removeClassPrefix(cards, 'mb-');
			            cards.forEach(card => card.classList.add('mb-1'));
			
			            removeClassPrefix(colXlElements, 'col-xl-');
			            colXlElements.forEach(el => el.classList.add('col-xl-12'));
			
			            expandButtons.forEach(btn => btn.classList.remove('d-none'));
			
			            doubleCardBodies.forEach(body => body.classList.remove('show'));
			
			            addUserCards.forEach(card => card.classList.add('table-mode'));
			        }
			    });
			});

		    // Direct filtering implementation that doesn't rely on SmartFilter
		    function implementDirectFiltering() {
		        const filterInput = document.getElementById('js-filter-contacts');
		        const clearBtn = document.getElementById('js-clear-filter');
		        const counterEl = document.getElementById('filter-result-counter');
		        
		        // Input filtering
		        filterInput.addEventListener('input', function() {
		            const filterValue = this.value.toLowerCase();
		            const cards = document.querySelectorAll('#js-userinfo-list .card');
		            const columns = document.querySelectorAll('#js-userinfo-list [class*="col-xl-"]');
		            let visibleCount = 0;
		            
		            // First, hide all columns
		            columns.forEach(col => {
		                col.style.display = 'none';
		            });
		            
		            // Filter cards based on their data-filter-tags attribute
		            cards.forEach(card => {
		                const filterTags = card.getAttribute('data-filter-tags') || '';
		                const parentColumn = card.closest('[class*="col-xl-"]');
		                
		                if (filterValue === '' || filterTags.toLowerCase().includes(filterValue)) {
		                    if (parentColumn) {
		                        parentColumn.style.display = ''; // Show the column
		                    }
		                    visibleCount++;
		                }
		            });
		            
		            // Update UI
		            if (filterValue) {
		                counterEl.textContent = `Showing ${visibleCount} of ${cards.length} contacts`;
		                filterInput.classList.add('border-primary');
		                clearBtn.classList.remove('d-none');
		            } else {
		                counterEl.textContent = '';
		                filterInput.classList.remove('border-primary');
		                clearBtn.classList.add('d-none');
		            }
		        });
		        
		        // Clear button functionality
		        clearBtn.addEventListener('click', function(e) {
		            e.preventDefault();
		            filterInput.value = '';
		            
		            // Show all columns
		            const columns = document.querySelectorAll('#js-userinfo-list [class*="col-xl-"]');
		            columns.forEach(col => {
		                col.style.display = '';
		            });
		            
		            // Reset UI
		            counterEl.textContent = '';
		            filterInput.classList.remove('border-primary');
		            clearBtn.classList.add('d-none');
		        });
		        
		        // Set up keyboard events for convenience
		        filterInput.addEventListener('keydown', function(e) {
		            // Clear on Escape key
		            if (e.key === 'Escape') {
		                e.preventDefault();
		                this.value = '';
		                clearBtn.click();
		            }
		        });
		    }
		}
		
		this.renderUserCard = function(userList){
			var $target = $('#js-userinfo-list');
		    $target.empty();

		    $.each(userList, function(index, user) {
		        var cardId = 'c_' + (index + 1);

		        var userId = user.user_id || 'N/A';
		        var empNo = user.emp_no || 'N/A';
		        var nameKor = user.name_kor || 'N/A';
		        var positionName = user.position_name || 'N/A';
		        var email = user.email || '';
		        var cellPhoneNo = user.cell_phone_no || 'N/A';
		        var status = user.status || '';
		        var signatureYn = user.signature_yn || 'N';
		        var signature_text = user.signature_text || '';
		        
		        
		        var filterTags = [
		            userId,
		            userId,
		            empNo,
		            positionName,
		            email,
		            signature_text
		        ].join(' ');

		        var html = '';
		        if(signatureYn == "Y" ){
		        	var html = ''
		        		+ '<div class="col-xl-4">'
			            + '    <div id="' + cardId + '" class="card border shadow-0 shadow-sm-hover mb-g" data-filter-tags="' + filterTags + '">'
		        	    + '        <div class="card-body border-faded border-top-0 border-start-0 border-end-0 rounded-top">'
		        	    + '            <div class="d-flex flex-row align-items-center">'
		        	    + '                <span class="me-3">'
                        + '                    <span class="profile-image d-block " style="background-size: cover;"><i class="sa sa-profile userinfo-photo-icon"></i></span>'
                        + '                </span>'
		        	    + '                <div class="info-card-text flex-grow-1">'
		        	    + '                    <a href="javascript:BASIS001.openUserDeail(\'' + userId + '\');" class="fs-xl text-truncate text-truncate-lg">'
		        	    + '                        [' + userId + '] - ' + nameKor + '(' + empNo + ')'
		        	    + '                    </a>'
		        	    + '                    <span class="d-block text-truncate text-truncate-lg">' + positionName + '</span>'
		        	    + '                </div>'
			            + '                <span style="margin-right:15px;">' + BASIS001.getStatusBadge(status, signatureYn) + '</span>'
		        	    + '                <button type="button" class="js-expand-btn btn btn-sm btn-default waves-effect waves-themed d-none"'
			            + '                    data-bs-toggle="collapse"'
			            + '                    data-bs-target="#' + cardId + ' > .card-body + .card-body"'
			            + '                    aria-expanded="false">'
			            + '                    <span class="collapsed-hidden">+</span>'
			            + '                    <span class="collapsed-reveal">-</span>'
			            + '                </button>'
		        	    + '            </div>'
		        	    + '        </div>'
		        	    + '        <div class="card-body p-3 collapse show">'
		        	    + '            <div class="d-flex justify-content-between align-items-start">'
		        	    + '                <div>'
		        	    + '                    <a href="javascript:void(0);" class="mt-1 d-block fs-sm fw-400">'
		        	    + '                        <i class="sa sa-screen-smartphone text-muted me-2"></i> ' + cellPhoneNo
		        	    + '                    </a>'
		        	    + '                    <a href="javascript:void(0);" class="mt-1 d-block fs-sm fw-400">'
		        	    + '                        <i class="sa sa-envelope text-muted me-2"></i> ' + email
		        	    + '                    </a>'
		        	    + '                </div>'
		        	    + '                <div class="signature-box">'
		        	    + '                    <img src="/basis/signature/' + empNo + '" alt="signature" onerror="this.style.display=\'none\';" style="width: 49px;">'
		        	    + '                </div>'
		        	    + '            </div>'
		        	    + '        </div>'
		        	    + '    </div>'
		        	    + '</div>';
		        }else{
		        	html = ''
			            + '<div class="col-xl-4">'
			            + '    <div id="' + cardId + '" class="card border shadow-0 shadow-sm-hover mb-g" data-filter-tags="' + filterTags + '">'
			            + '        <div class="card-body border-faded border-top-0 border-start-0 border-end-0 rounded-top">'
			            + '            <div class="d-flex flex-row align-items-center">'
		        	    + '                <span class="me-3">'
                        + '                    <span class="profile-image d-block " style="background-size: cover;"><i class="sa sa-profile userinfo-photo-icon"></i></span>'
                        + '                </span>'
			            + '                <div class="info-card-text flex-grow-1">'
			            + '                    <a href="javascript:BASIS001.openUserDeail(\'' + userId + '\');" class="fs-xl text-truncate text-truncate-lg">'
			            + '                        [' + userId + '] - ' + nameKor + '(' + empNo + ')'
			            + '                    </a>'
			            + '                    <span class="d-block text-truncate text-truncate-lg">' + positionName + '</span>'
			            + '                </div>'
			            + '                <span style="margin-right:15px;">' + BASIS001.getStatusBadge(status, signatureYn) + '</span>'
			            + '                <button type="button" class="js-expand-btn btn btn-sm btn-default waves-effect waves-themed d-none"'
			            + '                    data-bs-toggle="collapse"'
			            + '                    data-bs-target="#' + cardId + ' > .card-body + .card-body"'
			            + '                    aria-expanded="false">'
			            + '                    <span class="collapsed-hidden">+</span>'
			            + '                    <span class="collapsed-reveal">-</span>'
			            + '                </button>'
			            + '            </div>'
			            + '        </div>'
			            + '        <div class="card-body p-0 collapse show">'
			            + '            <div class="p-3">'
			            + '                <a href="javascript:void(0);" class="mt-1 d-block fs-sm fw-400">'
			            + '                    <i class="sa sa-screen-smartphone text-muted me-2"></i> ' + cellPhoneNo
			            + '                </a>'
			            + '                <a href="javascript:void(0);" class="mt-1 d-block fs-sm fw-400">'
			            + '                    <i class="sa sa-envelope text-muted me-2"></i> ' + email
			            + '                </a>'
			            + '            </div>'
			            + '        </div>'
			            + '    </div>'
			            + '</div>';
		        }
		        
		        

		        $target.append(html);
		    });
		    
		    var addCardHtml = ''
		        + '<div class="col-xl-4 col-lg-6 col-md-6 col-sm-12 mb-3 user-card-wrap">'
		        + '    <div class="card user-card border shadow-0 shadow-sm-hover add-user-card">'
		        + '        <div class="card-body d-flex flex-column justify-content-center align-items-center text-center" style="padding: 24px; cursor: pointer;" onclick="BASIS001.openNewUser();">'
		        + '            <div class="add-icon-wrap">'
		        + '                <i class="sa sa-plus text-primary" style="font-size: 3rem;"></i>'
		        + '            </div>'
		        + '            <div class="fs-lg fw-700 text-dark">사용자 추가</div>'
		        + '            <div class="text-muted fs-sm mt-1">새로운 사용자를 등록합니다.</div>'
		        + '        </div>'
		        + '    </div>'
		        + '</div>';
		        
		  
		        
		    $target.append(addCardHtml);
			
		}
		
		this.openUserDeail = function(pUserId){
			var getParams = "?dialog_id="           + "userInfoDetail_Dialog"
            				 + "&opener_pgm_id="    +  "BASIS001"
							 + "&param_user_id="          +  pUserId;
            
			KpackageOBJ.sidepanel.open('userInfoDetail_Dialog','/basis/userSignatureDetail_pop' + getParams, '1200px');
		}
		
		this.openNewUser = function(){
			var getParams = "?dialog_id="           + "userInfoDetail_Dialog"
			 + "&opener_pgm_id="    +  "BASIS001"

			KpackageOBJ.sidepanel.open('userInfoDetail_Dialog','/basis/userSignatureDetail_pop' + getParams, '1200px');
		}
		
		
		
		
		this.getStatusBadge = function(status, signatureYn) {
		    var statusBadge = '';
		    var signatureBadge = '';

		    if (status === 'Y') {
		        statusBadge = '<span class="badge badge-user-status bg-success">사용</span>';
		    } else if (status === 'R') {
		        statusBadge = '<span class="badge badge-user-status bg-warning text-dark">대기</span>';
		    } else if (status === 'N') {
		        statusBadge = '<span class="badge badge-user-status bg-secondary">미사용</span>';
		    } else {
		        statusBadge = '<span class="badge badge-user-status bg-light text-dark">' + (status || '-') + '</span>';
		    }

		    if (signatureYn === 'Y') {
		        signatureBadge = '<span class="badge badge-user-status bg-primary ms-1">서명권자</span>';
		    } else {
		        signatureBadge = '';
		    }

		    return statusBadge + signatureBadge;
		};
		
	};
	
	
	
	$(document).ready(function() {
		pageSetUp(); // 위젯 기능을 사용하기 위해 필수로 호출 합니다.
		BASIS001.Initialize_viewObject();
	});
</script>

</html>