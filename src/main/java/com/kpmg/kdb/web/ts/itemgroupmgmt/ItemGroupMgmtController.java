package com.kpmg.kdb.web.ts.itemgroupmgmt;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GenericController;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/****************************************************************************************************
 *
 * ItemGroupMgmtController.class
 *
 * @since 2025.04
 * @author D.Cat
 *
 * 제품군 관리 Controller
 *
 ****************************************************************************************************/
@Controller
@SuppressWarnings("rawtypes")
public class ItemGroupMgmtController extends GenericController {

    protected Logger logger = LoggerFactory.getLogger(ItemGroupMgmtController.class);

    @Autowired
    protected ItemGroupMgmtService service;


    /**
     * 제품군 Excel Upload 팝업
     */
    @RequestMapping(value = "/itemgroupmgmt/excelUploadPopup")
    public String excelUploadPopup(Model model, HttpSession session) {
        return "itemgroupmgmt/itemgroupexceluploadpopup";
    }


    /**
     * 제품군 Excel 양식 다운로드
     */
    /**
     * 제품군 Excel 양식 다운로드
     */
    @RequestMapping(value = "/itemgroupmgmt/templateDownload")
    public void templateDownload(HttpServletResponse response) {

        logger.debug("##### templateDownload START");

        XSSFWorkbook workbook = null;
        OutputStream out = null;

        try {

            workbook = new XSSFWorkbook();

            Sheet sheet = workbook.createSheet("제품군등록");

            Row headerRow = sheet.createRow(0);

            headerRow.createCell(0).setCellValue("제품군코드");
            headerRow.createCell(1).setCellValue("제품군명");
            headerRow.createCell(2).setCellValue("제조공정순서");

            sheet.setColumnWidth(0, 20 * 256);
            sheet.setColumnWidth(1, 30 * 256);
            sheet.setColumnWidth(2, 60 * 256);

            String fileName = URLEncoder
                    .encode("제품군등록_양식.xlsx", "UTF-8")
                    .replaceAll("\\+", "%20");

            response.setContentType(
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            );

            response.setHeader(
                    "Content-Disposition",
                    "attachment; filename=\"" + fileName + "\""
            );

            out = response.getOutputStream();

            workbook.write(out);

            out.flush();

        } catch (Exception e) {

            logger.error("templateDownload error", e);

        } finally {

            try {

                if (out != null) {
                    out.close();
                }

            } catch (Exception e) {

                logger.error("outputStream close error", e);
            }
        }

        logger.debug("##### templateDownload END");
    }

    /**
     * 제품군 Excel Upload
     */
    @RequestMapping(value = "/itemgroupmgmt/excelUpload")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public Result excelUpload(
            @RequestParam Map<String, Object> param,
            @RequestParam(value = "FILEUP", required = false) MultipartFile file,
            HttpSession session) {

        logger.debug("##### excelUpload START");

        Result result = new Result();

        try {

            Map<String, Object> saveParam = super.extendsMap(param);

            Map<String, Object> sessionUser =
                    (Map<String, Object>) session.getAttribute("_sessionUser");

            if (sessionUser != null) {

                Object userId = sessionUser.get("user_id");

                saveParam.put("CREATE_BY", userId);
                saveParam.put("UPDATE_BY", userId);
            }

            result = service.excelUpload(saveParam, file);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(
                    false,
                    "MSG_UNSPECIFIED_ERROR",
                    new Object[] {}
            );
        }

        logger.debug("##### excelUpload END");

        return result;
    }
    
    /**
     * 제품군 관리 메인 화면
     */
    @RequestMapping(value = "/itemgroupmgmt/ItemGroupMgmt")
    public String itemgroupmgmt000_view(Model model, HttpSession session) {
        return "itemgroupmgmt/itemgroupmgmt";
    }


    /**
     * 제품군 관리 팝업
     */
    @GetMapping("/itemgroupmgmt/itemGroupPopup")
    public String itemGroupPopup() {
        return "itemgroupmgmt/itemgrouppopup";
    }


    /**
     * 품목 상세정보 팝업
     */
    @GetMapping("/itemgroupmgmt/itemDetailPopup")
    public String itemDetailPopup() {
        return "itemgroupmgmt/itemdetailpopup";
    }


    /**
     * 제품군 목록 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemGroupMgmt")
    @ResponseBody
    public Result retrieveItemGroupMgmt(@RequestBody Map param) {

        logger.debug("##### retrieveItemGroupMgmt START");

        Result result = new Result();

        try {
            result = service.retrieveItemGroupMgmt(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemGroupMgmt END");

        return result;
    }


    /**
     * 제품군별 품목 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemGroupItemList")
    @ResponseBody
    public Result retrieveItemGroupItemList(@RequestBody Map param) {

        logger.debug("##### retrieveItemGroupItemList START");

        Result result = new Result();

        try {
            result = service.retrieveItemGroupItemList(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemGroupItemList END");

        return result;
    }


    /**
     * 제품군 상세 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemGroupDetail")
    @ResponseBody
    public Result retrieveItemGroupDetail(@RequestBody Map param) {

        logger.debug("##### retrieveItemGroupDetail START");

        Result result = new Result();

        try {
            result = service.retrieveItemGroupDetail(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemGroupDetail END");

        return result;
    }


    /**
     * 제품군 그리드 일괄 저장
     */
    @RequestMapping(value = "/itemgroupmgmt/saveItemGroupList")
    @ResponseBody
    public Result saveItemGroupList(@RequestBody Map param) {

        logger.debug("##### saveItemGroupList START");

        Result result = new Result();

        try {
            result = service.saveItemGroupList(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### saveItemGroupList END");

        return result;
    }


    /**
     * 제품군 삭제
     */
    @RequestMapping(value = "/itemgroupmgmt/deleteItemGroup")
    @ResponseBody
    public Result deleteItemGroup(@RequestBody Map param) {

        logger.debug("##### deleteItemGroup START");

        Result result = new Result();

        try {
            result = service.deleteItemGroup(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### deleteItemGroup END");

        return result;
    }


    /**
     * 제품군 팝업 저장
     */
    @RequestMapping(value = "/itemgroupmgmt/saveItemGroup")
    @ResponseBody
    @SuppressWarnings("unchecked")
    public Result saveItemGroup(
            @RequestParam Map<String, Object> param,
            @RequestParam(value = "FILEUP", required = false) List<MultipartFile> files,
            HttpSession session) {

        logger.debug("##### saveItemGroup START");

        Result result = new Result();

        try {

            Map<String, Object> saveParam = super.extendsMap(param);

            Map<String, Object> sessionUser = (Map<String, Object>) session.getAttribute("_sessionUser");

            if (sessionUser != null) {
                Object userId = sessionUser.get("user_id");

                saveParam.put("CREATE_BY", userId);
                saveParam.put("UPDATE_BY", userId);
            }

            result = service.saveItemGroup(saveParam, files);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### saveItemGroup END");

        return result;
    }
    
    
    /**
     * 제품군 다중 삭제
     */
    @RequestMapping(value = "/itemgroupmgmt/deleteItemGroupList")
    @ResponseBody
    public Result deleteItemGroupList(@RequestBody Map param) {

        logger.debug("##### deleteItemGroupList START");

        Result result = new Result();

        try {

            result = service.deleteItemGroupList(super.extendsMap(param));

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### deleteItemGroupList END");

        return result;
    }

    /**
     * 제품군 첨부파일 목록 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemGroupFileList")
    @ResponseBody
    public Result retrieveItemGroupFileList(@RequestBody Map param) {

        logger.debug("##### retrieveItemGroupFileList START");

        Result result = new Result();

        try {
            result = service.retrieveItemGroupFileList(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemGroupFileList END");

        return result;
    }


    /**
     * 제품군 첨부파일 다운로드
     */
    @GetMapping("/itemgroupmgmt/itemGroupFileDownload")
    @ResponseBody
    public ResponseEntity<byte[]> itemGroupFileDownload(@RequestParam Map<String, Object> param) {

        Map<String, Object> fileMap = service.itemGroupFileDownload(super.extendsMap(param));

        if (fileMap == null || fileMap.get("REALFILE") == null) {
            return ResponseEntity.notFound().build();
        }

        byte[] fileData = (byte[]) fileMap.get("REALFILE");

        String fileName = String.valueOf(fileMap.get("ORIGIN_FILE_NAME"));

        String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replace("+", "%20");

        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName);
        headers.setContentLength(fileData.length);

        return ResponseEntity.ok().headers(headers).body(fileData);
    }


    /**
     * 품목 상세 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemDetail")
    @ResponseBody
    public Result retrieveItemDetail(@RequestBody Map param) {

        logger.debug("##### retrieveItemDetail START");

        Result result = new Result();

        try {
            result = service.retrieveItemDetail(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemDetail END");

        return result;
    }


    /**
     * 제품군 콤보 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemGroupCombo")
    @ResponseBody
    public Result retrieveItemGroupCombo(@RequestBody Map param) {

        logger.debug("##### retrieveItemGroupCombo START");

        Result result = new Result();

        try {
            result = service.retrieveItemGroupCombo(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemGroupCombo END");

        return result;
    }


    /**
     * 품목 이미지 목록 조회
     */
    @RequestMapping(value = "/itemgroupmgmt/retrieveItemFileList")
    @ResponseBody
    public Result retrieveItemFileList(@RequestBody Map param) {

        logger.debug("##### retrieveItemFileList START");

        Result result = new Result();

        try {
            result = service.retrieveItemFileList(super.extendsMap(param));
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### retrieveItemFileList END");

        return result;
    }


    /**
     * 품목 상세 저장
     * - 제품군 변경
     * - 이미지 추가
     * - 기존 이미지 삭제
     */
    @RequestMapping(value = "/itemgroupmgmt/saveItemDetail")
    @ResponseBody
    public Result saveItemDetail(
            @RequestParam Map<String, Object> param,
            @RequestParam(value = "ITEM_IMG", required = false) List<MultipartFile> files) {

        logger.debug("##### saveItemDetail START");

        Result result = new Result();

        try {
            result = service.saveItemDetail(super.extendsMap(param), files);
        } catch (Exception e) {
            e.printStackTrace();
            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        logger.debug("##### saveItemDetail END");

        return result;
    }

}