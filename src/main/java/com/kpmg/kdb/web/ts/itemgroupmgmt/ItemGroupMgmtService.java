package com.kpmg.kdb.web.ts.itemgroupmgmt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kpmg.kdb.core.form.Result;
import com.kpmg.kdb.core.generic.GeneralService;

import java.io.InputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


@Service
@SuppressWarnings({ "rawtypes", "unchecked" })
public class ItemGroupMgmtService extends GeneralService {

    static Logger logger = LoggerFactory.getLogger(ItemGroupMgmtService.class);


    /**
     * 제품군 목록 조회
     */
    public Result retrieveItemGroupMgmt(Map<String, Object> param) {

        Result result = new Result();

        try {

            List<Map<String, Object>> list = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemGroupMgmt(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }

    
    /**
     * 제품군 Excel Upload
     */
    /**
     * 제품군 Excel Upload
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional
    public Result excelUpload(Map<String, Object> param, MultipartFile file) {

        Result result = new Result();

        if (file == null || file.isEmpty()) {
            result.setSuccess(false);
            result.setMessage("업로드할 Excel 파일을 선택하세요.");
            return result;
        }

        String originalFileName = file.getOriginalFilename();

        if (originalFileName == null || !originalFileName.toLowerCase().endsWith(".xlsx")) {
            result.setSuccess(false);
            result.setMessage("xlsx 파일만 업로드할 수 있습니다.");
            return result;
        }

        XSSFWorkbook workbook = null;
        InputStream inputStream = null;

        try {

            ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);

            inputStream = file.getInputStream();

            workbook = new XSSFWorkbook(inputStream);

            Sheet sheet = workbook.getSheetAt(0);

            DataFormatter formatter = new DataFormatter();

            List<Map<String, Object>> insertList = new ArrayList<Map<String, Object>>();

            Set<String> excelProductCodeSet = new HashSet<String>();


            /* 헤더 검증 */
            Row headerRow = sheet.getRow(0);

            if (headerRow == null) {
                result.setSuccess(false);
                result.setMessage("Excel 양식이 올바르지 않습니다.");
                return result;
            }

            String header1 = formatter.formatCellValue(headerRow.getCell(0)).trim();
            String header2 = formatter.formatCellValue(headerRow.getCell(1)).trim();
            String header3 = formatter.formatCellValue(headerRow.getCell(2)).trim();

            if (!"제품군코드".equals(header1)
                    || !"제품군명".equals(header2)
                    || !"제조공정순서".equals(header3)) {

                result.setSuccess(false);
                result.setMessage("Excel 양식이 올바르지 않습니다. 제품군등록 양식을 사용하세요.");
                return result;
            }


            /* Excel 데이터 읽기 */
            for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {

                Row row = sheet.getRow(rowIndex);

                if (row == null) {
                    continue;
                }

                String productCode = formatter.formatCellValue(row.getCell(0)).trim();
                String productName = formatter.formatCellValue(row.getCell(1)).trim();
                String flowchartComment = formatter.formatCellValue(row.getCell(2)).trim();


                /* 빈 행 제외 */
                if ("".equals(productCode)
                        && "".equals(productName)
                        && "".equals(flowchartComment)) {
                    continue;
                }


                /* 필수값 검증 */
                if ("".equals(productCode)) {
                    result.setSuccess(false);
                    result.setMessage((rowIndex + 1) + "행의 제품군코드가 없습니다.");
                    return result;
                }

                if ("".equals(productName)) {
                    result.setSuccess(false);
                    result.setMessage((rowIndex + 1) + "행의 제품군명이 없습니다.");
                    return result;
                }

                if ("".equals(flowchartComment)) {
                    result.setSuccess(false);
                    result.setMessage((rowIndex + 1) + "행의 제조공정순서가 없습니다.");
                    return result;
                }


                /* Excel 내부 중복 */
                if (excelProductCodeSet.contains(productCode)) {
                    result.setSuccess(false);
                    result.setMessage("Excel 파일 내 제품군코드가 중복되었습니다. [" + productCode + "]");
                    return result;
                }

                excelProductCodeSet.add(productCode);


                Map<String, Object> rowParam = new HashMap<String, Object>();

                rowParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
                rowParam.put("PRODUCT_CODE", productCode);
                rowParam.put("PRODUCT_NAME", productName);
                rowParam.put("PRODUCT_NAME_ENG", null);
                rowParam.put("FLOWCHART_COMMENT", flowchartComment);
                rowParam.put("CREATE_BY", param.get("CREATE_BY"));
                rowParam.put("UPDATE_BY", param.get("UPDATE_BY"));

                insertList.add(rowParam);
            }


            if (insertList.size() == 0) {
                result.setSuccess(false);
                result.setMessage("등록할 제품군 데이터가 없습니다.");
                return result;
            }


            /* DB 중복 체크 - 하나라도 존재하면 전체 중단 */
            for (Map<String, Object> rowParam : insertList) {

                String duplicate = dao.selectItemGroupDuplicate(rowParam);

                if (duplicate != null && !"".equals(duplicate)) {

                    result.setSuccess(false);
                    result.setMessage("이미 등록된 제품군코드입니다. [" + rowParam.get("PRODUCT_CODE") + "]");
                    return result;
                }
            }


            /* 전체 검증 완료 후 INSERT */
            int insertCount = 0;

            for (Map<String, Object> rowParam : insertList) {
                insertCount += dao.insertItemGroup(rowParam);
            }


            result.setValue(insertCount);
            result.setSuccess(true);
            result.setMessage(insertCount + "건의 제품군이 등록되었습니다.");

            return result;

        } catch (Exception e) {

            logger.error("excelUpload error", e);

            throw new RuntimeException(e);

        } finally {

            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (Exception e) {
                logger.error("excel inputStream close error", e);
            }
        }
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Transactional
    
    /**
     * 제품군별 품목 조회
     */
    public Result retrieveItemGroupItemList(Map<String, Object> param) {

        Result result = new Result();

        try {

            List<Map<String, Object>> list = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemGroupItemList(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 제품군 상세 조회
     */
    public Result retrieveItemGroupDetail(Map<String, Object> param) {

        Result result = new Result();

        try {

            Map<String, Object> data = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemGroupDetail(param);

            result.setValue(data);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 제품군 그리드 일괄 저장
     */
    public Result saveItemGroupList(Map<String, Object> param) {

        Result result = new Result();

        try {

            ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);

            List<Map<String, Object>> addedRows = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> editedRows = new ArrayList<Map<String, Object>>();

            if (param.get("addedRows") instanceof List) {
                addedRows = (List<Map<String, Object>>) param.get("addedRows");
            }

            if (param.get("editedRows") instanceof List) {
                editedRows = (List<Map<String, Object>>) param.get("editedRows");
            }


            for (Map<String, Object> row : addedRows) {

                Map<String, Object> saveMap = new HashMap<String, Object>();

                saveMap.putAll(param);
                saveMap.putAll(row);

                String duplicate = dao.selectItemGroupDuplicate(saveMap);

                if (duplicate != null && !"".equals(duplicate)) {
                    return super.getResult(false, "MSG_PRODUCT_CODE_LINE_VALIDATION_ERROR", new Object[] {});
                }

                dao.insertItemGroup(saveMap);
            }


            for (Map<String, Object> row : editedRows) {

                Map<String, Object> saveMap = new HashMap<String, Object>();

                saveMap.putAll(param);
                saveMap.putAll(row);

                dao.updateItemGroup(saveMap);
            }


            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 제품군 삭제
     */
    public Result deleteItemGroup(Map<String, Object> param) {

        Result result = new Result();

        try {

            ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);

            dao.deleteItemGroupFileAll(param);

            dao.deleteItemGroup(param);

            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }
    
    


    /**
     * 제품군 팝업 저장
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result saveItemGroup(Map<String, Object> param, List<MultipartFile> files) {

        Result result = new Result();

        try {

            ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);

            String flag = param.get("flag") == null ? "" : param.get("flag").toString();

            if ("insert".equals(flag)) {

                String duplicate = dao.selectItemGroupDuplicate(param);

                if (duplicate != null && !"".equals(duplicate)) {
                    result.setSuccess(false);
                    result.setMessage("MSG_PRODUCT_CODE_LINE_VALIDATION_ERROR");
                    return result;
                }

                dao.insertItemGroup(param);

            } else if ("update".equals(flag)) {

                dao.updateItemGroup(param);

            } else {

                result.setSuccess(false);
                result.setMessage("저장 구분값이 올바르지 않습니다.");
                return result;
            }


            if (param.get("delList") != null && !"".equals(param.get("delList").toString())) {

                String[] delSeqs = param.get("delList").toString().split(",");

                for (String fileSeq : delSeqs) {

                    if (fileSeq == null || "".equals(fileSeq.trim())) {
                        continue;
                    }

                    Map<String, Object> deleteParam = new HashMap<String, Object>();

                    deleteParam.put("COMPANY_CODE", param.get("COMPANY_CODE"));
                    deleteParam.put("PRODUCT_CODE", param.get("PRODUCT_CODE"));
                    deleteParam.put("FILE_SEQ", fileSeq.trim());

                    dao.deleteItemGroupFile(deleteParam);
                }
            }


            if (files != null) {

                for (MultipartFile file : files) {

                    if (file == null || file.isEmpty()) {
                        continue;
                    }

                    Map<String, Object> fileMap = new HashMap<String, Object>();

                    fileMap.put("COMPANY_CODE", param.get("COMPANY_CODE"));
                    fileMap.put("PRODUCT_CODE", param.get("PRODUCT_CODE"));
                    fileMap.put("FILE_NAME", file.getName());
                    fileMap.put("ORIGIN_FILE_NAME", file.getOriginalFilename());
                    fileMap.put("REALFILE", file.getBytes());
                    fileMap.put("CREATE_BY", param.get("CREATE_BY"));
                    fileMap.put("UPDATE_BY", param.get("UPDATE_BY"));

                    dao.insertItemGroupFile(fileMap);
                }
            }

            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            logger.error("saveItemGroup error", e);

            throw new RuntimeException(e);
        }

        return result;
    }

    /**
     * 제품군 첨부파일 목록
     */
    public Result retrieveItemGroupFileList(Map<String, Object> param) {

        Result result = new Result();

        try {

            List<Map<String, Object>> list = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemGroupFileList(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 제품군 첨부파일 다운로드
     */
    public Map<String, Object> itemGroupFileDownload(Map<String, Object> param) {

        return sqlSession.getMapper(ItemGroupMgmtDao.class).itemGroupFileDownload(param);
    }


    /**
     * 품목 상세 조회
     */
    public Result retrieveItemDetail(Map<String, Object> param) {

        Result result = new Result();

        try {

            Map<String, Object> data = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemDetail(param);

            result.setValue(data);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 제품군 콤보 조회
     */
    public Result retrieveItemGroupCombo(Map<String, Object> param) {

        Result result = new Result();

        try {

            List<Map<String, Object>> list = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemGroupCombo(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }


    /**
     * 품목 이미지 목록 조회
     */
    public Result retrieveItemFileList(Map<String, Object> param) {

        Result result = new Result();

        try {

            List<Map<String, Object>> list = sqlSession.getMapper(ItemGroupMgmtDao.class).retrieveItemFileList(param);

            result.setValue(list);
            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }

    /**
     * 제품군 다중 삭제
     */
    /**
     * 제품군 다중 삭제
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Result deleteItemGroupList(Map<String, Object> param) {

        Result result = new Result();

        ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);

        List<Map<String, Object>> deleteRows = (List<Map<String, Object>>) param.get("deleteRows");

        if (deleteRows == null || deleteRows.size() == 0) {

            result.setSuccess(false);
            result.setMessage("삭제할 제품군이 없습니다.");

            return result;
        }

        dao.deleteItemGroupFileList(param);

        int deleteCount = dao.deleteItemGroupList(param);

        result.setValue(deleteCount);
        result.setSuccess(true);
        result.setMessage(DEFAULT_MESSAGE_OK);

        return result;
    }
    
    
    /**
     * 품목 상세 저장
     * 제품군 변경 + 이미지 추가 + 기존 이미지 삭제
     */
    public Result saveItemDetail(Map<String, Object> param, List<MultipartFile> files) {

        Result result = new Result();

        try {

            ItemGroupMgmtDao dao = sqlSession.getMapper(ItemGroupMgmtDao.class);


            dao.updateItemProductCode(param);


            if (param.get("delList") != null && !"".equals(String.valueOf(param.get("delList")))) {

                String[] fileSeqList = String.valueOf(param.get("delList")).split(",");

                param.put("FILE_SEQ_LIST", fileSeqList);

                dao.deleteItemFile(param);
            }


            if (files != null) {

                for (MultipartFile file : files) {

                    if (file == null || file.isEmpty()) {
                        continue;
                    }

                    Map<String, Object> fileMap = new HashMap<String, Object>();

                    fileMap.putAll(param);

                    fileMap.put("FILE_NAME", file.getOriginalFilename());
                    fileMap.put("ORIGIN_FILE_NAME", file.getOriginalFilename());

                    dao.insertItemFile(fileMap);
                }
            }


            result.setSuccess(true);
            result.setMessage(DEFAULT_MESSAGE_OK);

        } catch (Exception e) {

            e.printStackTrace();

            result = super.getResult(false, "MSG_UNSPECIFIED_ERROR", new Object[] {});
        }

        return result;
    }

}