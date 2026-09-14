CREATE OR REPLACE FUNCTION "FC01_GET_ITEM_NATION"(P_COMPANY_CODE  MATERIAL_INV_BAL.COMPANY_CODE%TYPE
                                                    ,P_DIVISION_CODE MATERIAL_INV_BAL.DIVISION_CODE%TYPE
                                                    ,P_ITEM_CODE     MATERIAL_INV_BAL.ITEM_CODE%TYPE
                                                    ,P_FTA_CODE      IN VARCHAR2
                                                    ,P_HS_CODE       IN VARCHAR2
                                                    ,P_YYYYMMDD      VARCHAR2 DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD')
                                                    ,P_BOM_TYPE      VARCHAR2 DEFAULT NULL
                                                    ,P_ASSETS_TYPE   VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    /******************************************************************************/
    /* Project      : FTA PROJECT (K-ORIGIN)                                      */
    /* Module       : FC01_GET_ITEM_NATION                                        */
    /* Program Name : FC01_GET_ITEM_NATION                                        */
    /* Description  : GET ITEM NATION                                             */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /*                                                                            */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/

    V_ORIGIN_RATE NUMBER := 0;
    V_MAX_MONTHS  NUMBER := 6;
    V_PO_COUNT    NUMBER := 0;
    V_MTM_COUNT   NUMBER := 0;
    V_COO_NATION  VARCHAR2(2) := NULL;

    V_START_YYYYMMDD         VARCHAR2(8) := NULL;
    V_END_YYYYMMDD           VARCHAR2(8) := NULL;
    V_DIVISION_CODE          VARCHAR2(20) := NULL;
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


            BEGIN
                SELECT CASE WHEN COUNT(*) > 1 THEN 'TT' -- 멀티소싱인 경우 임의로 'TT'로  입력
                            ELSE MAX(COO_NATION) END AS COO_NATION
                  INTO V_COO_NATION
                  FROM (
                      SELECT DISTINCT PL.VENDOR_CODE
                            ,PL.ITEM_CODE
                            ,ECD.COO_NATION
                      FROM   PO_LEDGER PL
                      LEFT   OUTER JOIN COO_DIVISION_V D
                      ON     D.DIVISION_CODE = PL.DIVISION_CODE
                      AND    D.COMPANY_CODE = PL.COMPANY_CODE
                      INNER JOIN EXT_COO_CERTIFY_MST ECM
                      ON ECM.COMPANY_CODE = PL.COMPANY_CODE
                      INNER JOIN EXT_COO_CERTIFY_DTL ECD
                              ON     ECD.COO_CERTIFY_NO = ECM.COO_CERTIFY_NO
                              AND    ECD.COMPANY_CODE = ECM.COMPANY_CODE
                              AND    ECD.DIVISION_CODE = ECM.DIVISION_CODE
                              AND    ECD.VENDOR_CODE = PL.VENDOR_CODE
                              AND    ECD.FTA_CODE = 'PKRRC'
                              AND    ECD.HS_CODE = CASE WHEN P_ASSETS_TYPE = 'P' OR P_ASSETS_TYPE = 'H'
                                                          THEN ECD.HS_CODE
                                                          ELSE P_HS_CODE END
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
                              AND    ECD.ITEM_CODE = PL.ITEM_CODE
                      AND    PL.ITEM_CODE = P_ITEM_CODE
                            --x AND    PL.DIVISION_CODE = P_DIVISION_CODE --공장간 이체적용을위해 뺌
                      AND   PL.COMPANY_CODE = P_COMPANY_CODE
                      AND   PL.WAREHOUSING_DATE BETWEEN (CASE WHEN V_LAST_YYYYMM||'01' < V_START_YYYYMMDD THEN V_LAST_YYYYMM||'01' ELSE V_START_YYYYMMDD END) AND
                            V_END_YYYYMMDD);



            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  V_COO_NATION := '';
              WHEN OTHERS THEN
                  V_COO_NATION := '';

            END;
        END IF;

    END LOOP;

    RETURN V_COO_NATION;

END;

 
