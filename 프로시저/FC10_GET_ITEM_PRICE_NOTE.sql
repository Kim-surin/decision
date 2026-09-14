CREATE OR REPLACE FUNCTION FC10_GET_ITEM_PRICE_NOTE(P_COMPANY_CODE  MATERIAL_INV_BAL.COMPANY_CODE%TYPE
                                                   ,P_DIVISION_CODE MATERIAL_INV_BAL.DIVISION_CODE%TYPE
                                                   ,P_ITEM_CODE     MATERIAL_INV_BAL.ITEM_CODE%TYPE
                                                   ,P_FTA_CODE      IN VARCHAR2
                                                   ,P_YYYYMMDD      VARCHAR2 DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD'))

 RETURN VARCHAR2 DETERMINISTIC AS

    /******************************************************************************/
    /* Project      : FTA PROJECT (K-ORIGIN)                                      */
    /* Module       : FC10_GET_ITEM_PRICE                                            */
    /* Program Name : FC10_GET_ITEM_PRICE                                            */
    /* Description  : 재료비 조회                                                  */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /* 2012/05/04  Lee Doo hwan  Initial Version                                 */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/
    V_PRICE         NUMBER;
    V_PRICE_NOTE    FCR_DTL.PRICE_NOTE%TYPE;
    V_MAX_MONTHS    NUMBER := NVL(FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'MA'), 12); --최근 12개월 수불부 참조

BEGIN

    ----------------------------------------------------
    -- 1. 원재료 수불부의 출고단가
    ----------------------------------------------------
    BEGIN
        SELECT CASE
                   WHEN ML.ISSUE_AMOUNT > 0 AND
                        ML.ISSUE_QTY > 0 THEN
                   -- 출고금액 / 출고수량
                    ML.ISSUE_AMOUNT / ML.ISSUE_QTY
                   WHEN ML.INVENTORY_AMOUNT > 0 AND
                        ML.INVENTORY_QTY > 0 THEN
                   -- 재고금액 / 재고수량
                    ML.INVENTORY_AMOUNT / ML.INVENTORY_QTY
                   WHEN ML.EXTRA_ISSUE_AMOUNT > 0 AND
                        ML.EXTRA_ISSUE_QTY > 0 THEN
                   -- 기타출고금액 / 기타출고수량
                    ML.EXTRA_ISSUE_AMOUNT / ML.EXTRA_ISSUE_QTY
                   ELSE
                    0
               END AS PRICE
              ,'수불부 단가 (' || ML.YYYYMM || ',' || ML.DIVISION_CODE || ')'
        INTO   V_PRICE
              ,V_PRICE_NOTE
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
                AND    ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY + INVENTORY_QTY > 0)
        AND    ML.ITEM_CODE = P_ITEM_CODE
        AND    ML.DIVISION_CODE = P_DIVISION_CODE
        AND    ML.COMPANY_CODE = P_COMPANY_CODE;

        IF V_PRICE > 0 THEN
            RETURN V_PRICE_NOTE;
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    ----------------------------------------------------
    -- 2. 원재료 수불부의 출고단가(타 플랜트)
    ----------------------------------------------------
    BEGIN
        SELECT CASE
                   WHEN ML.ISSUE_AMOUNT > 0 AND
                        ML.ISSUE_QTY > 0 THEN
                   -- 출고금액 / 출고수량
                    ML.ISSUE_AMOUNT / ML.ISSUE_QTY
                   WHEN ML.INVENTORY_AMOUNT > 0 AND
                        ML.INVENTORY_QTY > 0 THEN
                   -- 재고금액 / 재고수량
                    ML.INVENTORY_AMOUNT / ML.INVENTORY_QTY
                   WHEN ML.EXTRA_ISSUE_AMOUNT > 0 AND
                        ML.EXTRA_ISSUE_QTY > 0 THEN
                   -- 기타출고금액 / 기타출고수량
                    ML.EXTRA_ISSUE_AMOUNT / ML.EXTRA_ISSUE_QTY
                   ELSE
                    0
               END AS PRICE
              ,'수불부 단가 (' || ML.YYYYMM || ',' || ML.DIVISION_CODE || ')'
        INTO   V_PRICE
              ,V_PRICE_NOTE
        FROM   MATERIAL_INV_BAL ML
        WHERE  ML.YYYYMM =
               (SELECT MAX(ML2.YYYYMM)
                FROM   MATERIAL_INV_BAL ML2
                WHERE  ML2.YYYYMM BETWEEN
                       TO_CHAR(ADD_MONTHS(TO_DATE(P_YYYYMMDD, 'YYYYMMDD'), V_MAX_MONTHS * -1), 'YYYYMM') AND
                       SUBSTR(P_YYYYMMDD, 1, 6)
                AND    ML2.ITEM_CODE = ML.ITEM_CODE
                      --AND    ML2.DIVISION_CODE = ML.DIVISION_CODE
                AND    ML2.COMPANY_CODE = ML.COMPANY_CODE
                AND    ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY + INVENTORY_QTY > 0)
        AND    ML.ITEM_CODE = P_ITEM_CODE
        --AND    ML.DIVISION_CODE = P_DIVISION_CODE
        AND    ML.COMPANY_CODE = P_COMPANY_CODE
        AND    ROWNUM = 1;

        IF V_PRICE > 0 THEN
            RETURN V_PRICE_NOTE;
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    ----------------------------------------------------
    -- 3. 구매단가(가장 최근)
    ----------------------------------------------------
    BEGIN
        SELECT PL.UNIT_PRICE
              ,'구매 단가 (' || PL.WAREHOUSING_DATE || ',' || PL.DIVISION_CODE || ',' ||
               PL.VENDOR_CODE || ')'
        INTO   V_PRICE
              ,V_PRICE_NOTE
        FROM   (SELECT /*+ INDEX_DESC(PL PO_LEDGER_IDX2) */
                 PL.UNIT_PRICE
                ,PL.WAREHOUSING_DATE
                ,PL.DIVISION_CODE
                ,PL.VENDOR_CODE
                ,ROW_NUMBER() OVER(ORDER BY WAREHOUSING_DATE DESC, WAREHOUSING_NO DESC) SEQ
                FROM   PO_LEDGER PL
                WHERE  PL.COMPANY_CODE = P_COMPANY_CODE
                AND    PL.DIVISION_CODE = P_DIVISION_CODE
                AND    PL.WAREHOUSING_DATE BETWEEN
                       TO_CHAR(ADD_MONTHS(P_YYYYMMDD, V_MAX_MONTHS * -1), 'YYYYMMDD') AND
                       P_YYYYMMDD
                AND    PL.ITEM_CODE = P_ITEM_CODE
                AND    PL.UNIT_PRICE > 0) PL
        WHERE  SEQ = 1;

        IF V_PRICE > 0 THEN
            RETURN V_PRICE_NOTE;
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    ----------------------------------------------------
    -- 4. 표준단가(최근 마지막)
    ----------------------------------------------------
    BEGIN
        SELECT /*+ index_desc(SC STANDARD_COST_PK) */ SC.STANDARD_COST_AMOUNT
              ,'표준 단가 (' || SC.APPLY_DATE || ',' || SC.DIVISION_CODE || ')'
        INTO   V_PRICE
              ,V_PRICE_NOTE
        FROM   STANDARD_COST SC -- 표준원가
        WHERE  SC.COMPANY_CODE = P_COMPANY_CODE
        --AND SC.DIVISION_CODE = P_DIVISION_CODE
        AND    SC.ITEM_CODE = P_ITEM_CODE
        AND    P_YYYYMMDD BETWEEN SC.APPLY_DATE AND
               NVL(SC.END_DATE, '99991231')
        AND    SC.STANDARD_COST_AMOUNT != 0
        AND    ROWNUM = 1;

        IF V_PRICE > 0 THEN
            RETURN V_PRICE_NOTE;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
                V_PRICE_NOTE := NULL;
                /*        SELECT SC.STANDARD_COST_AMOUNT,
                      '표준 단가 (' || SC.APPLY_DATE || ',' || SC.DIVISION_CODE || ')'
                 INTO V_PRICE, V_PRICE_NOTE
                 FROM STANDARD_COST SC -- 표준원가
                WHERE SC.COMPANY_CODE = P_COMPANY_CODE
                  AND SC.ITEM_CODE = P_ITEM_CODE
                  AND P_YYYYMMDD BETWEEN SC.APPLY_DATE AND
                      NVL(SC.END_DATE, '99991231')
                  AND SC.STANDARD_COST_AMOUNT != 0
                  AND ROWNUM = 1;*/
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    V_PRICE := 0;
            END;
    END;

    ----------------------------------------------------
    -- 5. BOM 단가
    ----------------------------------------------------
    /*  BEGIN
      SELECT RB.UNIT_PRICE,
             RB.PRICE_NOTE
        INTO V_PRICE, V_PRICE_NOTE
        FROM RESULT_BOM RB
       WHERE RB.COMPANY_CODE = P_COMPANY_CODE
         AND RB.YYYYMM <= SUBSTR(P_YYYYMMDD, 1, 6)
         AND RB.ITEM_CODE = P_ITEM_CODE
         AND RB.UNIT_PRICE > 0
         AND ROWNUM = 1;

      IF V_PRICE > 0 THEN
        RETURN V_PRICE_NOTE;
      END IF;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_PRICE := 0;
    END;*/

    IF V_PRICE > 0 THEN
        RETURN V_PRICE_NOTE;
    ELSE
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;

END FC10_GET_ITEM_PRICE_NOTE;

 
