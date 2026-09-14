CREATE OR REPLACE FUNCTION FC10_GET_ITEM_ORIGIN_RATE(P_COMPANY_CODE  MATERIAL_INV_BAL.COMPANY_CODE%TYPE
                                                    ,P_DIVISION_CODE MATERIAL_INV_BAL.DIVISION_CODE%TYPE
                                                    ,P_ITEM_CODE     MATERIAL_INV_BAL.ITEM_CODE%TYPE
                                                    ,P_FTA_CODE      IN VARCHAR2
                                                    ,P_YYYYMMDD      VARCHAR2 DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD'))
    RETURN NUMBER DETERMINISTIC AS

    /******************************************************************************/
    /* Project      : FTA PROJECT (K-ORIGIN)                                      */
    /* Module       : FC10_GET_ITEM_ORIGIN_RATE                                   */
    /* Program Name : FC10_GET_ITEM_ORIGIN_RATE                                   */
    /* Description  : 원재료 역내산 비율  조회                                    */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /* 2012/05/04  Lee Doo hwan  Initial Version                                 */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/
    V_ORIGIN_RATE NUMBER := 0;
    V_MAX_MONTHS  NUMBER := 6;
    V_PO_COUNT    NUMBER := 0;
    V_MTM_COUNT   NUMBER := 0;

    --    V_MAT_YYYYMM       MATERIAL_INV_BAL.YYYYMM%TYPE;
    --    V_MAT_INITIAL_QTY  MATERIAL_INV_BAL.INITIAL_QTY%TYPE;
    --    V_MAT_INPUT_QTY    MATERIAL_INV_BAL.INPUT_QTY%TYPE;
    --    V_MAT_AGING_PERIOD MATERIAL_INV_BAL.AGING_PERIOD%TYPE;

    V_START_YYYYMMDD         VARCHAR2(8) := NULL;
    V_END_YYYYMMDD           VARCHAR2(8) := NULL;
    V_WAREHOUSING_AMOUNT_SUM NUMBER;

    V_LAST_YYYYMM            VARCHAR2(6) := NULL;

    CURSOR C_MAT IS

    -- BOM상 원재료의 수불부 기본 정보 조회
        SELECT ML.ITEM_CODE
              ,ML.YYYYMM AS MAT_YYYYMM
              ,ML.INITIAL_QTY AS MAT_INITIAL_QTY
              ,ML.INPUT_QTY + ML.EXTRA_INPUT_QTY AS MAT_INPUT_QTY
              ,ML.AGING_PERIOD AS MAT_AGING_PERIOD
              ,'BOM' AS MAT_ITEM_TYPE
        FROM   MATERIAL_INV_BAL ML
        WHERE  ML.YYYYMM =
               (SELECT MAX(ML2.YYYYMM)
                FROM   MATERIAL_INV_BAL ML2
                WHERE  ML2.YYYYMM BETWEEN
                       TO_CHAR(ADD_MONTHS(TO_DATE(P_YYYYMMDD, 'YYYYMMDD'), V_MAX_MONTHS * -1), 'YYYYMM') AND
                       SUBSTR(P_YYYYMMDD, 1, 6)
                AND    ML2.ITEM_CODE = ML.ITEM_CODE
                AND    ML2.DIVISION_CODE = ML.DIVISION_CODE
                AND    ML2.COMPANY_CODE = ML.COMPANY_CODE
                AND    (ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY) > 0)
        AND    ML.ITEM_CODE = P_ITEM_CODE
        AND    ML.DIVISION_CODE = P_DIVISION_CODE
        AND    ML.COMPANY_CODE = P_COMPANY_CODE
        UNION ALL
        -- 대체자재의 수불부 기본정보 조회
        SELECT DISTINCT ML.ITEM_CODE
                       ,ML.YYYYMM AS MAT_YYYYMM
                       ,ML.INITIAL_QTY AS MAT_INITIAL_QTY
                       ,ML.INPUT_QTY + ML.EXTRA_INPUT_QTY AS MAT_INPUT_QTY
                       ,ML.AGING_PERIOD AS MAT_AGING_PERIOD
                       ,'FUNGIBLE' AS MAT_ITEM_TYPE
        FROM   FUNGIBLE_MATERIALS FM
        INNER  JOIN MATERIAL_INV_BAL ML
        ON     ML.ITEM_CODE =
               DECODE(FM.ITEM_CODE, P_ITEM_CODE, FM.FUNGIBLE_ITEM_CODE, FM.ITEM_CODE)
        AND    ML.DIVISION_CODE = FM.DIVISION_CODE
        AND    ML.COMPANY_CODE = FM.COMPANY_CODE
        AND    ML.YYYYMM =
               (SELECT MAX(ML2.YYYYMM)
                 FROM   MATERIAL_INV_BAL ML2
                 WHERE  ML2.YYYYMM BETWEEN
                        TO_CHAR(ADD_MONTHS(TO_DATE(P_YYYYMMDD, 'YYYYMMDD'), V_MAX_MONTHS * -1), 'YYYYMM') AND
                        SUBSTR(P_YYYYMMDD, 1, 6)
                 AND    ML2.ITEM_CODE = ML.ITEM_CODE
                 AND    ML2.DIVISION_CODE = ML.DIVISION_CODE
                 AND    ML2.COMPANY_CODE = ML.COMPANY_CODE
                 AND    (ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY) > 0)
        WHERE  (FM.ITEM_CODE = P_ITEM_CODE OR
               FM.FUNGIBLE_ITEM_CODE = P_ITEM_CODE)
        AND    FM.DIVISION_CODE = P_DIVISION_CODE
        AND    FM.COMPANY_CODE = P_COMPANY_CODE
        AND    FM.DELETE_YN = 'N';

BEGIN

    FOR MAT_REC IN C_MAT
    LOOP

        V_START_YYYYMMDD := NULL;
        V_END_YYYYMMDD   := NULL;
        V_PO_COUNT       := 0;
        V_MTM_COUNT      := 0;

        -- 참조할 수불부가 있을 경우
        IF MAT_REC.MAT_YYYYMM IS NOT NULL THEN

          SELECT MAX(ML.YYYYMM)
            INTO V_LAST_YYYYMM
            FROM MATERIAL_INV_BAL ML
           WHERE ML.YYYYMM <= SUBSTR(P_YYYYMMDD,1,6)
             AND ML.ITEM_CODE = P_ITEM_CODE
             AND ML.DIVISION_CODE = P_DIVISION_CODE
             AND ML.COMPANY_CODE = P_COMPANY_CODE
             AND ML.INPUT_QTY > 0;

            -- 기초 금액이 0 이상을 경우
            --기초 원재료 역내산 비율(구매원장,원산지확인서)을 조회 하기 위한 조회 시작일자를 SETTING 한다.
            IF MAT_REC.MAT_INITIAL_QTY > 0 THEN

                -- 재고 회전 기간이 0 이하일 경우 계산 불능 ==> 역내산 0% RETURN
                IF MAT_REC.MAT_AGING_PERIOD < 0 THEN
                    RETURN 0; --역외 리턴

                    -- 재고 회전 기간이 0 이상일 경우 조회 시작일을 -(재고 회전월+1) 만큼 잡는다
                ELSE
                    V_START_YYYYMMDD := TO_CHAR(ADD_MONTHS(TO_DATE(MAT_REC.MAT_YYYYMM || '01', 'YYYYMMDD'), (MAT_REC.MAT_AGING_PERIOD + 1) * -1), 'YYYYMMDD');
                END IF;

            END IF;

            -- 당월 구매입고 수량이 있을 경우
            --당월 입고 분의 역내산 비율(구매원장,원산지확인서)을 조회 하기 위한 조회 종료일자를 SETTING 한다
            IF MAT_REC.MAT_INPUT_QTY > 0 THEN

                -- 시작일자가 없을경우 즉 기초 재고가 없을 경우 시작일자 = 수불부상의 최근 출고월
                IF V_START_YYYYMMDD IS NULL THEN
                    V_START_YYYYMMDD := TO_CHAR(TO_DATE(MAT_REC.MAT_YYYYMM, 'YYYYMM'), 'YYYYMMDD');
                END IF;

                -- 종료 일자 = 수불부상의 최근 출고월
                V_END_YYYYMMDD := TO_CHAR(LAST_DAY(TO_DATE(MAT_REC.MAT_YYYYMM, 'YYYYMM')), 'YYYYMMDD');

                --당월 입고는 없지만 기초재고가 있을 경우 즉 기초재고로 생산 출고가 일어난 CASE
                -- 조회 종료일자 = 수불부상의 최근 출고 전월
            ELSIF MAT_REC.MAT_INITIAL_QTY > 0 THEN
                V_END_YYYYMMDD := TO_CHAR(TO_DATE(MAT_REC.MAT_YYYYMM || '01', 'YYYYMMDD') - 1, 'YYYYMMDD');
                -- 수불부가 비정상적으로 생성이 되어 기초재고, 입고, 기말재고가 정확하지 않은 상태로 재고회전이 계산되어짐.
                -- 해당문제로 인해 시작일과 종료일을 계산하지 못하여 마지막에 재고회전기간에 따른 시작일 종료일 계산로직을 추가함. 20150826
            ELSIF MAT_REC.MAT_AGING_PERIOD > 0 THEN

                V_START_YYYYMMDD := TO_CHAR(ADD_MONTHS(TO_DATE(MAT_REC.MAT_YYYYMM || '01', 'YYYYMMDD'), (MAT_REC.MAT_AGING_PERIOD + 1) * -1), 'YYYYMMDD');
                V_END_YYYYMMDD := TO_CHAR(TO_DATE(MAT_REC.MAT_YYYYMM || '01', 'YYYYMMDD') - 1, 'YYYYMMDD');
            END IF;
       
        END IF;

        -- 조회 시작일자 와 조회 종료일자가 있을 경우 즉 기초재고와 당월 입고건이 있을 경우
        IF V_START_YYYYMMDD IS NOT NULL AND
           V_END_YYYYMMDD IS NOT NULL THEN

            -- MTM이 있을 경우 MTM 수만큼 재수행
            /*
            IF MAT_REC.MAT_ITEM_TYPE = 'BOM' THEN
                SELECT COUNT(*)
                INTO   V_MTM_COUNT
                FROM   MANUFACT_TRANS_INFO MTI
                WHERE  MTI.YYYYMM BETWEEN SUBSTR(V_START_YYYYMMDD, 1, 6) AND
                       SUBSTR(V_END_YYYYMMDD, 1, 6)
                AND    MTI.FROM_ITEM_CODE <> MTI.TO_ITEM_CODE
                AND    MTI.TO_ITEM_CODE = MAT_REC.ITEM_CODE
                AND    MTI.COMPANY_CODE = P_COMPANY_CODE
                AND    MTI.TO_DIVISION_CODE = P_DIVISION_CODE;

            END IF;
            */
            /*
            IF MAT_REC.MAT_ITEM_TYPE = 'BOM' AND
               V_MTM_COUNT > 0 THEN
                SELECT COUNT(*)
                      ,NVL(SUM(PL.WAREHOUSING_AMOUNT), 0)
                INTO   V_PO_COUNT
                      ,V_WAREHOUSING_AMOUNT_SUM
                FROM   PO_LEDGER PL
                INNER  JOIN (SELECT MIB.ITEM_CODE AS TRANS_ITEM_CODE
                                   ,LEAST(MIN(TO_CHAR(ADD_MONTHS(TO_DATE(MIB.YYYYMM || '01', 'YYYYMMDD'), (MIB.AGING_PERIOD + 1) * -1), 'YYYYMMDD')), V_START_YYYYMMDD) AS TRANS_FROM_DATE
                             FROM   MANUFACT_TRANS_INFO MTI
                             INNER  JOIN MATERIAL_INV_BAL MIB
                             ON     MIB.YYYYMM = MTI.YYYYMM
                             AND    MIB.ITEM_CODE = MTI.FROM_ITEM_CODE
                             AND    MIB.DIVISION_CODE = MTI.FROM_DIVISION_CODE
                             AND    MIB.COMPANY_CODE = MTI.COMPANY_CODE
                             WHERE  MTI.YYYYMM BETWEEN
                                    SUBSTR(V_START_YYYYMMDD, 1, 6) AND
                                    SUBSTR(V_END_YYYYMMDD, 1, 6)
                             AND    MTI.TO_DIVISION_CODE = P_DIVISION_CODE
                             AND    MTI.TO_ITEM_CODE = P_ITEM_CODE
                             AND    MTI.COMPANY_CODE = P_COMPANY_CODE
                             GROUP  BY MIB.ITEM_CODE) MIB
                ON     1 = 1
                AND    (PL.ITEM_CODE = MAT_REC.ITEM_CODE OR
                      PL.ITEM_CODE = MIB.TRANS_ITEM_CODE)
                      --x AND    PL.DIVISION_CODE = P_DIVISION_CODE --공장간 이체적용을위해 뺌
                AND    PL.COMPANY_CODE = P_COMPANY_CODE
                AND    PL.WAREHOUSING_DATE BETWEEN MIB.TRANS_FROM_DATE AND
                       V_END_YYYYMMDD;

            ELSE
              */
            SELECT COUNT(*)
                  ,NVL(SUM(PL.WAREHOUSING_AMOUNT), 0)
            INTO   V_PO_COUNT
                  ,V_WAREHOUSING_AMOUNT_SUM
            FROM   PO_LEDGER PL
            WHERE  PL.ITEM_CODE = MAT_REC.ITEM_CODE
                  --x AND    PL.DIVISION_CODE = P_DIVISION_CODE --공장간 이체적용을위해 뺌
            AND    PL.COMPANY_CODE = P_COMPANY_CODE
            AND    PL.WAREHOUSING_DATE BETWEEN (CASE WHEN V_LAST_YYYYMM||'01' < V_START_YYYYMMDD THEN V_LAST_YYYYMM||'01' ELSE V_START_YYYYMMDD END) AND
                   V_END_YYYYMMDD;

            --END IF;
            /*
            DBMS_OUTPUT.PUT_LINE(MAT_REC.MAT_AGING_PERIOD);
            DBMS_OUTPUT.PUT_LINE(V_PO_COUNT);
            DBMS_OUTPUT.PUT_LINE(V_MTM_COUNT);
            DBMS_OUTPUT.PUT_LINE(V_START_YYYYMMDD);
            DBMS_OUTPUT.PUT_LINE(V_END_YYYYMMDD);
            DBMS_OUTPUT.PUT_LINE(V_MTM_COUNT);
            DBMS_OUTPUT.PUT_LINE(MAT_REC.ITEM_CODE);
            DBMS_OUTPUT.PUT_LINE('V_WAREHOUSING_AMOUNT_SUM : ' ||
                                 V_WAREHOUSING_AMOUNT_SUM);
            */
            IF V_PO_COUNT = 0 THEN
                RETURN 0;
            END IF;

            BEGIN
                -- MTM이 없을경우.
                --IF V_MTM_COUNT = 0 THEN

                SELECT CASE
                           WHEN FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'ME') = 'IA' THEN

                            CASE
                                WHEN NVL(SUM(WAREHOUSING_AMOUNT), 0) = 0 OR
                                     V_WAREHOUSING_AMOUNT_SUM = 0 THEN
                                 1 -- 역외산이 없으면 전체 역내산
                                ELSE
                                 1 - ROUND(SUM(WAREHOUSING_AMOUNT) /
                                           V_WAREHOUSING_AMOUNT_SUM, 2)
                            END
                           ELSE
                            DECODE(COUNT(*), 0, 1, 0)
                       END AS ORIGIN_RATE
                INTO   V_ORIGIN_RATE
                FROM   PO_LEDGER PL
                LEFT   OUTER JOIN COO_DIVISION_V D
                ON     D.DIVISION_CODE = PL.DIVISION_CODE
                AND    D.COMPANY_CODE = PL.COMPANY_CODE
                -- 역외산 또는 확인서 미수취건이 존재하는지..
                WHERE  NOT EXISTS
                 (SELECT 1
                        FROM   EXT_COO_CERTIFY_MST ECM
                        INNER  JOIN EXT_COO_CERTIFY_DTL ECD
                        ON     ECD.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO
                        AND    ECD.COMPANY_CODE = ECM.COMPANY_CODE
                        AND    ECD.DIVISION_CODE = ECM.DIVISION_CODE
                        AND    ECD.VENDOR_CODE = ECM.VENDOR_CODE
                        AND    ECD.FTA_CODE = P_FTA_CODE
                        AND    ECD.COO_YN = 'Y'
                        WHERE  ECM.SUBMIT_STATUS = '4'
                        AND    ECM.VENDOR_CODE = PL.VENDOR_CODE
                        AND    ECM.COMPANY_CODE = PL.COMPANY_CODE
                        AND    ECM.DIVISION_CODE = CASE
                               --증명서 일경우 구매 DIVISION과 확인서 DIVISION 일치
                                   WHEN ECM.DOCUMENT_TYPE = 'F' THEN
                                    PL.DIVISION_CODE
                               --확인서 이고  확인서 전사 적용 일경우
                                   WHEN ECM.DOCUMENT_TYPE = 'D' AND
                                        ECM.APPLY_TYPE = 'A' THEN
                                    ECM.DIVISION_CODE
                               --확인서 이고  확인서가 수취 PLANT별로 적용할 경우
                                   WHEN ECM.DOCUMENT_TYPE = 'D' AND
                                        ECM.APPLY_TYPE = 'M' THEN
                                    D.COO_RECEIPT_DIVISION_CODE
                               END
                        AND    ((ECM.COO_CERTIFY_TYPE = 'C' AND
                              PL.WAREHOUSING_DATE BETWEEN ECD.APPLY_DATE AND
                              ECD.END_DATE) OR
                              (ECM.COO_CERTIFY_TYPE = 'N' AND
                              PL.WAREHOUSING_NO = ECD.WAREHOUSING_NO AND
                              PL.SEQ = ECD.WAREHOUSING_SEQ))
                        AND    ECD.ITEM_CODE = PL.ITEM_CODE)
                AND    PL.ITEM_CODE = MAT_REC.ITEM_CODE
                      --x AND    PL.DIVISION_CODE = P_DIVISION_CODE --공장간 이체적용을위해 뺌
                AND    PL.COMPANY_CODE = P_COMPANY_CODE
                AND    PL.WAREHOUSING_DATE BETWEEN (CASE WHEN V_LAST_YYYYMM||'01' < V_START_YYYYMMDD THEN V_LAST_YYYYMM||'01' ELSE V_START_YYYYMMDD END) AND
                       V_END_YYYYMMDD;

                -- MTM이 있을경우
                /*               ELSE

                    SELECT CASE
                               WHEN FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'ME') = 'IA' THEN
                                1 - ROUND(COUNT(*) / V_PO_COUNT, 2)
                               ELSE
                                DECODE(COUNT(*), 0, 1, 0)
                           END AS ORIGIN_RATE
                    INTO   V_ORIGIN_RATE
                    FROM   PO_LEDGER PL
                    INNER  JOIN (SELECT MIB.ITEM_CODE AS TRANS_ITEM_CODE
                                       ,LEAST(MIN(TO_CHAR(ADD_MONTHS(TO_DATE(MIB.YYYYMM || '01', 'YYYYMMDD'), (MIB.AGING_PERIOD + 1) * -1), 'YYYYMMDD')), V_START_YYYYMMDD) AS TRANS_FROM_DATE
                                 FROM   MANUFACT_TRANS_INFO MTI
                                 INNER  JOIN MATERIAL_INV_BAL MIB
                                 ON     MIB.YYYYMM = MTI.YYYYMM
                                 AND    MIB.ITEM_CODE = MTI.FROM_ITEM_CODE
                                 AND    MIB.DIVISION_CODE =
                                        MTI.FROM_DIVISION_CODE
                                 AND    MIB.COMPANY_CODE = MTI.COMPANY_CODE
                                 WHERE  MTI.YYYYMM BETWEEN
                                        SUBSTR(V_START_YYYYMMDD, 1, 6) AND
                                        SUBSTR(V_END_YYYYMMDD, 1, 6)
                                 AND    MTI.TO_DIVISION_CODE = P_DIVISION_CODE
                                 AND    MTI.TO_ITEM_CODE = P_ITEM_CODE
                                 AND    MTI.COMPANY_CODE = P_COMPANY_CODE
                                 GROUP  BY MIB.ITEM_CODE) MIB
                    ON     1 = 1
                    LEFT   OUTER JOIN COO_DIVISION_V D
                    ON     D.DIVISION_CODE = PL.DIVISION_CODE
                    AND    D.COMPANY_CODE = PL.COMPANY_CODE
                    -- 역외산 또는 확인서 미수취건이 존재하는지..
                    WHERE  NOT EXISTS
                     (SELECT 1
                            FROM   EXT_COO_CERTIFY_MST ECM
                            INNER  JOIN EXT_COO_CERTIFY_DTL ECD
                            ON     ECD.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO
                            AND    ECD.COMPANY_CODE = ECM.COMPANY_CODE
                            AND    ECD.DIVISION_CODE = ECM.DIVISION_CODE
                            AND    ECM.VENDOR_CODE = ECD.VENDOR_CODE
                            AND    ECM.SUBMIT_STATUS = '4'
                            AND    ECD.FTA_CODE = P_FTA_CODE
                            AND    ECD.COO_YN = 'Y'
                            WHERE  ECM.VENDOR_CODE = PL.VENDOR_CODE
                            AND    ECM.COMPANY_CODE = PL.COMPANY_CODE
                            AND    ECM.DIVISION_CODE = CASE
                                   --증명서 일경우 구매 DIVISION과 확인서 DIVISION 일치
                                       WHEN ECM.DOCUMENT_TYPE = 'F' THEN
                                        PL.DIVISION_CODE
                                   --확인서 이고  확인서 전사 적용 일경우
                                       WHEN ECM.DOCUMENT_TYPE = 'D' AND
                                            ECM.APPLY_TYPE = 'A' THEN
                                        ECM.DIVISION_CODE
                                   --확인서 이고  확인서가 수취 PLANT별로 적용할 경우
                                       WHEN ECM.DOCUMENT_TYPE = 'D' AND
                                            ECM.APPLY_TYPE = 'M' THEN
                                        D.COO_RECEIPT_DIVISION_CODE
                                   END
                            AND    ((ECM.COO_CERTIFY_TYPE = 'C' AND
                                  PL.WAREHOUSING_DATE BETWEEN ECD.APPLY_DATE AND
                                  ECD.END_DATE) OR
                                  (ECM.COO_CERTIFY_TYPE = 'N' AND
                                  PL.WAREHOUSING_NO = ECD.WAREHOUSING_NO AND
                                  PL.SEQ = ECD.WAREHOUSING_SEQ))
                            AND    ECD.ITEM_CODE = PL.ITEM_CODE)
                    AND    (PL.ITEM_CODE = MAT_REC.ITEM_CODE OR
                          PL.ITEM_CODE = MIB.TRANS_ITEM_CODE)
                          --x AND    PL.DIVISION_CODE = P_DIVISION_CODE --공장간 이체적용을위해 뺌
                    AND    PL.COMPANY_CODE = P_COMPANY_CODE
                    AND    PL.WAREHOUSING_DATE BETWEEN TRANS_FROM_DATE AND
                           V_END_YYYYMMDD;

                END IF;*/
                DBMS_OUTPUT.PUT_LINE('V_ORIGIN_RATE : ' || V_ORIGIN_RATE);
                IF V_ORIGIN_RATE = 0 THEN
                    RETURN 0; --역외 리
                END IF;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RETURN 0; --역외 리턴
            END;
        END IF;

    END LOOP;

    RETURN V_ORIGIN_RATE;
    --END;

EXCEPTION
    WHEN OTHERS THEN
        --DBMS_OUTPUT.PUT_LINE('오류');
        RETURN 0;

END FC10_GET_ITEM_ORIGIN_RATE;

 
