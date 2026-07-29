CREATE OR REPLACE FUNCTION GET_INCOTERMS_CHANGE_RATE(P_STD_YYYY            IN FTA_INCOTERMS_INFO.STD_YYYY%TYPE,
                                                     P_COMPNAY_CODE        IN SALES_MST.COMPANY_CODE%TYPE,
                                                     P_DIVISION_CODE       IN FTA_INCOTERMS_INFO.DIVISION_CODE%TYPE,
                                                     P_EXPORT_FLAG         IN SALES_MST.EXPORT_FLAG%TYPE,
                                                     P_NATION_CODE            IN FTA_INCOTERMS_INFO.NATION_CODE%TYPE,
                                                     P_FROM_INCOTERMS_CODE IN FTA_MASTER.INKOTERMS_TYPE%TYPE,
                                                     P_TO_INCOTERMS_CODE   IN FTA_MASTER.INKOTERMS_TYPE%TYPE)
    RETURN NUMBER AS
    /******************************************************************************/
    /* Project      : FTA PROJECT (K-ORIGIN)                                      */
    /* Module       : GET  HS_CODE                                                */
    /* Program Name : FAT_GET_INCOTERMS                                           */
    /* Description  : GET INCOTERMS VALES                                         */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /* 2012/12/11        Initial Version                                          */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/
    V_RATE NUMBER;

BEGIN

    SELECT 1 - ((FROM_INCOTERMS_RATE - TO_INCOTERMS_RATE) / 100)
    INTO   V_RATE
    FROM   (SELECT DECODE(P_FROM_INCOTERMS_CODE,
                          'EXW',
                          FII.EXW_RATE,
                          'FCA',
                          FII.FCA_RATE,
                          'FAS',
                          FII.FAS_RATE,
                          'FOB',
                          FII.FOB_RATE,
                          'CFR',
                          FII.CFR_RATE,
                          'CIF',
                          FII.CIF_RATE,
                          'CPT',
                          FII.CPT_RATE,
                          'CIP',
                          FII.CIP_RATE,
                          'DAP',
                          FII.DAP_RATE,
                          'DAT',
                          FII.DAT_RATE,
                          'DDU',
                          FII.DDU_RATE,
                          'DDP') AS FROM_INCOTERMS_RATE
                  ,DECODE(P_TO_INCOTERMS_CODE, 'EXW', FII.EXW_RATE, 'FOB', FII.FOB_RATE) AS TO_INCOTERMS_RATE
            FROM   FTA_INCOTERMS_INFO FII
            WHERE  FII.STD_YYYY = (SELECT MAX(FII2.STD_YYYY)
                                   FROM   FTA_INCOTERMS_INFO FII2
                                   WHERE  FII2.DIVISION_CODE = FII.DIVISION_CODE
                                   AND    FII2.INCOTERMS_TYPE = FII.INCOTERMS_TYPE
                                   AND    FII2.NATION_CODE = FII.NATION_CODE
                                   AND    FII2.STD_YYYY <= P_STD_YYYY)
            AND    FII.DIVISION_CODE = P_DIVISION_CODE
            AND    FII.INCOTERMS_TYPE = P_EXPORT_FLAG
            AND    FII.NATION_CODE = P_NATION_CODE
            AND    ROWNUM = 1);

    IF V_RATE IS NULL THEN
        RETURN 1;
    ELSE
        RETURN V_RATE;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 1;
END;
 
