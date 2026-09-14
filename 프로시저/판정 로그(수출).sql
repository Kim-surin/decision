[2026-08-07 14:35:22,192][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:22,192][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermin/originDeterminForm.do
[2026-08-07 14:35:22,194][DEBUG] [java.sql.Connection]: {conn-171406} Connection
[2026-08-07 14:35:22,195][DEBUG] [java.sql.PreparedStatement]: {pstm-171407} Executing Statement:

    SELECT SM.SALES_NO
          ,SM.DIVISION_CODE
          ,TO_CHAR(TO_DATE(SM.INVOICE_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') INVOICE_DATE
          ,SM.EXPORT_FLAG
          ,SM.STATUS
          ,COMMON_PKG.GET_CODE_NAME(SM.STATUS, 'DS', 'MRV100', 'KOR') STATUS_NAME
          ,SM.TARGET_FTA_CODE
          ,SM.CUSTOMS_CODE
          ,COMMON_PKG.GET_CODE_NAME(SM.CUSTOMS_CODE, 'CT', 'MRV100', 'KOR') CUSTOMS_NAME
          ,SM.EXPORTER_NAME
          ,SM.EXPORTER_REPRESENTATIVE_NAME
          ,SM.EXPORTER_TEL_NO
          ,SM.EXPORTER_BIZ_NO
          ,SM.EXPORTER_ADDRESS
          ,SM.ARRIVAL_NATION
          ,SM.INVOICE_NO
          ,SM.EXPORT_DECLARE_NO
          ,TO_CHAR(TO_DATE(SM.EXPORT_DECLARE_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') EXPORT_DECLARE_DATE
          ,TO_CHAR(TO_DATE(SM.EXPORT_ACCEPT_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') EXPORT_ACCEPT_DATE
          ,SM.BL_NO
          ,SM.ARRIVAL_NATION
          ,COMMON_PKG.GET_CODE_NAME(SM.ARRIVAL_NATION, 'NA', 'MRV100', 'KOR') ARRIVAL_NAME
          ,SM.ARRIVAL_PORT_CODE
          ,SM.ARRIVAL_PORT_NAME
          ,SM.INKOTERMS
          ,SM.DEPARTURE_PORT_CODE
          ,SM.DEPARTURE_PORT_NAME
          ,TO_CHAR(TO_DATE(SM.SHIPPING_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') SHIPPING_DATE
          ,SM.VEHICLE_TYPE
          ,SM.VEHICLE_NAME
          ,SM.PACKING_MARK
          ,SM.PACKING_COUNT
          ,SM.TOTAL_WEIGHT
          ,SM.COUNT_UNIT
          ,NVL(SM.SHIPMENT_BEFORE, 0) SHIPMENT_BEFORE
          ,NVL(SM.SHIPMENT_AFTER, 0) SHIPMENT_AFTER
          ,SM.SHIP_INVOICE_NO
      FROM SALES_MST SM
     WHERE SM.SALES_NO = '2026040858'
       AND SM.DIVISION_CODE = 'MRV101'
       AND SM.COMPANY_CODE = 'MRV100'

[2026-08-07 14:35:22,208][DEBUG] [java.sql.ResultSet]: {rset-171408} Header: [SALES_NO, DIVISION_CODE, INVOICE_DATE, EXPORT_FLAG, STATUS, STATUS_NAME, TARGET_FTA_CODE, CUSTOMS_CODE, CUSTOMS_NAME, EXPORTER_NAME, EXPORTER_REPRESENTATIVE_NAME, EXPORTER_TEL_NO, EXPORTER_BIZ_NO, EXPORTER_ADDRESS, ARRIVAL_NATION, INVOICE_NO, EXPORT_DECLARE_NO, EXPORT_DECLARE_DATE, EXPORT_ACCEPT_DATE, BL_NO, ARRIVAL_NATION, ARRIVAL_NAME, ARRIVAL_PORT_CODE, ARRIVAL_PORT_NAME, INKOTERMS, DEPARTURE_PORT_CODE, DEPARTURE_PORT_NAME, SHIPPING_DATE, VEHICLE_TYPE, VEHICLE_NAME, PACKING_MARK, PACKING_COUNT, TOTAL_WEIGHT, COUNT_UNIT, SHIPMENT_BEFORE, SHIPMENT_AFTER, SHIP_INVOICE_NO]
[2026-08-07 14:35:22,222][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {sModalWidth=1000px, SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermin/originDeterminForm.do, COMPANY_CODE=MRV100, p_mode=U, sModalHeight=640PX, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028526, USER_ID=fta, REQUEST_URL=/origin/compliance/origindetermin/originDeterminForm.do, DIVISION_CODE=MRV101, sModalFlag=true, PARAMETER=sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/origin/compliance/origindetermin/originDeterminForm.do]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
STATUS=[4]

, _END_PAGE_INDEX=-1, CREATE_BY=fta, PU_CODE=00, _START_PAGE_INDEX=1, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, STATUS=4}
[2026-08-07 14:35:23,084][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_BOM_EXCHANGE_UNIT) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE1) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE2) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE3) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE4) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE5) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE6) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE7) is null.
[2026-08-07 14:35:23,085][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE8) is null.
[2026-08-07 14:35:23,086][ERROR] [origin.framework.resource.OriginResourceBundleMessageSource]: Message code(TXT_ATTRIBUTE9) is null.
[2026-08-07 14:35:23,091][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:23,091][DEBUG] [java.sql.Connection]: {conn-171409} Connection
[2026-08-07 14:35:23,092][DEBUG] [java.sql.PreparedStatement]: {pstm-171410} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp'
                   , 'sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[dtlSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]
'
                   , sysdate
                )

[2026-08-07 14:35:23,112][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:23,112][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp
[2026-08-07 14:35:23,113][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {sModalWidth=1000px, SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermin/originDeterminForm.do, COMPANY_CODE=MRV100, p_mode=U, sModalHeight=640PX, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, p_spreadName=dtlSpread, LOG_SEQ=000000000000000000000028526, USER_ID=fta, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp, DIVISION_CODE=MRV101, sModalFlag=true, PARAMETER=sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[dtlSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, function_auth=N, STATUS=4}
[2026-08-07 14:35:23,116][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:23,116][DEBUG] [java.sql.Connection]: {conn-171411} Connection
[2026-08-07 14:35:23,117][DEBUG] [java.sql.PreparedStatement]: {pstm-171412} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp'
                   , 'sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
p_all_chk=[1]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
p_obj_nm=[FTA_CODE]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
p_del_yn=[N]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]
p_sel_opt=[regEvent='true']
'
                   , sysdate
                )

[2026-08-07 14:35:23,141][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:23,141][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp
[2026-08-07 14:35:23,142][DEBUG] [java.sql.Connection]: {conn-171413} Connection
[2026-08-07 14:35:23,142][DEBUG] [java.sql.PreparedStatement]: {pstm-171414} Executing Statement:

                SELECT FTA_CODE CODE
                      ,FTA_NAME CODE_NAME
                  FROM FTA_MASTER
                 WHERE DELETE_YN = 'N'

[2026-08-07 14:35:23,143][DEBUG] [java.sql.ResultSet]: {rset-171415} Header: [CODE, CODE_NAME]
[2026-08-07 14:35:23,145][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {sModalWidth=1000px, SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermin/originDeterminForm.do, COMPANY_CODE=MRV100, p_all_chk=1, p_mode=U, sModalHeight=640PX, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028526, USER_ID=fta, p_obj_nm=FTA_CODE, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp, DIVISION_CODE=MRV101, sModalFlag=true, PARAMETER=sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
p_all_chk=[1]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
p_obj_nm=[FTA_CODE]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
p_del_yn=[N]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]
p_sel_opt=[regEvent='true']

, _END_PAGE_INDEX=-1, CREATE_BY=fta, PU_CODE=00, p_del_yn=N, _START_PAGE_INDEX=1, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, function_auth=N, STATUS=4, p_sel_opt=regEvent='true'}
cmn_dtl_cd=====>PKRPH
cmn_dtl_cd=====>PKRIL
cmn_dtl_cd=====>PKRKH
cmn_dtl_cd=====>PKRRC
cmn_dtl_cd=====>PKRID
cmn_dtl_cd=====>PKRCN
cmn_dtl_cd=====>PKRNZ
cmn_dtl_cd=====>PKRVN
cmn_dtl_cd=====>PKRCR
cmn_dtl_cd=====>PKRAU
cmn_dtl_cd=====>PKRCA
cmn_dtl_cd=====>PKRCO
cmn_dtl_cd=====>PKRGB
cmn_dtl_cd=====>PKRPR
cmn_dtl_cd=====>PKRUS
cmn_dtl_cd=====>PKRIN
cmn_dtl_cd=====>PKREU
cmn_dtl_cd=====>PKRCL
cmn_dtl_cd=====>PKRAS
cmn_dtl_cd=====>PKREF
cmn_dtl_cd=====>PKRAP
cmn_dtl_cd=====>PKRSI
cmn_dtl_cd=====>PKRTR
cmn_dtl_cd=====>PKRGS
cmn_dtl_cd=====>PKRAE
[2026-08-07 14:35:23,150][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:23,150][DEBUG] [java.sql.Connection]: {conn-171416} Connection
[2026-08-07 14:35:23,151][DEBUG] [java.sql.PreparedStatement]: {pstm-171417} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp'
                   , 'sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[fcrSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]
'
                   , sysdate
                )

[2026-08-07 14:35:23,169][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:23,169][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp
[2026-08-07 14:35:23,170][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {sModalWidth=1000px, SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermin/originDeterminForm.do, COMPANY_CODE=MRV100, p_mode=U, sModalHeight=640PX, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, p_spreadName=fcrSpread, LOG_SEQ=000000000000000000000028526, USER_ID=fta, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp, DIVISION_CODE=MRV101, sModalFlag=true, PARAMETER=sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[fcrSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, function_auth=N, STATUS=4}
[2026-08-07 14:35:23,171][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:23,172][DEBUG] [java.sql.Connection]: {conn-171418} Connection
[2026-08-07 14:35:23,173][DEBUG] [java.sql.PreparedStatement]: {pstm-171419} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp'
                   , 'sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[resultSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]
'
                   , sysdate
                )

[2026-08-07 14:35:23,192][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:23,193][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp
[2026-08-07 14:35:23,193][DEBUG] [origin.framework.util.ViewUtils]: forwarding() > dataMap Debug ==> {sModalWidth=1000px, SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, sDataUrl=/origin/compliance/origindetermin/originDeterminForm.do, COMPANY_CODE=MRV100, p_mode=U, sModalHeight=640PX, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, p_spreadName=resultSpread, LOG_SEQ=000000000000000000000028526, USER_ID=fta, REQUEST_URL=/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp, DIVISION_CODE=MRV101, sModalFlag=true, PARAMETER=sModalWidth=[1000px]
SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/originDeterminForm.do]
sModalHeight=[640PX]
p_mode=[U]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
p_spreadName=[resultSpread]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/WEB-INF/jsp/origin/compliance/origindetermin/originDeterminForm.jsp]
DIVISION_CODE=[MRV101]
sModalFlag=[true]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
function_auth=[N]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, function_auth=N, STATUS=4}
[2026-08-07 14:35:24,353][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:24,354][DEBUG] [java.sql.Connection]: {conn-171420} Connection
[2026-08-07 14:35:24,355][DEBUG] [java.sql.PreparedStatement]: {pstm-171421} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermin/productList.do'
                   , 'SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/productList.do]
callFunc=[setStatus]
p_spMode=[D]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/origin/compliance/origindetermin/productList.do]
FTA_CODE=[]
STATUS_NAME=[판정완료]
DIVISION_CODE=[MRV101]
EXPORTER_NAME=[Mirae VC CO.,Ltd]
INVOICE_DATE=[2026-04-08]
SALES_SEQ_TEMP=[]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
STATUS=[4]
p_formName=[main]
spread=[[object]]
'
                   , sysdate
                )

[2026-08-07 14:35:24,387][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:24,387][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermin/productList.do
[2026-08-07 14:35:24,388][DEBUG] [java.sql.Connection]: {conn-171422} Connection
[2026-08-07 14:35:24,390][DEBUG] [java.sql.PreparedStatement]: {pstm-171423} Executing Statement:

    SELECT SD.PRODUCT_CODE
          ,SD.PRODUCT_NAME
          ,SD.PROD_DIVISION_CODE
          ,DI.DIVISION_NAME PROD_DIVISION_NAME
          ,SD.QUANTITY
          ,SD.UNIT_PRICE
          ,SD.AMOUNT
          ,IM.UNIT
          ,IM.HS_CODE
          ,SD.PRODUCT_ASSETS_TYPE
          ,COMMON_PKG.GET_CODE_NAME(SD.PRODUCT_ASSETS_TYPE, 'AT', 'MRV100', 'KOR') PRODUCT_ASSETS_NAME
          ,NVL(SD.NET_WEIGHT,0) NET_WEIGHT
          ,NVL(SD.GROSS_WEIGHT,0) GROSS_WEIGHT
          ,NVL(SD.WEIGHT_UNIT,0) WEIGHT_UNIT
          ,SD.COO_CERTIFY_NO
          ,FM.INKOTERMS_TYPE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.OCEAN_FREIGHT_CHARGE
                          WHEN ISA.ROWID IS NOT NULL THEN ISA.OCEAN_FREIGHT_CHARGE
                          WHEN PSA.ROWID IS NOT NULL THEN PSA.OCEAN_FREIGHT_CHARGE
                          ELSE 0.0
                     END,2) OCEAN_FREIGHT_CHARGE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.FREIGHT_CHARGE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.FREIGHT_CHARGE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.FREIGHT_CHARGE
                      ELSE 0.0
                 END,2) FREIGHT_CHARGE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.INSURANCE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.INSURANCE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.INSURANCE
                      ELSE 0.0
                 END,2) INSURANCE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE1
                        WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE1
                        WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE1
                        ELSE 0.0
                   END,2) ATTRIBUTE1
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE2
                          WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE2
                          WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE2
                          ELSE 0.0
                     END,2) ATTRIBUTE2
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE3
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE3
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE3
                      ELSE 0.0
                 END,2) ATTRIBUTE3
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE4
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE4
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE4
                      ELSE 0.0
                 END,2) ATTRIBUTE4
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE5
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE5
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE5
                      ELSE 0.0
                 END,2) ATTRIBUTE5
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE6
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE6
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE6
                      ELSE 0.0
                 END,2) ATTRIBUTE6
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE7
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE7
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE7
                      ELSE 0.0
                 END,2) ATTRIBUTE7
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE8
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE8
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE8
                      ELSE 0.0
                 END,2) ATTRIBUTE8
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.ATTRIBUTE9
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.ATTRIBUTE9
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.ATTRIBUTE9
                      ELSE 0.0
                 END,2) ATTRIBUTE9
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.THC
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.THC
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.THC
                      ELSE 0.0
                 END,2) THC
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.D_FEE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.D_FEE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.D_FEE
                      ELSE 0.0
                 END,2) D_FEE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.C_TAX
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.C_TAX
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.C_TAX
                      ELSE 0.0
                 END,2) C_TAX
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.WFG_FEE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.WFG_FEE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.WFG_FEE
                      ELSE 0.0
                 END,2) WFG_FEE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.EXT_FREIGHT_CHARGE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.EXT_FREIGHT_CHARGE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.EXT_FREIGHT_CHARGE
                      ELSE 0.0
                 END,2) EXT_FREIGHT_CHARGE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.AIR_FREIGHT_CHARGE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.AIR_FREIGHT_CHARGE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.AIR_FREIGHT_CHARGE
                      ELSE 0.0
                 END,2) AIR_FREIGHT_CHARGE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.EXT_AIR_FREIGHT_CHARGE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.EXT_AIR_FREIGHT_CHARGE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.EXT_AIR_FREIGHT_CHARGE
                      ELSE 0.0
                 END,2) EXT_AIR_FREIGHT_CHARGE
          ,TRUNC(CASE WHEN SAI.ROWID IS NOT NULL THEN SAI.CFS_FEE
                      WHEN ISA.ROWID IS NOT NULL THEN ISA.CFS_FEE
                      WHEN PSA.ROWID IS NOT NULL THEN PSA.CFS_FEE
                      ELSE 0.0
                 END,2) CFS_FEE
          ,SD.SALES_NO
          ,SD.SALES_SEQ
          ,SD.STATUS
          ,CD.CODE_NAME STATUS_NAME
          ,CASE WHEN IM.HS_CODE IS NULL AND SD.PRODUCT_CODE LIKE '79%' AND SD.PRODUCT_NAME LIKE 'UP-KIT%' THEN '[79*] UP-KIT는 판정 제외 품목입니다.'
                WHEN IM.HS_CODE IS NULL THEN 'HS CODE 없습니다.'
                WHEN SD.BOM_STATUS = 1 THEN 'BOM이 없습니다.'
                ELSE FR.ERROR_MSG
           END ERROR_MSG
      FROM SALES_MST SM
     INNER JOIN SALES_DTL SD
        ON SD.SALES_NO = SM.SALES_NO
       AND SD.DIVISION_CODE = SM.DIVISION_CODE
       AND SD.COMPANY_CODE = SM.COMPANY_CODE
     INNER JOIN DIVISION DI
        ON DI.DIVISION_CODE = SD.PROD_DIVISION_CODE
       AND DI.COMPANY_CODE = SD.COMPANY_CODE
     INNER JOIN ITEM_MST IM
        ON IM.ITEM_CODE = SD.PRODUCT_CODE
       AND IM.COMPANY_CODE = SD.COMPANY_CODE
     INNER JOIN CODE_DTL CD
        ON CD.CODE = SD.STATUS
       AND CD.CATEGORY = 'DS'
       AND CD.COMPANY_CODE = SM.COMPANY_CODE
      LEFT OUTER JOIN SALES_ADJUST_INFO SAI
        ON SAI.YYYYMM = SUBSTR(SM.INVOICE_DATE,1,6)
       AND SAI.SALES_NO = SM.SALES_NO
       AND SAI.SALES_SEQ = SD.SALES_SEQ
       AND SAI.DIVISION_CODE = SM.DIVISION_CODE
       AND SAI.COMPANY_CODE = SM.COMPANY_CODE
      LEFT OUTER JOIN ITEM_SALES_ADJUST ISA
        ON ISA.YYYYMM = SUBSTR(SM.INVOICE_DATE,1,6)
       AND ISA.PRODUCT_CODE = SD.PRODUCT_CODE
       AND ISA.DIVISION_CODE = SM.DIVISION_CODE
       AND ISA.COMPANY_CODE = SM.COMPANY_CODE
      LEFT OUTER JOIN PRODUCT_SALES_ADJUST PSA
        ON PSA.YYYYMM = SUBSTR(SM.INVOICE_DATE,1,6)
       AND PSA.PRODUCT_GROUP_CODE = SD.PROD_DIVISION_CODE
       AND PSA.DIVISION_CODE = SM.DIVISION_CODE
       AND PSA.COMPANY_CODE = SM.COMPANY_CODE
      LEFT OUTER JOIN FTA_MASTER FM
        ON SM.TARGET_FTA_CODE = FM.FTA_CODE
      LEFT OUTER JOIN (
                       SELECT FR.SALES_NO, FR.SALES_SEQ, FR.COMPANY_CODE, FR.DIVISION_CODE, MAX(FR.ERROR_MSG) AS ERROR_MSG
                         FROM FCR_RESULT FR
                        WHERE FR.COMPANY_CODE = 'MRV100'
                          AND FR.DIVISION_CODE = 'MRV101'
                          AND FR.SALES_NO = '2026040858'
                        GROUP BY FR.SALES_NO, FR.SALES_SEQ, FR.COMPANY_CODE, FR.DIVISION_CODE
                      ) FR
        ON FR.COMPANY_CODE = SM.COMPANY_CODE
       AND FR.DIVISION_CODE = SM.DIVISION_CODE
       AND FR.SALES_NO = SM.SALES_NO
       AND FR.SALES_SEQ = SD.SALES_SEQ
     WHERE SM.SALES_NO = '2026040858'
       AND SM.DIVISION_CODE = 'MRV101'
       AND SM.COMPANY_CODE = 'MRV100'
    ORDER BY FTA_NAME, SALES_NO  DESC, SALES_SEQ DESC

[2026-08-07 14:35:24,475][DEBUG] [java.sql.ResultSet]: {rset-171424} Header: [PRODUCT_CODE, PRODUCT_NAME, PROD_DIVISION_CODE, PROD_DIVISION_NAME, QUANTITY, UNIT_PRICE, AMOUNT, UNIT, HS_CODE, PRODUCT_ASSETS_TYPE, PRODUCT_ASSETS_NAME, NET_WEIGHT, GROSS_WEIGHT, WEIGHT_UNIT, COO_CERTIFY_NO, INKOTERMS_TYPE, OCEAN_FREIGHT_CHARGE, FREIGHT_CHARGE, INSURANCE, ATTRIBUTE1, ATTRIBUTE2, ATTRIBUTE3, ATTRIBUTE4, ATTRIBUTE5, ATTRIBUTE6, ATTRIBUTE7, ATTRIBUTE8, ATTRIBUTE9, THC, D_FEE, C_TAX, WFG_FEE, EXT_FREIGHT_CHARGE, AIR_FREIGHT_CHARGE, EXT_AIR_FREIGHT_CHARGE, CFS_FEE, SALES_NO, SALES_SEQ, STATUS, STATUS_NAME, ERROR_MSG]
[2026-08-07 14:35:24,476][DEBUG] []: ########## ModelView job End
[2026-08-07 14:35:24,508][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:24,508][DEBUG] [java.sql.Connection]: {conn-171425} Connection
[2026-08-07 14:35:24,509][DEBUG] [java.sql.PreparedStatement]: {pstm-171426} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermin/fcrList.do'
                   , 'SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
sDataUrl=[/origin/compliance/origindetermin/fcrList.do]
SALES_SEQ=[58]
p_spMode=[D]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/origin/compliance/origindetermin/fcrList.do]
FTA_CODE=[]
STATUS_NAME=[판정완료]
DIVISION_CODE=[MRV101]
EXPORTER_NAME=[Mirae VC CO.,Ltd]
INVOICE_DATE=[2026-04-08]
SALES_SEQ_TEMP=[]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
PRODUCT_CODE=[21000-B8SS0]
STATUS=[4]
p_formName=[main]
spread=[[object]]
'
                   , sysdate
                )

[2026-08-07 14:35:24,523][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:24,523][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermin/fcrList.do
[2026-08-07 14:35:24,525][DEBUG] [java.sql.Connection]: {conn-171427} Connection
[2026-08-07 14:35:24,526][DEBUG] [java.sql.PreparedStatement]: {pstm-171428} Executing Statement:

    SELECT SM.SALES_NO,
           SD.SALES_SEQ,
           SM.DIVISION_CODE,
           SM.INVOICE_DATE,
           SD.PRODUCT_CODE,
           SD.PRODUCT_NAME,
           FM.FTA_CODE,
           FAM.FTA_NAME,
           FM.HS_CODE,
           FM.AMOUNT,
           FM.EXWORK_AMOUNT,
           FM.FOB_AMOUNT,
           FM.NET_COST_AMOUNT,
           FM.INAREA_AMOUNT + FM.OUTAREA_AMOUNT SUM_AMOUNT,
           FM.INAREA_AMOUNT,
           FM.OUTAREA_AMOUNT,
           COMMON_PKG.GET_CODE_NAME(SM.STATUS, 'DS', 'MRV100', 'KOR') STATUS_NAME,
           FM.RULE_CONTENTS,
           DECODE(FM.FTA_COO_YN, 'Y', 'YES', 'NO') FTA_COO_YN,
           DECODE(FM.COMPANY_COO_YN, 'Y', 'YES', 'NO') COMPANY_COO_YN,
           FAM.INKOTERMS_TYPE
      FROM FCR_MST FM
     INNER JOIN SALES_MST SM
        ON SM.SALES_NO = FM.SALES_NO
       AND SM.COMPANY_CODE = FM.COMPANY_CODE
       AND SM.DIVISION_CODE = FM.DIVISION_CODE
     INNER JOIN SALES_DTL SD
        ON SD.SALES_NO = FM.SALES_NO
       AND SD.SALES_SEQ  = FM.SALES_SEQ
       AND SD.COMPANY_CODE = FM.COMPANY_CODE
       AND SD.DIVISION_CODE = FM.DIVISION_CODE
       AND SD.PRODUCT_CODE = '21000-B8SS0'
       AND SD.SALES_SEQ = '58'
     INNER JOIN FTA_MASTER FAM
        ON FM.FTA_CODE = FAM.FTA_CODE
     WHERE FM.COMPANY_CODE = 'MRV100'
       AND FM.DIVISION_CODE = 'MRV101'
       AND FM.SALES_NO = '2026040858'
    ORDER BY FTA_NAME

[2026-08-07 14:35:24,576][DEBUG] [java.sql.ResultSet]: {rset-171429} Header: [SALES_NO, SALES_SEQ, DIVISION_CODE, INVOICE_DATE, PRODUCT_CODE, PRODUCT_NAME, FTA_CODE, FTA_NAME, HS_CODE, AMOUNT, EXWORK_AMOUNT, FOB_AMOUNT, NET_COST_AMOUNT, SUM_AMOUNT, INAREA_AMOUNT, OUTAREA_AMOUNT, STATUS_NAME, RULE_CONTENTS, FTA_COO_YN, COMPANY_COO_YN, INKOTERMS_TYPE]
[2026-08-07 14:35:24,577][DEBUG] []: ########## ModelView job End
[2026-08-07 14:35:24,603][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:24,604][DEBUG] [java.sql.Connection]: {conn-171430} Connection
[2026-08-07 14:35:24,649][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:24,650][DEBUG] [java.sql.Connection]: {conn-171432} Connection
[2026-08-07 14:35:24,651][DEBUG] [java.sql.PreparedStatement]: {pstm-171433} Executing Statement:

        SELECT DISTINCT FRU.RULE_SEQ AS RULE_SEQ
              ,NVL(FR.RULE_CODE, FM.RULE_CONTENTS) AS RULE_CODE
              ,FR.RVC_RESULT_RATE/100 AS RVC_RATE
              ,FR.RVC_FTA_RESULT_RATE/100 AS RVC_FTA_RATE
              ,FR.RVC_COMPANY_RESULT_RATE/100 AS RVC_COM_RATE
              ,FR.COMPANY_RVC_YN AS RVC_YN
              ,FR.CTC_YN
              ,FR.CTC_RESULT_RATE/100 AS DE_RATE
              ,FR.CTC_FTA_RESULT_RATE/100 AS DE_FTA_RATE
              ,FR.CTC_COMPANY_RESULT_RATE/100 AS DE_COM_RATE
              ,FR.COMPANY_DE_MINIMIS_YN AS DE_YN
              ,NVL(FR.FTA_COO_YN, FM.FTA_COO_YN) AS FTA_COO_YN
              ,NVL(FR.COMPANY_COO_YN, FM.COMPANY_COO_YN) AS COMPANY_COO_YN
              ,FRU.RULE_DESCRIPTION AS RULE_DESCRIPTION
              ,FE.EXCLUSION_RULE_DESCRIPTION AS EXCL_DESCRIPTION
              ,FR.ERROR_MSG
          FROM FCR_MST FM
          LEFT OUTER JOIN FCR_RESULT FR
            ON FM.SALES_NO = FR.SALES_NO
           AND FM.SALES_SEQ = FR.SALES_SEQ
           AND FM.DIVISION_CODE = FR.DIVISION_CODE
           AND FM.COMPANY_CODE = FR.COMPANY_CODE
           AND FM.FTA_CODE = FR.FTA_CODE
          LEFT OUTER JOIN FTA_RULE FRU
            ON FRU.HS_CODE = SUBSTR(FR.HS_CODE, 1, LENGTH(FRU.HS_CODE))
           AND FRU.FTA_CODE = FR.FTA_CODE
           AND FRU.RULE_ID = FR.RULE_SEQ
          LEFT OUTER JOIN FTA_EXCLUSION_RULE FE
            ON FE.FTA_CODE = FR.FTA_CODE
           AND FE.HS_CODE = SUBSTR(FR.HS_CODE, 1, LENGTH(FRU.HS_CODE))
           AND FE.RULE_SEQ = FRU.RULE_SEQ
         WHERE FM.SALES_NO = '2026040858'
           AND FM.SALES_SEQ = '58'
           AND FM.DIVISION_CODE = 'MRV101'
           AND FM.COMPANY_CODE = 'MRV100'
           AND FM.FTA_CODE = 'PKRUS'
         ORDER BY FRU.RULE_SEQ

[2026-08-07 14:35:24,699][DEBUG] [java.sql.ResultSet]: {rset-171434} Header: [RULE_SEQ, RULE_CODE, RVC_RATE, RVC_FTA_RATE, RVC_COM_RATE, RVC_YN, CTC_YN, DE_RATE, DE_FTA_RATE, DE_COM_RATE, DE_YN, FTA_COO_YN, COMPANY_COO_YN, RULE_DESCRIPTION, EXCL_DESCRIPTION, ERROR_MSG]
[2026-08-07 14:35:24,699][DEBUG] []: ########## ModelView job End
[2026-08-07 14:35:29,210][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle start
[2026-08-07 14:35:29,211][DEBUG] [java.sql.Connection]: {conn-171435} Connection
[2026-08-07 14:35:29,212][DEBUG] [java.sql.PreparedStatement]: {pstm-171436} Executing Statement:

                insert into log_mgr_dtl (
                     log_seq
                   , seq
                   , menu_id
                   , url
                   , parameter
                   , request_date
                )
                values (
                     '000000000000000000000028526'
                   , log_mgr_dtl_seq_s.nextVal
                   , (SELECT menu_id
                      FROM menu
                      WHERE link_url = '/origin/compliance/origindetermin/originDetermin.do' AND ROWNUM = 1)
                   , '/origin/compliance/origindetermin/createDecisionProcess.do'
                   , 'SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/origin/compliance/origindetermin/createDecisionProcess.do]
FTA_CODE=[]
STATUS_NAME=[판정완료]
DIVISION_CODE=[MRV101]
EXPORTER_NAME=[Mirae VC CO.,Ltd]
INVOICE_DATE=[20260408]
SALES_SEQ_TEMP=[58]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
STATUS=[4]
'
                   , sysdate
                )

[2026-08-07 14:35:29,220][DEBUG] [framework.web.channel.FrameworkBasedInterceptor]: preHandle end
[2026-08-07 14:35:29,221][DEBUG] [##########origin.framework.handler.SessionInterceptorHandler]: preHandle goto login from /origin/compliance/origindetermin/createDecisionProcess.do
[2026-08-07 14:35:29,223][DEBUG] [compliance.origindetermin.service.OriginDeterminServiceImpl]: {SALES_NO=2026040858, DEL_AUTH=Y, UPDATE_BY=fta, EXC_AUTH=Y, REG_AUTH=Y, DEFAULT_LANGUAGE=KOR, COMPANY_CODE=MRV100, EXPORT_FLAG=, FLE_AUTH=Y, UPD_AUTH=Y, LOG_SEQ=000000000000000000000028526, USER_ID=fta, FTA_CODE=, REQUEST_URL=/origin/compliance/origindetermin/createDecisionProcess.do, STATUS_NAME=판정완료, DIVISION_CODE=MRV101, PARAMETER=SALES_NO=[2026040858]
DEL_AUTH=[Y]
EXC_AUTH=[Y]
REG_AUTH=[Y]
EXPORT_FLAG=[]
FLE_AUTH=[Y]
UPD_AUTH=[Y]
LOG_SEQ=[000000000000000000000028526]
REQUEST_URL=[/origin/compliance/origindetermin/createDecisionProcess.do]
FTA_CODE=[]
STATUS_NAME=[판정완료]
DIVISION_CODE=[MRV101]
EXPORTER_NAME=[Mirae VC CO.,Ltd]
INVOICE_DATE=[20260408]
SALES_SEQ_TEMP=[58]
LINK_URL=[/origin/compliance/origindetermin/originDetermin.do]
STATUS=[4]

, CREATE_BY=fta, PU_CODE=00, EXPORTER_NAME=Mirae VC CO.,Ltd, INVOICE_DATE=20260408, SALES_SEQ_TEMP=58, LINK_URL=/origin/compliance/origindetermin/originDetermin.do, CTC_DECISION_ONLY_YN=N, STATUS=4}
[2026-08-07 14:35:29,223][DEBUG] [java.sql.Connection]: {conn-171437} Connection
[2026-08-07 14:35:29,224][DEBUG] [java.sql.PreparedStatement]: {pstm-171438} Executing Statement:

    UPDATE SALES_DTL
       SET DECISION_YN = 'Y'
     WHERE COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'
       AND SALES_NO = '2026040858'

[2026-08-07 14:35:29,271][DEBUG] [java.sql.Connection]: {conn-171439} Connection
[2026-08-07 14:35:29,271][DEBUG] [java.sql.PreparedStatement]: {pstm-171440} Executing Statement:

    UPDATE FCR_MST
       SET DECISION_YN = 'Y'
     WHERE COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'
       AND SALES_NO = '2026040858'

[2026-08-07 14:35:29,300][DEBUG] [java.sql.Connection]: {conn-171441} Connection
[2026-08-07 14:35:29,300][DEBUG] [java.sql.Connection]: {conn-171441} Preparing Call: {CALL CREATE_FCR(?, ?, ?, ?, ?)}
[2026-08-07 14:35:29,300][DEBUG] [java.sql.PreparedStatement]: {pstm-171442} Executing Statement:
                {CALL CREATE_FCR('MRV100', 'MRV101', '2026040858', 'F', null)}
[2026-08-07 14:35:30,980][DEBUG] [java.sql.Connection]: {conn-171443} Connection
[2026-08-07 14:35:30,981][DEBUG] [java.sql.PreparedStatement]: {pstm-171444} Executing Statement:

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
             WHERE FM.SALES_NO = '2026040858'
               AND FM.DIVISION_CODE = 'MRV101'
               AND FM.COMPANY_CODE = 'MRV100'
               AND FM.DECISION_YN = 'Y'
             GROUP BY FM.PRODUCT_CODE, IM.ITEM_NAME, FM.HS_CODE, FM.PRODUCT_ASSETS_TYPE)
     WHERE ((PRODUCT_ASSETS_TYPE = 'P' AND NOT_EXIST_RULE > 0) OR HS_CODE IS NULL)

[2026-08-07 14:35:31,075][DEBUG] [java.sql.Connection]: {conn-171446} Connection
[2026-08-07 14:35:31,076][DEBUG] [java.sql.Connection]: {conn-171446} Preparing Call: {CALL PKG99_COO_DECISION.COO_DECISION(?, ?, ?)}
[2026-08-07 14:35:31,076][DEBUG] [java.sql.PreparedStatement]: {pstm-171447} Executing Statement:
                {CALL PKG99_COO_DECISION.COO_DECISION('MRV100', '2026040858', null)}
[2026-08-07 14:35:31,140][DEBUG] [java.sql.Connection]: {conn-171448} Connection
[2026-08-07 14:35:31,140][DEBUG] [java.sql.PreparedStatement]: {pstm-171449} Executing Statement:

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
     WHERE SALES_NO = '2026040858'
       AND COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'

[2026-08-07 14:35:31,318][DEBUG] [java.sql.Connection]: {conn-171450} Connection
[2026-08-07 14:35:31,319][DEBUG] [java.sql.PreparedStatement]: {pstm-171451} Executing Statement:

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
     WHERE SALES_NO = '2026040858'
       AND COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'
       AND DECISION_YN = 'Y'

[2026-08-07 14:35:31,332][DEBUG] [java.sql.Connection]: {conn-171452} Connection
[2026-08-07 14:35:31,333][DEBUG] [java.sql.PreparedStatement]: {pstm-171453} Executing Statement:

    UPDATE SALES_DTL
       SET DECISION_YN = ''
     WHERE COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'
       AND SALES_NO = '2026040858'

[2026-08-07 14:35:31,333][DEBUG] [java.sql.Connection]: {conn-171454} Connection
[2026-08-07 14:35:31,334][DEBUG] [java.sql.PreparedStatement]: {pstm-171455} Executing Statement:

    UPDATE FCR_MST
       SET DECISION_YN = ''
     WHERE COMPANY_CODE = 'MRV100'
       AND DIVISION_CODE = 'MRV101'
       AND SALES_NO = '2026040858'

[2026-08-07 14:35:31,353][DEBUG] []: messageCode=MSG_SUCCESS_ORIGIN_JUDGE, massageArgs=null, locale=null
