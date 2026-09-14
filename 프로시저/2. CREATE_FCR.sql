CREATE OR REPLACE PROCEDURE CREATE_FCR(P_COMPANY_CODE  IN VARCHAR2
                                      ,P_DIVISION_CODE IN VARCHAR2
                                      ,P_SALES_NO      IN VARCHAR2
                                      ,P_BOM_TYPE      IN VARCHAR2
                                      ,P_ERR_CODE      OUT VARCHAR2) AS
    -- 프로시저 로그를 관리하기 위한 변수
    V_LOG_ID NUMBER(32);

    -- 중간재포함여부 F:중간재없이 MF:중간재포함

    V_EXPORT_FLAG VARCHAR2(1);

    -- INVOICE DATE상의 기준월
    V_YYYYMM VARCHAR2(6);
    -- BOM 이전 년월(5년치 조회)
    V_BOM_PREVIOUS_YYYYMM VARCHAR2(6);

    V_INVOICE_DATE VARCHAR2(8);

    --V_PROD_DIVISION_CODE VARCHAR2(20);
    V_BOM_DIVISION_CODE VARCHAR2(20);
    V_BOM_YYYYMM        VARCHAR2(6);
    --V_SALES_SEQ          NUMBER(20);
    --V_PRODUCT_CODE VARCHAR2(30);
    V_STATUS     VARCHAR2(1);
    V_VIRTUAL_YN VARCHAR2(1);
    V_BOM_TYPE   VARCHAR2(5);
    V_MF_CNT     NUMBER(3);

    CURSOR C_SALES_DTL IS
        SELECT SALES_SEQ
              ,PRODUCT_CODE
              ,PROD_DIVISION_CODE
              ,STATUS
        FROM   SALES_DTL
        WHERE  SALES_NO = P_SALES_NO
        AND    DECISION_YN = 'Y'
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    PRODUCT_ASSETS_TYPE IN ('P', 'H');

    V_BOM_STATUS SALES_DTL.BOM_STATUS%TYPE;
    V_R_CNT      NUMBER(10) := 0;
    --V_S_CNT      NUMBER(10) := 0;
    V_P_CNT    NUMBER(10) := 0;
    V_ERR_CNT  NUMBER(10) := 0;
    V_ERR_CODE VARCHAR2(20) := 'successed';

    R_SALES_DTL C_SALES_DTL%ROWTYPE;

BEGIN

    /** 프로시저 로그 마스터 생성 */

    PKG00_PROCEDURE_LOG.BATCH_LOG(V_LOG_ID, TO_CHAR(SYSDATE, 'YYYYMMDD'), 'CREATE_FCR', 'S', P_COMPANY_CODE, 'COMPANY_CODE : ' ||
                                   P_COMPANY_CODE, 'Y');

    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '***** START CREATE_FCR');
    /***************************************************************
    /* 1. 파라미터 셋업 작업
    ****************************************************************/
    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '1. 파라미터 셋업 작업');
    SELECT EXPORT_FLAG
          ,SM.INVOICE_DATE
          ,SUBSTR(SM.INVOICE_DATE, 1, 6)
          ,TO_CHAR(ADD_MONTHS(SM.INVOICE_DATE, -60), 'YYYYMM')
          , -- BOM 이전년월(6개월)
           VIRTUAL_YN
    INTO   V_EXPORT_FLAG
          ,V_INVOICE_DATE
          ,V_YYYYMM
          ,V_BOM_PREVIOUS_YYYYMM
          ,V_VIRTUAL_YN
    FROM   SALES_MST SM
    WHERE  SALES_NO = P_SALES_NO
    AND    SM.DIVISION_CODE = P_DIVISION_CODE
    AND    SM.COMPANY_CODE = P_COMPANY_CODE;

    /** 포괄인지 아닌지를 체크하여 프로세스를 별도로 처리하도록 한다 **/
    /*SELECT VIRTUAL_YN INTO V_VIRTUAL_YN
     FROM SALES_MST
    WHERE SALES_NO      = P_SALES_NO
      AND DIVISION_CODE = P_DIVISION_CODE
      AND COMPANY_CODE  = P_COMPANY_CODE;*/

    /** 정산작업 시 중간재 적용판정인지 확인**/
    IF P_BOM_TYPE = 'X' THEN
        SELECT COUNT(*)
        INTO   V_MF_CNT
        FROM   FCR_MST
        WHERE  SALES_NO = P_SALES_NO
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    IM_APPLY_YN = 'MF';
        IF V_MF_CNT > 0 THEN
            V_BOM_TYPE := 'MF';
        ELSE
            V_BOM_TYPE := 'F';
        END IF;
    ELSE
        V_BOM_TYPE := P_BOM_TYPE;
    END IF;

    /***************************************************************
    /* 2. 실적 BOM 및 표준 BOM 확인 작업
    ****************************************************************/
    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '2. 실적 BOM 및 표준 BOM 확인 작업');

    OPEN C_SALES_DTL;
    LOOP
        FETCH C_SALES_DTL
            INTO R_SALES_DTL;
        EXIT WHEN C_SALES_DTL%NOTFOUND;

        V_BOM_STATUS        := '0';
        V_STATUS            := '0';
        V_R_CNT             := 0;
        V_P_CNT             := 0;
        V_BOM_YYYYMM        := '';
        V_BOM_DIVISION_CODE := '';

        --IF R_SALES_DTL.STATUS <> '4' THEN

        V_BOM_STATUS := '0';

        -- 판정오류건 판정전으로 변경
        IF R_SALES_DTL.STATUS = '5' THEN
            V_STATUS := '1'; -- 판정전
        END IF;

        -- 해당 사업장 BOM 존재 확인
        BEGIN
            SELECT ROWNUM AS CNT
                  ,DIVISION_CODE
                  ,FBD.YYYYMM
            INTO   V_R_CNT
                  ,V_BOM_DIVISION_CODE
                  ,V_BOM_YYYYMM
            FROM   FTA_BOM_DTL FBD
            WHERE  FBD.COMPANY_CODE = P_COMPANY_CODE
            AND    FBD.DIVISION_CODE = R_SALES_DTL.PROD_DIVISION_CODE
            AND    FBD.PRODUCT_CODE = R_SALES_DTL.PRODUCT_CODE
            AND    FBD.TXN_TYPE = V_BOM_TYPE
            AND    FBD.REQ_QTY >= 0
            AND    ROWNUM = 1
            AND    FBD.YYYYMM =
                   (SELECT MAX(FBDT.YYYYMM)
                     FROM   FTA_BOM_DTL FBDT
                     WHERE  FBDT.COMPANY_CODE = P_COMPANY_CODE
                     AND    FBDT.DIVISION_CODE = R_SALES_DTL.PROD_DIVISION_CODE
                     AND    FBDT.PRODUCT_CODE = R_SALES_DTL.PRODUCT_CODE
                     AND    FBDT.TXN_TYPE = V_BOM_TYPE
                     AND    FBDT.YYYYMM BETWEEN V_BOM_PREVIOUS_YYYYMM AND
                            V_YYYYMM);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_R_CNT             := 0;
                V_BOM_YYYYMM        := NULL;
                V_BOM_DIVISION_CODE := NULL;
        END;

        -- 실적 BOM이 없는 경우
        IF V_R_CNT = 0 THEN
            -- 타 플랜트 BOM 체크
            BEGIN
                SELECT ROWNUM AS CNT
                      ,DIVISION_CODE
                      ,FBD.YYYYMM
                INTO   V_P_CNT
                      ,V_BOM_DIVISION_CODE
                      ,V_BOM_YYYYMM
                FROM   FTA_BOM_DTL FBD
                WHERE  FBD.COMPANY_CODE = P_COMPANY_CODE
                      -- AND FBD.DIVISION_CODE = R_SALES_DTL.PROD_DIVISION_CODE
                AND    FBD.PRODUCT_CODE = R_SALES_DTL.PRODUCT_CODE
                AND    FBD.TXN_TYPE = V_BOM_TYPE
                AND    FBD.REQ_QTY >= 0
                AND    ROWNUM = 1
                AND    FBD.YYYYMM =
                       (SELECT MAX(FBDT.YYYYMM)
                         FROM   FTA_BOM_DTL FBDT
                         WHERE  FBDT.COMPANY_CODE = P_COMPANY_CODE
                               -- AND FBDT.DIVISION_CODE = R_SALES_DTL.PROD_DIVISION_CODE
                         AND    FBDT.PRODUCT_CODE = R_SALES_DTL.PRODUCT_CODE
                         AND    FBDT.TXN_TYPE = V_BOM_TYPE
                         AND    FBDT.YYYYMM BETWEEN V_BOM_PREVIOUS_YYYYMM AND
                                V_YYYYMM);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_P_CNT             := 0;
                    V_BOM_YYYYMM        := NULL;
                    V_BOM_DIVISION_CODE := NULL;
            END;

            -- BOM 없는 경우 에러로 처리
            IF V_P_CNT = 0 THEN
                V_ERR_CNT := V_ERR_CNT + 1;
                -- BOM이 없는 경우 에러 상태
                V_BOM_STATUS := '1';
            ELSE
                -- 타플랜트 BOM 사용
                V_BOM_STATUS := '2';
            END IF;
        END IF;
        --END IF;

        UPDATE SALES_DTL
        SET    STATUS            = V_STATUS
              ,BOM_STATUS        = V_BOM_STATUS
              ,BOM_YYYYMM        = V_BOM_YYYYMM
              ,BOM_DIVISION_CODE = V_BOM_DIVISION_CODE
              ,UPDATE_DATE       = SYSDATE
        WHERE  SALES_NO = P_SALES_NO
        AND    SALES_SEQ = R_SALES_DTL.SALES_SEQ
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    PRODUCT_CODE = R_SALES_DTL.PRODUCT_CODE;

    END LOOP;
    CLOSE C_SALES_DTL;

    /***************************************************************
    /* 3. FCR 생성 작업
    ****************************************************************/
    IF V_ERR_CNT = 0 OR
       V_VIRTUAL_YN = 'Y' THEN
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3. FCR 생성 작업');

        /***************************************************************
        /* 3-1. 전 처리 작업
        ****************************************************************/
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-1. 전 처리 작업');
        -- 초기화  FCR_DTL,FCR_MST

        DELETE FROM FCR_DTL FM
        WHERE  SALES_NO = P_SALES_NO
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    EXISTS (SELECT 1
                FROM   SALES_DTL SD
                WHERE  SD.SALES_NO = FM.SALES_NO
                AND    SD.SALES_SEQ = FM.SALES_SEQ
                AND    SD.DIVISION_CODE = FM.DIVISION_CODE
                AND    SD.COMPANY_CODE = FM.COMPANY_CODE
                AND    SD.SALES_NO = P_SALES_NO
                AND    SD.DIVISION_CODE = P_DIVISION_CODE
                AND    SD.COMPANY_CODE = P_COMPANY_CODE
                AND    SD.DECISION_YN = 'Y');

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, 'FCR_DTL 삭제 건수 : ' ||
                                           SQL%ROWCOUNT);
        DELETE FROM FCR_RESULT FM
        WHERE  SALES_NO = P_SALES_NO
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    EXISTS (SELECT 1
                FROM   SALES_DTL SD
                WHERE  SD.SALES_NO = FM.SALES_NO
                AND    SD.SALES_SEQ = FM.SALES_SEQ
                AND    SD.DIVISION_CODE = FM.DIVISION_CODE
                AND    SD.COMPANY_CODE = FM.COMPANY_CODE
                AND    SD.SALES_NO = P_SALES_NO
                AND    SD.DIVISION_CODE = P_DIVISION_CODE
                AND    SD.COMPANY_CODE = P_COMPANY_CODE
                AND    SD.DECISION_YN = 'Y');

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, 'FCR_RESULT 삭제 건수 : ' ||
                                           SQL%ROWCOUNT);

        DELETE FROM FCR_MST FM
        WHERE  SALES_NO = P_SALES_NO
        AND    DIVISION_CODE = P_DIVISION_CODE
        AND    COMPANY_CODE = P_COMPANY_CODE
        AND    EXISTS (SELECT 1
                FROM   SALES_DTL SD
                WHERE  SD.SALES_NO = FM.SALES_NO
                AND    SD.SALES_SEQ = FM.SALES_SEQ
                AND    SD.DIVISION_CODE = FM.DIVISION_CODE
                AND    SD.COMPANY_CODE = FM.COMPANY_CODE
                AND    SD.SALES_NO = P_SALES_NO
                AND    SD.DIVISION_CODE = P_DIVISION_CODE
                AND    SD.COMPANY_CODE = P_COMPANY_CODE
                AND    SD.DECISION_YN = 'Y');

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, 'FCR_MST 삭제 건수 : ' ||
                                           SQL%ROWCOUNT);

        /***************************************************************
        /* 3-2. FCR_MST 데이터 생성
        /*   1) 내수는 모든 FTA에 대해 FCR_MST 데이터 생성
        /*   2) 수출은 FTA협정국에 대해 데이터 생성
        ****************************************************************/
        -- 내수
        IF V_EXPORT_FLAG = 'D' THEN

            INSERT INTO FCR_MST
                (FTA_CODE
                ,SALES_NO
                ,SALES_SEQ
                ,PRODUCT_CODE
                ,DIVISION_CODE
                ,COMPANY_CODE
                ,HS_CODE
                ,STANDARD
                ,AMOUNT
                ,NET_COST_AMOUNT
                ,EXWORK_AMOUNT
                ,FOB_AMOUNT
                ,INAREA_AMOUNT
                ,OUTAREA_AMOUNT
                ,SP_COO_YN
                ,WO_COO_YN
                ,PRODUCT_UNIT
                ,PRODUCT_ASSETS_TYPE
                ,PROD_DIVISION_CODE
                ,IM_APPLY_YN
                ,CREATE_DATE
                ,CREATE_BY
                ,UPDATE_DATE
                ,UPDATE_BY
                ,DECISION_YN)
                SELECT FM.FTA_CODE
                      ,SALES.SALES_NO
                      ,SALES.SALES_SEQ
                      ,SALES.PRODUCT_CODE
                      ,SALES.DIVISION_CODE
                      ,SALES.COMPANY_CODE
                      --,SUBSTR(SALES.HS_CODE, 1, 6) HS_CODE
                      ,SUBSTR(FS03_GET_HS_CODE(SALES.COMPANY_CODE, SALES.PROD_DIVISION_CODE, SALES.DELIVERY_CUSTOMER_CODE, SALES.PRODUCT_CODE, SALES.ARRIVAL_NATION, FM.FTA_CODE, SALES.INVOICE_DATE), 1, 6) HS_CODE
                      ,SALES.STANDARD
                      ,SALES.AMOUNT
                      ,SALES.NET_COST
                      /* 한화케미컬 버전
                      ,FC10_GET_INCOTERMS(SALES.COMPANY_CODE, SUBSTR(V_INVOICE_DATE, 1, 4), SALES.PROD_DIVISION_CODE, SALES.EXPORT_FLAG, SALES.PRODUCT_CODE, 'EXW', 'FOB') *
                       SALES.AMOUNT AS EXWORK_AMOUNT
                      */
                      ,GET_INCOTERMS_CHANGE_RATE(SUBSTR(V_INVOICE_DATE, 1, 4),
                                                 SALES.COMPANY_CODE,
                                                 SALES.DIVISION_CODE,
                                                 SALES.EXPORT_FLAG,
                                                 'KR', -- FTA CODE
                                                 'FOB', -- FROM
                                                 'EXW' -- TO
                                                 ) * SALES.AMOUNT AS EXWORK_AMOUNT

                      ,SALES.AMOUNT AS FOB_AMOUNT
                      ,0 AS INAREA_AMOUNT
                      ,0 AS OUTAREA_AMOUNT
                      ,SALES.SP_COO_YN
                      ,SALES.WO_COO_YN
                      ,SALES.PRODUCT_UNIT
                      ,SALES.PRODUCT_ASSETS_TYPE
                      ,SALES.PROD_DIVISION_CODE
                      ,DECODE(V_BOM_TYPE, 'F', 'F', DECODE(FM.INTERMEDIATE_YN, 'Y', 'MF', 'F'))
                      ,SYSDATE
                      ,'CREATE_FCR'
                      ,SYSDATE
                      ,'CREATE_FCR'
                      ,'Y'
                FROM   (SELECT SM.SALES_NO
                              ,SD.SALES_SEQ
                              ,SD.PRODUCT_CODE
                              ,SD.DIVISION_CODE
                              ,SM.COMPANY_CODE
                             -- ,FS03_GET_HS_CODE(SM.COMPANY_CODE, SD.PROD_DIVISION_CODE, SD.DELIVERY_CUSTOMER_CODE, SD.PRODUCT_CODE, SM.ARRIVAL_NATION, SM.INVOICE_DATE) HS_CODE
                              ,SD.STANDARD
                              ,(SD.AMOUNT / SD.QUANTITY) AS AMOUNT
                              ,NVL(SD.SP_COO_YN, 'N') AS SP_COO_YN
                              ,DECODE(SD.PRODUCT_ASSETS_TYPE, 'B', 'Y', 'N') AS WO_COO_YN
                              , -- 부산물은 완전생산 기준을 만족함
                               SD.PRODUCT_UNIT
                              ,SD.PRODUCT_ASSETS_TYPE
                              ,SD.PROD_DIVISION_CODE
                              ,SM.INVOICE_DATE
                              ,0 AS NET_COST
                              , -- 순원가 금액 (원가 + (FOB 판가 *판관비율)
                               SM.EXPORT_FLAG
                              ,SM.INKOTERMS
                              ,SD.DELIVERY_CUSTOMER_CODE
                              ,SM.ARRIVAL_NATION
                        FROM   SALES_MST SM
                        INNER  JOIN SALES_DTL SD
                        ON     SM.SALES_NO = SD.SALES_NO
                        AND    SM.COMPANY_CODE = SD.COMPANY_CODE
                        AND    SM.DIVISION_CODE = SD.DIVISION_CODE
                        AND    SD.DECISION_YN = 'Y'
                        WHERE  SM.SALES_NO = P_SALES_NO
                        AND    SM.DIVISION_CODE = P_DIVISION_CODE
                        AND    SM.COMPANY_CODE = P_COMPANY_CODE
                        AND    SD.QUANTITY > 0
                        AND    SD.BOM_STATUS <> '1'
                        ) SALES
                INNER  JOIN FTA_MASTER FM
                ON     DELETE_YN = 'N';

            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-2. FCR_MST 데이터 생성' ||
                                               '건수 : ' || SQL%ROWCOUNT);
        ELSE
            -- 수출
            INSERT INTO FCR_MST
                (FTA_CODE
                ,SALES_NO
                ,SALES_SEQ
                ,PRODUCT_CODE
                ,DIVISION_CODE
                ,COMPANY_CODE
                ,HS_CODE
                ,STANDARD
                ,AMOUNT
                ,NET_COST_AMOUNT
                ,EXWORK_AMOUNT
                ,FOB_AMOUNT
                ,INAREA_AMOUNT
                ,OUTAREA_AMOUNT
                ,SP_COO_YN
                ,WO_COO_YN
                ,PRODUCT_UNIT
                ,PRODUCT_ASSETS_TYPE
                ,PROD_DIVISION_CODE
                ,IM_APPLY_YN
                ,CREATE_DATE
                ,CREATE_BY
                ,UPDATE_DATE
                ,UPDATE_BY
                ,DECISION_YN)
                SELECT FM.FTA_CODE
                      ,SALES.SALES_NO
                      ,SALES.SALES_SEQ
                      ,SALES.PRODUCT_CODE
                      ,SALES.DIVISION_CODE
                      ,SALES.COMPANY_CODE
                      ,SUBSTR(SALES.HS_CODE, 1, 6) HS_CODE
                      ,SALES.STANDARD
                      ,SALES.AMOUNT AS AMOUNT
                      ,NET_COST NET_COST_AMOUNT
                      /* 한화케미컬 버전
                      ,FC10_GET_INCOTERMS(SALES.COMPANY_CODE, SUBSTR(V_INVOICE_DATE, 1, 4), SALES.PROD_DIVISION_CODE, SALES.EXPORT_FLAG, SALES.PRODUCT_CODE, 'EXW', SALES.INKOTERMS) *
                       (SALES.AMOUNT / SALES.QUANTITY) AS EXWORK_AMOUNT
                      ,FC10_GET_INCOTERMS(SALES.COMPANY_CODE, SUBSTR(V_INVOICE_DATE, 1, 4), SALES.PROD_DIVISION_CODE, SALES.EXPORT_FLAG, SALES.PRODUCT_CODE, 'FOB', SALES.INKOTERMS) * (SALES.AMOUNT / SALES.QUANTITY) AS FOB_AMOUNT
                      */
                      ,GET_INCOTERMS_CHANGE_RATE(SUBSTR(V_INVOICE_DATE, 1, 4),
                                                 SALES.COMPANY_CODE,
                                                 SALES.DIVISION_CODE,
                                                 SALES.EXPORT_FLAG,
                                                 SALES.TARGET_FTA_CODE, -- FTA CODE
                                                 SALES.INKOTERMS, -- FROM
                                                 'EXW' -- TO
                                                 ) * SALES.AMOUNT AS EXWORK_AMOUNT
                      ,GET_INCOTERMS_CHANGE_RATE(SUBSTR(V_INVOICE_DATE, 1, 4),
                                                 SALES.COMPANY_CODE,
                                                 SALES.DIVISION_CODE,
                                                 SALES.EXPORT_FLAG,
                                                 SALES.TARGET_FTA_CODE, -- FTA CODE
                                                 SALES.INKOTERMS, -- FROM
                                                 'FOB' -- TO
                                                 ) * SALES.AMOUNT AS FOB_AMOUNT
                      ,0 INAREA_AMOUNT
                      ,0 OUTAREA_AMOUNT
                      ,SALES.SP_COO_YN
                      ,SALES.WO_COO_YN
                      ,SALES.PRODUCT_UNIT
                      ,SALES.PRODUCT_ASSETS_TYPE
                      ,SALES.PROD_DIVISION_CODE
                      ,DECODE(V_BOM_TYPE, 'F', 'F', DECODE(FM.INTERMEDIATE_YN, 'Y', 'MF', 'F'))
                      ,SYSDATE CREATE_DATE
                      ,'CREATE_FCR' CREATE_BY
                      ,SYSDATE UPDATE_DATE
                      ,'CREATE_FCR' UPDATE_BY
                      ,'Y'
                FROM   (SELECT SM.SALES_NO
                              ,SD.SALES_SEQ
                              ,SD.PRODUCT_CODE
                              ,SD.DIVISION_CODE
                              ,SD.COMPANY_CODE
                              ,FS03_GET_HS_CODE(SM.COMPANY_CODE, SD.PROD_DIVISION_CODE, SD.DELIVERY_CUSTOMER_CODE, SD.PRODUCT_CODE, SM.ARRIVAL_NATION, SM.INVOICE_DATE) HS_CODE
                              ,SD.STANDARD
                              ,SD.QUANTITY
                              ,(SD.AMOUNT / SD.QUANTITY) AS AMOUNT
                              ,SM.INKOTERMS
                              ,SM.TARGET_FTA_CODE TARGET_FTA_CODE
                              ,NVL(SD.SP_COO_YN, 'N') AS SP_COO_YN
                              ,DECODE(SD.PRODUCT_ASSETS_TYPE, 'B', 'Y', 'N') AS WO_COO_YN
                              , -- 부산물은 완전생산 기준을 만족함
                               SD.PRODUCT_UNIT
                              ,SD.PRODUCT_ASSETS_TYPE
                              ,SD.PROD_DIVISION_CODE
                              ,0 AS NET_COST  -- 순원가 금액 (원가 + (FOB 판가 *판관비율)
                              , SM.EXPORT_FLAG
                              ,NVL(SM.ARRIVAL_NATION, C.NATION_CODE) ARRIVAL_NATION
                              ,SM.INVOICE_DATE
                        FROM   SALES_MST SM
                        INNER  JOIN SALES_DTL SD
                        ON     SM.SALES_NO = SD.SALES_NO
                        AND    SM.DIVISION_CODE = SD.DIVISION_CODE
                        AND    SM.COMPANY_CODE = SD.COMPANY_CODE
                        AND    SD.DECISION_YN = 'Y'
                        AND    SD.BOM_STATUS <> '1'
                      INNER JOIN CUSTOMER C
                         ON SM.CUSTOMER_CODE = C.CUSTOMER_CODE
                        AND SM.COMPANY_CODE = C.COMPANY_CODE
                      WHERE  SM.SALES_NO = P_SALES_NO
                        AND    SM.DIVISION_CODE = P_DIVISION_CODE
                        AND    SM.COMPANY_CODE = P_COMPANY_CODE) SALES
                JOIN FTA_APPLY_NATION FAN
                  ON FAN.NATION_CODE = SALES.ARRIVAL_NATION
                 AND FAN.EFFECT_DATE <= SALES.INVOICE_DATE         
                JOIN FTA_MASTER FM
                  ON (DELETE_YN = 'N' AND FM.FTA_CODE = SALES.TARGET_FTA_CODE AND FM.FTA_CODE = FAN.FTA_CODE)
                 AND FM.FTA_STATUS = '4'
                ;
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-2. FCR_MST 데이터 생성' ||
                                               '건수 : ' || SQL%ROWCOUNT);
        END IF;

        /***************************************************************
        /* 3-3. 제품 FCR_DTL 데이터 생성
         ****************************************************************/
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-3. 제품 FCR_DTL 데이터 생성' ||
                                           '건수 : ' || SQL%ROWCOUNT);

        INSERT INTO FCR_DTL
            (ITEM_CODE
            ,FTA_CODE
            ,SALES_NO
            ,SALES_SEQ
            ,PRODUCT_CODE
            ,DIVISION_CODE
            ,COMPANY_CODE
            ,HS_CODE
            ,REQUIREMENT_QTY
            ,INPUT_AMOUNT
            ,INAREA_QTY
            ,INAREA_AMOUNT
            ,OUTAREA_QTY
            ,OUTAREA_AMOUNT
            ,HS_CODE_YN
            ,PRICE_NOTE
            ,CREATE_DATE
            ,CREATE_BY
            ,UPDATE_DATE
            ,UPDATE_BY)
            SELECT ITEM_CODE
                  ,FTA_CODE
                  ,SALES_NO
                  ,SALES_SEQ
                  ,PRODUCT_CODE
                  ,DIVISION_CODE
                  ,COMPANY_CODE
                  ,HS_CODE
                  ,REQUIREMENT_QTY
                  ,REQUIREMENT_QTY * UNIT_PRICE AS INPUT_AMOUNT
                  ,REQUIREMENT_QTY * ORIGIN_RATE AS INAREA_QTY
                  ,UNIT_PRICE * (REQUIREMENT_QTY * ORIGIN_RATE) AS INAREA_AMOUNT
                  ,REQUIREMENT_QTY * (1 - ORIGIN_RATE) AS OUTAREA_QTY
                  ,UNIT_PRICE * (REQUIREMENT_QTY * (1 - ORIGIN_RATE)) AS OUTAREA_AMOUNT
                  ,HS_CODE_YN
                  ,PRICE_NOTE
                  ,SYSDATE CREATE_DATE
                  ,'CREATE_FCR' CREATE_BY
                  ,SYSDATE UPDATE_DATE
                  ,'CREATE_FCR' UPDATE_BY
            FROM   (SELECT FD.ITEM_CODE
                          ,FD.FTA_CODE
                          ,FD.SALES_NO
                          ,FD.SALES_SEQ
                          ,FD.PRODUCT_CODE
                          ,FD.DIVISION_CODE
                          ,FD.COMPANY_CODE
                          ,FD.HS_CODE
                          ,SUM(DECODE(FD.UNIT_PRICE, 0, 0, FD.REQUIREMENT_QTY)) AS REQUIREMENT_QTY
                          ,CASE
                               WHEN SUM(DECODE(FD.UNIT_PRICE, 0, 0, FD.REQUIREMENT_QTY)) = 0 THEN
                                0
                               ELSE /* (수량 * 단가) / 수량합
                                                                   단가가 없거나 수량이 없으면 0처리 */
                                SUM(DECODE(FD.REQUIREMENT_QTY, 0, 0, FD.UNIT_PRICE) *
                                    DECODE(FD.UNIT_PRICE, 0, 0, FD.REQUIREMENT_QTY)) /
                                SUM(DECODE(FD.UNIT_PRICE, 0, 0, FD.REQUIREMENT_QTY))
                           END UNIT_PRICE
                          ,CASE
                               WHEN MIN(NVL(FD.ORIGIN_RATE, 0)) = 0 THEN --역외산이 있을 경우
                                0
                               ELSE -- 전부 역내산일 경우
                                1
                           END AS ORIGIN_RATE
                          ,MAX(FD.HS_CODE_YN) AS HS_CODE_YN
                          ,FC00_STRING_AGG_OR(FD.PRICE_NOTE) AS PRICE_NOTE
                    FROM   (SELECT FBD.ITEM_CODE
                                  ,FM.FTA_CODE
                                  ,FM.SALES_NO
                                  ,FM.SALES_SEQ
                                  ,FM.PRODUCT_CODE
                                  ,FM.DIVISION_CODE
                                  ,FM.COMPANY_CODE
                                  ,NVL(IM.HS_CODE, NVL(FM.HS_CODE, ' ')) HS_CODE -- BOM HS코드가 없을경우 보수적으로 PRODUCT HS CODE 사용
                                  ,NVL(FC10_GET_ITEM_PRICE(FM.COMPANY_CODE,
                                                           FBD.FROM_DIVISION_CODE,
                                                           FBD.ITEM_CODE,
                                                           FM.FTA_CODE,
                                                           V_INVOICE_DATE
                                                           --TO_CHAR(LAST_DAY(TO_DATE(SD.BOM_YYYYMM, 'YYYYMM')), 'YYYYMMDD')
                                                           ),
                                       0) AS UNIT_PRICE
                                  ,FC10_GET_ITEM_ORIGIN_RATE(FM.COMPANY_CODE,
                                                             FBD.FROM_DIVISION_CODE,
                                                             FBD.ITEM_CODE,
                                                             FM.FTA_CODE,
                                                             V_INVOICE_DATE
                                                             --TO_CHAR(LAST_DAY(TO_DATE(SD.BOM_YYYYMM, 'YYYYMM')), 'YYYYMMDD')
                                                             ) AS ORIGIN_RATE
                                  ,FBD.REQ_QTY * UNIT_EXCHANGE_RATE AS REQUIREMENT_QTY
                                  ,DECODE(IM.HS_CODE, NULL, 'N', 'Y') HS_CODE_YN
                                  ,FC10_GET_ITEM_PRICE_NOTE(FM.COMPANY_CODE,
                                                            FBD.FROM_DIVISION_CODE,
                                                            FBD.ITEM_CODE,
                                                            FM.FTA_CODE,
                                                            V_INVOICE_DATE
                                                            --TO_CHAR(LAST_DAY(TO_DATE(SD.BOM_YYYYMM, 'YYYYMM')), 'YYYYMMDD')
                                                            ) AS PRICE_NOTE
                            FROM   (SELECT SD.SALES_NO
                                          ,SD.SALES_SEQ
                                          ,SD.PRODUCT_CODE
                                          ,SD.DIVISION_CODE
                                          ,SD.COMPANY_CODE
                                          ,SD.BOM_STATUS
                                          ,SD.BOM_YYYYMM
                                          ,SD.BOM_DIVISION_CODE
                                          ,TO_NUMBER(NVL(SD.ATTRIBUTE02, 1)) AS UNIT_EXCHANGE_RATE --동우 BOM 단위 환산율
                                    FROM   SALES_DTL SD
                                          ,SALES_MST SM
                                    WHERE  SD.SALES_NO = SM.SALES_NO
                                    AND    SD.DIVISION_CODE = SM.DIVISION_CODE
                                    AND    SD.COMPANY_CODE = SM.COMPANY_CODE
                                    AND    SD.SALES_NO = P_SALES_NO
                                    AND    SD.DIVISION_CODE = P_DIVISION_CODE
                                    AND    SD.COMPANY_CODE = P_COMPANY_CODE
                                    AND    SD.BOM_STATUS <> '1'
                                    AND    SD.DECISION_YN = 'Y'
                                    ) SD
                            INNER  JOIN FCR_MST FM
                            ON     SD.SALES_NO = FM.SALES_NO
                            AND    SD.SALES_SEQ = FM.SALES_SEQ
                            AND    SD.DIVISION_CODE = FM.DIVISION_CODE
                            AND    SD.COMPANY_CODE = FM.COMPANY_CODE
                            AND    SD.PRODUCT_CODE = FM.PRODUCT_CODE
                            INNER  JOIN FTA_BOM_DTL FBD
                            ON     FBD.PRODUCT_CODE = SD.PRODUCT_CODE
                            AND    FBD.DIVISION_CODE = SD.BOM_DIVISION_CODE
                            AND    FBD.COMPANY_CODE = SD.COMPANY_CODE
                            AND    FBD.YYYYMM = SD.BOM_YYYYMM
                            AND    FBD.ISLEAF_YN = 'Y'
                            INNER  JOIN ITEM_MST IM
                            ON     FBD.ITEM_CODE = IM.ITEM_CODE
                            AND    FBD.COMPANY_CODE = IM.COMPANY_CODE
                            AND    IM.DELETE_YN = 'N'
                            WHERE  FM.PRODUCT_ASSETS_TYPE IN ('P', 'H')
                            AND    FM.DECISION_YN = 'Y'
                            AND    FBD.TXN_TYPE = V_BOM_TYPE
                            AND    FBD.REQ_QTY >= 0
                            AND NOT EXISTS (
                                SELECT 1
                                  FROM EXCEPT_ITEM E
                                 WHERE FBD.ITEM_CODE = E.ITEM_CODE
                                   AND FM.FTA_CODE = E.FTA_CODE
                                   AND E.COMPANY_CODE = P_COMPANY_CODE
                            )
                            ) FD
                    GROUP  BY FD.ITEM_CODE
                             ,FD.FTA_CODE
                             ,FD.SALES_NO
                             ,FD.SALES_SEQ
                             ,FD.PRODUCT_CODE
                             ,FD.DIVISION_CODE
                             ,FD.COMPANY_CODE
                             ,FD.HS_CODE);

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-3. 제품 FCR_DTL 데이터 생성 건수 : ' ||
                                           SQL%ROWCOUNT);
        /***************************************************************
        /* 3-4. 상품 FCR_DTL 데이터 생성
         ****************************************************************/
        INSERT INTO FCR_DTL
            (ITEM_CODE
            ,FTA_CODE
            ,SALES_NO
            ,SALES_SEQ
            ,PRODUCT_CODE
            ,DIVISION_CODE
            ,COMPANY_CODE
            ,HS_CODE
            ,REQUIREMENT_QTY
            ,INPUT_AMOUNT
            ,INAREA_QTY
            ,INAREA_AMOUNT
            ,OUTAREA_QTY
            ,OUTAREA_AMOUNT
            ,HS_CODE_YN
            ,CREATE_DATE
            ,CREATE_BY
            ,UPDATE_DATE
            ,UPDATE_BY)
            SELECT PRODUCT_CODE AS ITEM_CODE
                  ,FTA_CODE
                  ,SALES_NO
                  ,SALES_SEQ
                  ,PRODUCT_CODE
                  ,DIVISION_CODE
                  ,COMPANY_CODE
                  ,HS_CODE
                  ,REQUIREMENT_QTY
                  ,INPUT_AMOUNT
                  ,DECODE(ORIGIN_RATE, 1, REQUIREMENT_QTY, 0) AS INAREA_QTY
                  ,DECODE(ORIGIN_RATE, 1, REQUIREMENT_QTY, 0) * INPUT_AMOUNT AS INAREA_AMOUNT
                  ,DECODE(ORIGIN_RATE, 1, 0, REQUIREMENT_QTY) AS OUTAREA_QTY
                  ,DECODE(ORIGIN_RATE, 1, 0, REQUIREMENT_QTY) * INPUT_AMOUNT AS OUTAREA_AMOUNT
                  ,HS_CODE_YN
                  ,SYSDATE CREATE_DATE
                  ,'CREATE_FCR' CREATE_BY
                  ,SYSDATE UPDATE_DATE
                  ,'CREATE_FCR' UPDATE_BY
            FROM   (SELECT FM.PRODUCT_CODE
                          ,FM.FTA_CODE
                          ,FM.SALES_NO
                          ,FM.SALES_SEQ
                          ,FM.DIVISION_CODE
                          ,FM.COMPANY_CODE
                          ,NVL(IM.HS_CODE, NVL(FM.HS_CODE, ' ')) AS HS_CODE
                          ,1 AS REQUIREMENT_QTY
                          ,SD.UNIT_PRICE AS INPUT_AMOUNT
                          ,CASE
                               WHEN SD.PRODUCT_ASSETS_TYPE = 'B' THEN --부산물
                                1
                               ELSE
                                FC10_GET_ITEM_ORIGIN_RATE(FM.COMPANY_CODE, SD.PROD_DIVISION_CODE, FM.PRODUCT_CODE, FM.FTA_CODE, V_INVOICE_DATE)
                           END AS ORIGIN_RATE
                          ,DECODE(FM.HS_CODE, NULL, 'N', 'Y') HS_CODE_YN
                    FROM   FCR_MST FM
                    INNER  JOIN SALES_DTL SD
                    ON     SD.SALES_NO = FM.SALES_NO
                    AND    SD.SALES_SEQ = FM.SALES_SEQ
                    AND    SD.DIVISION_CODE = FM.DIVISION_CODE
                    AND    SD.COMPANY_CODE = FM.COMPANY_CODE
                    INNER  JOIN SALES_MST SM
                    ON     SD.SALES_NO = SM.SALES_NO
                    AND    SD.DIVISION_CODE = SM.DIVISION_CODE
                    AND    SD.COMPANY_CODE = SM.COMPANY_CODE
                    INNER  JOIN ITEM_MST IM
                    ON     SD.PRODUCT_CODE = IM.ITEM_CODE
                    AND    SD.COMPANY_CODE = IM.COMPANY_CODE
                    WHERE  SD.SALES_NO = P_SALES_NO
                    AND    SD.DIVISION_CODE = P_DIVISION_CODE
                    AND    SD.COMPANY_CODE = P_COMPANY_CODE
                    AND    SD.PRODUCT_ASSETS_TYPE IN ('M', 'R', 'B')
                    AND    SD.DECISION_YN = 'Y');

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-4. 상품 FCR_DTL 데이터 생성' ||
                                           '건수 : ' || SQL%ROWCOUNT);
        /***************************************************************
        /* 3-5. FCR MST UPDATE -- 상품 원산지 판정
         ****************************************************************/
        MERGE INTO FCR_MST FM
        USING (SELECT FM.FTA_CODE
                     ,FM.SALES_NO
                     ,FM.SALES_SEQ
                     ,FM.DIVISION_CODE
                     ,FM.COMPANY_CODE
                     ,(SELECT /*+ INDEX_DESC(PL PO_LEDGER_IDX2) */
                        ECD.RULE_CODE
                       FROM   PO_LEDGER PL
                       INNER  JOIN EXT_COO_CERTIFY_MST ECM
                       ON     ECM.COMPANY_CODE = PL.COMPANY_CODE
                             --AND    ECM.DIVISION_CODE = PL.DIVISION_CODE -- 만도는 PLANT 별로
                       AND    ECM.VENDOR_CODE = PL.VENDOR_CODE
                       AND    ECM.SUBMIT_STATUS = '4'
                       AND    ((ECM.COO_CERTIFY_TYPE = 'C' AND
                             PL.WAREHOUSING_DATE BETWEEN ECM.APPLY_DATE AND
                             ECM.END_DATE) OR
                             (ECM.COO_CERTIFY_TYPE = 'N' AND
                             PL.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO))
                       /* 2023.07.20 USEO
                        * HS코드변경시, 오래전에 제출된 확인서의 결정기준을 불러오는경우가 있어 아우터조인으로 변경
                       INNER  JOIN EXT_COO_CERTIFY_DTL ECD
                       ON     ECD.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO
                       AND    ECD.VENDOR_CODE = ECM.VENDOR_CODE
                       AND    ECD.DIVISION_CODE = ECM.DIVISION_CODE
                       AND    ECD.COMPANY_CODE = ECM.COMPANY_CODE
                       AND    ECD.ITEM_CODE = PL.ITEM_CODE
                        * 변경 시작 */
                       LEFT OUTER  JOIN EXT_COO_CERTIFY_DTL ECD
                       ON     ECD.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO
                       AND    ECD.VENDOR_CODE = ECM.VENDOR_CODE
                       AND    ECD.DIVISION_CODE = ECM.DIVISION_CODE
                       AND    ECD.COMPANY_CODE = ECM.COMPANY_CODE
                       AND    ECD.ITEM_CODE = PL.ITEM_CODE
                       AND    V_INVOICE_DATE BETWEEN ECD.APPLY_DATE AND ECD.END_DATE
                       /* 변경 끝 */
                       WHERE  PL.COMPANY_CODE = P_COMPANY_CODE
                       AND    PL.ITEM_CODE =
                              NVL(IM.ITEM_CODE_ANOTHER, FM.PRODUCT_CODE)
                       AND    ECD.FTA_CODE = FM.FTA_CODE
                             --AND    PL.WAREHOUSING_DATE LIKE SUBSTR(V_INVOICE_DATE, 1, 6) || '%'
                       AND    ROWNUM = 1) AS VENDOR_RULE_CONTENTS
                     ,(SELECT RULE_CONTENTS
                       FROM   FTA_RULE FR
                       WHERE  FR.HS_CODE =
                              SUBSTR(FM.HS_CODE, 1, LENGTH(FR.HS_CODE))
                       AND    FR.FTA_CODE = FM.FTA_CODE
                       AND    HS_CODE_SUB_CATEGORY = 1
                       AND    ROWNUM = 1) AS RULE_CONTENTS
                     ,DECODE(FD.OUTAREA_QTY, 0, 'Y', 'N') COO_YN
               FROM   FCR_MST FM
               INNER  JOIN FCR_DTL FD
               ON     FD.FTA_CODE = FM.FTA_CODE
               AND    FD.SALES_NO = FM.SALES_NO
               AND    FD.SALES_SEQ = FM.SALES_SEQ
               AND    FD.DIVISION_CODE = FM.DIVISION_CODE
               AND    FD.COMPANY_CODE = FM.COMPANY_CODE
               INNER  JOIN ITEM_MST IM
               ON     IM.ITEM_CODE = FM.PRODUCT_CODE
               AND    IM.COMPANY_CODE = FM.COMPANY_CODE
               WHERE  FM.PRODUCT_ASSETS_TYPE IN ('M', 'R', 'B')
               AND    FM.SALES_NO = P_SALES_NO
               AND    FM.DIVISION_CODE = P_DIVISION_CODE
               AND    FM.COMPANY_CODE = P_COMPANY_CODE) SUB
        ON (FM.FTA_CODE = SUB.FTA_CODE AND FM.SALES_NO = SUB.SALES_NO AND FM.SALES_SEQ = SUB.SALES_SEQ AND FM.DIVISION_CODE = SUB.DIVISION_CODE AND FM.COMPANY_CODE = SUB.COMPANY_CODE)
        WHEN MATCHED THEN
            UPDATE
            SET    FM.FTA_COO_YN     = SUB.COO_YN
                  ,FM.COMPANY_COO_YN = SUB.COO_YN
                  ,FM.RULE_CONTENTS  = NVL(SUB.VENDOR_RULE_CONTENTS, SUB.RULE_CONTENTS);
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-5. 상품 원산지 판정 -- FCR MST UPDATE' ||
                                           '건수 : ' || SQL%ROWCOUNT);
        /***************************************************************
        /* 3-6. FCR RESULT UPDATE -- 상품 원산지 판정
         ****************************************************************/
        INSERT INTO FCR_RESULT
            (SEQ
            ,SALES_NO
            ,SALES_SEQ
            ,FTA_CODE
            ,DIVISION_CODE
            ,COMPANY_CODE
            ,HS_CODE
            ,PRODUCT_CODE
            ,STANDARD
            ,RULE_SEQ
            ,RULE_CODE
            ,FTA_COO_YN
            ,COMPANY_COO_YN
            ,BUFFER_OPTION
            ,DE_MINIMIS_RATE
            ,RVC_RATE
            ,CTC_YN
            ,COMPANY_RVC_YN
            ,STATUS
            ,ERROR_CODE
            ,ERROR_MSG
            ,DELETE_YN
            ,CREATE_DATE
            ,CREATE_BY
            ,UPDATE_DATE
            ,UPDATE_BY)
            SELECT 1 SEQ
                  ,FM.SALES_NO
                  ,FM.SALES_SEQ
                  ,FM.FTA_CODE
                  ,FM.DIVISION_CODE
                  ,FM.COMPANY_CODE
                  ,FM.HS_CODE
                  ,FM.PRODUCT_CODE
                  ,FM.STANDARD
                  ,'-1' AS RULE_SEQ
                  ,FM.RULE_CONTENTS AS RULE_CODE
                  ,FM.FTA_COO_YN
                  ,FM.COMPANY_COO_YN
                  ,NULL BUFFER_OPTION
                  ,NULL DE_MINIMIS_RATE
                  ,NULL RVC_RATE
                  /*2016.04.14 : 상품판정의 경우 소명서 상의 세번변경 충족여부 체크 추가[소명서 항목 16번 ] */
                  ,CASE WHEN (SELECT COUNT(1)
                                FROM FTA_RULE X
                               WHERE X.HS_CODE IN (SUBSTR(FM.HS_CODE,1,2),SUBSTR(FM.HS_CODE,1,4),FM.HS_CODE)
                                 AND X.FTA_CODE = FM.FTA_CODE
                                 AND X.CTH_RULE IS NOT NULL) > 0 AND FM.COMPANY_COO_YN = 'Y' THEN 'Y'
                        ELSE 'N'
                    END AS CTC_YN
                   /*2016.04.14 : 상품판정의 경우 소명서 상의 부가가치기준 충족여부 체크 추가
                                  세번변경으로 판정된 경우 부가가치 기준은 미충족으로 함
                                  세번+부가가치 조합 기준인 경우 부가가치 기준에 대한 부분도 체크
                                  [소명서 항목 17번] */
                   ,CASE WHEN (SELECT COUNT(1) FROM FTA_RULE X WHERE X.HS_CODE IN (SUBSTR(FM.HS_CODE,1,2),SUBSTR(FM.HS_CODE,1,4),FM.HS_CODE) AND X.FTA_CODE = FM.FTA_CODE
                                AND (X.BD_RULE IS NOT NULL OR X.BU_RULE IS NOT NULL OR X.NC_RULE IS NOT NULL OR X.MC_RULE IS NOT NULL)
                              ) > 0
                              AND FM.COMPANY_COO_YN = 'Y'
                              AND INSTR(FM.RULE_CONTENTS, '+', 1,1) > 0 THEN 'Y'
                        ELSE 'N'
                     END AS COMPANY_RVC_YN
                  ,'N' STATUS
                  ,NULL ERROR_CODE
                  ,NULL ERROR_MSG
                  ,'N' DELETE_YN
                  ,SYSDATE CREATE_DATE
                  ,'CREATE_FCR' CREATE_BY
                  ,SYSDATE UPDATE_DATE
                  ,'CREATE_FCR' UPDATE_BY
            FROM   FCR_MST FM
            INNER  JOIN SALES_DTL SD
            ON     SD.SALES_NO = FM.SALES_NO
            AND    SD.SALES_SEQ = FM.SALES_SEQ
            AND    SD.DIVISION_CODE = FM.DIVISION_CODE
            AND    SD.COMPANY_CODE = FM.COMPANY_CODE
            WHERE  SD.SALES_NO = P_SALES_NO
            AND    SD.DIVISION_CODE = P_DIVISION_CODE
            AND    SD.COMPANY_CODE = P_COMPANY_CODE
            AND    SD.PRODUCT_ASSETS_TYPE IN ('M', 'R', 'B')
            AND    SD.DECISION_YN = 'Y'
            --AND   (SD.STATUS IS NULL OR SD.STATUS NOT IN('4', '5'))
            ;
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-6. 상품 원산지 판정 -- FCR RESULT UPDATE ' ||
                                           '건수 : ' || SQL%ROWCOUNT);
        /***************************************************************
        /* 3-7. FCR_MST의 역내산재료비금액 / 역외산재료비금액 UPDATE
         ****************************************************************/
        MERGE INTO FCR_MST FM
        USING (SELECT FCM.FTA_CODE
                     ,FCM.SALES_NO
                     ,FCM.SALES_SEQ
                     ,FCM.DIVISION_CODE
                     ,FCM.COMPANY_CODE
                     ,SUM(FCD.INAREA_AMOUNT) AS INAREA_AMOUNT
                     ,SUM(FCD.OUTAREA_AMOUNT) AS OUTAREA_AMOUNT
               FROM   FCR_MST FCM
               INNER  JOIN FCR_DTL FCD
               ON     FCM.FTA_CODE = FCD.FTA_CODE
               AND    FCM.SALES_NO = FCD.SALES_NO
               AND    FCM.SALES_SEQ = FCD.SALES_SEQ
               AND    FCM.DIVISION_CODE = FCD.DIVISION_CODE
               AND    FCM.COMPANY_CODE = FCD.COMPANY_CODE
               WHERE  FCM.SALES_NO = P_SALES_NO
               AND    FCM.DIVISION_CODE = P_DIVISION_CODE
               AND    FCM.COMPANY_CODE = P_COMPANY_CODE
               AND    FCM.DECISION_YN = 'Y'
               GROUP  BY FCM.FTA_CODE
                        ,FCM.SALES_NO
                        ,FCM.SALES_SEQ
                        ,FCM.DIVISION_CODE
                        ,FCM.COMPANY_CODE) FMD
        ON (FM.FTA_CODE = FMD.FTA_CODE AND FM.SALES_NO = FMD.SALES_NO AND FM.SALES_SEQ = FMD.SALES_SEQ AND FM.DIVISION_CODE = FMD.DIVISION_CODE AND FM.COMPANY_CODE = FMD.COMPANY_CODE)
        WHEN MATCHED THEN
            UPDATE
            SET    FM.INAREA_AMOUNT  = FMD.INAREA_AMOUNT
                  ,FM.OUTAREA_AMOUNT = FMD.OUTAREA_AMOUNT;

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '3-7. FCR_MST의 역내산재료비금액 / 역외산재료비금액 UPDATE' ||
                                           '건수 : ' || SQL%ROWCOUNT);

        IF V_ERR_CNT > 0 AND
           V_VIRTUAL_YN = 'Y' THEN
            V_ERR_CODE := 'semisuccess';
        END IF;

    ELSE
        V_ERR_CODE := 'failed';
    END IF;

    P_ERR_CODE := V_ERR_CODE;

    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(V_LOG_ID, '***** END CREATE_FCR');
    PKG00_PROCEDURE_LOG.BATCH_LOG_LAST(V_LOG_ID, 'N');

END CREATE_FCR;

 
