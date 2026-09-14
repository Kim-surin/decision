CREATE OR REPLACE FUNCTION FC10_GET_ITEM_PRICE(P_COMPANY_CODE  MATERIAL_INV_BAL.COMPANY_CODE%TYPE,
                                               P_DIVISION_CODE MATERIAL_INV_BAL.DIVISION_CODE%TYPE,
                                               P_ITEM_CODE     MATERIAL_INV_BAL.ITEM_CODE%TYPE,
                                               P_FTA_CODE      IN VARCHAR2,
                                               P_YYYYMMDD      VARCHAR2 DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD'))
    RETURN NUMBER DETERMINISTIC AS

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
    V_PRICE      NUMBER;
    V_MAX_MONTHS NUMBER := NVL(FC01_GET_COMPANY_SETING_VALUE(P_COMPANY_CODE, 'MA'), 12); --최근 12개월 수불부 참조

BEGIN

    -- 1. 해당 PLANT의 최근 6개월 기준으로 원재료 수불부의 출고가 있는 월의 단가를 이용
    BEGIN
        SELECT /*NVL((DECODE(ML.INVENTORY_AMOUNT, 0, ML.ISSUE_AMOUNT + ML.EXTRA_ISSUE_AMOUNT, ML.INVENTORY_AMOUNT) /
                   DECODE(DECODE(ML.INVENTORY_QTY, 0, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, ML.INVENTORY_QTY),
                           0,
                           NULL,
                           DECODE(ML.INVENTORY_QTY, 0, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, ML.INVENTORY_QTY))),
                   0) AS PRICE -- 확인*/

               -- 기말재고단가 => 출고단가 변경 20180404 KYU
               NVL(((ML.ISSUE_AMOUNT + ML.EXTRA_ISSUE_AMOUNT) /
                   DECODE(ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, 0, NULL, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY)),
                   0) AS PRICE
        INTO   V_PRICE
        FROM   MATERIAL_INV_BAL ML
        WHERE  ML.YYYYMM = (SELECT MAX(ML2.YYYYMM)
                            FROM   MATERIAL_INV_BAL ML2
                            WHERE  ML2.YYYYMM BETWEEN
                                   TO_CHAR(ADD_MONTHS(TO_DATE(P_YYYYMMDD, 'YYYYMMDD'), V_MAX_MONTHS * -1), 'YYYYMM') AND
                                   SUBSTR(P_YYYYMMDD, 1, 6)
                            AND    ML2.ITEM_CODE = ML.ITEM_CODE
                            AND    ML2.DIVISION_CODE = ML.DIVISION_CODE
                            AND    ML2.COMPANY_CODE = ML.COMPANY_CODE
                            AND    ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY  > 0)
        AND    ML.ITEM_CODE = P_ITEM_CODE
        AND    ML.DIVISION_CODE = P_DIVISION_CODE
        AND    ML.COMPANY_CODE = P_COMPANY_CODE;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    IF V_PRICE > 0 THEN
        RETURN V_PRICE;
    END IF;

    -- 2. 타 PLANT의 최근 6개월 기준으로 원재료 수불부의 출고가 있는 월의 단가를 이용
    BEGIN
        SELECT /*NVL((DECODE(ML.INVENTORY_AMOUNT, 0, ML.ISSUE_AMOUNT + ML.EXTRA_ISSUE_AMOUNT, ML.INVENTORY_AMOUNT) /
                   DECODE(DECODE(ML.INVENTORY_QTY, 0, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, ML.INVENTORY_QTY),
                           0,
                           NULL,
                           DECODE(ML.INVENTORY_QTY, 0, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, ML.INVENTORY_QTY))),
                   0) AS PRICE -- 확인*/

               -- 기말재고단가 => 출고단가 변경 20180404 KYU
               NVL(((ML.ISSUE_AMOUNT + ML.EXTRA_ISSUE_AMOUNT) /
                   DECODE(ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY, 0, NULL, ML.ISSUE_QTY + ML.EXTRA_ISSUE_QTY)),
                   0) AS PRICE
        INTO   V_PRICE
        FROM   MATERIAL_INV_BAL ML
        WHERE  ML.YYYYMM = (SELECT MAX(ML2.YYYYMM)
                            FROM   MATERIAL_INV_BAL ML2
                            WHERE  ML2.YYYYMM BETWEEN
                                   TO_CHAR(ADD_MONTHS(TO_DATE(P_YYYYMMDD, 'YYYYMMDD'), V_MAX_MONTHS * -1), 'YYYYMM') AND
                                   SUBSTR(P_YYYYMMDD, 1, 6)
                            AND    ML2.ITEM_CODE = ML.ITEM_CODE
                                  --AND    ML2.DIVISION_CODE = ML.DIVISION_CODE
                            AND    ML2.COMPANY_CODE = ML.COMPANY_CODE
                            AND    ML2.ISSUE_QTY + ML2.EXTRA_ISSUE_QTY > 0)
        AND    ML.ITEM_CODE = P_ITEM_CODE
              --AND    ML.DIVISION_CODE = P_DIVISION_CODE
        AND    ML.COMPANY_CODE = P_COMPANY_CODE
        AND    ROWNUM = 1;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    IF V_PRICE > 0 THEN
        RETURN V_PRICE;
    END IF;

    -- 4.BPA단가
    --3. 최근월  구매단가 --ITEM_CODE, WAREHOUSING_DATE, DIVISION_CODE, COMPANY_CODE
    BEGIN
       -- SELECT /*+ INDEX_DESC(PL PO_LEDGER_IDX2) */
       --  PL.UNIT_PRICE
       -- INTO   V_PRICE
       -- FROM   PO_LEDGER PL
       -- WHERE  PL.ITEM_CODE = P_ITEM_CODE
       -- AND    PL.COMPANY_CODE = P_COMPANY_CODE
       -- AND    PL.WAREHOUSING_DATE <= P_YYYYMMDD
       -- AND    PL.UNIT_PRICE > 0
       -- AND    ROWNUM = 1;

        SELECT PL.UNIT_PRICE
        INTO   V_PRICE
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

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    IF V_PRICE > 0 THEN
        RETURN V_PRICE;
    END IF;

    -- 4. 표준단가 이용
    BEGIN
        SELECT SC.STANDARD_COST_AMOUNT
        INTO   V_PRICE
        FROM   STANDARD_COST SC -- 표준원가
        WHERE  SC.COMPANY_CODE = P_COMPANY_CODE
        AND    SC.DIVISION_CODE = P_DIVISION_CODE
        AND    SC.ITEM_CODE = P_ITEM_CODE
        AND    P_YYYYMMDD BETWEEN SC.APPLY_DATE AND NVL(SC.END_DATE, '99991231')
        AND    ROWNUM = 1;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    IF V_PRICE > 0 THEN
        RETURN V_PRICE;
    END IF;

    BEGIN
        SELECT SC.STANDARD_COST_AMOUNT
        INTO   V_PRICE
        FROM   STANDARD_COST SC -- 표준원가
        WHERE  SC.COMPANY_CODE = P_COMPANY_CODE
        --AND    SC.DIVISION_CODE = P_DIVISION_CODE
        AND    SC.ITEM_CODE = P_ITEM_CODE
        AND    P_YYYYMMDD BETWEEN SC.APPLY_DATE AND NVL(SC.END_DATE, '99991231')
        AND    ROWNUM = 1;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_PRICE := 0;
    END;

    IF V_PRICE > 0 THEN
        RETURN V_PRICE;
    ELSE
        RETURN NULL;
    END IF;



EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;

END FC10_GET_ITEM_PRICE;

 
