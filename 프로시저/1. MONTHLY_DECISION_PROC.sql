CREATE OR REPLACE PROCEDURE MONTHLY_DECISION_PROC(P_YYYYMMDD               IN VARCHAR2 -- YYYYMM, YYYYMMDD 둘다 가능
                                                 ,P_COMPANY_CODE           IN VARCHAR2
                                                 ,P_DIVISION_CODE          IN VARCHAR2 DEFAULT NULL
                                                 ,P_CUSTOMER_CODE          IN VARCHAR2 DEFAULT NULL
                                                 ,P_DELIVERY_CUSTOMER_CODE IN VARCHAR2 DEFAULT NULL
                                                 ,P_PRODUCT_CODE           IN VARCHAR2 DEFAULT NULL
                                                 ,P_EXPORT_FLAG            IN VARCHAR2 DEFAULT NULL) AS

    /** 판정을 하기 위한 대상 추출 커서 **/
    CURSOR C_SALES_MST IS

        SELECT COMPANY_CODE
              ,DIVISION_CODE
              ,SALES_NO
        FROM   (SELECT SM.COMPANY_CODE
                      ,SM.DIVISION_CODE
                      ,SM.SALES_NO
                      ,SM.EXPORT_FLAG
                      ,SM.CUSTOMER_CODE
                FROM   SALES_MST SM
                JOIN   SALES_DTL SD
                ON     SD.SALES_NO = SM.SALES_NO
                AND    SD.DIVISION_CODE = SM.DIVISION_CODE
                AND    SD.COMPANY_CODE = SM.COMPANY_CODE
                WHERE  SM.COMPANY_CODE = P_COMPANY_CODE
                AND    SM.DIVISION_CODE = NVL(P_DIVISION_CODE, SM.DIVISION_CODE)
                AND    ((SM.EXPORT_FLAG = 'D' AND SM.VIRTUAL_YN = 'Y') OR
                      (SM.EXPORT_FLAG = 'E' AND
                      SM.TARGET_FTA_CODE IS NOT NULL))
                AND    INVOICE_DATE LIKE P_YYYYMMDD || '%'
                AND    SM.CUSTOMER_CODE = NVL(P_CUSTOMER_CODE, SM.CUSTOMER_CODE)
                AND    SM.DELIVERY_CUSTOMER_CODE =
                       NVL(P_DELIVERY_CUSTOMER_CODE, SM.DELIVERY_CUSTOMER_CODE)
                AND    SM.EXPORT_FLAG = NVL(P_EXPORT_FLAG, SM.EXPORT_FLAG)
                AND    SD.PRODUCT_CODE = NVL(P_PRODUCT_CODE, SD.PRODUCT_CODE))
        GROUP  BY COMPANY_CODE
                 ,DIVISION_CODE
                 ,SALES_NO
                 ,EXPORT_FLAG
                 ,CUSTOMER_CODE
        ORDER  BY EXPORT_FLAG
                 ,CUSTOMER_CODE;

    V_RETURN_CODE VARCHAR2(200);

    -- 프로시저 로그를 관리하기 위한 변수
    V_LOG_ID    NUMBER(32);
    R_ERROR_MSG VARCHAR2(4000);
    V_CNT       NUMBER(6) := 1;
    V_YYYYMM    VARCHAR2(6) := SUBSTR(P_YYYYMMDD, 1, 6);
    V_MATERIAL_USE_YN   VARCHAR2(6);
    V_CTC_DECISION_ONLY_YN VARCHAR2(1); -- 세번변경 판정만 수행하는 법인의 경우 Y  Add By Cheezred(2021-03-03)

BEGIN

    /** 프로시저 로그 마스터 생성 */

    PKG00_PROCEDURE_LOG.BATCH_LOG(V_LOG_ID, TO_CHAR(SYSDATE, 'YYYYMMDD'), 'MONTHLY_DECISION_PROC', 'S', P_COMPANY_CODE, 'COMPANY_CODE : ' ||
                                   P_COMPANY_CODE ||
                                   ', P_CUSTOMER_CODE : ' ||
                                   P_CUSTOMER_CODE ||
                                   ', P_DELIVERY_CUSTOMER_CODE : ' ||
                                   P_DELIVERY_CUSTOMER_CODE ||
                                   ', P_PRODUCT_CODE : ' ||
                                   P_PRODUCT_CODE ||
                                   ', P_YYYYMM : ' ||
                                   P_YYYYMMDD ||
                                   ', P_DIVISION_CODE : ' ||
                                   P_DIVISION_CODE, 'Y');

    SELECT NVL(MATERIAL_USE_YN, 'N'), NVL(CTC_DECISION_ONLY_YN, 'N')
    INTO   V_MATERIAL_USE_YN,V_CTC_DECISION_ONLY_YN
    FROM   COMPANY
    WHERE  COMPANY_CODE = P_COMPANY_CODE;

    IF 'Y' = V_MATERIAL_USE_YN THEN
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '원재료수불부(자동생성) 로드하는 프로세스 실행');
        PKG01_IF_LOAD.AUTO_MATERIAL_INV_BAL_PROC(P_COMPANY_CODE, V_YYYYMM);
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '원재료수불부(자동생성) 로드하는 프로세스 완료');
    END IF;

    /***************************************************************
    /* 1. 내수 포괄 매출 생성 (가상 SALES_MST 생성)
    ****************************************************************/
    DELETE
      FROM SALES_DTL
     WHERE SALES_NO IN (SELECT SM.CUSTOMER_CODE || SM.DIVISION_CODE || V_YYYYMM
                          FROM SALES_MST SM
                         WHERE SM.COMPANY_CODE = P_COMPANY_CODE
                           AND SM.INVOICE_DATE LIKE P_YYYYMMDD || '%'
                           AND SM.EXPORT_FLAG = 'D'
                           AND SM.VIRTUAL_YN = 'Y');

    DELETE
      FROM SALES_MST
     WHERE SALES_NO IN (SELECT SM.CUSTOMER_CODE || SM.DIVISION_CODE || V_YYYYMM
                          FROM SALES_MST SM
                         WHERE SM.COMPANY_CODE = P_COMPANY_CODE
                           AND SM.INVOICE_DATE LIKE P_YYYYMMDD || '%'
                           AND SM.EXPORT_FLAG = 'D'
                           AND SM.VIRTUAL_YN = 'Y');

    MERGE INTO SALES_MST SM
    USING (SELECT SM.CUSTOMER_CODE || SM.DIVISION_CODE || V_YYYYMM SALES_NO
                 ,SM.DIVISION_CODE
                 ,SM.COMPANY_CODE
                 ,SM.CUSTOMER_CODE
                 ,MAX(SM.EXPORT_FLAG) EXPORT_FLAG
                 ,MAX(SM.DEPARTMENT_CODE) DEPARTMENT_CODE
                 ,MAX(SM.INVOICE_DATE) AS INVOICE_DATE
                 ,'1' STATUS
                 ,MAX(SM.EXPORTER_NAME) AS EXPORTER_NAME
                 ,MAX(SM.EXPORTER_REPRESENTATIVE_NAME) AS EXPORTER_REPRESENTATIVE_NAME
                 ,MAX(SM.EXPORTER_BIZ_NO) AS EXPORTER_BIZ_NO
                 ,MAX(SM.EXPORTER_TEL_NO) AS EXPORTER_TEL_NO
                 ,MAX(SM.EXPORTER_ADDRESS) AS EXPORTER_ADDRESS
                 ,MAX(SM.PRODUCER_NAME) AS PRODUCER_NAME
                 ,MAX(SM.PRODUCER_REPRESENTATIVE_NAME) AS PRODUCER_REPRESENTATIVE_NAME
                 ,MAX(SM.PRODUCER_BIZ_NO) AS PRODUCER_BIZ_NO
                 ,MAX(SM.PRODUCER_TEL_NO) AS PRODUCER_TEL_NO
                 ,MAX(SM.PRODUCER_ADDRESS) AS PRODUCER_ADDRESS
                 ,MAX(SM.DELIVERY_CUSTOMER_CODE) AS DELIVERY_CUSTOMER_CODE
                 ,'Y' VIRTUAL_YN
                 ,SYSDATE CREATE_DATE
                 ,'MONTHLY_DECISION_PROC' CREATE_BY
                 ,SYSDATE UPDATE_DATE
                 ,'MONTHLY_DECISION_PROC' UPDATE_BY
           FROM   SALES_MST SM
           WHERE  SM.COMPANY_CODE = P_COMPANY_CODE
           AND    SM.INVOICE_DATE LIKE P_YYYYMMDD || '%'
           AND    SM.EXPORT_FLAG = 'D'
           AND    SM.VIRTUAL_YN = 'N'
                 -- 추가 조건 START
           AND    SM.CUSTOMER_CODE = NVL(P_CUSTOMER_CODE, SM.CUSTOMER_CODE)
           AND    SM.EXPORT_FLAG = NVL(P_EXPORT_FLAG, SM.EXPORT_FLAG)
           AND    SM.DIVISION_CODE = NVL(P_DIVISION_CODE, SM.DIVISION_CODE)
           -- 추가 조건 END
           GROUP  BY SM.COMPANY_CODE
                    ,SM.DIVISION_CODE
                    ,SM.CUSTOMER_CODE) VSM
    ON (SM.SALES_NO = VSM.SALES_NO AND SM.COMPANY_CODE = VSM.COMPANY_CODE AND SM.DIVISION_CODE = VSM.DIVISION_CODE)
    WHEN NOT MATCHED THEN
        INSERT
            (SALES_NO
            ,DIVISION_CODE
            ,COMPANY_CODE
            ,CUSTOMER_CODE
            ,EXPORT_FLAG
            ,DEPARTMENT_CODE
            ,INVOICE_DATE
            ,STATUS
            ,EXPORTER_NAME
            ,EXPORTER_REPRESENTATIVE_NAME
            ,EXPORTER_BIZ_NO
            ,EXPORTER_TEL_NO
            ,EXPORTER_ADDRESS
            ,PRODUCER_NAME
            ,PRODUCER_REPRESENTATIVE_NAME
            ,PRODUCER_BIZ_NO
            ,PRODUCER_TEL_NO
            ,PRODUCER_ADDRESS
            ,DELETE_YN
            ,VIRTUAL_YN
            ,DELIVERY_CUSTOMER_CODE
            ,CREATE_DATE
            ,CREATE_BY
            ,UPDATE_DATE
            ,UPDATE_BY)
        VALUES
            (VSM.SALES_NO
            ,VSM.DIVISION_CODE
            ,VSM.COMPANY_CODE
            ,VSM.CUSTOMER_CODE
            ,VSM.EXPORT_FLAG
            ,VSM.DEPARTMENT_CODE
            ,VSM.INVOICE_DATE
            ,VSM.STATUS
            ,VSM.EXPORTER_NAME
            ,VSM.EXPORTER_REPRESENTATIVE_NAME
            ,VSM.EXPORTER_BIZ_NO
            ,VSM.EXPORTER_TEL_NO
            ,VSM.EXPORTER_ADDRESS
            ,VSM.PRODUCER_NAME
            ,VSM.PRODUCER_REPRESENTATIVE_NAME
            ,VSM.PRODUCER_BIZ_NO
            ,VSM.PRODUCER_TEL_NO
            ,VSM.PRODUCER_ADDRESS
            ,'N'
            ,VSM.VIRTUAL_YN
            ,VSM.DELIVERY_CUSTOMER_CODE
            ,VSM.CREATE_DATE
            ,VSM.CREATE_BY
            ,VSM.UPDATE_DATE
            ,VSM.UPDATE_BY);

    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '내수 포괄 판정대상 매출 마스터 생성' ||
                                       ' 건수:' || SQL%ROWCOUNT);

    /***************************************************************
    /* 2. 포괄 SALES_DTL 생성
    ****************************************************************/
    MERGE INTO SALES_DTL SD
    USING (SELECT VSD.CUSTOMER_CODE || VSD.DIVISION_CODE || V_YYYYMM AS SALES_NO
                 ,(NVL((SELECT MAX(SALES_SEQ) + 1
                       FROM   SALES_DTL
                       WHERE  SALES_NO = VSD.CUSTOMER_CODE || VSD.DIVISION_CODE ||
                              V_YYYYMM
                       AND    COMPANY_CODE = VSD.COMPANY_CODE
                       AND    DIVISION_CODE = VSD.DIVISION_CODE), 1) + ROWNUM - 1) SALES_SEQ
                 ,VSD.DIVISION_CODE
                 ,VSD.COMPANY_CODE
                 ,VSD.PRODUCT_CODE
                 ,VSD.PRODUCT_NAME
                 ,VSD.CUSTOMER_ITEM_CODE
                 ,VSD.HS_CODE
                 ,VSD.PRODUCT_UNIT
                 ,VSD.PRODUCT_ASSETS_TYPE
                 ,VSD.PROD_DIVISION_CODE
                 ,VSD.QUANTITY
                 ,VSD.UNIT_PRICE
                 ,VSD.AMOUNT
                 ,'0' BOM_STATUS
                 ,'1' STATUS
                 ,VSD.DELIVERY_CUSTOMER_CODE
                  --,VSD.ATTRIBUTE01
                  --,VSD.ATTRIBUTE02
                 ,SYSDATE CREATE_DATE
                 ,'MONTHLY_DECISION_PROC' CREATE_BY
                 ,SYSDATE UPDATE_DATE
                 ,'MONTHLY_DECISION_PROC' UPDATE_BY
           FROM   (SELECT SD.DIVISION_CODE
                         ,SD.COMPANY_CODE
                         ,SM.CUSTOMER_CODE
                         ,SD.PRODUCT_CODE
                         ,SD.PRODUCT_NAME
                         ,IM.HS_CODE
                         ,SD.PRODUCT_UNIT
                         ,SD.PRODUCT_ASSETS_TYPE
                         ,SD.PROD_DIVISION_CODE
                         ,SD.DELIVERY_CUSTOMER_CODE
                         ,SUM(SD.QUANTITY) QUANTITY
                         ,NVL(SUM(SD.AMOUNT) /
                              DECODE(SUM(SD.QUANTITY), 0, NULL, SUM(SD.QUANTITY)), 0) UNIT_PRICE
                         ,SUM(SD.AMOUNT) AMOUNT
                         ,MAX(SD.CUSTOMER_ITEM_CODE) CUSTOMER_ITEM_CODE
                   --,MAX(SD.ATTRIBUTE01) AS ATTRIBUTE01
                   --,MAX(SD.ATTRIBUTE02) AS ATTRIBUTE02
                   FROM   SALES_MST SM
                   INNER  JOIN SALES_DTL SD
                   ON     SM.SALES_NO = SD.SALES_NO
                   AND    SM.COMPANY_CODE = SD.COMPANY_CODE
                   AND    SM.DIVISION_CODE = SD.DIVISION_CODE
                   INNER  JOIN ITEM_MST IM
                   ON     IM.COMPANY_CODE = SD.COMPANY_CODE
                   AND    IM.ITEM_CODE = SD.PRODUCT_CODE
                   WHERE  SM.INVOICE_DATE LIKE P_YYYYMMDD || '%'
                   AND    SM.EXPORT_FLAG = 'D'
                   AND    SM.VIRTUAL_YN = 'N'
                   AND    SM.COMPANY_CODE = P_COMPANY_CODE
                         -- 추가 조건 START
                   AND    SM.CUSTOMER_CODE =
                          NVL(P_CUSTOMER_CODE, SM.CUSTOMER_CODE)
                   AND    SD.DELIVERY_CUSTOMER_CODE =
                          NVL(P_DELIVERY_CUSTOMER_CODE, SM.DELIVERY_CUSTOMER_CODE)
                   AND    SM.EXPORT_FLAG = NVL(P_EXPORT_FLAG, SM.EXPORT_FLAG)
                   AND    SD.PRODUCT_CODE = NVL(P_PRODUCT_CODE, SD.PRODUCT_CODE)
                   AND    SM.DIVISION_CODE =
                          NVL(P_DIVISION_CODE, SM.DIVISION_CODE)
                   -- 추가 조건 END
                   GROUP  BY SD.DIVISION_CODE
                            ,SD.COMPANY_CODE
                            ,SD.PRODUCT_CODE
                            ,SM.CUSTOMER_CODE
                            ,SD.PRODUCT_NAME
                            ,SD.PRODUCT_UNIT
                            ,SD.PRODUCT_ASSETS_TYPE
                            ,IM.HS_CODE
                            ,SD.PROD_DIVISION_CODE
                            ,SD.DELIVERY_CUSTOMER_CODE) VSD
           WHERE  VSD.QUANTITY > 0) VSD
    ON (SD.SALES_NO = VSD.SALES_NO AND SD.PRODUCT_CODE = VSD.PRODUCT_CODE AND SD.DIVISION_CODE = VSD.DIVISION_CODE AND SD.PROD_DIVISION_CODE = VSD.PROD_DIVISION_CODE AND SD.COMPANY_CODE = VSD.COMPANY_CODE AND SD.DELIVERY_CUSTOMER_CODE = VSD.DELIVERY_CUSTOMER_CODE)
    WHEN MATCHED THEN
        UPDATE
        SET  PRODUCT_ASSETS_TYPE = VSD.PRODUCT_ASSETS_TYPE
    WHEN NOT MATCHED THEN
        INSERT
            (SALES_NO
            ,SALES_SEQ
            ,DIVISION_CODE
            ,COMPANY_CODE
            ,PRODUCT_CODE
            ,PRODUCT_NAME
            ,PRODUCT_UNIT
            ,PRODUCT_ASSETS_TYPE
            ,HS_CODE
            ,PROD_DIVISION_CODE
            ,QUANTITY
            ,UNIT_PRICE
            ,AMOUNT
            ,BOM_STATUS
            ,STATUS
            ,CUSTOMER_ITEM_CODE
            ,CREATE_DATE
            ,CREATE_BY
            ,UPDATE_DATE
            ,UPDATE_BY
            ,DELIVERY_CUSTOMER_CODE
             --,ATTRIBUTE01
             --,ATTRIBUTE02
             )
        VALUES
            (VSD.SALES_NO
            ,VSD.SALES_SEQ
            ,VSD.DIVISION_CODE
            ,VSD.COMPANY_CODE
            ,VSD.PRODUCT_CODE
            ,VSD.PRODUCT_NAME
            ,VSD.PRODUCT_UNIT
            ,VSD.PRODUCT_ASSETS_TYPE
            ,VSD.HS_CODE
            ,VSD.PROD_DIVISION_CODE
            ,VSD.QUANTITY
            ,VSD.UNIT_PRICE
            ,VSD.AMOUNT
            ,VSD.BOM_STATUS
            ,VSD.STATUS
            ,VSD.CUSTOMER_ITEM_CODE
            ,VSD.CREATE_DATE
            ,VSD.CREATE_BY
            ,VSD.UPDATE_DATE
            ,VSD.UPDATE_BY
            ,VSD.DELIVERY_CUSTOMER_CODE
             --,VSD.ATTRIBUTE01
             --,VSD.ATTRIBUTE02
             );

    /***************************************************************
    /* 4. 판정대상 커서 LOOP
    ****************************************************************/

    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '판정 Start ******* ');

    FOR SALES_LIST IN C_SALES_MST
    LOOP

        BEGIN

            /***************************************************************
            /* 5. 원산지판정
            ****************************************************************/
            -- 원산지 판정 Flag UPDATE (전체판정이기 때문에)
            UPDATE SALES_DTL SD
            SET    SD.DECISION_YN = 'Y'
                  ,SD.STATUS      = '1' -- 판정전
            WHERE  SD.COMPANY_CODE = SALES_LIST.COMPANY_CODE
            AND    SD.DIVISION_CODE = SALES_LIST.DIVISION_CODE
            AND    SD.SALES_NO = SALES_LIST.SALES_NO;
            --AND    SD.PRODUCT_CODE = NVL(P_PRODUCT_CODE, SD.PRODUCT_CODE)
            --AND    SD.DELIVERY_CUSTOMER_CODE =
            --       NVL(P_DELIVERY_CUSTOMER_CODE, SD.DELIVERY_CUSTOMER_CODE);

            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, SALES_LIST.SALES_NO ||
                                               '건 FCR생성 중');

            -- FCR 생성
            CREATE_FCR(SALES_LIST.COMPANY_CODE, SALES_LIST.DIVISION_CODE, SALES_LIST.SALES_NO, 'F', V_RETURN_CODE);

            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, SALES_LIST.SALES_NO ||
                                               '건 판정 중');
            -- 원산지 판정
            IF NVL(V_CTC_DECISION_ONLY_YN, 'N') = 'N' THEN
              PKG99_COO_DECISION.COO_DECISION(SALES_LIST.COMPANY_CODE, SALES_LIST.SALES_NO, V_RETURN_CODE);              
            ELSE
              PKG99_COO_CTC_DECISION.COO_DECISION(SALES_LIST.COMPANY_CODE, SALES_LIST.SALES_NO, V_RETURN_CODE);
            END IF;


            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, SALES_LIST.SALES_NO ||
                                               '건 판정 완료');

            -- 상태값 변경 4: 판정완료
            UPDATE SALES_MST
            SET    STATUS   = '4'
                  ,COO_DATE = SYSDATE
            WHERE  COMPANY_CODE = SALES_LIST.COMPANY_CODE
            AND    SALES_NO = SALES_LIST.SALES_NO;

            UPDATE SALES_DTL DTL
            SET    STATUS = CASE
                                WHEN (SELECT NVL(SUM(DECODE(FR.STATUS, 'E', 1, 0) +
                                                     NVL2(FM.RULE_CONTENTS, 0, 1)), 1)
                                      FROM   FCR_MST    FM
                                            ,FCR_RESULT FR
                                      WHERE  FM.SALES_NO = DTL.SALES_NO
                                      AND    FM.DIVISION_CODE = DTL.DIVISION_CODE
                                      AND    FM.COMPANY_CODE = DTL.COMPANY_CODE
                                      AND    FM.SALES_SEQ = DTL.SALES_SEQ
                                      AND    FR.FTA_CODE(+) = FM.FTA_CODE
                                      AND    FR.SALES_NO(+) = FM.SALES_NO
                                      AND    FR.SALES_SEQ(+) = FM.SALES_SEQ
                                      AND    FR.DIVISION_CODE(+) =
                                             FM.DIVISION_CODE
                                      AND    FR.COMPANY_CODE(+) = FM.COMPANY_CODE
                                      AND    FM.DECISION_YN = 'Y') > 0 THEN
                                 '5'
                                ELSE
                                 '4'
                            END
                  ,DECISION_YN = ''
                  ,UPDATE_DATE = SYSDATE
                  ,UPDATE_BY   = 'MONTHLY_DECISION_PROC'
            WHERE  COMPANY_CODE = SALES_LIST.COMPANY_CODE
            AND    SALES_NO = SALES_LIST.SALES_NO
            AND    DECISION_YN = 'Y';

            -- 판정일자 업데이트
            UPDATE FCR_MST
            SET    COO_DATE    = SYSDATE
                  ,DECISION_YN = ''
            WHERE  COMPANY_CODE = SALES_LIST.COMPANY_CODE
            AND    SALES_NO = SALES_LIST.SALES_NO
            AND    DECISION_YN = 'Y';

            IF MOD(V_CNT, 100) = 0 THEN
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, V_CNT || '건 판정 완료');
            END IF;

            V_CNT := V_CNT + 1;

        EXCEPTION
            WHEN OTHERS THEN
                R_ERROR_MSG := SQLCODE || ':' || SQLERRM;
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, 'DBMS 에러가 발생 했습니다 ' ||
                                                   R_ERROR_MSG ||
                                                   '[PARAM {COMAPNY_CODE : ' ||
                                                   SALES_LIST.COMPANY_CODE ||
                                                   '}{SALES_NO : ' ||
                                                   SALES_LIST.SALES_NO || '}]', 'Y');

        END;

    END LOOP;

    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '***** END MONTHLY_DECISION_PROC');
    PKG00_PROCEDURE_LOG.BATCH_LOG_LAST(V_LOG_ID, 'N');

    /***************************************************************
    /* 99. 에러를 처리
    /***************************************************************/

EXCEPTION
    WHEN OTHERS THEN
        R_ERROR_MSG := SQLCODE || ':' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(R_ERROR_MSG);

        -- 프로시저 로그 저장
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, 'DBMS 에러가 발생 했습니다 ' ||
                                           R_ERROR_MSG, 'Y');
        PKG00_PROCEDURE_LOG.BATCH_LOG_LAST(V_LOG_ID, 'E', 'DBMS ERROR', 'Y');

END MONTHLY_DECISION_PROC;

 
