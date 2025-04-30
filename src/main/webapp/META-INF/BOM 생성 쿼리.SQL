/*
UPDATE bom_20240229_tmp a
  SET a.product_code = TRIM(a.product_code)
      ,a.item_code = TRIM(a.item_code)
      ,a.input_amt = REPLACE(a.input_amt, ',', '')
*/
SELECT COUNT(1) FROM bom_20240229_tmp A WHERE A.TP = '1510코스비전' ;

INSERT INTO RESULT_BOM_ITEM_TMP
SELECT     '1500'           
, '1510'          
, '202101'            
, A.PRODUCT_CODE           
, A.ITEM_CODE              
, 'R'              
, SUM(A.INPUT_AMT)
, ''              
, A.INPUT_UNIT        
, 'N'       
, 'Y'                 
, SYSDATE            
, '1510코스비전'            
, SYSDATE
, '1510코스비전'  
FROM bom_20240229_tmp A
WHERE A.TP = '1510코스비전'
GROUP BY A.PRODUCT_CODE , A.ITEM_CODE, A.INPUT_UNIT
;

MERGE INTO result_bom_item I
USING ( SELECT * FROM result_bom_item_tmp WHERE CREATE_BY ='1510코스비전' ) T
   ON (  I.COMPANY_CODE = T.COMPANY_CODE
  AND I.DIVISION_CODE = T.DIVISION_CODE
  AND I.BOM_VERSION = T.BOM_VERSION
  AND I.PRODUCT_CODE = T.PRODUCT_CODE
    AND I.ITEM_CODE = T.ITEM_CODE
    AND T.CREATE_BY = '1510코스비전')
WHEN MATCHED THEN UPDATE 
     SET I.INPUT_QTY = I.INPUT_QTY
WHEN NOT MATCHED THEN 
  INSERT (
  I.COMPANY_CODE           
, I.DIVISION_CODE          
, I.BOM_VERSION            
, I.PRODUCT_CODE           
, I.ITEM_CODE              
, I.ITEM_TYPE              
, I.INPUT_QTY              
, I.HS_CODE10              
, I.INPUT_BASS_UNIT        
, I.BYPRD_OCCRRNC_AT       
, I.USE_YN                 
, I.CREATE_DATE            
, I.CREATE_BY              
, I.UPDATE_DATE            
, I.UPDATE_BY       
  )
  VALUES(
    T.COMPANY_CODE           
, T.DIVISION_CODE          
, T.BOM_VERSION            
, T.PRODUCT_CODE           
, T.ITEM_CODE              
, 'R'              
, T.INPUT_QTY/1000
, ''              
, T.INPUT_BASS_UNIT        
, 'N'       
, 'Y'                 
, SYSDATE            
, '1510코스비전'            
, SYSDATE
, '1510코스비전'      );


/*result_bom_hdr 생성*/
INSERT INTO result_bom_hdr
SELECT COMPANY_CODE, DIVISION_CODE, BOM_VERSION, PRODUCT_CODE, 1, '20210101', '99991231', 'EA' ,'1.000', SYSDATE, 'N', SYSDATE, 'N' 
  FROM result_bom_item I
WHERE NOT EXISTS (SELECT 1
                     FROM result_bom_hdr H
                    WHERE H.COMPANY_CODE = I.COMPANY_CODE
                      AND H.DIVISION_CODE = I.DIVISION_CODE
                      AND H.BOM_VERSION = I.BOM_VERSION
                      AND H.PRODUCT_CODE =I.PRODUCT_CODE)
  AND I.CREATE_BY = '1510코스비전'
GROUP BY COMPANY_CODE, DIVISION_CODE, BOM_VERSION, PRODUCT_CODE;

