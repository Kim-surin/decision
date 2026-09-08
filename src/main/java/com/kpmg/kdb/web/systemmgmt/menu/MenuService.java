package com.kpmg.kdb.web.systemmgmt.menu;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

@Service
@SuppressWarnings({ "rawtypes" })
public class MenuService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(MenuService.class);

    /** 메뉴 Tree 목록 조회 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveMenuList(Map<String, Object> param) {
        Result result = new Result();
        try {
            result.setValue(sqlSession.getMapper(MenuDao.class).retrieveMenuList(param));
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error("메뉴 목록 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    /** 메뉴 상세 조회 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result retrieveMenuDetail(Map<String, Object> param) {
        Result result = new Result();
        try {
            result.setValue(sqlSession.getMapper(MenuDao.class).retrieveMenuDetail(param));
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error("메뉴 상세 조회 중 오류가 발생했습니다.", e);
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }
        return result;
    }

    /** 메뉴 등록 및 수정 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional(rollbackFor = Exception.class)
    public Result saveMenu(Map<String, Object> param) {
        Result result = new Result();
        try {
            MenuDao dao = sqlSession.getMapper(MenuDao.class);
            String saveType = stringValue(param.get("save_type"));
            String menuId = stringValue(param.get("menu_id"));

            if (menuId.length() == 0) {
                return failureResult("메뉴 ID를 입력해 주세요.");
            }

            if ("I".equals(saveType)) {
                if (dao.retrieveMenuIdCount(param) > 0) {
                    return failureResult("이미 사용 중인 메뉴 ID입니다.");
                }
                dao.insertMenu(param);
            } else if ("U".equals(saveType)) {
                if (dao.updateMenu(param) == 0) {
                    return failureResult("수정할 메뉴를 찾을 수 없습니다.");
                }
            } else {
                return failureResult("저장 구분값이 올바르지 않습니다.");
            }

            Map<String, Object> value = new HashMap<String, Object>();
            value.put("menu_id", menuId);
            value.put("save_type", saveType);

            result.setValue(value);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);
        } catch (Exception e) {
            logger.error("메뉴 저장 중 오류가 발생했습니다.", e);
            throw new RuntimeException("메뉴 저장 중 오류가 발생했습니다.", e);
        }
        return result;
    }

    private Result failureResult(String message) {
        Result result = new Result();
        result.setSuccess(false);
        result.setMessage(message);
        return result;
    }

    private String stringValue(Object value) {
        return value == null ? "" : String.valueOf(value).trim();
    }
}