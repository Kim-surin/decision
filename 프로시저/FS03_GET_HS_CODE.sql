CREATE OR REPLACE FUNCTION FS03_GET_HS_CODE(P_COMPANY_CODE  VARCHAR2,
                                            P_DIVISION_CODE VARCHAR2,
                                            P_CUSTOMER_CODE VARCHAR2,
                                            P_ITEM_CODE     VARCHAR2,
                                            P_NATION_CODE   VARCHAR2,
                                            P_FTA_CODE      VARCHAR2,
                                            P_YYYYMMDD      VARCHAR2 DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDD'))
    RETURN VARCHAR2 DETERMINISTIC AS
    /******************************************************************************/
    /* Project      : FTA PROJECT (K-ORIGIN)                                      */
    /* Module       : FS03_GET_HS_CODE                                            */
    /* Program Name : FS03_GET_HS_CODE                                            */
    /* Description  : 국가별 hs code 조회                                         */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /* 2012/05/04  Lee Doo hwan  Initial Version                                 */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/
    V_HS_CODE ITEM_MST.HS_CODE%TYPE;

BEGIN

    SELECT CASE
               WHEN CM.CUSTOMER_HS_CODE IS NOT NULL THEN
                CM.CUSTOMER_HS_CODE
               WHEN FAHC.FTA_AGM_HS_CODE IS NOT NULL THEN
                FAHC.FTA_AGM_HS_CODE
               WHEN FHC.FTA_HS_CODE IS NOT NULL THEN
                FHC.FTA_HS_CODE
               WHEN HIS.HS_CODE IS NOT NULL THEN
                HIS.HS_CODE
               ELSE
                IM.HS_CODE
           END
    INTO   V_HS_CODE
    FROM   ITEM_MST IM
    LEFT   OUTER JOIN CUSTOMER_MODEL CM
    ON     CM.COMPANY_CODE = IM.COMPANY_CODE
    AND    CM.ITEM_CODE = IM.ITEM_CODE
    AND    CM.DIVISION_CODE = P_DIVISION_CODE
    AND    CM.CUSTOMER_CODE = P_CUSTOMER_CODE
    LEFT   OUTER JOIN FTA_AGM_HS_CODE FAHC
    ON     FAHC.COMPANY_CODE = IM.COMPANY_CODE
    AND    FAHC.ITEM_CODE = IM.ITEM_CODE
    AND    FAHC.FTA_CODE = P_FTA_CODE
    LEFT   OUTER JOIN FTA_HS_CODE FHC
    ON     FHC.COMPANY_CODE = IM.COMPANY_CODE
    AND    IM.ITEM_CODE = FHC.ITEM_CODE
    AND    FHC.NATION_CODE = P_NATION_CODE
    LEFT   OUTER JOIN HISTORY_ITEM_HS_CODE HIS
    ON     HIS.ITEM_CODE = P_ITEM_CODE
    AND    HIS.COMPANY_CODE = P_COMPANY_CODE
    AND    P_YYYYMMDD BETWEEN HIS.FROM_DATE AND NVL(HIS.TO_DATE, '99991231')
    WHERE  IM.ITEM_CODE = P_ITEM_CODE
    AND    IM.COMPANY_CODE = P_COMPANY_CODE
    AND    ROWNUM = 1;

    RETURN V_HS_CODE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN('');
END FS03_GET_HS_CODE;
 
