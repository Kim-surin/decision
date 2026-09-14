CREATE OR REPLACE PACKAGE BODY PKG99_COO_DECISION AS
    PROCEDURE COO_DECISION(P_COMPANY_CODE IN SALES_MST.COMPANY_CODE%TYPE
                          ,P_SALES_NO     IN SALES_MST.SALES_NO%TYPE
                          ,O_RETURN_CODE  OUT NUMBER

                           ) AS

        /**************************************************
         Main Transaction에 영향없이 Commit/Rollback 처리
        ***************************************************/
        -- PRAGMA AUTONOMOUS_TRANSACTION;
        V_YYYYMMDD VARCHAR2(8);
        V_RCEP_NATION VARCHAR(10);
        V_MP_ITEM_YN VARCHAR(1);
        
        -- 판정을 위한 커서 선언
        -- 포괄 및 개별을 동시에 판정하기 위하여 대상을 합집합을 추출 한다
        CURSOR C_FCR_MST IS
            SELECT FTAFM.FTA_CODE            AS FTA_CODE
                  ,FTAFM.SALES_NO            AS SALES_NO
                  ,FTAFM.SALES_SEQ           AS SALES_SEQ
                  ,FTAFM.DIVISION_CODE       AS DIVISION_CODE
                  ,FTAFM.COMPANY_CODE        AS COMPANY_CODE
                  ,FTAFM.PRODUCT_CODE        AS PRODUCT_CODE
                  ,FTAFM.BIZ_PROJECT_CODE    AS BIZ_PROJECT_CODE
                  ,FTAFM.INKOTERMS_TYPE      AS INKOTERMS_TYPE
                  ,FTAFM.DE_MINIMIS_INKOTERMS_TYPE AS DE_MINIMIS_INKOTERMS_TYPE
                  ,FTAFM.PRODUCT_UNIT        AS PRODUCT_UNIT
                  ,FTAFM.PRODUCT_ASSETS_TYPE AS PRODUCT_ASSETS_TYPE
                  ,FTAFM.HS_CODE             AS HS_CODE
                  ,FTAFM.STANDARD            AS STANDARD
                  ,FTAFM.WEIGHT              AS WEIGHT
                  ,FTAFM.AMOUNT              AS AMOUNT
                  ,FTAFM.NET_COST_AMOUNT     AS NET_COST_AMOUNT
                  ,FTAFM.EXWORK_AMOUNT       AS EXWORK_AMOUNT
                  ,FTAFM.FOB_AMOUNT          AS FOB_AMOUNT
                  ,FTAFM.INAREA_AMOUNT       AS INAREA_AMOUNT
                  ,FTAFM.OUTAREA_AMOUNT      AS OUTAREA_AMOUNT
                  ,FTAFM.SP_COO_YN           AS SP_COO_YN
                  ,FTAFM.WO_COO_YN           AS WO_COO_YN
                   --, FTAFM.COO_TYPE             AS COO_TYPE
                  ,DECODE(IHSC.HS_CODE_SUB_CATEGORY, NULL, '1', IHSC.HS_CODE_SUB_CATEGORY) AS HS_CODE_SUB_CATEGORY -- 가목,나목처리를 위하여 사용됨
                  ,FTAFM.TARIFF_YN AS TARIFF_YN
            FROM   (SELECT FCRM.FTA_CODE            AS FTA_CODE
                          ,FCRM.SALES_NO            AS SALES_NO
                          ,FCRM.SALES_SEQ           AS SALES_SEQ
                          ,FCRM.DIVISION_CODE       AS DIVISION_CODE
                          ,FCRM.COMPANY_CODE        AS COMPANY_CODE
                          ,FCRM.PRODUCT_CODE        AS PRODUCT_CODE
                          ,FCRM.BIZ_PROJECT_CODE    AS BIZ_PROJECT_CODE
                          ,FM.INKOTERMS_TYPE        AS INKOTERMS_TYPE -- 분모값의 유형을 정의하는 구분자
                          ,FM.DE_MINIMIS_INKOTERMS_TYPE AS DE_MINIMIS_INKOTERMS_TYPE  -- 미소기준 상품가격 계상기준(UAE)
                          ,FCRM.PRODUCT_UNIT        AS PRODUCT_UNIT
                          ,FCRM.PRODUCT_ASSETS_TYPE AS PRODUCT_ASSETS_TYPE
                          ,FCRM.HS_CODE             AS HS_CODE
                          ,FCRM.STANDARD            AS STANDARD
                          ,FCRM.WEIGHT              AS WEIGHT
                          ,FCRM.AMOUNT              AS AMOUNT
                          ,FCRM.NET_COST_AMOUNT     AS NET_COST_AMOUNT
                          ,FCRM.EXWORK_AMOUNT       AS EXWORK_AMOUNT
                          ,FCRM.FOB_AMOUNT          AS FOB_AMOUNT
                          ,FCRM.INAREA_AMOUNT       AS INAREA_AMOUNT
                          ,FCRM.OUTAREA_AMOUNT      AS OUTAREA_AMOUNT
                          ,FCRM.SP_COO_YN           AS SP_COO_YN
                          ,FCRM.WO_COO_YN           AS WO_COO_YN
                    --, FCRM.COO_TYPE             AS COO_TYPE
                          ,DECODE(TD.HS_CODE, NULL, 'N', 'Y') AS TARIFF_YN
                    FROM   (

                            SELECT FM.FTA_CODE            AS FTA_CODE
                                   ,FM.SALES_NO            AS SALES_NO
                                   ,FM.SALES_SEQ           AS SALES_SEQ
                                   ,FM.DIVISION_CODE       AS DIVISION_CODE
                                   ,FM.COMPANY_CODE        AS COMPANY_CODE
                                   ,FM.PRODUCT_CODE        AS PRODUCT_CODE
                                   ,FM.BIZ_PROJECT_CODE    AS BIZ_PROJECT_CODE
                                   ,FM.PRODUCT_UNIT        AS PRODUCT_UNIT
                                   ,FM.PRODUCT_ASSETS_TYPE AS PRODUCT_ASSETS_TYPE
                                   ,FM.HS_CODE             AS HS_CODE
                                   ,FM.STANDARD            AS STANDARD
                                   ,FM.WEIGHT              AS WEIGHT
                                   ,FM.AMOUNT              AS AMOUNT
                                   ,FM.NET_COST_AMOUNT     AS NET_COST_AMOUNT
                                   ,FM.EXWORK_AMOUNT       AS EXWORK_AMOUNT
                                   ,FM.FOB_AMOUNT          AS FOB_AMOUNT
                                   ,FM.INAREA_AMOUNT       AS INAREA_AMOUNT
                                   ,FM.OUTAREA_AMOUNT      AS OUTAREA_AMOUNT
                                   ,FM.SP_COO_YN           AS SP_COO_YN
                                   ,FM.WO_COO_YN           AS WO_COO_YN
                            --, 'N'                  AS COO_TYPE
                                   ,SM.EXPORT_FLAG         AS EXPORT_FLAG
                                   ,SM.INVOICE_DATE        AS INVOICE_DATE
                                   ,SM.ARRIVAL_NATION      AS ARRIVAL_NATION
                            FROM   FCR_MST fm
                            INNER JOIN SALES_MST SM
                              ON SM.SALES_NO = FM.SALES_NO
                             AND SM.DIVISION_CODE = FM.DIVISION_CODE
                             AND SM.COMPANY_CODE = FM.COMPANY_CODE
                           WHERE FM.SALES_NO = P_SALES_NO
                             AND FM.COMPANY_CODE = P_COMPANY_CODE
                             AND FM.DECISION_YN = 'Y' -- 판정대상 지정된것만
                             AND FM.PRODUCT_ASSETS_TYPE IN ('P', 'H')) FCRM
                          INNER JOIN FTA_MASTER FM
                            ON FM.FTA_CODE = FCRM.FTA_CODE
                           AND FM.DELETE_YN <> 'Y'
                          LEFT OUTER JOIN TARIFF_DIFFERENTIALS TD
                            ON TD.FTA_CODE = FCRM.FTA_CODE
                           AND TD.HS_CODE = FCRM.HS_CODE
                           AND TD.NATION_CODE = DECODE(FCRM.EXPORT_FLAG,'E',FCRM.ARRIVAL_NATION,TD.NATION_CODE)
                           AND FCRM.INVOICE_DATE BETWEEN TD.APPLY_DATE AND TD.END_DATE
                         ) FTAFM
                  LEFT OUTER JOIN ITEM_HS_SUB_CATEGORY IHSC
                    ON IHSC.ITEM_CODE = FTAFM.PRODUCT_CODE
                   AND IHSC.DIVISION_CODE = FTAFM.DIVISION_CODE
                   AND IHSC.COMPANY_CODE = FTAFM.COMPANY_CODE
                   AND IHSC.FTA_CODE = FTAFM.FTA_CODE
                ; -- For cursor

        -- 룰관련하여 커서를 선언한다
        CURSOR C_FTA_RULE(V_HS_CODE              IN FTA_RULE.HS_CODE%TYPE
                         ,V_FTA_CODE             IN FTA_RULE.FTA_CODE%TYPE
                         ,V_HS_CODE_SUB_CATEGORY IN FTA_RULE.HS_CODE_SUB_CATEGORY%TYPE
                         ,V_NEW_APTA_PSR_FLAG    IN VARCHAR2) IS
            SELECT RULE_ID AS RULE_ID
                  ,FTA_CODE AS FTA_CODE
                  ,HS_CODE AS HS_CODE
                  ,HS_CODE_SUB_CATEGORY AS HS_CODE_SUB_CATEGORY
                  ,RULE_SEQ AS RULE_SEQ
                  ,HS_CODE_DESCRIPTION AS HS_CODE_DESCRIPTION
                  ,RULE_DESCRIPTION AS RULE_DESCRIPTION
                  ,RULE_CONTENTS AS RULE_CONTENTS
                  ,DECODE(INSTR(RULE_CONTENTS, 'SP'), 0, '*', 'SP') AS SP_RULE
                   --,DECODE(SUBSTR(RULE_CONTENTS, 1, 2), 'SP', 'SP', '*') AS SP_RULE
                  ,DECODE(WO_RULE, NULL, '*', WO_RULE) AS WO_RULE
                  ,DECODE(CTH_RULE, NULL, '*', CTH_RULE) AS CTH_RULE
                  ,NVL(BD_RULE, 0) AS BD_RULE
                  ,NVL(BU_RULE, 0) AS BU_RULE
                  ,NVL(NC_RULE, 0) AS NC_RULE
                  ,NVL(MC_RULE, 0) AS MC_RULE
                  ,DE_MINIMIS_UNIT AS DE_MINIMIS_UNIT
                  ,DE_MINIMIS_RATE AS DE_MINIMIS_RATE
                  ,EXCLUSION_RULE_YN AS EXCLUSION_RULE_YN
            FROM   FTA_RULE
                  ,(
                    -- CTSH > CTC > CC 순으로 룰을 찾아서 판정을 하기 위해서 적용가능한 HS CODE의
                    -- 최대 길이를 구한다
                    SELECT MAX(LENGTH(HS_CODE)) AS HS_CODE_LENGTH
                    FROM   FTA_RULE
                    WHERE  HS_CODE = SUBSTR(V_HS_CODE, 1, LENGTH(HS_CODE))
                    AND    FTA_CODE = V_FTA_CODE
                    AND    HS_CODE_SUB_CATEGORY = V_HS_CODE_SUB_CATEGORY) FRL
            WHERE  HS_CODE = SUBSTR(V_HS_CODE, 1, FRL.HS_CODE_LENGTH)
            AND    FTA_CODE = V_FTA_CODE
            AND    HS_CODE_SUB_CATEGORY = V_HS_CODE_SUB_CATEGORY
            /* 2018.07.03 APTA NEW PSR 적용위한 조건절 추가
               설명 : INVOICE_DATE에 따른 V_NEW_APTA_PSR_FLAG 값을 구해 APTA 협정인 경우에만 추가된 PSR의 사용 여부를 적용한다.
            */
            AND    RULE_SEQ = CASE WHEN FTA_CODE = 'PKRAP' AND '0' = V_NEW_APTA_PSR_FLAG THEN '1' ELSE RULE_SEQ END
            ORDER  BY RULE_SEQ; -- For cursor

        -- 오라클에서 11G 이하 인 경우는 CONTINUE문을 지원하지 않아서 변수처리를 함
        V_LOOP_FLAG VARCHAR2(1) := 'N';
        FR_LIST     C_FTA_RULE%ROWTYPE;
        V_RULE_CNT  NUMBER;

        V_NEW_APTA_PSR_FLAG VARCHAR2(1) := '1'; -- 0 :FALSE , 1 : TRUE
        V_APTA_STD_YYYYMMDD VARCHAR2(8) := '20180701'; -- APTA시행 기준일자 초기화

    BEGIN

        --DBMS_OUTPUT.PUT_LINE('PKG99_COO_DECISION Start..');



        -- 프로시저 로그 저장
        PKG00_PROCEDURE_LOG.BATCH_LOG(VG_LOG_ID, TO_CHAR(SYSDATE, 'YYYYMMDD'), 'PKG99_COO_DECISION', 'S', P_COMPANY_CODE, 'INPUT DATA : ' ||
                                       P_COMPANY_CODE || ':' ||
                                       P_SALES_NO);

        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, 'START PKG99_COO_DECISION *****');

        /***************************************************************
        /* 초기화 작업을 수행
        /****************************************************************/

        SELECT CASE WHEN SM.INVOICE_DATE < V_APTA_STD_YYYYMMDD THEN '0'
                    ELSE '1'
                END AS USE_NEW_APTA_PSR
              ,SM.INVOICE_DATE
          INTO V_NEW_APTA_PSR_FLAG
              ,V_YYYYMMDD
          FROM SALES_MST SM
         WHERE SM.SALES_NO = P_SALES_NO
           AND SM.COMPANY_CODE = P_COMPANY_CODE;


        /***************************************************************
        /* 판정을 수행
        /****************************************************************/
        /*
        * 포괄원산지 확인서 인경우에는 COVER FCR MASTER, 개별 인경우에는 FCR MASTER에서 데이터를
        * 읽어와서 판정대상이 있는 동안  LOOP를 수행 한다
        */
        FOR FM_LIST IN C_FCR_MST
        LOOP

            /**
            GET RVC 버퍼, 미소기준 버퍼
            */

            GET_BUFFER(FM_LIST.COMPANY_CODE, FM_LIST.DIVISION_CODE, FM_LIST.FTA_CODE, FM_LIST.PRODUCT_CODE);

            -- 기판정된 결과가 있는 경우에는 삭제를 한다
            DELETE FROM FCR_RESULT
            WHERE  SALES_NO = FM_LIST.SALES_NO
            AND    SALES_SEQ = FM_LIST.SALES_SEQ
            AND    FTA_CODE = FM_LIST.FTA_CODE
            AND    COMPANY_CODE = P_COMPANY_CODE;

            --PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID,
            --                                  '기판정된 결과 삭제 건수 : ' || SQL%ROWCOUNT);

            /*
            * FCR INFO 정보를 읽어와서  판정용 TEMP 테이블에 INSERT 한다
            * TEMP테이블을 사용하는 목적은 예외규정을 쉽게 처리하기 위하여 사용된다
            */
            INSERT INTO FCR_INFO_TEMP
                SELECT FI.FTA_CODE AS FTA_CODE
                      ,FI.DIVISION_CODE AS DIVISION_CODE
                      ,FI.COMPANY_CODE AS COMPANY_CODE
                      ,FI.PRODUCT_CODE AS PRODUCT_CODE
                      ,FI.ITEM_CODE AS ITEM_CODE
                      ,FM_LIST.HS_CODE AS PARENT_HS_CODE
                      ,FI.HS_CODE AS HS_CODE
                      ,FI.STANDARD AS STANDARD
                      ,FI.WEIGHT AS WEIGHT
                      ,FI.REQUIREMENT_QTY AS REQUIREMENT_QTY
                      ,FI.INPUT_AMOUNT AS INPUT_AMOUNT
                      ,FI.INAREA_QTY AS INAREA_QTY
                      ,FI.INAREA_AMOUNT AS INAREA_AMOUNT
                      ,FI.OUTAREA_QTY AS OUTAREA_QTY
                      ,FI.OUTAREA_AMOUNT AS OUTAREA_AMOUNT
                      ,'N' AS EXCLUSION_RULE1_YN
                      ,'N' AS EXCLUSION_RULE2_YN
                      ,'N' AS EXCLUSION_RULE3_YN
                      ,'N' AS EXCLUSION_RULE4_YN
                      ,'N' AS EXCLUSION_RULE5_YN
                      ,'N' AS EXCLUSION_RULE6_YN
                      ,'N' AS EXCLUSION_RULE7_YN
                      ,'N' AS EXCLUSION_RULE8_YN
                      ,'N' AS EXCLUSION_RULE9_YN
                      ,'N' AS EXCLUSION_RULE10_YN
                      ,'N' AS EXCLUSION_RULE11_YN
                      ,'N' AS EXCLUSION_RULE12_YN
                      ,'N' AS EXCLUSION_RULE13_YN
                      ,'N' AS EXCLUSION_RULE14_YN
                      ,NULL AS COO_NATION
                FROM   FCR_DTL FI
                WHERE  FI.FTA_CODE = FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = FM_LIST.COMPANY_CODE
                AND    FI.SALES_NO = FM_LIST.SALES_NO
                AND    FI.SALES_SEQ = FM_LIST.SALES_SEQ;

                IF FM_LIST.FTA_CODE = 'PKRRC' THEN
                 UPDATE FCR_INFO_TEMP FIT
                    SET FIT.COO_NATION = FC01_GET_ITEM_NATION(FIT.COMPANY_CODE, FIT.DIVISION_CODE, FIT.ITEM_CODE, FIT.FTA_CODE, FIT.HS_CODE, V_YYYYMMDD)
                  WHERE FIT.FTA_CODE = 'PKRRC'
                    AND FIT.COMPANY_CODE = FM_LIST.COMPANY_CODE
                    AND FIT.DIVISION_CODE = FM_LIST.DIVISION_CODE
                    AND FIT.INAREA_AMOUNT > 0
                    ;
              END IF;

            /*
            *  해당 FCR MST의 판정 대상 제품에 해당하는 룰 데이터를 읽어온다
            */
            VG_RULE_COUNT := 0;
            V_RULE_CNT    := 0;

            OPEN C_FTA_RULE(FM_LIST.HS_CODE, FM_LIST.FTA_CODE, FM_LIST.HS_CODE_SUB_CATEGORY, V_NEW_APTA_PSR_FLAG);
            LOOP
                FR_LIST := NULL;
                FETCH C_FTA_RULE
                    INTO FR_LIST;

                /*
                판정기준 존재 체크(FTA_RULE)
                */
                V_RULE_CNT := V_RULE_CNT + 1;
                IF C_FTA_RULE%NOTFOUND AND
                   FR_LIST.RULE_ID IS NULL AND
                   V_RULE_CNT = 1 THEN
                    V_RULE_CNT := 100;
                ELSIF C_FTA_RULE%NOTFOUND AND
                      FR_LIST.RULE_ID IS NULL AND
                      V_RULE_CNT > 1 THEN
                    EXIT WHEN C_FTA_RULE%NOTFOUND;
                END IF;

                -- 특정협정에 대한  HS_CODE 관련 FTA 룰이  없는 경우를 체크하기 위해서 1을 넣어둠
                VG_RULE_COUNT := 1;

                -- LOOP에서 CONTINUE를 지원하지 않아서 IF로 대치하기 위해 사용한 변수 초기화
                V_LOOP_FLAG := 'N';

                /*
                * 룰 ID 한건에 해당하는 판정을 수행하고 결과를 판정결과 레코드 변수에 담는다
                *
                */
                VG_FRD_REC.SALES_NO      := FM_LIST.SALES_NO;
                VG_FRD_REC.SALES_SEQ     := FM_LIST.SALES_SEQ;
                VG_FRD_REC.FTA_CODE      := FM_LIST.FTA_CODE;
                VG_FRD_REC.RULE_SEQ      := FR_LIST.RULE_ID;
                VG_FRD_REC.DIVISION_CODE := FM_LIST.DIVISION_CODE;
                VG_FRD_REC.COMPANY_CODE  := FM_LIST.COMPANY_CODE;
                VG_FRD_REC.RULE_CODE     := FR_LIST.RULE_CONTENTS;
                VG_FRD_REC.PRODUCT_CODE  := FM_LIST.PRODUCT_CODE;
                VG_FRD_REC.HS_CODE       := FM_LIST.HS_CODE;
                VG_FRD_REC.STANDARD      := FM_LIST.STANDARD;
                VG_FRD_REC.STATUS        := 'N'; -- 일단 판정상태는 정상으로 설정

                VG_FRD_REC.CREATE_DATE := SYSDATE;
                VG_FRD_REC.CREATE_BY   := 'PKG99_COO_DECISION';
                VG_FRD_REC.UPDATE_DATE := SYSDATE;
                VG_FRD_REC.UPDATE_BY   := 'PKG99_COO_DECISION';

                IF V_RULE_CNT = 100 THEN
                    -- 판정기준이 미 존재 합니다.
                    VG_FRD_REC.COMPANY_COO_YN := 'N';
                    VG_FRD_REC.FTA_COO_YN     := 'N';
                    VG_FRD_REC.STATUS         := 'E';
                    VG_FRD_REC.ERROR_CODE     := 'MSG_DECISION_STANDARD_NOT_EXIST';
                    VG_FRD_REC.ERROR_MSG      := '판정기준이 미 존재 합니다.';
                    INSERT_FRD_PROCESS();
                    EXIT WHEN C_FTA_RULE%NOTFOUND;
                ELSIF FM_LIST.INAREA_AMOUNT + FM_LIST.OUTAREA_AMOUNT <= 0 THEN
                    -- 역내+역외 재료비 금액이 0일경우 역외산 처리
                    VG_FRD_REC.COMPANY_COO_YN := 'N';
                    VG_FRD_REC.FTA_COO_YN     := 'N';
                    VG_FRD_REC.STATUS         := 'E';
                    VG_FRD_REC.ERROR_CODE     := 'MSG_FAILED_DECISION_QTY_AMOUNT';
                    VG_FRD_REC.ERROR_MSG      := '소요량 또는 금액이 0 인 것이 존재합니다.';
                    INSERT_FRD_PROCESS();
                    --CONTINUE;  11g 이상 가능
                    --END IF;
                ELSE

                    /*
                    *  판정을 위해 사용하는 제품 금액을 협정별에서 사용하는 INCOTERMS기준으로 구한다
                    */

                    -- 중량기준으로 미소를 체크하기 위해서 제품 중량을 가져온다
                    VG_NET_WEIGHT := FM_LIST.WEIGHT;

                    VG_NET_COST_AMOUNT := FM_LIST.NET_COST_AMOUNT; -- 한미용 순원가 금액
                    IF FM_LIST.INKOTERMS_TYPE = 'EXW' THEN
                        VG_INKOTERMS_AMOUNT := FM_LIST.EXWORK_AMOUNT; -- EU/EFTA에서 사용됨
                    ELSE
                        VG_INKOTERMS_AMOUNT := FM_LIST.FOB_AMOUNT; -- 기타 협정에서 사용됨
                    END IF;
                    
                    -- UAE : 미소기준 금액기준 
                    IF FM_LIST.DE_MINIMIS_INKOTERMS_TYPE = 'EXW' THEN
                        VG_DE_MINIMIS_INKOTERMS_AMOUNT := FM_LIST.EXWORK_AMOUNT; 
                    ELSE
                        VG_DE_MINIMIS_INKOTERMS_AMOUNT := FM_LIST.FOB_AMOUNT; 
                    END IF;

                    -- 가공공정 기준 판정
                    IF FR_LIST.SP_RULE = 'SP' THEN
                        VG_FRD_REC.SP_COO_YN := FM_LIST.SP_COO_YN;
                    END IF;

                    -- 완전생산  기준 판정
                    IF FR_LIST.WO_RULE = 'WO' THEN
                        VG_FRD_REC.WO_COO_YN := FM_LIST.WO_COO_YN;
                    END IF;

                    /*
                    * 만일 룰 예외처리를 해야 하는 부분이 있으면 예외처리를 먼저 하도록 한다
                    * 예외처리에서 나온 결과를 이용하여 다시 CTC 판정을 하도록 한다
                    */
                    IF FR_LIST.EXCLUSION_RULE_YN = 'Y' THEN

                        -- 예외룰을 판정한 뒤 판정결과 레코드 변수에 담는다
                        EXCLUTION_RULE_DECISION(FM_LIST, FR_LIST);

                        -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                        IF VG_RETURN_CODE < 0 THEN

                            -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                            ERROR_MARKING_PROCESS();

                            -- 룰 ID에 해당하는 판정 결과를 저장한다
                            INSERT_FRD_PROCESS();

                            -- 오라클 11G는 CONTINUE사용 그 이하는 GOTO
                            -- CONTINUE;

                            V_LOOP_FLAG := 'Y';

                        END IF;

                    END IF;

                    -- CHC 판정을 해야 하는 경우는 CTC 판정을 한다
                    IF V_LOOP_FLAG = 'N' THEN
                        -- LOOP CHECK

                        IF FR_LIST.CTH_RULE <> '*' THEN

                            -- CTC 판정 및 미소기준 판정  / 예외판정 및 복합판정(RVC)
                            COO_DECISION_FOR_CTC(FM_LIST, FR_LIST);

                            -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                            IF VG_RETURN_CODE < 0 THEN

                                -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                                ERROR_MARKING_PROCESS();

                                -- 룰 ID에 해당하는 판정 결과를 저장한다
                                INSERT_FRD_PROCESS();

                                -- 오라클 11G는 CONTINUE사용 그 이하는 GOTO
                                -- CONTINUE;

                                V_LOOP_FLAG := 'Y';

                            END IF;

                        END IF;

                    END IF; -- LOOP CHECK

                    /*
                    * RVC 룰 항목에 비율이 있는 경우에는 무조건 RVC 판정을 수행한다
                    * CTC + RVC가 있으므로 세번 변경기준 인 경우도 수행을 하도록 한다
                    */
                    IF V_LOOP_FLAG = 'N' THEN
                        -- LOOP CHECK

                        IF FR_LIST.BD_RULE > 0 OR
                           FR_LIST.BU_RULE > 0 OR
                           FR_LIST.NC_RULE > 0 OR
                           FR_LIST.MC_RULE > 0 THEN

                            COO_DECISION_FOR_RVC(FM_LIST, FR_LIST);

                            -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                            IF VG_RETURN_CODE < 0 THEN

                                -- 만일 예외 판정에서 에러가 발생한 경우는 해당 룰 ID를 ERROR로 처리 한다
                                ERROR_MARKING_PROCESS();

                                -- 룰 ID에 해당하는 판정 결과를 저장한다
                                INSERT_FRD_PROCESS();

                                -- 오라클 11G는 CONTINUE사용 그 이하는 GOTO
                                -- CONTINUE;

                                V_LOOP_FLAG := 'Y';

                            END IF;

                        END IF;

                    END IF; -- LOOP CHECK

                    /*
                    * 룰 ID에 대한 최종 판정은 모든 판정값이 N이 아니어야 한다
                    */

                    IF V_LOOP_FLAG = 'N' THEN
                        -- LOOP CHECK


                        -- 예외룰을 만족하지 못하고 결합 조건이 AND인 경우는 역외산으로 처리한다
                        -- 예외타입 16을 적용한 경우에 대해 추가 (2015.07.16)
                        -- 1. 예외타입 15, 예외타입 16 순으로 타는 경우 : VG_FRD_REC.EXCLUSION_CONDITION = 'AND'
                        -- 2. 예외타입 16, 예외타입 15 순으로 타는 경우 : VG_FRD_REC.EXCLUSION_CONDITION = 'AND'
                        -- 3. 예외타입 15만 타는 경우                   : VG_FRD_REC.EXCLUSION_CONDITION = 'E16'
                        IF FR_LIST.EXCLUSION_RULE_YN = 'Y' THEN

                            IF VG_FRD_REC.EXCLUSION_YN = 'N' AND
                               VG_FRD_REC.EXCLUSION_CONDITION = 'AND' THEN
                                VG_FRD_REC.FTA_COO_YN     := 'N';
                                VG_FRD_REC.COMPANY_COO_YN := 'N';
                                V_LOOP_FLAG               := 'Y';

                            ELSIF VG_FRD_REC.EXCLUSION_YN = 'Y' AND
                                VG_FRD_REC.EXCLUSION_CONDITION = 'E16' THEN
                                VG_FRD_REC.FTA_COO_YN     := 'Y';
                                VG_FRD_REC.COMPANY_COO_YN := 'Y';
                                VG_FRD_REC.EXCLUSION_CONDITION := 'AND';
                                V_LOOP_FLAG               := 'Y';

                            ELSIF VG_FRD_REC.EXCLUSION_YN = 'N' AND
                                VG_FRD_REC.EXCLUSION_CONDITION = 'E16' THEN
                                VG_FRD_REC.FTA_COO_YN     := 'N';
                                VG_FRD_REC.COMPANY_COO_YN := 'N';
                                VG_FRD_REC.EXCLUSION_CONDITION := 'AND';
                                V_LOOP_FLAG               := 'Y';

                            END IF;

                        END IF;

                        IF V_LOOP_FLAG = 'N' THEN

                            -- 기본룰이 없이 예외만 존재를 하는 경우에는 예외룰로만 판정을 처리한다
                            IF VG_FRD_REC.RULE_CODE = '-' THEN
                                -- 양허제외에 관한 HSCODE로 인해 제외인 경우 무조건 역외처리 추가 20161212
                                IF VG_FRD_REC.EXCLUSION_YN = 'Y' THEN
                                    VG_FRD_REC.FTA_COO_YN     := VG_FRD_REC.EXCLUSION_YN;
                                    VG_FRD_REC.COMPANY_COO_YN := VG_FRD_REC.EXCLUSION_YN;
                                    V_LOOP_FLAG               := 'Y';
                                ELSE
                                    VG_FRD_REC.FTA_COO_YN     := 'N';
                                    VG_FRD_REC.COMPANY_COO_YN := 'N';
                                    V_LOOP_FLAG               := 'Y';
                                END IF;


                            ELSE

                                -- 예외조건에 상관없이 모든것이 역내산으로 판정이 되었는지만 체크한다
                                IF NVL(VG_FRD_REC.SP_COO_YN, 'Y') = 'Y' AND
                                   NVL(VG_FRD_REC.WO_COO_YN, 'Y') = 'Y' AND
                                   (NVL(VG_FRD_REC.CTC_YN, 'Y') = 'Y' OR
                                    NVL(VG_FRD_REC.FTA_DE_MINIMIS_YN, 'N') = 'Y') AND
                                   NVL(VG_FRD_REC.FTA_RVC_YN, 'Y') = 'Y' THEN

                                    -- 협정기준 판정결과를 역내산으로 지정한다
                                    VG_FRD_REC.FTA_COO_YN := 'Y';

                                    -- 회사기준 충족여부를 체크 한다
                                    IF NVL(VG_FRD_REC.COMPANY_DE_MINIMIS_YN, 'Y') = 'Y' AND
                                       NVL(VG_FRD_REC.COMPANY_RVC_YN, 'Y') = 'Y' THEN
                                        VG_FRD_REC.COMPANY_COO_YN := 'Y';
                                    ELSE
                                        VG_FRD_REC.COMPANY_COO_YN := 'N';
                                    END IF;

                                    -- 룰ID건에 비역내가 존재 하므로 협정 및 회사의 결과를 모두 역외로 처리
                                ELSE
                                    VG_FRD_REC.FTA_COO_YN     := 'N';
                                    VG_FRD_REC.COMPANY_COO_YN := 'N';
                                END IF;
                            END IF; -- RULE_CONTENTS IF
                            
                        /**************************************
                      * RCEP                                *
                      **************************************/
                      IF FM_LIST.FTA_CODE = 'PKRRC' THEN
                        V_RCEP_NATION := '';
                        V_MP_ITEM_YN := '';
                        VG_RCEP_KR_YN := '';
                        VG_RCEP_COO_NATION := '';
                      
                        -- 0. RCEP 재료 원산지 확인
                        V_RCEP_NATION := GET_RCEP_NATION();
                        
                        -- 1. 한국산 원산지 재료로만 이루어진 경우
                        IF V_RCEP_NATION = 'KR' THEN
                          VG_FRD_REC.RCEP_COO_NATION := 'KR';
                          
                        -- 2. RCEP 회원국 원산지 재료로만 이루어진 경우(2개국이상)
                        ELSIF V_RCEP_NATION = 'RCEP' THEN
                          -- 2-1. 양허표 부록 해당인 경우
                          IF FM_LIST.TARIFF_YN = 'Y' THEN
                            -- 2-1-1. 한국산재료비 BD20 및 최대기여국 확인
                            GET_RCEP_RVC_NATION(FM_LIST.AMOUNT);
                            
                            -- 2-1-1-1. 한국산 재료비 BD20 이상 인 경우 한국
                            IF VG_RCEP_KR_YN = 'Y' THEN
                              VG_FRD_REC.RCEP_COO_NATION := 'KR';
                            -- 2-1-1-2. 한국산 재료비 BD20 미만 인 경우 최대기여국
                            ELSE
                              VG_FRD_REC.RCEP_COO_NATION := VG_RCEP_COO_NATION;
                            END IF;
                            
                          -- 2-2. 양허표 부록에 해당되지 않는 경우
                          ELSE
                            -- 2-2-1. 최소공정 이상 제외 품목인지 확인
                            V_MP_ITEM_YN := GET_MP_ITEM(FM_LIST.COMPANY_CODE, FM_LIST.DIVISION_CODE, FM_LIST.SALES_NO, FM_LIST.SALES_SEQ);
                            
                            -- 2-2-1-1. 최소공정 이상 인 경우 한국
                            IF V_MP_ITEM_YN = 'N' THEN
                              VG_FRD_REC.RCEP_COO_NATION := 'KR';
                            -- 2-2-1-2. 최소공정 제외 품목 인 경우 최대기여국 확인
                            ELSE
                              GET_RCEP_RVC_NATION(FM_LIST.AMOUNT);
                              VG_FRD_REC.RCEP_COO_NATION := VG_RCEP_COO_NATION;
                            END IF;
                          END IF;
                            
                        -- 3. PSR 충족 및 RCEP 회원국과 기타국가 재료가 혼합된 경우
                        ELSIF FM_LIST.TARIFF_YN = 'Y' AND VG_FRD_REC.COMPANY_COO_YN = 'Y' AND V_RCEP_NATION = 'ZZ' THEN
                          -- 3-1. 양허표 부록 해당인 경우
                          IF FM_LIST.TARIFF_YN = 'Y' THEN
                            -- 3-1-1. 한국산재료비 BD20 및 최대기여국 확인
                            GET_RCEP_RVC_NATION(FM_LIST.AMOUNT);
                            
                            -- 3-1-1-1. 한국산 재료비 BD20 이상 인 경우 한국
                            IF VG_RCEP_KR_YN = 'Y' THEN
                              VG_FRD_REC.RCEP_COO_NATION := 'KR';
                            -- 3-1-1-2. 한국산 재료비 BD20 미만 인 경우 최대기여국
                            ELSE
                              VG_FRD_REC.RCEP_COO_NATION := VG_RCEP_COO_NATION;
                            END IF;
                            
                          -- 3-2. 양허표 부록에 해당되지 않는 경우
                          ELSE
                            VG_FRD_REC.RCEP_COO_NATION := 'KR';
                          END IF;
                        END IF;
                      END IF;    
                            
                        END IF; -- LOOP IF

                        -- RULE ID 에 대하여 판정이 모두 이루어 졌으므로 결과를 저장한다
                        INSERT_FRD_PROCESS();

                    END IF;

                END IF; --제료비 금액이 0 이 아닐경우

                -- 예외룰에 대하여 해당 협정에서 처리를 한 경우에는 다시 초기화를 해야 한다
                -- 초기화를 하지 않응 경우 다른 협정의 예외처리가 그대로 적용이 되므로 반드시
                -- 초기화를 해야 한다
                IF FR_LIST.EXCLUSION_RULE_YN = 'Y' THEN

                    UPDATE FCR_INFO_TEMP
                    SET    EXCLUSION_RULE1_YN  = 'N'
                          ,EXCLUSION_RULE2_YN  = 'N'
                          ,EXCLUSION_RULE3_YN  = 'N'
                          ,EXCLUSION_RULE4_YN  = 'N'
                          ,EXCLUSION_RULE5_YN  = 'N'
                          ,EXCLUSION_RULE6_YN  = 'N'
                          ,EXCLUSION_RULE7_YN  = 'N'
                          ,EXCLUSION_RULE8_YN  = 'N'
                          ,EXCLUSION_RULE9_YN  = 'N'
                          ,EXCLUSION_RULE10_YN = 'N'
                          ,EXCLUSION_RULE11_YN = 'N'
                          ,EXCLUSION_RULE12_YN = 'N'
                          ,EXCLUSION_RULE13_YN = 'N'
                          ,EXCLUSION_RULE14_YN = 'N'
                    WHERE  FTA_CODE = FM_LIST.FTA_CODE
                    AND    DIVISION_CODE = FM_LIST.DIVISION_CODE
                    AND    COMPANY_CODE = FM_LIST.COMPANY_CODE
                    AND    PRODUCT_CODE = FM_LIST.PRODUCT_CODE;

                END IF;

                EXIT WHEN C_FTA_RULE%NOTFOUND;
            END LOOP;
            CLOSE C_FTA_RULE;

            /*
            * FCR RESULT MASTER 정보를 갱신 한다
            * 최종 판정을 한뒤 작업데이터를 초기화 한다
            */

            UPDATE_FRM_PROCEDURE(FM_LIST);

            -- 판정요펑번호에 해당하는 제품별로 처리를 하게 되므로 DB ERROR 외외는 한건씩 처리를 한다
            /*
            IF VG_RETURN_CODE = 0 THEN
                COMMIT;
            ELSE
                ROLLBACK;
            END IF;
            */

            DELETE FROM FCR_INFO_TEMP;

        --DBMS_OUTPUT.PUT_LINE('End decision...' || FM_LIST.PRODUCT_CODE || ':' ||
        --                     FM_LIST.FTA_CODE);

        END LOOP; -- FOR LOOP END

        -- 모든것이 정상적이므로 최종 COMMIT룰 수행한다
        O_RETURN_CODE := VG_RETURN_CODE;
        COMMIT;

        --DBMS_OUTPUT.PUT_LINE('PKG99_COO_DECISION : End Of Procedure');
        PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, '***** END PKG99_COO_DECISION');
        PKG00_PROCEDURE_LOG.BATCH_LOG_LAST(VG_LOG_ID, 'N');

        -- 에러 처리를 수행한다
    EXCEPTION
        WHEN OTHERS THEN
            VG_ERROR_CODE := 'COO_DECISION ERROR';
            VG_ERROR_MSG  := SQLCODE || ':' || SQLERRM;
            O_RETURN_CODE := -1;
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ' : ' ||
                                               VG_ERROR_MSG);
    END; --  PROCEDURE COO_DECISION

    /*
    ******************************************************************************
    * PROCEDURE NAME : COO_DECISION_FOR_RVC
    *    DESCRIPTION : 부가가치 기준 원산지 판정을 한다
    *
    *****************************************************************************
    */
    PROCEDURE COO_DECISION_FOR_RVC(I_FM_LIST IN FM_LIST
                                  ,I_FR_LIST IN FR_LIST) IS
        V_RVC_RATE         NUMBER(20, 8) := 0;
        V_FTA_RVC_RATE     NUMBER(20, 8) := 0;
        V_COMPANY_RVC_RATE NUMBER(20, 8) := 0;

        V_INAREA_AMOUNT   NUMBER(20, 8) := 0;
        V_OUTAREA_AMOUNT  NUMBER(20, 8) := 0;
        V_INPUT_AMOUNT    NUMBER(20, 8) := 0; -- NC를 위한 원재료 합산금액
        V_ZERO_AMOUNT_CNT NUMBER := 0; --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)

    BEGIN

        BEGIN
            SELECT SUM(NVL(INAREA_AMOUNT, 0)) AS INAREA_AMOUNT
                  ,SUM(NVL(OUTAREA_AMOUNT, 0)) AS OUTAREA_AMOUNT
                  ,SUM(NVL(INPUT_AMOUNT, 0)) AS INPUT_AMOUNT
                  ,SUM(DECODE(INPUT_AMOUNT, 0, 1, 0)) AS ZERO_AMOUNT_CNT --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
            INTO   V_INAREA_AMOUNT
                  ,V_OUTAREA_AMOUNT
                  ,V_INPUT_AMOUNT
                  ,V_ZERO_AMOUNT_CNT --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
            FROM   FCR_INFO_TEMP FI
            WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
            AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
            AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
            AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE;
        EXCEPTION
            WHEN OTHERS THEN
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, 'COO_DECISION_FOR_RVC ERR 1');
        END;

        /*
        * 재료비 금액 0인게 존재할경우 에러처리 위해 (dlee16)
        */
        IF V_ZERO_AMOUNT_CNT > 0 THEN
            -- ERROR 정보 설정
            VG_FRD_REC.FTA_RVC_YN     := 'N';
            VG_FRD_REC.COMPANY_RVC_YN := 'N';

            VG_FRD_REC.STATUS     := 'E';
            VG_FRD_REC.ERROR_CODE := 'MSG_FAILED_DECISION_QTY_AMOUNT';
            VG_FRD_REC.ERROR_MSG  := '소요량 또는 금액이 0 인 것이 존재합니다.';
        ELSE
            BEGIN
                /*
                * RVC 판정 방법에 따라 RATE를 먼저 구한다 KKKKKKKKK
                */
                IF I_FR_LIST.BU_RULE > 0 THEN
                    -- BU 판정을 수행
                    -- RVC RATE를 구한다
                    IF V_INAREA_AMOUNT > VG_INKOTERMS_AMOUNT THEN
                        -- FOM/EXWORK 금액 보다 역내금액 큰 경우 0
                        V_RVC_RATE := 0;
                    ELSE
                        V_RVC_RATE := (V_INAREA_AMOUNT / VG_INKOTERMS_AMOUNT) * 100;
                    END IF;

                    V_FTA_RVC_RATE := I_FR_LIST.BU_RULE;

                    V_COMPANY_RVC_RATE := V_FTA_RVC_RATE + VG_COMPANY_RVC_RATE;
                ELSIF I_FR_LIST.BD_RULE > 0 THEN
                    -- BD 판정을 수행
                    -- RVC RATE를 구한다
                    IF V_OUTAREA_AMOUNT > VG_INKOTERMS_AMOUNT THEN
                        -- FOM/EXWORK 금액 보다 역외금액 큰 경우 0
                        V_RVC_RATE := 0;
                    ELSE
                        V_RVC_RATE := ((VG_INKOTERMS_AMOUNT - V_OUTAREA_AMOUNT) /
                                      VG_INKOTERMS_AMOUNT) * 100;
                    END IF;

                    V_FTA_RVC_RATE := I_FR_LIST.BD_RULE;

                    V_COMPANY_RVC_RATE := V_FTA_RVC_RATE + VG_COMPANY_RVC_RATE;
                ELSIF I_FR_LIST.NC_RULE > 0 THEN
                    -- NC 판정을 수행
                    -- RVC RATE를 구한다
                    V_RVC_RATE     := ((V_INPUT_AMOUNT - V_OUTAREA_AMOUNT) /
                                      VG_NET_COST_AMOUNT) * 100;
                    V_FTA_RVC_RATE := I_FR_LIST.NC_RULE;

                    V_COMPANY_RVC_RATE := V_FTA_RVC_RATE + VG_COMPANY_RVC_RATE;
                ELSIF I_FR_LIST.MC_RULE > 0 THEN
                    -- MC 판정을 수행
                    -- RVC RATE를 구한다
                    IF V_OUTAREA_AMOUNT > VG_INKOTERMS_AMOUNT THEN
                        -- FOM/EXWORK 금액 보다 역외금액 큰 경우 0
                        V_RVC_RATE := 100;
                    ELSE
                        V_RVC_RATE := (V_OUTAREA_AMOUNT / VG_INKOTERMS_AMOUNT) * 100;
                    END IF;

                    V_FTA_RVC_RATE := I_FR_LIST.MC_RULE;

                    -- MC기준인 경우에는 회사버퍼 부분을 빼준다
                    V_COMPANY_RVC_RATE := V_FTA_RVC_RATE - VG_COMPANY_RVC_RATE;
                END IF;

                -- 협정기준 및 회사기준 데이터를 셋한다
                VG_FRD_REC.RVC_RESULT_RATE         := V_RVC_RATE;
                VG_FRD_REC.RVC_FTA_RESULT_RATE     := V_FTA_RVC_RATE;
                VG_FRD_REC.RVC_COMPANY_RESULT_RATE := V_COMPANY_RVC_RATE;

                -- 협정기준 충족여부를 체크한다
                -- MC 인경우와 이외의 경우를 나누어 판정한다
                IF I_FR_LIST.MC_RULE > 0 THEN

                    IF V_RVC_RATE <= V_FTA_RVC_RATE THEN
                        VG_FRD_REC.FTA_RVC_YN := 'Y';
                    ELSE
                        VG_FRD_REC.FTA_RVC_YN := 'N';
                    END IF;

                ELSE

                    IF V_RVC_RATE >= V_FTA_RVC_RATE THEN
                        VG_FRD_REC.FTA_RVC_YN := 'Y';
                    ELSE
                        VG_FRD_REC.FTA_RVC_YN := 'N';
                    END IF;

                END IF;

                -- 회사기준 충족여부를 체크한다
                -- MC 인경우와 이외의 경우를 나누어 판정한다
                IF I_FR_LIST.MC_RULE > 0 THEN

                    IF V_RVC_RATE <= V_COMPANY_RVC_RATE THEN
                        VG_FRD_REC.COMPANY_RVC_YN := 'Y';
                    ELSE
                        VG_FRD_REC.COMPANY_RVC_YN := 'N';
                    END IF;

                ELSE
                    IF V_RVC_RATE >= V_COMPANY_RVC_RATE THEN
                        VG_FRD_REC.COMPANY_RVC_YN := 'Y';
                    ELSE
                        VG_FRD_REC.COMPANY_RVC_YN := 'N';
                    END IF;
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, 'COO_DECISION_FOR_RVC ERR' ||
                                                       'BU:' ||
                                                       I_FR_LIST.BU_RULE || '|' ||
                                                       'BD:' ||
                                                       I_FR_LIST.BD_RULE || '|' ||
                                                       'BN:' ||
                                                       I_FR_LIST.NC_RULE || '|' ||
                                                       'MC:' ||
                                                       I_FR_LIST.MC_RULE || '|' ||
                                                       '역내금액:' ||
                                                       V_INAREA_AMOUNT || '|' ||
                                                       '역외금액:' ||
                                                       V_OUTAREA_AMOUNT || '|' ||
                                                       'FOB/EX:' ||
                                                       VG_INKOTERMS_AMOUNT || '|' ||
                                                       'RVC%:' ||
                                                       V_FTA_RVC_RATE || '|' ||
                                                       'COM%:' ||
                                                       VG_COMPANY_RVC_RATE);
            END;

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            VG_ERROR_CODE  := 'RVC ERROR';
            VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
            VG_RETURN_CODE := -1;
            --DBMS_OUTPUT.PUT_LINE(VG_ERROR_MSG);
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ':' ||
                                               VG_ERROR_MSG);

    END; -- END OF PROCEDURE

    /*
    ******************************************************************************
    * PROCEDURE NAME : COO_DECISION_FOR_CTC
    *    DESCRIPTION : 세번 변경 및 미소 기준을 판정 한다
    ******************************************************************************
    */
    PROCEDURE COO_DECISION_FOR_CTC(I_FM_LIST IN FM_LIST
                                  ,I_FR_LIST IN FR_LIST) IS

        -- 세번 변경기준 최종판정 결과를 담기 위한 변수
        V_CC_YN   VARCHAR2(1);
        V_CTH_YN  VARCHAR2(1);
        V_CTSH_YN VARCHAR2(1);

        V_TOTAL_COUNT    NUMBER(20, 8) := 0;
        V_OUTAREA_AMOUNT NUMBER(20, 8) := 0;
        V_MATCH_COUNT    NUMBER(20, 3) := 0;
        V_CC_CNT         NUMBER(20, 8) := 0;
        V_CC_AMOUNT      NUMBER(20, 8) := 0;
        V_CC_WEIGHT      NUMBER(20, 3) := 0;
        V_CTH_CNT        NUMBER(20, 8) := 0;
        V_CTH_AMOUNT     NUMBER(20, 8) := 0;
        V_CTH_WEIGHT     NUMBER(20, 3) := 0;
        V_CTSH_CNT       NUMBER(20, 8) := 0;
        V_CTSH_AMOUNT    NUMBER(20, 8) := 0;
        V_CTSH_WEIGHT    NUMBER(20, 3) := 0;

        -- 미소기준
        V_DE_MINIMIS_WEIGHT_RATE NUMBER(13, 8);
        V_DE_MINIMIS_AMOUNT_RATE NUMBER(13, 8);
        --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
        V_ZERO_AMOUNT_CNT NUMBER := 0;
        -- HS 코드 누락 건수
        V_NO_HSCODE_CNT NUMBER := 0;
    BEGIN

        BEGIN
            SELECT SUM(CASE
                           WHEN HS_CODE = ' ' THEN
                            1
                           ELSE
                            0
                       END) AS NO_HSCODE_CNT --- HS 코드 누락 포함
            INTO   V_NO_HSCODE_CNT
            FROM   FCR_INFO_TEMP FI
            WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
            AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
            AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
            AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE;

            IF V_NO_HSCODE_CNT > 0 THEN
                -- ERROR 정보 설정
                VG_FRD_REC.STATUS     := 'E';
                VG_FRD_REC.ERROR_CODE := 'TXT_HSCODE_INCLUDE_MISSING';
                VG_FRD_REC.ERROR_MSG  := 'HS 코드 누락 포함';

                RETURN;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, 'COO_DECISION_FOR_CTC ERR 1');
        END;

        -- CC CHECK
        SELECT CASE
                   WHEN OFI.CNT = FI.CC_CNT THEN
                    'Y'
                   ELSE
                    'N'
               END AS CC_YN
               -- CTH CHECK
              ,CASE
                   WHEN OFI.CNT = FI.CTH_CNT THEN
                    'Y'
                   ELSE
                    'N'
               END AS CTH_YN
               -- CTSH CHECK
              ,CASE
                   WHEN OFI.CNT = FI.CTSH_CNT THEN
                    'Y'
                   ELSE
                    'N'
               END AS CTSH_YN
              ,OFI.CNT AS TOTAL_COUNT
              ,OFI.OUTAREA_AMOUNT AS OUTAREA_AMOUNT
              ,OFI.MATCH_COUNT AS MATCH_COUNT
              ,OFI.ZERO_AMOUNT_CNT AS ZERO_AMOUNT_CNT --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
              ,FI.CC_CNT AS CC_CNT
              ,FI.CC_AMOUNT AS CC_AMOUNT
              ,FI.CC_WEIGHT AS CC_WEIGHT
              ,FI.CTH_CNT AS CTH_CNT
              ,FI.CTH_AMOUNT AS CTH_AMOUNT
              ,FI.CTH_WEIGHT AS CTH_WEIGHT
              ,FI.CTSH_CNT AS CTSH_CNT
              ,FI.CTSH_AMOUNT AS CTSH_AMOUNT
              ,FI.CTSH_WEIGHT AS CTSH_WEIGHT
        INTO   V_CC_YN
              ,V_CTH_YN
              ,V_CTSH_YN
              ,V_TOTAL_COUNT
              ,V_OUTAREA_AMOUNT
              ,V_MATCH_COUNT
              ,V_ZERO_AMOUNT_CNT --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
              ,V_CC_CNT
              ,V_CC_AMOUNT
              ,V_CC_WEIGHT
              ,V_CTH_CNT
              ,V_CTH_AMOUNT
              ,V_CTH_WEIGHT
              ,V_CTSH_CNT
              ,V_CTSH_AMOUNT
              ,V_CTSH_WEIGHT
        FROM   (SELECT NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 2) =
                                        SUBSTR(PARENT_HS_CODE, 1, 2) THEN
                                    0
                                   ELSE
                                    1
                               END), 0) AS CC_CNT

                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 2) =
                                        SUBSTR(PARENT_HS_CODE, 1, 2) THEN
                                    OUTAREA_AMOUNT
                                   ELSE
                                    0
                               END), 0) AS CC_AMOUNT

                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 2) =
                                        SUBSTR(PARENT_HS_CODE, 1, 2) THEN
                                    WEIGHT * OUTAREA_QTY
                                   ELSE
                                    0
                               END), 0) AS CC_WEIGHT
                       -- FOR CTH
                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 4) =
                                        SUBSTR(PARENT_HS_CODE, 1, 4) THEN
                                    0
                                   ELSE
                                    1
                               END), 0) AS CTH_CNT
                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 4) =
                                        SUBSTR(PARENT_HS_CODE, 1, 4) THEN
                                    OUTAREA_AMOUNT
                                   ELSE
                                    0
                               END), 0) AS CTH_AMOUNT

                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 4) =
                                        SUBSTR(PARENT_HS_CODE, 1, 4) THEN
                                    WEIGHT * OUTAREA_QTY
                                   ELSE
                                    0
                               END), 0) AS CTH_WEIGHT
                       -- FOR CTSH
                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 6) =
                                        SUBSTR(PARENT_HS_CODE, 1, 6) THEN
                                    0
                                   ELSE
                                    1
                               END), 0) AS CTSH_CNT
                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 6) =
                                        SUBSTR(PARENT_HS_CODE, 1, 6) THEN
                                    OUTAREA_AMOUNT
                                   ELSE
                                    0
                               END), 0) AS CTSH_AMOUNT

                      ,NVL(SUM(CASE
                                   WHEN SUBSTR(HS_CODE, 1, 6) =
                                        SUBSTR(PARENT_HS_CODE, 1, 6) THEN
                                    WEIGHT * OUTAREA_QTY
                                   ELSE
                                    0
                               END), 0) AS CTSH_WEIGHT
                FROM   FCR_INFO_TEMP FI
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0)
                AND    EXCLUSION_RULE7_YN = 'N' -- 예외판정에서 미리 업데이트 해놓은 항목
                ) FI
              ,(SELECT
                --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
                 SUM(CASE
                         WHEN FI.OUTAREA_QTY > 0 OR
                              FI.OUTAREA_AMOUNT > 0 THEN
                          1
                         ELSE
                          0
                     END) AS CNT
                ,SUM(DECODE(FI.INPUT_AMOUNT, 0, 1, 0)) AS ZERO_AMOUNT_CNT
                 --COUNT(*) AS CNT
                 -- 미소기준의 B 유형을 체크하기 위한 데이터 추출
                ,SUM(NVL(OUTAREA_AMOUNT, 0)) AS OUTAREA_AMOUNT
                ,SUM(CASE
                         WHEN (OUTAREA_AMOUNT > 0) AND
                              (SUBSTR(HS_CODE, 1, 6) = SUBSTR(PARENT_HS_CODE, 1, 6)) THEN
                          1
                         ELSE
                          0
                     END) AS MATCH_COUNT
                FROM   FCR_INFO_TEMP FI
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                      --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
                      --AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0)
                AND    EXCLUSION_RULE7_YN = 'N' -- 예외판정에서 미리 업데이트 해놓은 항목
                ) OFI;

        --- 재료비 금액 0인게 존재할경우 에러처리 위해(dlee16)
        IF V_ZERO_AMOUNT_CNT > 0 THEN
            -- ERROR 정보 설정
            VG_FRD_REC.FTA_DE_MINIMIS_YN     := 'N';
            VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
            VG_FRD_REC.CTC_YN                := 'N';

            VG_FRD_REC.STATUS     := 'E';
            VG_FRD_REC.ERROR_CODE := 'MSG_FAILED_DECISION_QTY_AMOUNT';
            VG_FRD_REC.ERROR_MSG  := '소요량 또는 금액이 0 인 것이 존재합니다.';

        ELSE

            -- CTH에 대한 판정 결과를 계산하여 SETTING 한다
            IF I_FR_LIST.CTH_RULE = 'CTSH' THEN
                VG_FRD_REC.CTC_YN := V_CTSH_YN;

                IF VG_NET_WEIGHT > 0 THEN
                    V_DE_MINIMIS_WEIGHT_RATE := (V_CTSH_WEIGHT / VG_NET_WEIGHT) * 100;
                END IF;

                --V_DE_MINIMIS_AMOUNT_RATE := (V_CTSH_AMOUNT / VG_INKOTERMS_AMOUNT) * 100;
                V_DE_MINIMIS_AMOUNT_RATE := (V_CTSH_AMOUNT / VG_DE_MINIMIS_INKOTERMS_AMOUNT) * 100;

            ELSIF I_FR_LIST.CTH_RULE = 'CTH' THEN
                VG_FRD_REC.CTC_YN := V_CTH_YN;

                IF VG_NET_WEIGHT > 0 THEN
                    V_DE_MINIMIS_WEIGHT_RATE := (V_CTH_WEIGHT / VG_NET_WEIGHT) * 100;
                END IF;

                --V_DE_MINIMIS_AMOUNT_RATE := (V_CTH_AMOUNT / VG_INKOTERMS_AMOUNT) * 100;
                V_DE_MINIMIS_AMOUNT_RATE := (V_CTH_AMOUNT / VG_DE_MINIMIS_INKOTERMS_AMOUNT) * 100;

            ELSIF I_FR_LIST.CTH_RULE = 'CC' THEN
                VG_FRD_REC.CTC_YN := V_CC_YN;

                IF VG_NET_WEIGHT > 0 THEN
                    V_DE_MINIMIS_WEIGHT_RATE := (V_CC_WEIGHT / VG_NET_WEIGHT) * 100;
                END IF;

                --V_DE_MINIMIS_AMOUNT_RATE := (V_CC_AMOUNT / VG_INKOTERMS_AMOUNT) * 100;
                V_DE_MINIMIS_AMOUNT_RATE := (V_CC_AMOUNT / VG_DE_MINIMIS_INKOTERMS_AMOUNT) * 100;

            END IF;

            -- 세번변경기준을 충족하지 못한 경우는 미소기준 적용을 체크한다
            IF VG_FRD_REC.CTC_YN = 'N' THEN

                -- 미소기준중에서 중량 단위가 적용되는지 체크한다
                IF I_FR_LIST.DE_MINIMIS_UNIT = 'W' THEN

                    -- 중량이 없는 경우에는 에러 처리를 한다
                    IF VG_NET_WEIGHT <= 0 THEN
                        VG_FRD_REC.FTA_DE_MINIMIS_YN     := 'N';
                        VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';

                        -- ERROR 정보 설정
                        VG_FRD_REC.STATUS     := 'E';
                        VG_FRD_REC.ERROR_CODE := 'DE_MINIMIS01';
                        VG_FRD_REC.ERROR_MSG  := 'Product Weight Not found!!';

                    ELSE
                        -- 협정기준 및 회사기준 데이터를 셋한다
                        VG_FRD_REC.CTC_RESULT_RATE         := V_DE_MINIMIS_WEIGHT_RATE;
                        VG_FRD_REC.CTC_FTA_RESULT_RATE     := I_FR_LIST.DE_MINIMIS_RATE;
                        VG_FRD_REC.CTC_COMPANY_RESULT_RATE := I_FR_LIST.DE_MINIMIS_RATE - VG_COMPANY_CTC_RATE;

                        -- 협정기준 충족여부를 체크한다
                        IF V_DE_MINIMIS_WEIGHT_RATE <= VG_FRD_REC.CTC_FTA_RESULT_RATE THEN
                            VG_FRD_REC.FTA_DE_MINIMIS_YN := 'Y';                               
                        ELSE
                            VG_FRD_REC.FTA_DE_MINIMIS_YN := 'N';

                        END IF;

                        -- 회사기준 충족여부를 체크한다
                        -- 회사기준은 협정기준 + 회사버퍼를 더해서 계산한다
                        IF V_DE_MINIMIS_WEIGHT_RATE <= VG_FRD_REC.CTC_COMPANY_RESULT_RATE THEN
                            VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'Y';
                            VG_FRD_REC.CTC_YN := 'Y';
                        ELSE
                            VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
                        END IF;
                    END IF;

                    -- 금액단위 A 타입이 적용되는지  체크
                ELSIF I_FR_LIST.DE_MINIMIS_UNIT = 'A' THEN

                    -- 협정기준 및 회사기준 데이터를 셋한다
                    VG_FRD_REC.CTC_RESULT_RATE         := V_DE_MINIMIS_AMOUNT_RATE;
                    VG_FRD_REC.CTC_FTA_RESULT_RATE     := I_FR_LIST.DE_MINIMIS_RATE;
                    VG_FRD_REC.CTC_COMPANY_RESULT_RATE := I_FR_LIST.DE_MINIMIS_RATE - VG_COMPANY_CTC_RATE;

                    -- 협정기준 충족여부를 체크한다
                    IF V_DE_MINIMIS_AMOUNT_RATE <=
                       VG_FRD_REC.CTC_FTA_RESULT_RATE THEN
                        VG_FRD_REC.FTA_DE_MINIMIS_YN := 'Y';
                    ELSE
                        VG_FRD_REC.FTA_DE_MINIMIS_YN := 'N';
                    END IF;

                    -- 회사기준 충족여부를 체크한다
                    -- 회사기준은 협정기준 + 회사버퍼를 더해서 계산한다
                    IF V_DE_MINIMIS_AMOUNT_RATE <=
                       VG_FRD_REC.CTC_COMPANY_RESULT_RATE THEN
                        VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'Y';
                        VG_FRD_REC.CTC_YN := 'Y';
                    ELSE
                        VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
                    END IF;

                    -- 금액단위 B 타입이 적용되는지   체크
                ELSIF I_FR_LIST.DE_MINIMIS_UNIT = 'B' THEN

                    -- 제품금액대비 비역내산 재료비에 대한 비율을 계산한다
                    IF V_OUTAREA_AMOUNT > VG_INKOTERMS_AMOUNT THEN
                        VG_FRD_REC.CTC_RESULT_RATE := 100;
                    ELSE
                        VG_FRD_REC.CTC_RESULT_RATE := (V_OUTAREA_AMOUNT /
                                                      VG_INKOTERMS_AMOUNT) * 100;
                    END IF;

                    VG_FRD_REC.CTC_FTA_RESULT_RATE     := I_FR_LIST.DE_MINIMIS_RATE;
                    VG_FRD_REC.CTC_COMPANY_RESULT_RATE := I_FR_LIST.DE_MINIMIS_RATE - VG_COMPANY_CTC_RATE;

                    -- 같은 6단위 세번이 있으면 미충족 처리를 한다
                    IF V_MATCH_COUNT > 0 THEN
                        VG_FRD_REC.FTA_DE_MINIMIS_YN     := 'N';
                        VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
                    ELSE

                        -- 협정기준 충족여부를 체크한다
                        IF VG_FRD_REC.CTC_RESULT_RATE <=
                           VG_FRD_REC.CTC_FTA_RESULT_RATE THEN
                            VG_FRD_REC.FTA_DE_MINIMIS_YN := 'Y';
                        ELSE
                            VG_FRD_REC.FTA_DE_MINIMIS_YN := 'N';
                        END IF;

                        -- 회사기준 충족여부를 체크한다
                        -- 회사기준은 협정기준 + 회사버퍼를 더해서 계산한다
                        IF VG_FRD_REC.CTC_RESULT_RATE <=
                           VG_FRD_REC.CTC_COMPANY_RESULT_RATE THEN
                            VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'Y';
                            VG_FRD_REC.CTC_YN := 'Y';
                        ELSE
                            VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
                        END IF;

                    END IF;
                    -- 미소기준이 적용이 되지 않는 항목이므로 모두 역외처리를 한다
                ELSE
                    VG_FRD_REC.CTC_FTA_RESULT_RATE     := NULL;
                    VG_FRD_REC.CTC_COMPANY_RESULT_RATE := NULL;
                END IF;

            END IF;

        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            VG_ERROR_CODE  := 'CTC ERROR';
            VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
            VG_RETURN_CODE := -1;
            --DBMS_OUTPUT.PUT_LINE(VG_ERROR_MSG);
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ':' || VG_ERROR_MSG);

    END;

    /*
    ******************************************************************************
    * PROCEDURE NAME : EXCLUTION_RULE_DECISION
    *    DESCRIPTION : 예외룰에 대한 처리를 수행 한다
    *
    *****************************************************************************
    */
    PROCEDURE EXCLUTION_RULE_DECISION(I_FM_LIST IN FM_LIST -- FCR MASTER 정보
                                     ,I_FR_LIST IN FR_LIST -- 룰 정보
                                      ) IS

        -- 최종 판정결과를 담기 위한 변수
        V_EXCLUSION_YN VARCHAR2(1) := 'Y';
        --V_OR_HOLD_JOIN_CONDITION FTA_EXCLUSION_RULE.JOIN_CONDITION%TYPE  := '';
        --V_AND_HOLD_JOIN_CONDITION FTA_EXCLUSION_RULE.JOIN_CONDITION%TYPE := '';
        V_OR_HOLD_EXCLUSION_YN  VARCHAR2(1) := '';
        V_AND_HOLD_EXCLUSION_YN VARCHAR2(1) := '';

        /*
        * 예외처리 관련 룰 커서를 선언한다
        * 단 수리화를 할 수 없는 9,10,12번 유형은 제외를 한다
        * FTA 룰 데이터는 동일한 FTA/ HS코드/예외유형에 대해서는 결합조건 및 RATE가 동일하다
        */
        CURSOR C_FTA_EXCLUSION_RULE(V_FTA_CODE             IN FTA_EXCLUSION_RULE.FTA_CODE%TYPE
                                   ,V_HS_CODE              IN FTA_EXCLUSION_RULE.HS_CODE%TYPE
                                   ,V_HS_CODE_SUB_CATEGORY IN FTA_EXCLUSION_RULE.HS_CODE_SUB_CATEGORY%TYPE
                                   ,V_RULE_SEQ             IN FTA_EXCLUSION_RULE.RULE_SEQ%TYPE) IS
            SELECT DISTINCT EXCLUSION_TYPE
                           ,JOIN_CONDITION
                           ,EXCLUSION_RATE
            FROM   FTA_EXCLUSION_RULE
            WHERE  FTA_CODE = V_FTA_CODE
            AND    HS_CODE = V_HS_CODE
            AND    HS_CODE_SUB_CATEGORY = V_HS_CODE_SUB_CATEGORY
            AND    RULE_SEQ = V_RULE_SEQ
            ORDER  BY TO_NUMBER(EXCLUSION_TYPE); -- CURSOR END
    BEGIN

        -- 글로벌 변수 초기화
        VG_RETURN_CODE := 0;
        -- 예외타입 16번만을 위한 변수 초기화 (20150716)
        VG_FRD_REC.EXCLUSION_CONDITION := '000';

        -- 예외조건 판정을 위하여 현재 선택된 룰의 정보를 이용하여 예외룰 정보를 읽어 온다
        FOR FER_LIST IN C_FTA_EXCLUSION_RULE(I_FR_LIST.FTA_CODE, I_FR_LIST.HS_CODE, I_FR_LIST.HS_CODE_SUB_CATEGORY, I_FR_LIST.RULE_SEQ)
        LOOP
            /*
            * 예외 TYPE 1 : IF 특정물픔 중량 조건으로서 세번번경기준 + 특정 HS CODE들의 비역내산 투입합계 중량이
            *               총중량의 몇 %를 넘어가지 않아야 한다
            *  대상 협정 : EU, 미국, 아세안
            */

            /*
                                     WHEN ( ( SUM( DECODE (  SUBSTR(FI.HS_CODE,1,LENGTH(FER.EXCLUSION_HS_CODE)),
                                 FER.EXCLUSION_HS_CODE,  TRUNC( (FI.WEIGHT * OUTAREA_QTY),3), 0 ))
                                    /  SUM(NVL(WEIGHT,0) * NVL(FI.REQUIREMENT_QTY,0 ) )  )  * 100 ) <  FER_LIST.EXCLUSION_RATE  THEN
            */

            IF FER_LIST.EXCLUSION_TYPE = '1' THEN

                SELECT CASE
                           WHEN NVL(((SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, TRUNC((FI.WEIGHT *
                                                        OUTAREA_QTY), 3), 0)) /
                                    NULLIF(SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, TRUNC((FI.WEIGHT *
                                                               NVL(FI.REQUIREMENT_QTY, 0)), 3), 0)), 0)) * 100), 0) <
                                FER_LIST.EXCLUSION_RATE THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                      ,(SELECT *
                        FROM   FTA_EXCLUSION_RULE FER
                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                        AND    HS_CODE = I_FR_LIST.HS_CODE
                        AND    HS_CODE_SUB_CATEGORY =
                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0); -- SQL END

                /*
                * 예외 TYPE 2 : 특정 HS CODE 는 완전 생산 조건을 충족해야함
                *               CC   + 특정호는 완전생산할 것
                *  대상 협정 : EU, 아세안
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '2' THEN

                -- 완전생산 기준은 사용자의 입력으로 부터 데이터를 받아서 처리 함
                V_EXCLUSION_YN := I_FM_LIST.WO_COO_YN;

                /*
                * 예외 TYPE 3 : CTH에서 세번변경이 되지 않은 비역내산 원재료에 대해 제품과 6자리 세번이 동일한
                *               아이템이 있는 경우에는 미소기준을 적용하지 아니하는 규정
                *               해당하는 룰이 단한건임
                *  대상 협정 : 아세안
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '3' THEN

                SELECT CASE
                           WHEN COUNT(*) > 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP AA
                WHERE  EXISTS
                 (SELECT FI.*
                        FROM   (SELECT *
                                FROM   FCR_INFO_TEMP
                                WHERE  FTA_CODE = I_FM_LIST.FTA_CODE
                                AND    DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                                AND    COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                                AND    PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE) FI
                              ,(SELECT EXCLUSION_HS_CODE
                                FROM   FTA_EXCLUSION_RULE
                                WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                AND    HS_CODE = I_FR_LIST.HS_CODE
                                AND    HS_CODE_SUB_CATEGORY =
                                       I_FR_LIST.HS_CODE_SUB_CATEGORY
                                AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                        WHERE  SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)) =
                               FER.EXCLUSION_HS_CODE
                        AND    FI.FTA_CODE = AA.FTA_CODE
                        AND    FI.DIVISION_CODE = AA.DIVISION_CODE
                        AND    FI.COMPANY_CODE = AA.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = AA.PRODUCT_CODE
                        AND    FI.ITEM_CODE = AA.ITEM_CODE); -- SQL END

                /*
                * 예외 TYPE 4 : 특정 HS CODE에 해당하는 비역내산 원재료의 재료비 금액이 물픔가격의 일정 비율이하여야 한다
                *  대상 협정 : EU, EFTA, 아세안
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '4' THEN

                SELECT CASE
                           WHEN NVL(((SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, OUTAREA_AMOUNT, 0)) /
                                    VG_INKOTERMS_AMOUNT) * 100), 0) <
                                MAX(FER.EXCLUSION_RATE) THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                      ,(SELECT *
                        FROM   FTA_EXCLUSION_RULE FER
                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                        AND    HS_CODE = I_FR_LIST.HS_CODE
                        AND    HS_CODE_SUB_CATEGORY =
                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0); -- SQL END

                /*
                * 예외 TYPE 5 : 가공공정기준 인경우
                *               CC   + 특정호는 완전생산할 것
                *  대상 협정 : EU, EFTA, 인도, 미국, 아세안 , 칠레, 싱가폴, 페루
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '5' THEN

                -- 가공공정  기준은 사용자의 입력으로 부터 데이터를 받아서 처리 함
                V_EXCLUSION_YN := I_FM_LIST.SP_COO_YN;

                /*
                * 예외 TYPE 6 : 특정 HS CODE에 대한 원재료의 원산지가 반드시 역내산 이어야 함
                *               CC  + 특정호의 재료는 원산지재료 일것
                *  대상 협정 : EU, 아세안
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '6' THEN

                SELECT CASE
                           WHEN NVL(CEIL(SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, OUTAREA_QTY, 0))), 0) = 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                      ,(SELECT *
                        FROM   FTA_EXCLUSION_RULE FER
                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                        AND    HS_CODE = I_FR_LIST.HS_CODE
                        AND    HS_CODE_SUB_CATEGORY =
                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0); -- SQL END

                /*
                * 예외 TYPE 7 : 특정 HS CODE를 제조하기 위하여 투입된 원재료 중에서 비역내산 이더라도 협정에서 정한 HS CODE인 경우
                *               역내산으로 인정하는 규정  ( 즉 역내산으로 인정을 함 )
                *               따라서 세번변경시 해당 원재료 HS CODE는 ？고 판정을 하도록 한다
                *  대상 협정 : 싱가폴, 아세안, 칠레, 미국, EU
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '7' THEN

                -- 이부분은 세번 변경 기준에서 사용을 해야 하므로 세번 변경  판정을 위하여 데이터만 업데이트 해둠
                UPDATE FCR_INFO_TEMP AA
                SET    EXCLUSION_RULE7_YN = 'Y'
                WHERE  EXISTS
                 (SELECT FI.*
                        FROM   (SELECT *
                                FROM   FCR_INFO_TEMP
                                WHERE  FTA_CODE = I_FM_LIST.FTA_CODE
                                AND    DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                                AND    COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                                AND    PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE) FI
                              ,(SELECT EXCLUSION_HS_CODE
                                FROM   FTA_EXCLUSION_RULE
                                WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                AND    HS_CODE = I_FR_LIST.HS_CODE
                                AND    HS_CODE_SUB_CATEGORY =
                                       I_FR_LIST.HS_CODE_SUB_CATEGORY
                                AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                        WHERE  SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)) =
                               FER.EXCLUSION_HS_CODE
                        AND    FI.FTA_CODE = AA.FTA_CODE
                        AND    FI.DIVISION_CODE = AA.DIVISION_CODE
                        AND    FI.COMPANY_CODE = AA.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = AA.PRODUCT_CODE
                        AND    FI.ITEM_CODE = AA.ITEM_CODE)

                ; -- SQL END

                -- 이규정은 나중에 세번 변경 기준에서 적용이 되므로 예외조건 판정은 역내산으로 설정한다
                V_EXCLUSION_YN := 'Y';

                /*
                * 예외 TYPE 8 : 특정 비역내산 HS CODE에 대하여 제품세번과 HS CODE가 달라도 세번 변경으로
                *               인정하지 않는 규정
                *               따라서 해당 원재료 세번이 들어간 경우에는 세번 번경이 되지 않는다
                *  대상 협정 : EU, EFTA, 미국, 아세안, 인도, 칠레, 싱가폴, 페루
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '8' THEN

                SELECT CASE
                           WHEN NVL(SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, 1, 0)), 0) = 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                      ,(SELECT *
                        FROM   FTA_EXCLUSION_RULE FER
                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                        AND    HS_CODE = I_FR_LIST.HS_CODE
                        AND    HS_CODE_SUB_CATEGORY =
                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0); -- SQL END

                /*
                * 예외 TYPE 9 : 수리화를 할수 없는 룰이므로 무조건 비역내로 처리를 한다
                *    대상 협정 : 아세안, 칠레, EFTA, EU, 싱가포르, 미국
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '9' THEN

                V_EXCLUSION_YN := 'N';

                /*
                * 예외 TYPE 10 : 제품생산시 반드시 원재료 HS CODE가 '4017001000'를 투입하여 생산되어야
                *                하는  규정
                *  대상 협정 : EFTA
                */

            ELSIF FER_LIST.EXCLUSION_TYPE = '10' THEN

                SELECT CASE
                           WHEN COUNT(*) = 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    FI.HS_CODE <> '4017001000'; -- SQL END

                /*
                * 예외 TYPE 11 : 제품 제조 시 투입된 원재료는 협정에서 정한 특정 HS CODE에 해당하는
                *                원재료가 투입되어야한다
                *  대상 협정 : EU, 미국, 인도, 칠레
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '11' THEN

                SELECT CASE
                           WHEN FI.CNT > 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   (SELECT COUNT(*) CNT
                        FROM   FCR_INFO_TEMP FI
                        WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                        AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                        AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                        AND    EXISTS
                         (SELECT 1
                                FROM   (SELECT *
                                        FROM   FTA_EXCLUSION_RULE FER
                                        WHERE  EXCLUSION_TYPE =
                                               FER_LIST.EXCLUSION_TYPE
                                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                        AND    HS_CODE = I_FR_LIST.HS_CODE
                                        AND    HS_CODE_SUB_CATEGORY =
                                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                                WHERE  FER.EXCLUSION_HS_CODE =
                                       SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)))) FI; -- SQL END

                /*
                * 예외 TYPE 12 : 수리화를 할수 없는 룰이므로 무조건 비역내로 처리를 한다
                *    대상 협정 : 아세안, 칠레, EFTA, EU, 싱가포르, 미국
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '12' THEN

                V_EXCLUSION_YN := 'N';

                /*
                * 예외 TYPE 13 : MC 조건을 충족한 경우라도 역외산 재료 금액이 역내산 재료 금액을
                *                초과하지 않는 규정
                *  대상 협정 : EU
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '13' THEN

                SELECT CASE
                           WHEN SUM(OUTAREA_AMOUNT) <= SUM(INAREA_AMOUNT) THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE; -- SQL END

                /*
                * 예외 TYPE 14 : 제품 HS CODE의 같은류에 해당하는 원재료로 부터 반드시 생산이 되어야 함
                *                또한 미국의 특정 HS CODE에 대해서만 적용이 되므로 수리화 및 로직화를 만들기
                *                어려움에 따라 하드코딩으로 처리를 한다
                *  대상 협정 : 미국
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '14' THEN
                SELECT CASE
                           WHEN FI.CNT >= OFI.CNT THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   (SELECT COUNT(*) CNT
                        FROM   FCR_INFO_TEMP FI
                        WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                        AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                        AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                        AND    EXISTS
                         (SELECT 1
                                FROM   (SELECT *
                                        FROM   FTA_EXCLUSION_RULE FER
                                        WHERE  EXCLUSION_TYPE =
                                               FER_LIST.EXCLUSION_TYPE
                                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                        AND    HS_CODE = I_FR_LIST.HS_CODE
                                        AND    HS_CODE_SUB_CATEGORY =
                                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                                WHERE  (FER.EXCLUSION_HS_CODE =
                                       SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE))
                                       -- 룰 제품세번이 2106이고 FCR의 HS CODE가 2009면 원산지로 인정
                                       -- 비슷한 US 룰에 대하여 하드 코딩을 함
                                       OR DECODE(FER.HS_CODE, '2106', DECODE(SUBSTR(FI.HS_CODE, 1, 4), '2009', '2009', '0'), '0') =
                                       '2009' OR DECODE(FER.HS_CODE, '2106', DECODE(SUBSTR(FI.HS_CODE, 1, 6), '220290', '220290', '0000'), '0000') =
                                       '220290' OR DECODE(FER.HS_CODE, '220290', DECODE(SUBSTR(FI.HS_CODE, 1, 4), '2009', '2009', '0'), '0') =
                                       '2009' OR DECODE(FER.HS_CODE, '220290', DECODE(SUBSTR(FI.HS_CODE, 1, 6), '210690', '210690', '0'), '0') =
                                       '210690')
                                AND    ('200990' <>
                                      SUBSTR(FI.HS_CODE, 1, LENGTH('200990'))))) FI
                      ,(SELECT COUNT(*) CNT
                        FROM   FCR_INFO_TEMP FI
                        WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                        AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                        AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE) OFI; -- SQL END

                /*
                * 예외 TYPE 15 : 제3901호부터 제3915호까지에 해당하는 비원산지 폴리머의 중량이 해당 물품의 폴리머 전체 중량의 40%를 초과하지 않는 것
                *  대상 HS코드 : 39
                *  대상 협정 : 캐나다
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '15' THEN
                     SELECT CASE
                         WHEN ((SUM(
                           CASE SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE))
                             WHEN FER.EXCLUSION_HS_CODE
                               THEN ROUND((FI.WEIGHT * FI.OUTAREA_QTY), 8)
                             ELSE 0
                           END) / NULLIF(ROUND(SUM(FI.WEIGHT * NVL(FI.REQUIREMENT_QTY, 0)), 8), 0)
                           ) * 100) < FER_LIST.EXCLUSION_RATE THEN 'Y'
                         ELSE 'N'
                       END
                   INTO   V_EXCLUSION_YN
                   FROM   FCR_INFO_TEMP FI
                         ,(SELECT FER1.RULE_ID,
                                  FER1.FTA_CODE,
                                  FER1.HS_CODE,
                                  FER1.HS_CODE_SUB_CATEGORY,
                                  FER1.RULE_SEQ,
                                  FER1.EXCLUSION_TYPE,
                                  FER1.JOIN_CONDITION,
                                  FER1.EXCLUSION_HS_CODE,
                                  FER1.EXCLUSION_RATE,
                                  FER1.EXCLUSION_RULE_DESCRIPTION
                             FROM FTA_EXCLUSION_RULE FER1
                            WHERE FER1.EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                              AND FER1.FTA_CODE = I_FR_LIST.FTA_CODE
                              AND FER1.HS_CODE = I_FR_LIST.HS_CODE
                              AND FER1.HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                              AND FER1.RULE_SEQ = I_FR_LIST.RULE_SEQ
                            ) FER
                   WHERE FI.FTA_CODE = I_FM_LIST.FTA_CODE
                     AND FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                     AND FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                     AND FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                     AND FI.HS_CODE LIKE '39%';

                 /* SELECT CASE
                         WHEN ((SUM(
                           CASE SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE))
                             WHEN FER.EXCLUSION_HS_CODE
                               THEN ROUND((FI.WEIGHT * FI.OUTAREA_QTY), 8)
                             ELSE 0
                           END) / NULLIF(SUM(
                           CASE SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE))
                             WHEN FER.EXCLUSION_HS_CODE
                               THEN ROUND(FI.WEIGHT * NVL(FI.REQUIREMENT_QTY, 0), 8)
                             ELSE 0
                           END), 0)) * 100) < FER_LIST.EXCLUSION_RATE THEN 'Y'
                         ELSE 'N'
                       END
                   INTO   V_EXCLUSION_YN
                   FROM   FCR_INFO_TEMP FI
                         ,(SELECT FER1.RULE_ID,
                                  FER1.FTA_CODE,
                                  FER1.HS_CODE,
                                  FER1.HS_CODE_SUB_CATEGORY,
                                  FER1.RULE_SEQ,
                                  FER1.EXCLUSION_TYPE,
                                  FER1.JOIN_CONDITION,
                                  FER1.EXCLUSION_HS_CODE,
                                  FER1.EXCLUSION_RATE,
                                  FER1.EXCLUSION_RULE_DESCRIPTION
                             FROM FTA_EXCLUSION_RULE FER1
                            WHERE FER1.EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                              AND FER1.FTA_CODE = I_FR_LIST.FTA_CODE
                              AND FER1.HS_CODE = I_FR_LIST.HS_CODE
                              AND FER1.HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                              AND FER1.RULE_SEQ = I_FR_LIST.RULE_SEQ
                            ) FER
                   WHERE FI.FTA_CODE = I_FM_LIST.FTA_CODE
                     AND FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                     AND FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                     AND FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                     AND FI.HS_CODE LIKE '39%'; -- SQL END */

            /*
            * 예외 TYPE 16 : 1. 제품 제조 시 투입된 원재료는 협정에서 정한 특정 HS CODE에 해당하는 원재료가 투입되어야한다 (TYPE 11)
            *                2. 특정 HS CODE에 해당하는 비역내산 원재료의 재료비 금액이 물픔가격의 일정 비율 이하여야 한다  (TYPE 4)
            *                3. 특정 HS CODE를 제외한 세번변경이 이루어지지 않은 자재에 대해서는 협정에서 명시된 기준으로 미소기준을 적용한다
            *  대상 협정   : 캐나다
            */
            ELSIF FER_LIST.EXCLUSION_TYPE = '16' THEN
                -- 1. 제품 제조 시 투입된 원재료는 협정에서 정한 특정 HS CODE에 해당하는 원재료가 투입되어야한다 (TYPE 11)
                --    특정 HS CODE가 들어가 있지 않으면 무조건 역외
                SELECT CASE
                           WHEN FI.CNT > 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   (SELECT COUNT(*) CNT
                        FROM   FCR_INFO_TEMP FI
                        WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                        AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                        AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                        AND    EXISTS (SELECT 1
                                       FROM   (SELECT *
                                               FROM   FTA_EXCLUSION_RULE FER
                                               WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                               AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                               AND    HS_CODE = I_FR_LIST.HS_CODE
                                               AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                                               AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                                       WHERE  FER.EXCLUSION_HS_CODE = SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)))) FI;


                -- 특정 HS CODE가 있으면 다음 조건을 수행
                IF V_EXCLUSION_YN = 'Y' THEN
                    -- 2. 특정 HS CODE에 해당하는 비역내산 원재료의 재료비 금액이 물픔가격의 일정 비율 이하여야 한다 (TYPE 4)
                    --    여기서 주의할 점은 특정 HS CODE가 여러개일 경우 비역내산 재료비 합이여야 한다
                    SELECT CASE
                               WHEN NVL(((SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)),
                                                     FER.EXCLUSION_HS_CODE,
                                                     OUTAREA_AMOUNT,
                                                     0)) / VG_INKOTERMS_AMOUNT) * 100),
                                        0) < MAX(FER.EXCLUSION_RATE) THEN
                                'Y'
                               ELSE
                                'N'
                           END
                    INTO   V_EXCLUSION_YN
                    FROM   FCR_INFO_TEMP FI
                          ,(SELECT *
                            FROM   FTA_EXCLUSION_RULE FER
                            WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                            AND    FTA_CODE = I_FR_LIST.FTA_CODE
                            AND    HS_CODE = I_FR_LIST.HS_CODE
                            AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                            AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                    WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                    AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                    AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                    AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                    AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0);

                    -- 특정 HS CODE에 해당하는 비역내산 원재료의 재료비 금액이 물픔가격의 일정 비율 이하이면
                    IF V_EXCLUSION_YN = 'Y' THEN
                        -- 3. 특정 HS CODE를 제외한 세번변경이 이루어지지 않은 자재에 대해서는 협정에서 명시된 기준으로 미소기준을 적용한다
                        --    세번변경이 안된 자재중에서 특정 HS CODE를 제외하고 그중 역외산 재료비 합의 미소기준을 확인한다.

                        IF I_FR_LIST.CTH_RULE = 'CC' THEN
                            SELECT CASE
                                       WHEN NVL(((SUM(CASE
                                                          WHEN SUBSTR(FI.HS_CODE,1,2) = SUBSTR(FI.PARENT_HS_CODE,1,2) THEN
                                                            FI.OUTAREA_AMOUNT
                                                          ELSE 0
                                                      END)/ VG_INKOTERMS_AMOUNT) * 100),
                                               0) < MAX(I_FR_LIST.DE_MINIMIS_RATE)
                                       THEN
                                         'Y'
                                       ELSE
                                         'N'
                                   END
                            INTO   V_EXCLUSION_YN
                            FROM   FCR_INFO_TEMP FI
                            WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                            AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                            AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                            AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                            AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0)
                            AND    NOT EXISTS (SELECT 1
                                               FROM   FTA_EXCLUSION_RULE FER
                                               WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                               AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                               AND    HS_CODE = I_FR_LIST.HS_CODE
                                               AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                                               AND    RULE_SEQ = I_FR_LIST.RULE_SEQ
                                               AND    FER.EXCLUSION_HS_CODE = SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)));



                        ELSIF I_FR_LIST.CTH_RULE = 'CTH' THEN
                            SELECT CASE
                                       WHEN NVL(((SUM(CASE
                                                          WHEN SUBSTR(FI.HS_CODE,1,4) = SUBSTR(FI.PARENT_HS_CODE,1,4) THEN
                                                            FI.OUTAREA_AMOUNT
                                                          ELSE 0
                                                      END)/ VG_INKOTERMS_AMOUNT) * 100),
                                               0) < MAX(I_FR_LIST.DE_MINIMIS_RATE)
                                       THEN
                                         'Y'
                                       ELSE
                                         'N'
                                   END
                            INTO   V_EXCLUSION_YN
                            FROM   FCR_INFO_TEMP FI
                            WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                            AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                            AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                            AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                            AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0)
                            AND    NOT EXISTS (SELECT 1
                                               FROM   FTA_EXCLUSION_RULE FER
                                               WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                               AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                               AND    HS_CODE = I_FR_LIST.HS_CODE
                                               AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                                               AND    RULE_SEQ = I_FR_LIST.RULE_SEQ
                                               AND    FER.EXCLUSION_HS_CODE = SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)));


                        ELSIF I_FR_LIST.CTH_RULE = 'CTSH' THEN
                            SELECT CASE
                                       WHEN NVL(((SUM(CASE
                                                          WHEN SUBSTR(FI.HS_CODE,1,6) = SUBSTR(FI.PARENT_HS_CODE,1,6) THEN
                                                            FI.OUTAREA_AMOUNT
                                                          ELSE 0
                                                      END)/ VG_INKOTERMS_AMOUNT) * 100),
                                               0) < MAX(I_FR_LIST.DE_MINIMIS_RATE)
                                       THEN
                                         'Y'
                                       ELSE
                                         'N'
                                   END
                            INTO   V_EXCLUSION_YN
                            FROM   FCR_INFO_TEMP FI
                            WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                            AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                            AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                            AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                            AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0)
                            AND    NOT EXISTS (SELECT 1
                                               FROM   FTA_EXCLUSION_RULE FER
                                               WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                               AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                               AND    HS_CODE = I_FR_LIST.HS_CODE
                                               AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                                               AND    RULE_SEQ = I_FR_LIST.RULE_SEQ
                                               AND    FER.EXCLUSION_HS_CODE = SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE))) ;


                        -------------------------------------

                        /*
                * 예외 TYPE 17 : 제품 제조 시 투입된 원재료는 협정에서 정한 특정 HS CODE에 해당하는 원재료가 투입되어야한다.
                *                특정 HS CODE에 해당하는 원재료의 비원산지 재료의 가치가 해당 물품의 거래가치 또는 공장도가격의 초과하지 않는 경우에 한정한다.
                *  대상 협정 : 캐나다
                */
            ELSIF FER_LIST.EXCLUSION_TYPE = '17' THEN


                SELECT CASE
                           WHEN FI.CNT > 0 THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   (SELECT COUNT(*) CNT
                        FROM   FCR_INFO_TEMP FI
                        WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                        AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                        AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                        AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                        AND    EXISTS
                         (SELECT 1
                                FROM   (SELECT *
                                        FROM   FTA_EXCLUSION_RULE FER
                                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                                        AND    HS_CODE = I_FR_LIST.HS_CODE
                                        AND    HS_CODE_SUB_CATEGORY = I_FR_LIST.HS_CODE_SUB_CATEGORY
                                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                                WHERE  FER.EXCLUSION_HS_CODE =
                                       SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)))) FI; -- SQL END

              IF V_EXCLUSION_YN = 'Y' THEN
              SELECT CASE
                           WHEN NVL(((SUM(DECODE(SUBSTR(FI.HS_CODE, 1, LENGTH(FER.EXCLUSION_HS_CODE)), FER.EXCLUSION_HS_CODE, OUTAREA_AMOUNT, 0)) /
                                    VG_INKOTERMS_AMOUNT) * 100), 0) <
                                MAX(FER.EXCLUSION_RATE) THEN
                            'Y'
                           ELSE
                            'N'
                       END
                INTO   V_EXCLUSION_YN
                FROM   FCR_INFO_TEMP FI
                      ,(SELECT *
                        FROM   FTA_EXCLUSION_RULE FER
                        WHERE  EXCLUSION_TYPE = FER_LIST.EXCLUSION_TYPE
                        AND    FTA_CODE = I_FR_LIST.FTA_CODE
                        AND    HS_CODE = I_FR_LIST.HS_CODE
                        AND    HS_CODE_SUB_CATEGORY =
                               I_FR_LIST.HS_CODE_SUB_CATEGORY
                        AND    RULE_SEQ = I_FR_LIST.RULE_SEQ) FER
                WHERE  FI.FTA_CODE = I_FM_LIST.FTA_CODE
                AND    FI.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                AND    FI.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                AND    FI.PRODUCT_CODE = I_FM_LIST.PRODUCT_CODE
                AND    (FI.OUTAREA_QTY > 0 OR FI.OUTAREA_AMOUNT > 0); -- SQL END

                        END IF;



                        ----------------------------------------

                        END IF;

                    ELSE
                        V_EXCLUSION_YN := 'N';
                    END IF;

                ELSE
                    V_EXCLUSION_YN := 'N';
                END IF;

                -- 예외타입 16번만을 위한 변수 초기화 (20150716)
                -- VG_FRD_REC.EXCLUSION_CONDITION := '000' 이면 'E16'으로 셋팅
                IF VG_FRD_REC.EXCLUSION_CONDITION <> 'N16' THEN
                   VG_FRD_REC.EXCLUSION_CONDITION := 'E16';
                END IF;

            END IF; -- CASE END

            -- 예외 조항이 N개인 경우를 위하여 이미 판정된 예외의 결과를 체크하여 결과 값을 셋팅한다
            IF FER_LIST.JOIN_CONDITION = 'AND' OR
               FER_LIST.JOIN_CONDITION = 'IF' THEN

                -- IF도 AND와 동일하게 처리를 한다
                IF NVL(V_AND_HOLD_EXCLUSION_YN, 'NO') = 'NO' THEN
                    V_AND_HOLD_EXCLUSION_YN := V_EXCLUSION_YN;

                ELSE

                    IF V_AND_HOLD_EXCLUSION_YN = 'Y' THEN
                        V_AND_HOLD_EXCLUSION_YN := V_EXCLUSION_YN;
                    END IF;

                END IF;

                -- OR 조건인 경우에는 기존의 조건을 체크하여 셋팅을 다시한다
            ELSE

                IF NVL(V_OR_HOLD_EXCLUSION_YN, 'NO') = 'NO' THEN
                    V_OR_HOLD_EXCLUSION_YN := V_EXCLUSION_YN;
                END IF;

                -- OR조건들은 둘중에 하나만 Y이면 Y가 되므로 Y로 설정 한다
                IF V_OR_HOLD_EXCLUSION_YN = 'Y' OR
                   V_EXCLUSION_YN = 'Y' THEN
                    V_OR_HOLD_EXCLUSION_YN := 'Y';
                ELSE
                    V_OR_HOLD_EXCLUSION_YN := 'N';
                END IF;

            END IF;

            -- 예외타입 16번만을 위한 변수 초기화 (20150716)
            -- VG_FRD_REC.EXCLUSION_CONDITION := 'E16' 이면 'N16'으로 셋팅
            IF FER_LIST.EXCLUSION_TYPE <> '16' THEN
               VG_FRD_REC.EXCLUSION_CONDITION := 'N16';
            END IF;

        END LOOP;

        /*
        * 예외조건에 대해서 최종 판정 결과를 판정결과 레코드 변수에 담는다
        */

        -- 예외타입 16번만을 위한 변수 초기화 (20150716)
        -- VG_FRD_REC.EXCLUSION_CONDITION := 'N16' 이면 'AND'으로 셋팅
        IF VG_FRD_REC.EXCLUSION_CONDITION <> 'E16' THEN
           VG_FRD_REC.EXCLUSION_CONDITION := 'AND';
        END IF;

        IF NVL(V_AND_HOLD_EXCLUSION_YN, 'NO') = 'NO' THEN
            IF V_OR_HOLD_EXCLUSION_YN = 'N' THEN
                VG_FRD_REC.EXCLUSION_YN := 'N';
            ELSE
                VG_FRD_REC.EXCLUSION_YN := 'Y';
            END IF;

        ELSE
            IF V_AND_HOLD_EXCLUSION_YN = 'N' THEN
                VG_FRD_REC.EXCLUSION_YN := 'N';
            ELSE
                IF NVL(V_OR_HOLD_EXCLUSION_YN, 'NO') = 'NO' OR
                   V_OR_HOLD_EXCLUSION_YN = 'Y' THEN
                    VG_FRD_REC.EXCLUSION_YN := 'Y';
                ELSE
                    VG_FRD_REC.EXCLUSION_YN := 'N';
                END IF;
            END IF;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            VG_ERROR_CODE  := 'EXCLUSION99';
            VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
            VG_RETURN_CODE := -1;
            --DBMS_OUTPUT.PUT_LINE(VG_ERROR_MSG);
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ':' ||
                                               VG_ERROR_MSG);

    END;

    /*
    ******************************************************************************
    * PROCEDURE NAME : UPDATE_FRM_PROCEDURE
    *    DESCRIPTION : 판정결과 마스터 정보를 업데이트 한다
    *                  최종판정을 수행하는 것으로 FCR RESULT 상세 정보에서
    *                  결과를 추출 한다
    *
    *****************************************************************************
    */
    PROCEDURE UPDATE_FRM_PROCEDURE(I_FM_LIST IN FM_LIST) IS
        V_FRD_REC FCR_RESULT%ROWTYPE;
        V_COO_YN  VARCHAR2(1);
        --V_FRD_COUNT NUMBER :=0;

    BEGIN

        BEGIN

            VG_RETURN_CODE := 0;
            -- 모든 판정이 에러인 경우는 판정 결과를 에러로 설정
            IF VG_RULE_COUNT < 1 THEN
                V_FRD_REC.SP_COO_YN      := 'N';
                V_FRD_REC.WO_COO_YN      := 'N';
                V_FRD_REC.FTA_COO_YN     := 'N';
                V_FRD_REC.COMPANY_COO_YN := 'N';
                V_FRD_REC.STATUS         := 'E';
                V_FRD_REC.ERROR_MSG      := '협정에 해당하는 HS RULE이 없습니다!!';
                VG_RETURN_CODE           := 9;

            ELSIF I_FM_LIST.INAREA_AMOUNT + I_FM_LIST.OUTAREA_AMOUNT <= 0 THEN
                V_FRD_REC.SP_COO_YN      := 'N';
                V_FRD_REC.WO_COO_YN      := 'N';
                V_FRD_REC.FTA_COO_YN     := 'N';
                V_FRD_REC.COMPANY_COO_YN := 'N';
                V_FRD_REC.STATUS         := 'E';
                V_FRD_REC.ERROR_MSG      := '재료비가 없는 자재가 존재합니다.';
                VG_RETURN_CODE           := 10;

            ELSE
                -- 최종판정 결과를 확인하기 위하여 판정된 모든항목을 체크한다
                BEGIN
                    -- 역내산 체크 시작
                    SELECT *
                    INTO   V_FRD_REC
                    FROM   FCR_RESULT FRD
                    WHERE  FRD.SALES_NO = I_FM_LIST.SALES_NO
                    AND    FRD.SALES_SEQ = I_FM_LIST.SALES_SEQ
                    AND    FRD.FTA_CODE = I_FM_LIST.FTA_CODE
                    AND    FRD.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                    AND    FRD.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                    AND    FRD.COMPANY_COO_YN = 'Y'
                    AND    ROWNUM = 1;

                    V_COO_YN := 'Y';

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        -- 역외산만 존재 하는 경우 체크
                        BEGIN
                            -- 역외산 체크 시작

                            SELECT FRD.*
                            INTO   V_FRD_REC
                            FROM   FCR_RESULT FRD
                            WHERE  FRD.SALES_NO = I_FM_LIST.SALES_NO
                            AND    FRD.SALES_SEQ = I_FM_LIST.SALES_SEQ
                            AND    FRD.FTA_CODE = I_FM_LIST.FTA_CODE
                            AND    FRD.DIVISION_CODE = I_FM_LIST.DIVISION_CODE
                            AND    FRD.COMPANY_CODE = I_FM_LIST.COMPANY_CODE
                            AND    FRD.COMPANY_COO_YN = 'N'
                            AND    STATUS = 'N'
                            AND    ROWNUM = 1;

                            V_COO_YN := 'N';

                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                V_COO_YN := 'E';

                        END; -- 역외산 체크 END

                END; -- 역내산 체크 END

                -- 모든 판정이 에러인 경우는 판정 결과를 에러로 설정
                IF V_COO_YN = 'E' THEN
                    V_FRD_REC.SP_COO_YN      := 'N';
                    V_FRD_REC.WO_COO_YN      := 'N';
                    V_FRD_REC.FTA_COO_YN     := 'N';
                    V_FRD_REC.COMPANY_COO_YN := 'N';
                    V_FRD_REC.STATUS         := 'E';
                    V_FRD_REC.ERROR_CODE     := 'ALL-ERROR';
                    VG_RETURN_CODE           := 8;
                END IF;

            END IF;

            -- 판정결과를 최종 업데이트 한다
            UPDATE FCR_MST
            SET    RULE_CONTENTS  = V_FRD_REC.RULE_CODE
                  ,FTA_COO_YN     = V_FRD_REC.FTA_COO_YN
                  ,COMPANY_COO_YN = V_FRD_REC.COMPANY_COO_YN
                  ,RCEP_COO_NATION = V_FRD_REC.RCEP_COO_NATION
            WHERE  SALES_NO = I_FM_LIST.SALES_NO
            AND    SALES_SEQ = I_FM_LIST.SALES_SEQ
            AND    FTA_CODE = I_FM_LIST.FTA_CODE
            AND    DIVISION_CODE = I_FM_LIST.DIVISION_CODE
            AND    COMPANY_CODE = I_FM_LIST.COMPANY_CODE;

        EXCEPTION
            WHEN OTHERS THEN
                VG_ERROR_CODE  := 'FCRMST01';
                VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
                VG_RETURN_CODE := -1;
                --DBMS_OUTPUT.PUT_LINE(VG_ERROR_MSG);
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ':' ||
                                                   VG_ERROR_MSG);

        END;
    END;

    /*
    ******************************************************************************
    * PROCEDURE NAME : INSERT_FRD_PROCESS
    *    DESCRIPTION : 룰 ID에 해당하는 판정결과를 저장한다
    *
    *****************************************************************************
    */
    PROCEDURE INSERT_FRD_PROCESS IS
    BEGIN

        BEGIN
            -- FCR RESULT 정보를 생성 한다
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
                ,STATUS
                ,ERROR_CODE
                ,ERROR_MSG
                ,DELETE_YN
                ,CREATE_DATE
                ,CREATE_BY
                ,UPDATE_DATE
                ,UPDATE_BY
                ,SP_COO_YN
                ,WO_COO_YN
                ,CTC_YN
                ,FTA_DE_MINIMIS_YN
                ,COMPANY_DE_MINIMIS_YN
                ,FTA_RVC_YN
                ,COMPANY_RVC_YN
                ,EXCLUSION_YN
                ,EXCLUSION_CONDITION
                ,CTC_RESULT_RATE
                ,CTC_FTA_RESULT_RATE
                ,CTC_COMPANY_RESULT_RATE
                ,RVC_RESULT_RATE
                ,RVC_FTA_RESULT_RATE
                ,RVC_COMPANY_RESULT_RATE
                ,RCEP_COO_NATION)
            VALUES
                (FCR_RESULT_SEQ_S.NEXTVAL
                ,VG_FRD_REC.SALES_NO --SALES_NO
                ,VG_FRD_REC.SALES_SEQ -- SALES_SEQ
                ,VG_FRD_REC.FTA_CODE -- FTA_CODE
                ,VG_FRD_REC.DIVISION_CODE -- DIVISION_CODE
                ,VG_FRD_REC.COMPANY_CODE -- COMPANY_CODE
                ,VG_FRD_REC.HS_CODE -- HS_CODE
                ,VG_FRD_REC.PRODUCT_CODE -- PRODUCT_CODE
                ,VG_FRD_REC.STANDARD -- STANDARD
                ,VG_FRD_REC.RULE_SEQ -- RULE_SEQ
                ,VG_FRD_REC.RULE_CODE -- RULE_CODE
                ,VG_FRD_REC.FTA_COO_YN -- FTA_COO_YM
                ,VG_FRD_REC.COMPANY_COO_YN -- COMPANY_COO_YN
                ,VG_OPTION_VALUE -- BUFFER_OPTION
                ,VG_COMPANY_CTC_RATE -- DE_MINIMIS_RATE
                ,VG_COMPANY_RVC_RATE -- RVC_RATE
                ,VG_FRD_REC.STATUS -- STATUS
                ,VG_FRD_REC.ERROR_CODE -- ERROR_CODE
                ,VG_FRD_REC.ERROR_MSG -- ERROR_MSG
                ,'N' -- DELETE_YN
                ,SYSDATE -- CREATE_DATE
                ,'PKG99_COO_DECISION' -- CREATE_BY
                ,SYSDATE -- UPDATE_DATE
                ,'PKG99_COO_DECISION' -- UPDATE_BY
                ,VG_FRD_REC.SP_COO_YN
                ,VG_FRD_REC.WO_COO_YN
                ,VG_FRD_REC.CTC_YN
                ,VG_FRD_REC.FTA_DE_MINIMIS_YN
                ,VG_FRD_REC.COMPANY_DE_MINIMIS_YN
                ,VG_FRD_REC.FTA_RVC_YN
                ,VG_FRD_REC.COMPANY_RVC_YN
                ,VG_FRD_REC.EXCLUSION_YN
                ,VG_FRD_REC.EXCLUSION_CONDITION
                ,VG_FRD_REC.CTC_RESULT_RATE
                ,VG_FRD_REC.CTC_FTA_RESULT_RATE
                ,VG_FRD_REC.CTC_COMPANY_RESULT_RATE
                ,VG_FRD_REC.RVC_RESULT_RATE
                ,VG_FRD_REC.RVC_FTA_RESULT_RATE
                ,VG_FRD_REC.RVC_COMPANY_RESULT_RATE
                ,VG_FRD_REC.RCEP_COO_NATION);

        EXCEPTION
            WHEN OTHERS THEN
                VG_ERROR_CODE  := 'DECISION01';
                VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
                VG_RETURN_CODE := -1;
                --DBMS_OUTPUT.PUT_LINE(VG_ERROR_MSG);
                PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_MSG);

        END;

        VG_RETURN_CODE := 0;
        --VG_FRD_REC := NULL;

        VG_FRD_REC.SALES_NO                := NULL;
        VG_FRD_REC.SALES_SEQ               := NULL;
        VG_FRD_REC.FTA_CODE                := NULL;
        VG_FRD_REC.RULE_SEQ                := NULL;
        VG_FRD_REC.DIVISION_CODE           := NULL;
        VG_FRD_REC.COMPANY_CODE            := NULL;
        VG_FRD_REC.RULE_CODE               := NULL;
        VG_FRD_REC.SP_COO_YN               := NULL;
        VG_FRD_REC.WO_COO_YN               := NULL;
        VG_FRD_REC.CTC_YN                  := NULL;
        VG_FRD_REC.FTA_DE_MINIMIS_YN       := NULL;
        VG_FRD_REC.COMPANY_DE_MINIMIS_YN   := NULL;
        VG_FRD_REC.FTA_RVC_YN              := NULL;
        VG_FRD_REC.COMPANY_RVC_YN          := NULL;
        VG_FRD_REC.EXCLUSION_YN            := NULL;
        VG_FRD_REC.EXCLUSION_CONDITION     := NULL;
        VG_FRD_REC.CTC_RESULT_RATE         := NULL;
        VG_FRD_REC.CTC_FTA_RESULT_RATE     := NULL;
        VG_FRD_REC.CTC_COMPANY_RESULT_RATE := NULL;
        VG_FRD_REC.RVC_RESULT_RATE         := NULL;
        VG_FRD_REC.RVC_FTA_RESULT_RATE     := NULL;
        VG_FRD_REC.RVC_COMPANY_RESULT_RATE := NULL;
        VG_FRD_REC.FTA_COO_YN              := NULL;
        VG_FRD_REC.COMPANY_COO_YN          := NULL;
        VG_FRD_REC.STATUS                  := NULL;
        VG_FRD_REC.ERROR_CODE              := NULL;
        VG_FRD_REC.ERROR_MSG               := NULL;
        VG_FRD_REC.CREATE_DATE             := NULL;
        VG_FRD_REC.CREATE_BY               := NULL;
        VG_FRD_REC.UPDATE_DATE             := NULL;
        VG_FRD_REC.UPDATE_BY               := NULL;
        VG_FRD_REC.RCEP_COO_NATION         := NULL;

        VG_FRD_REC.STATUS := 'N';

    END;


    /*
    ******************************************************************************
    * PROCEDURE NAME : ERROR_MARKING_PROCESS
    *    DESCRIPTION : 룰 ID에 대하여 판정에러 내용을 설정한다
    *
    *****************************************************************************
    */
    PROCEDURE ERROR_MARKING_PROCESS IS

    BEGIN
        VG_FRD_REC.SP_COO_YN             := 'N';
        VG_FRD_REC.CTC_YN                := 'N';
        VG_FRD_REC.FTA_DE_MINIMIS_YN     := 'N';
        VG_FRD_REC.COMPANY_DE_MINIMIS_YN := 'N';
        VG_FRD_REC.FTA_RVC_YN            := 'N';
        VG_FRD_REC.COMPANY_RVC_YN        := 'N';
        VG_FRD_REC.EXCLUSION_YN          := 'N';
        VG_FRD_REC.EXCLUSION_CONDITION   := 'AND';
        VG_FRD_REC.FTA_COO_YN            := 'N';
        VG_FRD_REC.COMPANY_COO_YN        := 'N';

        VG_FRD_REC.STATUS     := 'E';
        VG_FRD_REC.ERROR_CODE := VG_ERROR_CODE;
        VG_FRD_REC.ERROR_MSG  := VG_ERROR_MSG;

        -- 다음 판정을 위하여 글로벌 변수 초기화
        VG_RETURN_CODE := 0;
        VG_ERROR_CODE  := '';

    END;

    /*
    ******************************************************************************
    * PROCEDURE NAME : GET_BUFFER
    *    DESCRIPTION : GET RVC 버퍼, 미소기준 버퍼
    *
    *****************************************************************************
    */
    PROCEDURE GET_BUFFER(P_COMPANY_CODE  IN COMPANY.COMPANY_CODE%TYPE
                        ,P_DIVISION_CODE IN DIVISION.DIVISION_CODE%TYPE
                        ,P_FTA_CODE      IN FTA_MASTER.FTA_CODE%TYPE
                        ,P_PRODUCT_CODE  IN ITEM_MST.ITEM_CODE%TYPE) IS

    BEGIN

        /*OPTION 정보를 이용해 버퍼율을 구한다*/
        SELECT OPTION_VALUE
        INTO   VG_OPTION_VALUE
        FROM   COMPANY_OPTION
        WHERE  COMPANY_CODE = P_COMPANY_CODE
        AND    OPTION_CODE = 'BF';

        IF VG_OPTION_VALUE = 'COM' THEN
            -- 회사기준
            SELECT COM_RVC_RATE
                  ,COM_DE_MINIMIS_RATE
            INTO   VG_COMPANY_RVC_RATE
                  ,VG_COMPANY_CTC_RATE
            FROM   COMPANY
            WHERE  COMPANY_CODE = P_COMPANY_CODE;
        ELSIF VG_OPTION_VALUE = 'DIV' THEN
            -- 사업부 기준
            SELECT DIV_RVC_RATE
                  ,DIV_DE_MINIMIS_RATE
            INTO   VG_COMPANY_RVC_RATE
                  ,VG_COMPANY_CTC_RATE
            FROM   DIVISION
            WHERE  COMPANY_CODE = P_COMPANY_CODE
            AND    DIVISION_CODE = P_DIVISION_CODE;
        ELSIF VG_OPTION_VALUE = 'PRD' THEN
            -- 제품군기준
            SELECT PRD_RVC_RATE
                  ,PRD_DE_MINIMIS_RATE
            INTO   VG_COMPANY_RVC_RATE
                  ,VG_COMPANY_CTC_RATE
            FROM   PRODUCT_LINE PL
                  ,ITEM_MST     id
            WHERE  ID.COMPANY_CODE = P_COMPANY_CODE
            AND    ID.ITEM_CODE = P_PRODUCT_CODE
            AND    ID.PRODUCT_CODE = PL.PRODUCT_CODE
            AND    ID.COMPANY_CODE = PL.COMPANY_CODE;
        ELSIF VG_OPTION_VALUE = 'FTA' THEN
            -- FTA 기준
            SELECT COM_RVC_RATE
                  ,COM_DE_MINIMIS_RATE
            INTO   VG_COMPANY_RVC_RATE
                  ,VG_COMPANY_CTC_RATE
            FROM   FTA_MASTER
            WHERE  FTA_CODE = P_FTA_CODE;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            VG_ERROR_CODE  := 'GET_BUFFER';
            VG_ERROR_MSG   := SQLCODE || ':' || SQLERRM;
            VG_RETURN_CODE := -1;
            PKG00_PROCEDURE_LOG.BATCH_LOG_DTL(VG_LOG_ID, VG_ERROR_CODE || ':' ||
                                               VG_ERROR_MSG);
    END;


    /*
  ******************************************************************************
  * PROCEDURE NAME : GET_MP_ITEM
  *    DESCRIPTION : 최소공정 제외 품목 여부 확인
  *
  *****************************************************************************
  */
  FUNCTION GET_MP_ITEM(P_COMPANY_CODE  IN COMPANY.COMPANY_CODE%TYPE,
                       P_DIVISION_CODE IN DIVISION.DIVISION_CODE%TYPE,
                       P_SALES_NO  IN SALES_MST.SALES_NO%TYPE,
                       P_SALES_SEQ  IN SALES_DTL.SALES_SEQ%TYPE)
  RETURN VARCHAR2 IS
  
  V_MP_ITEM_YN VARCHAR2(1);
  
  BEGIN
    SELECT DECODE(COUNT(1),0,'N','Y')
      INTO V_MP_ITEM_YN
      FROM SALES_MST SM
     INNER JOIN SALES_DTL SD
        ON SD.SALES_NO = SM.SALES_NO
       AND SD.COMPANY_CODE = SM.COMPANY_CODE
       AND SD.DIVISION_CODE = SM.DIVISION_CODE
     INNER JOIN MINIMAL_PROCESS_ITEM MP
        ON MP.COMPANY_CODE = SD.COMPANY_CODE
       AND MP.DIVISION_CODE = SD.DIVISION_CODE
       AND MP.ITEM_CODE = SD.PRODUCT_CODE
       AND SM.INVOICE_DATE BETWEEN MP.APPLY_DATE AND MP.END_DATE
     WHERE SM.COMPANY_CODE = P_COMPANY_CODE
       AND SM.DIVISION_CODE = P_DIVISION_CODE
       AND SM.SALES_NO = P_SALES_NO
       AND SD.SALES_SEQ = P_SALES_SEQ;
    
    RETURN V_MP_ITEM_YN;
  END GET_MP_ITEM;
  
  /*
  ******************************************************************************
  *  FUNCTION NAME : GET_RCEP_NATION
  *    DESCRIPTION : RCEP 협정일 경우 회원국 원산지 확인
  *
  *****************************************************************************
  */
  FUNCTION GET_RCEP_NATION
  RETURN VARCHAR2 IS
  
  V_ITEM_CNT NUMBER;
  V_RCEP_CNT NUMBER;
  V_KR_CNT NUMBER;
  V_RCEP_NATION VARCHAR2(10);
  
  BEGIN
                                
    SELECT COUNT(*) ITEM_CNT
          ,SUM(CASE WHEN FI.COO_NATION = 'KR' OR FA.NATION_CODE IS NOT NULL THEN 1 ELSE 0 END) RCEP_CNT
          ,SUM(CASE WHEN FI.COO_NATION = 'KR' THEN 1 ELSE 0 END) KR_CNT
      INTO V_ITEM_CNT
          ,V_RCEP_CNT
          ,V_KR_CNT
      FROM FCR_INFO_TEMP FI
      LEFT OUTER JOIN FTA_APPLY_NATION FA
        ON FA.FTA_CODE = FI.FTA_CODE
       AND FA.NATION_CODE = FI.COO_NATION;
  
    -- 한국산 원산지 재료로만 이루어진 경우 KR
    IF V_ITEM_CNT = V_KR_CNT THEN
      V_RCEP_NATION := 'KR';
      RETURN V_RCEP_NATION;
    -- RCEP 회원국 원산지 재료로만 이루어진 경우(2국가 이상) RCEP
    ELSIF V_ITEM_CNT = V_RCEP_CNT THEN
      V_RCEP_NATION := 'RCEP';
      RETURN V_RCEP_NATION;
    -- RCEP 회원국과 기타 국가 재료가 혼합된 경우 ZZ
    ELSIF V_ITEM_CNT > V_RCEP_CNT THEN
      V_RCEP_NATION := 'ZZ';
      RETURN V_RCEP_NATION;
    END IF;
  
  END GET_RCEP_NATION;
  
  /*
  ******************************************************************************
  * PROCEDURE NAME : GET_RCEP_RVC_NATION
  *    DESCRIPTION : RCEP 한국산재료비 BD20 달성 확인 및 최대 기여국
  *
  *****************************************************************************
  */
  PROCEDURE GET_RCEP_RVC_NATION(P_AMOUNT  IN FCR_MST.AMOUNT%TYPE) IS
  
  V_RVC_RATE         NUMBER(20, 8) := 0;
  V_COMPANY_RVC_RATE NUMBER(20, 8) := 20;
  
  BEGIN
    
    -- 한국산 원산지 재료비 BD 비율 확인
    SELECT (P_AMOUNT - SUM(FI.INPUT_AMOUNT)) / P_AMOUNT * 100
      INTO V_RVC_RATE
      FROM FCR_INFO_TEMP FI
     WHERE FI.COO_NATION != 'KR' OR FI.COO_NATION IS NULL;
  
    -- 한국산 재료비가 BD20 이상인지 확인
    IF V_RVC_RATE >= V_COMPANY_RVC_RATE THEN
      VG_RCEP_KR_YN := 'Y';
    ELSE
      VG_RCEP_KR_YN := 'N';
    END IF;
    
    -- 원산지 재료비 최대 기여국 확인
    SELECT COO_NATION
      INTO VG_RCEP_COO_NATION
      FROM (
            SELECT A.COO_NATION
                  ,A.INAREA_AMOUNT
                  ,ROW_NUMBER() OVER(ORDER BY A.INAREA_AMOUNT DESC) AS RNUM
              FROM (
                    SELECT FI.COO_NATION
                          ,SUM(FI.INAREA_AMOUNT) INAREA_AMOUNT
                      FROM FCR_INFO_TEMP FI
                     INNER JOIN FTA_APPLY_NATION FAN
                        ON FAN.FTA_CODE = FI.FTA_CODE
                     WHERE FI.COO_NATION IS NOT NULL
                       AND FI.INAREA_QTY > 0
                     GROUP BY FI.COO_NATION
                   ) A
             ) A
      WHERE RNUM = 1;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        IF VG_RCEP_KR_YN = 'Y' THEN
          VG_RCEP_COO_NATION := 'KR';
        ELSE
          VG_RCEP_COO_NATION := '';
        END IF;
    
  END GET_RCEP_RVC_NATION;


END PKG99_COO_DECISION;

/******************************************************************************
/* END OF PROCEDURE
/******************************************************************************/
