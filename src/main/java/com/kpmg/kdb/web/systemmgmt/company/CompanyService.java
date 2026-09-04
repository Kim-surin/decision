package com.kpmg.kdb.web.systemmgmt.company;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes" })
public class CompanyService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(CompanyService.class);

    @SuppressWarnings("unchecked")
    public Result retrieveCompanyList(Map<String, Object> param) {
        Result result = new Result();
        try {
            result.setValue(sqlSession.getMapper(CompanyDao.class).retrieveCompanyList(param));
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error("회사 목록 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    public Result retrieveCompanyDetail(Map<String, Object> param) {
        Result result = new Result();
        try {
            result.setValue(sqlSession.getMapper(CompanyDao.class).retrieveCompanyDetail(param));
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error("회사 상세 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = Exception.class)
    public Result saveCompany(Map<String, Object> param) {
        try {
            String saveType = text(param.get("save_type"));
            String companyCode = text(param.get("TMP_COMPANY_CODE"));
            String companyName = text(param.get("company_name"));

            if (companyCode.length() == 0 || companyName.length() == 0) {
                return failure("회사코드와 회사명을 입력해 주세요.");
            }
            if (!isYn(param.get("co_certified_exporter_yn"))
                    || !isYn(param.get("company_use_yn"))) {
                return failure("사용 여부 항목을 올바르게 선택해 주세요.");
            }
            if (!validRate(param.get("com_de_minimis_rate"))
                    || !validRate(param.get("com_rvc_rate"))) {
                return failure("버퍼율은 0부터 999.99 사이로 입력해 주세요.");
            }

            CompanyDao dao = sqlSession.getMapper(CompanyDao.class);
            if ("I".equals(saveType)) {
                if (dao.retrieveCompanyCount(param) > 0) {
                    return failure("이미 등록된 회사코드입니다.");
                }
                
                
                // 회사 기초정보 등록
				int rtn = dao.insertCompany(param);
				
				// 회사 옵션 등록
				if(rtn > 0) {					
					rtn = dao.updateOptionDetail(param);
				}
				
				// 기초 사용자 등록
				if(rtn > 0) {
					rtn = dao.userInfoInsert(param);
				}
				
				// 기초 권한 등록
				if(rtn > 0) {
					rtn = dao.roleMstInsert(param);
				}
				
				// 기초 사용자 권한 등록
				if(rtn > 0) {
					rtn = dao.roleUserInsert(param);
				}
				
				// 기초 사용자 권한 메뉴 등록
				if(rtn > 0) {
					rtn = dao.roleMenuInsert(param);
				}
				
				// 기초 코드 등록
				if(rtn > 0) {
					// mst
					rtn = dao.codeMstInsert(param);
					
					if(rtn > 0) {
						// dtl
						rtn = dao.codeDtlInsert(param);
					}
				}
				
				// 기초 인터페이스 항목 등록
				if(rtn > 0) {
					// mst
					rtn = dao.interfaceItemMstInsert(param);
					
					if(rtn > 0) {
						// dtl
						rtn = dao.interfaceItemDtlInsert(param);
					}
				}
				
				// 기초 인터페이스 스캐줄 등록
				if(rtn > 0) {
					// schedule
					rtn = dao.interfaceScheduleInsert(param);
					
					if(rtn > 0) {
						// mapping
						rtn = dao.interfaceScheduleMappingInsert(param);
					}
				}
                
                
                
                
            } else if ("U".equals(saveType)) {
                if (dao.updateCompany(param) == 0) {
                    return failure("수정할 회사를 찾을 수 없습니다.");
                }
                
                dao.updateOptionDetail(param);
                
            } else {
                return failure("저장 구분값이 올바르지 않습니다.");
            }

            Map<String, Object> value = new HashMap<String, Object>();
            value.put("company_code", companyCode);
            Result result = new Result();
            result.setValue(value);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
            return result;
        } catch (Exception e) {
            logger.error("회사 저장 중 오류가 발생했습니다.", e);
            throw new RuntimeException(e);
        }
    }

    private boolean validRate(Object value) {
        try {
            BigDecimal rate = new BigDecimal(text(value));
            return rate.compareTo(BigDecimal.ZERO) >= 0
                    && rate.compareTo(new BigDecimal("999.99")) <= 0;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isYn(Object value) {
        return "Y".equals(text(value)) || "N".equals(text(value));
    }

    private String text(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }

    private Result failure(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }
}
