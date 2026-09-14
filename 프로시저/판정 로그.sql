
, CREATE_BY=fta, CUSTOMER_CODE=1018116406, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, PRODUCT_CODE=091103S100, YYYYMM=202604, virtualRegYn=Y}
[2026-08-07 11:01:13,606][DEBUG] [java.sql.Connection]: {conn-169712} Connection
[2026-08-07 11:01:13,606][DEBUG] [java.sql.PreparedStatement]: {pstm-169713} Executing Statement:

                SELECT '1018116406' ||'FRT101'|| '202604' FROM DUAL

[2026-08-07 11:01:13,607][DEBUG] [java.sql.ResultSet]: {rset-169714} Header: [:1||:2||:3]
[2026-08-07 11:01:13,608][DEBUG] [java.sql.PreparedStatement]: {pstm-169715} Executing Statement:

                MERGE INTO SALES_MST SM
                USING (SELECT '1018116406FRT101202604' SALES_NO
                             ,'FRT101' DIVISION_CODE
                             ,'FRT100' COMPANY_CODE
                             ,'1018116406' CUSTOMER_CODE
                             ,EXPORT_FLAG
                             ,DEPARTMENT_CODE
                             ,'202604' || '01' INVOICE_DATE
                             ,'1' STATUS
                             ,CUST.CUSTOMER_NAME AS EXPORTER_NAME
                             ,CUST.OFFICER_NAME AS EXPORTER_REPRESENTATIVE_NAME
                             ,NVL(CUST.BUSINESS_NO, ' ') AS EXPORTER_BIZ_NO
                             ,NVL(CUST.TEL_NO, ' ') AS EXPORTER_TEL_NO
                             ,NVL(CUST.ADDRESS, ' ')  AS EXPORTER_ADDRESS
                             ,SMI.PRODUCER_NAME AS PRODUCER_NAME
                             ,SMI.PRODUCER_REPRESENTATIVE_NAME AS PRODUCER_REPRESENTATIVE_NAME
                             ,SMI.PRODUCER_BIZ_NO AS PRODUCER_BIZ_NO
                             ,SMI.PRODUCER_TEL_NO AS PRODUCER_TEL_NO
                             ,SMI.PRODUCER_ADDRESS AS PRODUCER_ADDRESS
                             ,SMI.DELIVERY_CUSTOMER_CODE
                             ,SMI.INKOTERMS
                             ,SYSDATE CREATE_DATE
                             ,'fta' CREATE_BY
                             ,SYSDATE UPDATE_DATE
                             ,'fta' UPDATE_BY
                         FROM SALES_MST SMI
                        INNER JOIN COMPANY COM
                           ON SMI.COMPANY_CODE = COM.COMPANY_CODE
                        INNER JOIN DIVISION D
                           ON SMI.COMPANY_CODE = D.COMPANY_CODE
                          AND SMI.DIVISION_CODE = D.DIVISION_CODE
                        INNER JOIN CUSTOMER CUST
                           ON SMI.COMPANY_CODE = CUST.COMPANY_CODE
                          AND SMI.CUSTOMER_CODE = CUST.CUSTOMER_CODE
                        WHERE SMI.SALES_NO = '202604304521'
                          AND SMI.DIVISION_CODE = 'FRT101'
                          AND SMI.COMPANY_CODE = 'FRT100'
                          AND SMI.DELETE_YN = 'N') VSM
                   ON (    SM.SALES_NO = VSM.SALES_NO
                       AND SM.COMPANY_CODE = VSM.COMPANY_CODE
                       AND SM.DIVISION_CODE = VSM.DIVISION_CODE)
                 WHEN NOT MATCHED THEN
                      INSERT
                      (SALES_NO, DIVISION_CODE, COMPANY_CODE, CUSTOMER_CODE, EXPORT_FLAG,
                       DEPARTMENT_CODE, INVOICE_DATE, STATUS, EXPORTER_NAME, EXPORTER_REPRESENTATIVE_NAME,
                       EXPORTER_BIZ_NO, EXPORTER_TEL_NO, EXPORTER_ADDRESS, PRODUCER_NAME, PRODUCER_REPRESENTATIVE_NAME,
                       PRODUCER_BIZ_NO, PRODUCER_TEL_NO, PRODUCER_ADDRESS, VIRTUAL_YN, DELIVERY_CUSTOMER_CODE, INKOTERMS,
                       CREATE_DATE, CREATE_BY, UPDATE_DATE, UPDATE_BY)
                      VALUES
                      (VSM.SALES_NO, VSM.DIVISION_CODE, VSM.COMPANY_CODE, VSM.CUSTOMER_CODE, VSM.EXPORT_FLAG,
                       VSM.DEPARTMENT_CODE, VSM.INVOICE_DATE, '4', VSM.EXPORTER_NAME, VSM.EXPORTER_REPRESENTATIVE_NAME,
                       VSM.EXPORTER_BIZ_NO, VSM.EXPORTER_TEL_NO, VSM.EXPORTER_ADDRESS, VSM.PRODUCER_NAME, VSM.PRODUCER_REPRESENTATIVE_NAME,
                       VSM.PRODUCER_BIZ_NO, VSM.PRODUCER_TEL_NO, VSM.PRODUCER_ADDRESS, 'Y', VSM.DELIVERY_CUSTOMER_CODE, VSM.INKOTERMS,
                       VSM.CREATE_DATE, VSM.CREATE_BY, VSM.UPDATE_DATE, VSM.UPDATE_BY)

[2026-08-07 11:01:13,609][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: insertSalesMstVirtual end
[2026-08-07 11:01:13,610][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: insertSalesMstVirtual start {"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U","SALES_NO1":"1018116406FRT101202604","YYYYMM":"202604","DIVISION_CODE1":"FRT101","COMPANY_CODE":"FRT100","UPDATE_BY":"fta","CREATE_BY":"fta"}
[2026-08-07 11:01:13,614][DEBUG] [java.sql.Connection]: {conn-169716} Connection
[2026-08-07 11:01:13,615][DEBUG] [java.sql.PreparedStatement]: {pstm-169717} Executing Statement:

                MERGE INTO SALES_DTL SD
                USING (
                       SELECT '1018116406FRT101202604' SALES_NO
                             ,(NVL((SELECT MAX(SALES_SEQ) + 1
                                      FROM SALES_DTL
                                      WHERE SALES_NO = '1018116406FRT101202604'
                                      AND COMPANY_CODE = 'FRT100'
                                      AND DIVISION_CODE = 'FRT101'
                                    ), 1) + ROWNUM - 1) SALES_SEQ
                             ,VSD.DIVISION_CODE
                             ,VSD.COMPANY_CODE
                             ,VSD.PRODUCT_CODE
                             ,VSD.PRODUCT_NAME
                             ,VSD.HS_CODE
                             ,VSD.PRODUCT_UNIT
                             ,VSD.PRODUCT_ASSETS_TYPE
                             ,VSD.PROD_DIVISION_CODE
                             ,VSD.QUANTITY
                             ,VSD.UNIT_PRICE
                             ,VSD.AMOUNT
                             ,SYSDATE CREATE_DATE
                             ,'fta' CREATE_BY
                             ,SYSDATE UPDATE_DATE
                             ,'fta' UPDATE_BY
                             ,VSD.DELIVERY_CUSTOMER_CODE
                             ,VSD.CUSTOMER_ITEM_CODE
                       FROM (
                             SELECT SD.DIVISION_CODE
                                   ,SD.COMPANY_CODE
                                   ,SD.PRODUCT_CODE
                                   ,SD.PRODUCT_NAME
                                   ,IM.HS_CODE
                                   ,SD.PRODUCT_UNIT
                                   ,SD.PRODUCT_ASSETS_TYPE
                                   ,SD.PROD_DIVISION_CODE
                                   ,SUM(SD.QUANTITY) QUANTITY
                                   -- 대동은 보수적 판정을 위해 가장 작은단가를 사용하기로함
                                   --,NVL(SUM(SD.AMOUNT) / DECODE(SUM(SD.QUANTITY), 0, NULL, SUM(SD.QUANTITY)), 0)  UNIT_PRICE
                                   ,NVL(MIN(SD.AMOUNT / DECODE(SD.QUANTITY, 0, NULL, SD.QUANTITY)), 0) AS UNIT_PRICE
                                   ,SUM(SD.AMOUNT) AMOUNT
                                   ,SD.DELIVERY_CUSTOMER_CODE
                                   ,SD.CUSTOMER_ITEM_CODE
                               FROM SALES_MST SM
                              INNER JOIN SALES_DTL SD
                                 ON SM.SALES_NO = SD.SALES_NO
                                AND SM.COMPANY_CODE = SD.COMPANY_CODE
                                AND SM.DIVISION_CODE = SD.DIVISION_CODE
                              INNER JOIN ITEM_MST IM
                                 ON IM.COMPANY_CODE = SD.COMPANY_CODE
                                AND IM.ITEM_CODE = SD.PRODUCT_CODE
                              WHERE SM.INVOICE_DATE BETWEEN '202604' || '01' AND TO_CHAR(LAST_DAY(TO_DATE('202604', 'YYYYMM')), 'YYYYMMDD')
                                AND SD.PRODUCT_CODE = '091103S100'
                                AND SM.COMPANY_CODE = 'FRT100'
                                AND SM.DIVISION_CODE = 'FRT101'
                                AND SM.CUSTOMER_CODE = '1018116406'
                                AND SM.DELETE_YN = 'N'
                                AND SM.VIRTUAL_YN = 'N'
                              GROUP BY SD.DIVISION_CODE
                                      ,SD.COMPANY_CODE
                                      ,SD.PRODUCT_CODE
                                      ,SD.PRODUCT_NAME
                                      ,SD.PRODUCT_UNIT
                                      ,SD.PRODUCT_ASSETS_TYPE
                                      ,IM.HS_CODE
                                      ,SD.PROD_DIVISION_CODE
                                      ,SD.DELIVERY_CUSTOMER_CODE
                                      ,SD.CUSTOMER_ITEM_CODE
                            ) VSD
                      WHERE VSD.QUANTITY > 0
                      ) VSD
                   ON (    SD.SALES_NO = VSD.SALES_NO
                                   AND SD.PRODUCT_CODE = VSD.PRODUCT_CODE
                                   AND SD.DIVISION_CODE = VSD.DIVISION_CODE
                                   AND SD.COMPANY_CODE = VSD.COMPANY_CODE
                                   AND SD.DELIVERY_CUSTOMER_CODE = VSD.DELIVERY_CUSTOMER_CODE)
                 WHEN NOT MATCHED THEN
                      INSERT
                      (SALES_NO, SALES_SEQ, DIVISION_CODE, COMPANY_CODE, PRODUCT_CODE,
                       PRODUCT_NAME, PRODUCT_UNIT, PRODUCT_ASSETS_TYPE, HS_CODE, PROD_DIVISION_CODE,
                       QUANTITY, UNIT_PRICE, AMOUNT, BOM_STATUS, STATUS, DELIVERY_CUSTOMER_CODE,
                       CREATE_DATE, CREATE_BY, UPDATE_DATE, UPDATE_BY, CUSTOMER_ITEM_CODE)
                      VALUES
                      (VSD.SALES_NO, VSD.SALES_SEQ, VSD.DIVISION_CODE, VSD.COMPANY_CODE, VSD.PRODUCT_CODE,
                       VSD.PRODUCT_NAME, VSD.PRODUCT_UNIT, VSD.PRODUCT_ASSETS_TYPE, VSD.HS_CODE, VSD.PROD_DIVISION_CODE,
                       VSD.QUANTITY, VSD.UNIT_PRICE, VSD.AMOUNT, '0', '1', VSD.DELIVERY_CUSTOMER_CODE,
                       VSD.CREATE_DATE, VSD.CREATE_BY, VSD.UPDATE_DATE, VSD.UPDATE_BY, VSD.CUSTOMER_ITEM_CODE)
                 WHEN MATCHED THEN
                      UPDATE
                      SET SD.HS_CODE = VSD.HS_CODE
                         ,SD.QUANTITY = VSD.QUANTITY
                         ,SD.UNIT_PRICE = VSD.UNIT_PRICE
                         ,SD.AMOUNT = VSD.AMOUNT
                         ,SD.UPDATE_DATE = VSD.UPDATE_DATE
                         ,SD.UPDATE_BY = VSD.UPDATE_BY

[2026-08-07 11:01:13,623][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: insertSalesMstVirtual end
[2026-08-07 11:01:13,629][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: insertSalesMstVirtual start {"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U","SALES_NO1":"1018116406FRT101202604","YYYYMM":"202604","DIVISION_CODE1":"FRT101","COMPANY_CODE":"FRT100","UPDATE_BY":"fta","CREATE_BY":"fta"}
[2026-08-07 11:01:13,629][DEBUG] [java.sql.Connection]: {conn-169718} Connection
[2026-08-07 11:01:13,630][DEBUG] [java.sql.PreparedStatement]: {pstm-169719} Executing Statement:

                MERGE INTO SALES_DTL SD
                USING (
                       SELECT '1018116406FRT101202604' SALES_NO
                             ,(NVL((SELECT MAX(SALES_SEQ) + 1
                                      FROM SALES_DTL
                                      WHERE SALES_NO = '1018116406FRT101202604'
                                      AND COMPANY_CODE = 'FRT100'
                                      AND DIVISION_CODE = 'FRT101'
                                    ), 1) + ROWNUM - 1) SALES_SEQ
                             ,VSD.DIVISION_CODE
                             ,VSD.COMPANY_CODE
                             ,VSD.PRODUCT_CODE
                             ,VSD.PRODUCT_NAME
                             ,VSD.HS_CODE
                             ,VSD.PRODUCT_UNIT
                             ,VSD.PRODUCT_ASSETS_TYPE
                             ,VSD.PROD_DIVISION_CODE
                             ,VSD.QUANTITY
                             ,VSD.UNIT_PRICE
                             ,VSD.AMOUNT
                             ,SYSDATE CREATE_DATE
                             ,'fta' CREATE_BY
                             ,SYSDATE UPDATE_DATE
                             ,'fta' UPDATE_BY
                             ,VSD.DELIVERY_CUSTOMER_CODE
                             ,VSD.CUSTOMER_ITEM_CODE
                       FROM (
                             SELECT SD.DIVISION_CODE
                                   ,SD.COMPANY_CODE
                                   ,SD.PRODUCT_CODE
                                   ,SD.PRODUCT_NAME
                                   ,IM.HS_CODE
                                   ,SD.PRODUCT_UNIT
                                   ,SD.PRODUCT_ASSETS_TYPE
                                   ,SD.PROD_DIVISION_CODE
                                   ,SUM(SD.QUANTITY) QUANTITY
                                   -- 대동은 보수적 판정을 위해 가장 작은단가를 사용하기로함
                                   --,NVL(SUM(SD.AMOUNT) / DECODE(SUM(SD.QUANTITY), 0, NULL, SUM(SD.QUANTITY)), 0)  UNIT_PRICE
                                   ,NVL(MIN(SD.AMOUNT / DECODE(SD.QUANTITY, 0, NULL, SD.QUANTITY)), 0) AS UNIT_PRICE
                                   ,SUM(SD.AMOUNT) AMOUNT
                                   ,SD.DELIVERY_CUSTOMER_CODE
                                   ,SD.CUSTOMER_ITEM_CODE
                               FROM SALES_MST SM
                              INNER JOIN SALES_DTL SD
                                 ON SM.SALES_NO = SD.SALES_NO
                                AND SM.COMPANY_CODE = SD.COMPANY_CODE
                                AND SM.DIVISION_CODE = SD.DIVISION_CODE
                              INNER JOIN ITEM_MST IM
                                 ON IM.COMPANY_CODE = SD.COMPANY_CODE
                                AND IM.ITEM_CODE = SD.PRODUCT_CODE
                              WHERE SM.INVOICE_DATE BETWEEN '202604' || '01' AND TO_CHAR(LAST_DAY(TO_DATE('202604', 'YYYYMM')), 'YYYYMMDD')
                                AND SD.PRODUCT_CODE = '091103X100'
                                AND SM.COMPANY_CODE = 'FRT100'
                                AND SM.DIVISION_CODE = 'FRT101'
                                AND SM.CUSTOMER_CODE = '1018116406'
                                AND SM.DELETE_YN = 'N'
                                AND SM.VIRTUAL_YN = 'N'
                              GROUP BY SD.DIVISION_CODE
                                      ,SD.COMPANY_CODE
                                      ,SD.PRODUCT_CODE
                                      ,SD.PRODUCT_NAME
                                      ,SD.PRODUCT_UNIT
                                      ,SD.PRODUCT_ASSETS_TYPE
                                      ,IM.HS_CODE
                                      ,SD.PROD_DIVISION_CODE
                                      ,SD.DELIVERY_CUSTOMER_CODE
                                      ,SD.CUSTOMER_ITEM_CODE
                            ) VSD
                      WHERE VSD.QUANTITY > 0
                      ) VSD
                   ON (    SD.SALES_NO = VSD.SALES_NO
                                   AND SD.PRODUCT_CODE = VSD.PRODUCT_CODE
                                   AND SD.DIVISION_CODE = VSD.DIVISION_CODE
                                   AND SD.COMPANY_CODE = VSD.COMPANY_CODE
                                   AND SD.DELIVERY_CUSTOMER_CODE = VSD.DELIVERY_CUSTOMER_CODE)
                 WHEN NOT MATCHED THEN
                      INSERT
                      (SALES_NO, SALES_SEQ, DIVISION_CODE, COMPANY_CODE, PRODUCT_CODE,
                       PRODUCT_NAME, PRODUCT_UNIT, PRODUCT_ASSETS_TYPE, HS_CODE, PROD_DIVISION_CODE,
                       QUANTITY, UNIT_PRICE, AMOUNT, BOM_STATUS, STATUS, DELIVERY_CUSTOMER_CODE,
                       CREATE_DATE, CREATE_BY, UPDATE_DATE, UPDATE_BY, CUSTOMER_ITEM_CODE)
                      VALUES
                      (VSD.SALES_NO, VSD.SALES_SEQ, VSD.DIVISION_CODE, VSD.COMPANY_CODE, VSD.PRODUCT_CODE,
                       VSD.PRODUCT_NAME, VSD.PRODUCT_UNIT, VSD.PRODUCT_ASSETS_TYPE, VSD.HS_CODE, VSD.PROD_DIVISION_CODE,
                       VSD.QUANTITY, VSD.UNIT_PRICE, VSD.AMOUNT, '0', '1', VSD.DELIVERY_CUSTOMER_CODE,
                       VSD.CREATE_DATE, VSD.CREATE_BY, VSD.UPDATE_DATE, VSD.UPDATE_BY, VSD.CUSTOMER_ITEM_CODE)
                 WHEN MATCHED THEN
                      UPDATE
                      SET SD.HS_CODE = VSD.HS_CODE
                         ,SD.QUANTITY = VSD.QUANTITY
                         ,SD.UNIT_PRICE = VSD.UNIT_PRICE
                         ,SD.AMOUNT = VSD.AMOUNT
                         ,SD.UPDATE_DATE = VSD.UPDATE_DATE
                         ,SD.UPDATE_BY = VSD.UPDATE_BY

[2026-08-07 11:01:19,109][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: insertSalesMstVirtual end
[2026-08-07 11:01:19,120][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: OriginDeterminCoverDetail start {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, COMPANY_CODE=FRT100, realUrl=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, inDataSet=[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]], INVOICE_MONTH=202604, DIVISION_CODE1=FRT101, EXPORT_FLAG=D, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, SALES_NO1=1018116406FRT101202604, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]

, CREATE_BY=fta, CUSTOMER_CODE=1018116406, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, SALES_NO_VIRTUAL=1018116406FRT101202604, PRODUCT_CODE=091103S100, YYYYMM=202604, virtualRegYn=Y}
[2026-08-07 11:01:19,120][DEBUG] [java.sql.Connection]: {conn-169720} Connection
[2026-08-07 11:01:19,121][DEBUG] [java.sql.PreparedStatement]: {pstm-169721} Executing Statement:

                SELECT SM.SALES_NO
                      ,SM.DIVISION_CODE
                      ,SM.COMPANY_CODE
                      ,SM.STATUS
                      ,SM.INVOICE_DATE
                      ,COMMON_PKG.GET_CODE_NAME(SM.STATUS, 'DS', '1000', 'KOR') STATUS_NAME
                      ,SM.EXPORTER_NAME
                      ,SM.EXPORTER_REPRESENTATIVE_NAME
                      ,SM.EXPORTER_BIZ_NO
                      ,SM.EXPORTER_TEL_NO
                      ,SM.EXPORTER_ADDRESS
                      ,SM.PRODUCER_NAME
                      ,SM.PRODUCER_REPRESENTATIVE_NAME
                      ,SM.PRODUCER_BIZ_NO
                      ,SM.PRODUCER_TEL_NO
                      ,SM.PRODUCER_ADDRESS
                  FROM SALES_MST SM
                 WHERE SALES_NO = '1018116406FRT101202604'
                   AND COMPANY_CODE = 'FRT100'
                   AND DIVISION_CODE = 'FRT101'

[2026-08-07 11:01:19,126][DEBUG] [java.sql.ResultSet]: {rset-169722} Header: [SALES_NO, DIVISION_CODE, COMPANY_CODE, STATUS, INVOICE_DATE, STATUS_NAME, EXPORTER_NAME, EXPORTER_REPRESENTATIVE_NAME, EXPORTER_BIZ_NO, EXPORTER_TEL_NO, EXPORTER_ADDRESS, PRODUCER_NAME, PRODUCER_REPRESENTATIVE_NAME, PRODUCER_BIZ_NO, PRODUCER_TEL_NO, PRODUCER_ADDRESS]
[2026-08-07 11:01:19,126][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: OriginDeterminCoverDetail end
[2026-08-07 11:01:19,127][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: OriginDeterminCoverDetail end
[2026-08-07 11:01:19,127][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, COMPANY_CODE=FRT100, realUrl=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, inDataSet=[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]], INVOICE_MONTH=202604, DIVISION_CODE1=FRT101, EXPORT_FLAG=D, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, SALES_NO1=1018116406FRT101202604, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]

, _END_PAGE_INDEX=-1, CREATE_BY=fta, CUSTOMER_CODE=1018116406, PU_CODE=00, _START_PAGE_INDEX=1, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, SALES_NO_VIRTUAL=1018116406FRT101202604, productList=['091103S100', '091103X100'], PRODUCT_CODE=091103S100, YYYYMM=202604, virtualRegYn=Y}
[2026-08-07 11:01:19,128][DEBUG] []: ########## ModelView job End
[2026-08-07 11:01:19,132][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_CERTIFY_PRODUCT_CODE) is null.
[2026-08-07 11:01:19,134][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 11:01:19,139][DEBUG] [java.sql.Connection]: {conn-169723} Connection
[2026-08-07 11:01:19,140][DEBUG] [java.sql.PreparedStatement]: {pstm-169724} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028522'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermincover/OriginDeterminCoverList.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp'
                   , 'DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[dtlSpread]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
function_auth=[N]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]
'
                   , sysdate
                )

[2026-08-07 11:01:19,155][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 11:01:19,155][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp
[2026-08-07 11:01:19,156][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, COMPANY_CODE=FRT100, realUrl=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, inDataSet=[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]], INVOICE_MONTH=202604, DIVISION_CODE1=FRT101, EXPORT_FLAG=D, FLE_AUTH=Y, UPD_AUTH=Y, p_spreadName=dtlSpread, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[dtlSpread]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
function_auth=[N]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]

, CREATE_BY=fta, CUSTOMER_CODE=1018116406, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, function_auth=N, PRODUCT_CODE=091103S100, YYYYMM=202604, virtualRegYn=Y}
[2026-08-07 11:01:19,158][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 11:01:19,159][DEBUG] [java.sql.Connection]: {conn-169725} Connection
[2026-08-07 11:01:19,160][DEBUG] [java.sql.PreparedStatement]: {pstm-169726} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028522'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermincover/OriginDeterminCoverList.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp'
                   , 'DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
function_auth=[N]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]
'
                   , sysdate
                )

[2026-08-07 11:01:19,173][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 11:01:19,173][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp
[2026-08-07 11:01:19,174][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, COMPANY_CODE=FRT100, realUrl=/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do, inDataSet=[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]], INVOICE_MONTH=202604, DIVISION_CODE1=FRT101, EXPORT_FLAG=D, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
realUrl=[/origin/compliance/origindetermincover/OriginDeterminCoverDetail.do]
inDataSet=[[[[{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프론텍","PRODUCT_CODE":"091103S100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"},{"CHECK":"1","INVOICE_MONTH":"202604","DIVISION_NAME":"프 론텍","PRODUCT_CODE":"091103X100","PRODUCT_NAME":"JACK ASSY","PRODUCT_ASSETS_TYPE_NAME":"제품","HS_CODE":"842549","CUSTOMER_NAME":"현대모비스(주)","DELIVERY_CUSTOMER_CODE":"1018116406","DELIVERY_CUSTOMER_NAME":"현대모비스(주)","CUSTOMER_ITEM_CODE":"","STATUS":"판정완료","EXPORT_FLAG_NAME":"내수","COO_CERTIFY_NO":"","SALES_DEPT_NAME":"","DIVISION_CODE":"FRT101","PROD_DIVISION_CODE":"","CUSTOMER_CODE":"1018116406","EXPORT_FLAG":"D","PRODUCT_ASSETS_TYPE":"P","IUD":"U"}]]]]
INVOICE_MONTH=[202604]
DIVISION_CODE1=[FRT101]
EXPORT_FLAG=[D]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermincover/OriginDeterminCoverDetail.jsp]
CUSTOMER_CODE=[1018116406]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
function_auth=[N]
PRODUCT_CODE=[091103S100]
YYYYMM=[202604]
virtualRegYn=[Y]

, CREATE_BY=fta, CUSTOMER_CODE=1018116406, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, function_auth=N, PRODUCT_CODE=091103S100, YYYYMM=202604, virtualRegYn=Y}
[2026-08-07 11:01:19,917][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 11:01:19,917][DEBUG] [java.sql.Connection]: {conn-169727} Connection
[2026-08-07 11:01:19,920][DEBUG] [java.sql.PreparedStatement]: {pstm-169728} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028522'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermincover/OriginDeterminCoverList.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do'
                   , 'DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
callFunc=[backgroundColor]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[2000]
PAGE_INDEX=[1]
p_spMode=[LP]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
sVaidYn=[N]
REQUEST_URL=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
SALES_NO1=[1018116406FRT101202604]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
productList=[['091103S100', '091103X100']]
spread=[[object]]
'
                   , sysdate
                )

[2026-08-07 11:01:19,950][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 11:01:19,950][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do
[2026-08-07 11:01:19,953][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: selectOriginDeterminCoverDetail start {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do, COMPANY_CODE=FRT100, callFunc=backgroundColor, DIVISION_CODE1=FRT101, PAGE_SIZE=2000, PAGE_INDEX=1, p_spMode=LP, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, sVaidYn=N, REQUEST_URL=/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do, SALES_NO1=1018116406FRT101202604, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
callFunc=[backgroundColor]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[2000]
PAGE_INDEX=[1]
p_spMode=[LP]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
sVaidYn=[N]
REQUEST_URL=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
SALES_NO1=[1018116406FRT101202604]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
productList=[['091103S100', '091103X100']]
spread=[[object]]

, CREATE_BY=fta, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, productList=['091103S100', '091103X100'], spread=[object]}
[2026-08-07 11:01:19,953][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: DEL_AUTH=[Y]
UPDATE_BY=[fta]
EXC_AUTH=[Y]
REG_AUTH=[Y]
DEFAULT_LANGUAGE=[KOR]
sDataUrl=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
COMPANY_CODE=[FRT100]
callFunc=[backgroundColor]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[2000]
PAGE_INDEX=[1]
p_spMode=[LP]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
USER_ID=[fta]
sVaidYn=[N]
REQUEST_URL=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
SALES_NO1=[1018116406FRT101202604]
PARAMETER=[DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
callFunc=[backgroundColor]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[2000]
PAGE_INDEX=[1]
p_spMode=[LP]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
sVaidYn=[N]
REQUEST_URL=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
SALES_NO1=[1018116406FRT101202604]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
productList=[['091103S100', '091103X100']]
spread=[[object]]

]
CREATE_BY=[fta]
PU_CODE=[00]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
productList=[['091103S100', '091103X100']]
spread=[[object]]
end of DataMap info ============================

[2026-08-07 11:01:19,954][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: selectOriginDeterminCoverDetail start {DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do, COMPANY_CODE=FRT100, callFunc=backgroundColor, DIVISION_CODE1=FRT101, PAGE_SIZE=2000, PAGE_INDEX=1, p_spMode=LP, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, sVaidYn=N, REQUEST_URL=/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do, SALES_NO1=1018116406FRT101202604, PARAMETER=DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
callFunc=[backgroundColor]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[2000]
PAGE_INDEX=[1]
p_spMode=[LP]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
sVaidYn=[N]
REQUEST_URL=[/origin/compliance/origindetermincover/selectOriginDeterminCoverDetail.do]
SALES_NO1=[1018116406FRT101202604]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
productList=[['091103S100', '091103X100']]
spread=[[object]]

, CREATE_BY=fta, PU_CODE=00, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, productList=[091103S100, 091103X100], spread=[object]}
[2026-08-07 11:01:19,954][DEBUG] [java.sql.Connection]: {conn-169729} Connection
[2026-08-07 11:01:19,956][DEBUG] [java.sql.PreparedStatement]: {pstm-169730} Executing Statement:

                select data.* from ( select count(*) OVER() as totalCount ,rownum as paging_row_num , data.* from (
                        SELECT SM.SALES_NO
                              ,SD.SALES_SEQ
                              ,SD.DIVISION_CODE
                              ,IM.ITEM_CODE
                              ,IM.ITEM_NAME
                              ,SD.PRODUCT_CODE
                              ,SD.PRODUCT_NAME
                              ,NVL(FC10_GET_ITEM_HS_CODE(SD.COMPANY_CODE, SD.PRODUCT_CODE, SM.INVOICE_DATE), SD.HS_CODE) AS HS_CODE
                              ,COMMON_PKG.GET_CODE_NAME(SD.PRODUCT_ASSETS_TYPE, 'AT', SM.COMPANY_CODE, 'KOR') AS PRODUCT_ASSETS_TYPE
                              ,SD.PROD_DIVISION_CODE
                              ,DV.DIVISION_NAME AS PROD_DIVISION_NAME
                              ,SD.QUANTITY
                              ,SD.UNIT_PRICE
                              ,SD.AMOUNT
                              ,SD.COO_CERTIFY_NO
                              ,NVL(SD.PRODUCT_UNIT, IM.UNIT) AS UNIT
                              ,IM.SPEC
                              ,SD.STATUS
                              ,COMMON_PKG.GET_CODE_NAME(SD.STATUS, 'DS', SM.COMPANY_CODE, 'KOR') AS STATUS_NAME
                               -- 매출 판매비조정가치 정보
                              ,SM.COMPANY_CODE
                              ,SUBSTR(SM.INVOICE_DATE, 1, 6) AS INVOICE_YYYYMM
                        FROM   SALES_MST SM
                        INNER  JOIN SALES_DTL SD
                        ON     SD.SALES_NO = SM.SALES_NO
                        AND    SD.DIVISION_CODE = SM.DIVISION_CODE
                        AND    SD.COMPANY_CODE = SM.COMPANY_CODE
                        INNER  JOIN ITEM_MST IM
                        ON     IM.ITEM_CODE = SD.PRODUCT_CODE
                        AND    IM.COMPANY_CODE = SD.COMPANY_CODE
                        INNER  JOIN DIVISION DV
                        ON     DV.DIVISION_CODE = SD.PROD_DIVISION_CODE
                        AND    DV.COMPANY_CODE = SD.COMPANY_CODE
            WHERE SD.SALES_NO = '1018116406FRT101202604'
              AND SD.DIVISION_CODE = 'FRT101'
              AND SD.COMPANY_CODE = 'FRT100'
              AND SD.PRODUCT_CODE IN (
                 '091103S100'
               ,
                 '091103X100'
               )
                        ORDER  BY SD.STATUS
                                 ,SD.SALES_NO
                                 ,SD.SALES_SEQ
                ) data  ) data where data.paging_row_num between '1' and decode('2000',-1,data.totalCount,'2000')

[2026-08-07 11:01:20,004][DEBUG] [java.sql.ResultSet]: {rset-169731} Header: [TOTALCOUNT, PAGING_ROW_NUM, SALES_NO, SALES_SEQ, DIVISION_CODE, ITEM_CODE, ITEM_NAME, PRODUCT_CODE, PRODUCT_NAME, HS_CODE, PRODUCT_ASSETS_TYPE, PROD_DIVISION_CODE, PROD_DIVISION_NAME, QUANTITY, UNIT_PRICE, AMOUNT, COO_CERTIFY_NO, UNIT, SPEC, STATUS, STATUS_NAME, COMPANY_CODE, INVOICE_YYYYMM]
[2026-08-07 11:01:20,005][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: selectOriginDeterminCoverDetail end
[2026-08-07 11:01:20,007][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: selectOriginDeterminCoverDetail end
[2026-08-07 11:01:20,007][DEBUG] []: ########## ModelView job End
[2026-08-07 11:01:32,017][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 11:01:32,017][DEBUG] [java.sql.Connection]: {conn-169732} Connection
[2026-08-07 11:01:32,020][DEBUG] [java.sql.PreparedStatement]: {pstm-169733} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028522'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermincover/OriginDeterminCoverList.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermincover/OriginDeterminCoverGb.do'
                   , 'SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]
'
                   , sysdate
                )

[2026-08-07 11:01:32,046][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 11:01:32,046][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermincover/OriginDeterminCoverGb.do
[2026-08-07 11:01:32,049][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: OriginDeterminCoverGb start {SALES_NO=1018116406FRT101202604, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, EXPORTER_REPRESENTATIVE_NAME=정명철, COMPANY_CODE=FRT100, inDataSet=[[[]]], DIVISION_CODE1=FRT101, PAGE_SIZE=, PAGE_INDEX=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermincover/OriginDeterminCoverGb.do, DIVISION_CODE=FRT101, SALES_NO1=1018116406FRT101202604, EXPORTER_ADDRESS=서울특별시 강남 구 테헤란로 203 (역삼동), PARAMETER=SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, EXPORTER_NAME=현대모비스(주), INVOICE_DATE=2026-04-30, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, EXPORTER_TEL_NO= / , productList=['091103S100', '091103X100'], STATUS=4}
[2026-08-07 11:01:32,050][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
UPDATE_BY=[fta]
EXC_AUTH=[Y]
REG_AUTH=[Y]
DEFAULT_LANGUAGE=[KOR]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
USER_ID=[fta]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
PARAMETER=[SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]

]
CREATE_BY=[fta]
PU_CODE=[00]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]
end of DataMap info ============================

[2026-08-07 11:01:32,050][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: updateOriginDeterminCoverDetail{SALES_NO=1018116406FRT101202604, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, EXPORTER_REPRESENTATIVE_NAME=정명철, COMPANY_CODE=FRT100, inDataSet=[[[]]], DIVISION_CODE1=FRT101, PAGE_SIZE=, PAGE_INDEX=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermincover/OriginDeterminCoverGb.do, DIVISION_CODE=FRT101, SALES_NO1=1018116406FRT101202604, EXPORTER_ADDRESS=서울특별시 강남 구 테헤란로 203 (역삼동), PARAMETER=SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, EXPORTER_NAME=현대모비스(주), INVOICE_DATE=2026-04-30, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, EXPORTER_TEL_NO= / , productList=['091103S100', '091103X100'], STATUS=4}
[2026-08-07 11:01:32,050][DEBUG] [java.sql.Connection]: {conn-169734} Connection
[2026-08-07 11:01:32,051][DEBUG] [java.sql.PreparedStatement]: {pstm-169735} Executing Statement:

                UPDATE SALES_MST
                   SET EXPORTER_NAME = '현대모비스(주)'
                      ,EXPORTER_REPRESENTATIVE_NAME = '정명철'
                      ,EXPORTER_TEL_NO = ' / '
                      ,EXPORTER_ADDRESS = '서울특별시 강남구 테헤란로 203 (역삼동)'
                 WHERE SALES_NO = '1018116406FRT101202604'
                   AND DIVISION_CODE = 'FRT101'
                   AND COMPANY_CODE = 'FRT100'

[2026-08-07 11:01:32,057][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: updateOriginDeterminCoverDetail end
locale value is null!! default value parsing....... : 'ko'
[2026-08-07 11:01:32,061][DEBUG] []: messageCode=MSG_SAVE, massageArgs=null, locale=KOR
locale value is null!! default value parsing....... : 'ko'
[2026-08-07 11:01:32,062][DEBUG] []: messageCode=MSG_SUCCESS_PROCESS, massageArgs=[Ljava.lang.String;@528f581, locale=KOR
[2026-08-07 11:01:32,063][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: OriginDeterminCoverDetail start {SALES_NO=1018116406FRT101202604, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, EXPORTER_REPRESENTATIVE_NAME=정명철, COMPANY_CODE=FRT100, inDataSet=[[[]]], DIVISION_CODE1=FRT101, PAGE_SIZE=, PAGE_INDEX=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermincover/OriginDeterminCoverGb.do, DIVISION_CODE=FRT101, SALES_NO1=1018116406FRT101202604, EXPORTER_ADDRESS=서울특별시 강남구 테헤란로 203 (역삼동), PARAMETER=SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverGb.do]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[2026-04-30]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
productList=[['091103S100', '091103X100']]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, EXPORTER_NAME=현대모비스(주), INVOICE_DATE=2026-04-30, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, EXPORTER_TEL_NO= / , RTN=1, productList=['091103S100', '091103X100'], STATUS=4}
[2026-08-07 11:01:32,063][DEBUG] [java.sql.Connection]: {conn-169736} Connection
[2026-08-07 11:01:32,064][DEBUG] [java.sql.PreparedStatement]: {pstm-169737} Executing Statement:

                SELECT SM.SALES_NO
                      ,SM.DIVISION_CODE
                      ,SM.COMPANY_CODE
                      ,SM.STATUS
                      ,SM.INVOICE_DATE
                      ,COMMON_PKG.GET_CODE_NAME(SM.STATUS, 'DS', '1000', 'KOR') STATUS_NAME
                      ,SM.EXPORTER_NAME
                      ,SM.EXPORTER_REPRESENTATIVE_NAME
                      ,SM.EXPORTER_BIZ_NO
                      ,SM.EXPORTER_TEL_NO
                      ,SM.EXPORTER_ADDRESS
                      ,SM.PRODUCER_NAME
                      ,SM.PRODUCER_REPRESENTATIVE_NAME
                      ,SM.PRODUCER_BIZ_NO
                      ,SM.PRODUCER_TEL_NO
                      ,SM.PRODUCER_ADDRESS
                  FROM SALES_MST SM
                 WHERE SALES_NO = '1018116406FRT101202604'
                   AND COMPANY_CODE = 'FRT100'
                   AND DIVISION_CODE = 'FRT101'

[2026-08-07 11:01:32,065][DEBUG] [java.sql.ResultSet]: {rset-169738} Header: [SALES_NO, DIVISION_CODE, COMPANY_CODE, STATUS, INVOICE_DATE, STATUS_NAME, EXPORTER_NAME, EXPORTER_REPRESENTATIVE_NAME, EXPORTER_BIZ_NO, EXPORTER_TEL_NO, EXPORTER_ADDRESS, PRODUCER_NAME, PRODUCER_REPRESENTATIVE_NAME, PRODUCER_BIZ_NO, PRODUCER_TEL_NO, PRODUCER_ADDRESS]
[2026-08-07 11:01:32,065][DEBUG] [compliance.origindetermincover.service.OriginDeterminCoverDAO]: OriginDeterminCoverDetail end
[2026-08-07 11:01:32,066][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: OriginDeterminCoverGb end
[2026-08-07 11:01:32,066][DEBUG] []: ########## ModelView job End
[2026-08-07 11:01:32,082][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 11:01:32,083][DEBUG] [java.sql.Connection]: {conn-169739} Connection
[2026-08-07 11:01:32,084][DEBUG] [java.sql.PreparedStatement]: {pstm-169740} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028522'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermincover/OriginDeterminCoverList.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermincover/createFtaDecisionProcess.do'
                   , 'SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/createFtaDecisionProcess.do]
FTA_CODE=[]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[20260430]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
DUMMY=[1]
productList=[['091103S100', '091103X100']]
STATUS=[4]
BOM_TYPE=[F]
'
                   , sysdate
                )

[2026-08-07 11:01:32,109][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 11:01:32,109][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermincover/createFtaDecisionProcess.do
[2026-08-07 11:01:32,113][DEBUG] [compliance.origindetermincover.web.OriginDeterminCoverController]: createFtaDecisionProcess start
[2026-08-07 11:01:32,114][DEBUG] [compliance.origindetermin.service.OriginDeterminServiceImpl]: {SALES_NO=1018116406FRT101202604, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, EXPORTER_REPRESENTATIVE_NAME=정명철, COMPANY_CODE=FRT100, inDataSet=[[[]]], DIVISION_CODE1=FRT101, PAGE_SIZE=, PAGE_INDEX=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028522, USER_ID=fta, FTA_CODE=, REQUEST_URL=/origin/compliance/origindetermincover/createFtaDecisionProcess.do, DIVISION_CODE=FRT101, SALES_NO1=1018116406FRT101202604, EXPORTER_ADDRESS=서울특별시 강남구 테헤란로 203 (역 삼동), PARAMETER=SALES_NO=[1018116406FRT101202604]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORTER_REPRESENTATIVE_NAME=[정명철]
COMPANY_CODE=[FRT100]
inDataSet=[[[[]]]]
DIVISION_CODE1=[FRT101]
PAGE_SIZE=[]
PAGE_INDEX=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028522]
REQUEST_URL=[/origin/compliance/origindetermincover/createFtaDecisionProcess.do]
FTA_CODE=[]
DIVISION_CODE=[FRT101]
SALES_NO1=[1018116406FRT101202604]
EXPORTER_ADDRESS=[서울특별시 강남구 테헤란로 203 (역삼동)]
EXPORTER_NAME=[현대모비스(주)]
INVOICE_DATE=[20260430]
LINK_URL=[/origin/compliance/origindetermincover/OriginDeterminCoverList.do]
EXPORTER_TEL_NO=[ / ]
DUMMY=[1]
productList=[['091103S100', '091103X100']]
STATUS=[4]
BOM_TYPE=[F]

, CREATE_BY=fta, PU_CODE=00, EXPORTER_NAME=현대모비스(주), INVOICE_DATE=20260430, LINK_URL=/origin/compliance/origindetermincover/OriginDeterminCoverList.do, EXPORTER_TEL_NO= / , DUMMY=1, CTC_DECISION_ONLY_YN=N, productList=[091103S100, 091103X100], STATUS=4, BOM_TYPE=F}
[2026-08-07 11:01:32,114][DEBUG] [java.sql.Connection]: {conn-169741} Connection
[2026-08-07 11:01:32,114][DEBUG] [java.sql.PreparedStatement]: {pstm-169742} Executing Statement:

    UPDATE SALES_DTL
       SET DECISION_YN = 'Y'
     WHERE COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'
       AND SALES_NO = '1018116406FRT101202604'
       AND PRODUCT_CODE IN
      (
           '091103S100'
      ,
           '091103X100'
      )

[2026-08-07 11:01:32,126][DEBUG] [java.sql.Connection]: {conn-169743} Connection
[2026-08-07 11:01:32,126][DEBUG] [java.sql.PreparedStatement]: {pstm-169744} Executing Statement:

    UPDATE FCR_MST
       SET DECISION_YN = 'Y'
     WHERE COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'
       AND SALES_NO = '1018116406FRT101202604'
       AND PRODUCT_CODE IN
      (
           '091103S100'
      ,
           '091103X100'
      )

[2026-08-07 11:01:32,177][DEBUG] [java.sql.Connection]: {conn-169745} Connection
[2026-08-07 11:01:32,177][DEBUG] [java.sql.Connection]: {conn-169745} Preparing Call: {CALL CREATE_FCR(?, ?, ?, ?, ?)}
[2026-08-07 11:01:32,180][DEBUG] [java.sql.PreparedStatement]: {pstm-169746} Executing Statement:
                {CALL CREATE_FCR('FRT100', 'FRT101', '1018116406FRT101202604', 'F', null)}
[2026-08-07 11:01:38,428][DEBUG] [java.sql.Connection]: {conn-169747} Connection
[2026-08-07 11:01:39,277][DEBUG] [java.sql.PreparedStatement]: {pstm-169748} Executing Statement:

    SELECT PRODUCT_CODE
          ,ITEM_NAME
          ,HS_CODE
          ,DECODE(NOT_EXIST_RULE, 0, 'EXISTS', NULL) RULE_CONTENTS
      FROM (
            SELECT FM.PRODUCT_CODE
                  ,IM.ITEM_NAME
                  ,FM.HS_CODE
                  ,FM.PRODUCT_ASSETS_TYPE
                  ,SUM(DECODE(FRU.RULE_ID, NULL, 1, 0)) NOT_EXIST_RULE
              FROM FCR_MST FM
             INNER JOIN ITEM_MST IM
                ON IM.ITEM_CODE = FM.PRODUCT_CODE
               AND IM.COMPANY_CODE = FM.COMPANY_CODE
              LEFT OUTER JOIN FTA_RULE FRU
                ON FRU.HS_CODE = SUBSTR(FM.HS_CODE, 1, LENGTH(FRU.HS_CODE))
               AND FRU.FTA_CODE = FM.FTA_CODE
             WHERE FM.SALES_NO = '1018116406FRT101202604'
               AND FM.DIVISION_CODE = 'FRT101'
               AND FM.COMPANY_CODE = 'FRT100'
               AND FM.DECISION_YN = 'Y'
             GROUP BY FM.PRODUCT_CODE, IM.ITEM_NAME, FM.HS_CODE, FM.PRODUCT_ASSETS_TYPE)
     WHERE ((PRODUCT_ASSETS_TYPE = 'P' AND NOT_EXIST_RULE > 0) OR HS_CODE IS NULL)

[2026-08-07 11:01:39,384][DEBUG] [java.sql.Connection]: {conn-169750} Connection
[2026-08-07 11:01:39,384][DEBUG] [java.sql.Connection]: {conn-169750} Preparing Call: {CALL PKG99_COO_DECISION.COO_DECISION(?, ?, ?)}
[2026-08-07 11:01:39,387][DEBUG] [java.sql.PreparedStatement]: {pstm-169751} Executing Statement:
                {CALL PKG99_COO_DECISION.COO_DECISION('FRT100', '1018116406FRT101202604', null)}
[2026-08-07 11:01:40,322][DEBUG] [java.sql.Connection]: {conn-169752} Connection
[2026-08-07 11:01:40,322][DEBUG] [java.sql.PreparedStatement]: {pstm-169753} Executing Statement:

    UPDATE SALES_MST MST
       SET STATUS = CASE WHEN NVL(VIRTUAL_YN, 'N') = 'Y' THEN '4'
                         WHEN (SELECT NVL(SUM(DECODE(FR.STATUS, 'E', 1, 0) + NVL2(FM.RULE_CONTENTS, 0, 1)), 1)
                                 FROM FCR_MST FM, FCR_RESULT FR
                                WHERE FM.SALES_NO = MST.SALES_NO
                                  AND FM.DIVISION_CODE = MST.DIVISION_CODE
                                  AND FM.COMPANY_CODE = MST.COMPANY_CODE
                                  AND FR.FTA_CODE(+) = FM.FTA_CODE
                                  AND FR.SALES_NO(+) = FM.SALES_NO
                                  AND FR.SALES_SEQ(+) = FM.SALES_SEQ
                                  AND FR.DIVISION_CODE(+) = FM.DIVISION_CODE
                                  AND FR.COMPANY_CODE(+) = FM.COMPANY_CODE
                                  AND FM.DECISION_YN = 'Y'
                              ) > 0
                         THEN '5'
                         ELSE '4'
                    END
           ,COO_DATE = SYSDATE
           ,UPDATE_DATE = SYSDATE
           ,UPDATE_BY = 'fta'
     WHERE SALES_NO = '1018116406FRT101202604'
       AND COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'

[2026-08-07 11:01:40,326][DEBUG] [java.sql.Connection]: {conn-169754} Connection
[2026-08-07 11:01:40,326][DEBUG] [java.sql.PreparedStatement]: {pstm-169755} Executing Statement:

    UPDATE SALES_DTL DTL
       SET STATUS = CASE WHEN(
                               SELECT NVL(SUM(DECODE(FR.STATUS, 'E', 1, 0) + NVL2(FM.RULE_CONTENTS, 0, 1)), 1)
                                 FROM FCR_MST FM, FCR_RESULT FR
                                WHERE FM.SALES_NO = DTL.SALES_NO
                                  AND FM.DIVISION_CODE = DTL.DIVISION_CODE
                                  AND FM.COMPANY_CODE = DTL.COMPANY_CODE
                                  AND FM.SALES_SEQ = DTL.SALES_SEQ
                                  AND FR.FTA_CODE(+) = FM.FTA_CODE
                                  AND FR.SALES_NO(+) = FM.SALES_NO
                                  AND FR.SALES_SEQ(+) = FM.SALES_SEQ
                                  AND FR.DIVISION_CODE(+) = FM.DIVISION_CODE
                                  AND FR.COMPANY_CODE(+) = FM.COMPANY_CODE
                                  AND FM.DECISION_YN = 'Y'
                             ) > 0
                         THEN '5'
                         ELSE '4'
                    END
          ,UPDATE_DATE = SYSDATE
          ,UPDATE_BY   = 'fta'
     WHERE SALES_NO = '1018116406FRT101202604'
       AND COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'
       AND DECISION_YN = 'Y'

[2026-08-07 11:01:40,334][DEBUG] [java.sql.Connection]: {conn-169756} Connection
[2026-08-07 11:01:40,340][DEBUG] [java.sql.PreparedStatement]: {pstm-169757} Executing Statement:

    UPDATE SALES_DTL
       SET DECISION_YN = ''
     WHERE COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'
       AND SALES_NO = '1018116406FRT101202604'
       AND PRODUCT_CODE IN
      (
           '091103S100'
      ,
           '091103X100'
      )

[2026-08-07 11:01:40,346][DEBUG] [java.sql.Connection]: {conn-169758} Connection
[2026-08-07 11:01:40,346][DEBUG] [java.sql.PreparedStatement]: {pstm-169759} Executing Statement:

    UPDATE FCR_MST
       SET DECISION_YN = ''
     WHERE COMPANY_CODE = 'FRT100'
       AND DIVISION_CODE = 'FRT101'
       AND SALES_NO = '1018116406FRT101202604'
       AND PRODUCT_CODE IN
      (
           '091103S100'
      ,
           '091103X100'
      )

[2026-08-07 11:01:40,366][DEBUG] []: messageCode=MSG_SUCCESS_ORIGIN_JUDGE, massageArgs=null, locale=null
