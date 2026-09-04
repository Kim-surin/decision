package com.kpmg.kdb.web.systemmgmt.role;

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
public class RoleService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(RoleService.class);

    @SuppressWarnings("unchecked")
    public Result retrieveRoleList(Map<String, Object> param) {
        return selectResult("권한 목록", sqlSession.getMapper(RoleDao.class).retrieveRoleList(param));
    }

    @SuppressWarnings("unchecked")
    public Result retrieveRoleDetail(Map<String, Object> param) {
        return selectResult("권한 상세", sqlSession.getMapper(RoleDao.class).retrieveRoleDetail(param));
    }

    @SuppressWarnings("unchecked")
    public Result retrieveRoleMenuList(Map<String, Object> param) {
        return selectResult("권한 메뉴", sqlSession.getMapper(RoleDao.class).retrieveRoleMenuList(param));
    }

    @SuppressWarnings("unchecked")
    public Result retrieveUserRoleList(Map<String, Object> param) {
        return selectResult("사용자별 권한", sqlSession.getMapper(RoleDao.class).retrieveUserRoleList(param));
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = Exception.class)
    public Result saveRole(Map<String, Object> param) {
        try {
            RoleDao dao = sqlSession.getMapper(RoleDao.class);
            String saveType = text(param.get("save_type"));
            String roleCode = text(param.get("role_code"));

            if (roleCode.length() == 0 || text(param.get("role_name")).length() == 0) {
                return failure("권한코드와 권한명을 입력해 주세요.");
            }

            if ("I".equals(saveType)) {
                if (dao.retrieveRoleCount(param) > 0) {
                    return failure("이미 등록된 권한코드입니다.");
                }
                dao.insertRole(param);
            } else if ("U".equals(saveType)) {
                if (dao.updateRole(param) == 0) {
                    return failure("수정할 권한을 찾을 수 없습니다.");
                }
            } else {
                return failure("저장 구분값이 올바르지 않습니다.");
            }

            Map<String, Object> value = new HashMap<String, Object>();
            value.put("role_code", roleCode);
            Result result = success(value);
            return result;
        } catch (Exception e) {
            logger.error("권한 저장 중 오류가 발생했습니다.", e);
            throw new RuntimeException(e);
        }
    }

    @SuppressWarnings("unchecked")
    @Transactional(rollbackFor = Exception.class)
    public Result deleteRole(Map<String, Object> param) {
        try {
            RoleDao dao = sqlSession.getMapper(RoleDao.class);
            dao.deleteRoleMenu(param);
            dao.deleteRoleUser(param);
            if (dao.deleteRole(param) == 0) {
                return failure("삭제할 권한을 찾을 수 없습니다.");
            }
            return success(null);
        } catch (Exception e) {
            logger.error("권한 삭제 중 오류가 발생했습니다.", e);
            throw new RuntimeException(e);
        }
    }

    @SuppressWarnings({ "unchecked" })
    @Transactional(rollbackFor = Exception.class)
    public Result saveRoleMenu(Map<String, Object> param) {
        try {
            RoleDao dao = sqlSession.getMapper(RoleDao.class);
            if (text(param.get("role_code")).length() == 0) {
                return failure("저장할 권한을 선택해 주세요.");
            }

            dao.deleteRoleMenu(param);
            Object menuList = param.get("menu_list");
            if (menuList instanceof List && !((List) menuList).isEmpty()) {
                dao.insertRoleMenuList(param);
            }
            return success(null);
        } catch (Exception e) {
            logger.error("메뉴 권한 저장 중 오류가 발생했습니다.", e);
            throw new RuntimeException(e);
        }
    }

    /**
     * 선택 사용자에게 단일 권한을 일괄 적용한다.
     * 기존 사용자-권한 매핑을 모두 삭제하고 role_code가 있으면 새 권한을 등록한다.
     */
    @SuppressWarnings({ "unchecked" })
    @Transactional(rollbackFor = Exception.class)
    public Result saveUserRole(Map<String, Object> param) {
        try {
            Object userList = param.get("user_list");
            if (!(userList instanceof List) || ((List) userList).isEmpty()) {
                return failure("권한을 적용할 사용자를 선택해 주세요.");
            }

            RoleDao dao = sqlSession.getMapper(RoleDao.class);
            dao.deleteUserRoleList(param);

            if (text(param.get("role_code")).length() > 0) {
                dao.insertUserRoleList(param);
            }
            return success(null);
        } catch (Exception e) {
            logger.error("사용자별 권한 저장 중 오류가 발생했습니다.", e);
            throw new RuntimeException(e);
        }
    }

    private Result selectResult(String name, Object value) {
        Result result = new Result();
        try {
            result.setValue(value);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error(name + " 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    private Result success(Object value) {
        Result result = new Result();
        result.setValue(value);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);
        return result;
    }

    private Result failure(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }

    private String text(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }
}
