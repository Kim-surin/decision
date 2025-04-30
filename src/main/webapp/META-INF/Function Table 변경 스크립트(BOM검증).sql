DROP FUNCTION FN_GET_DIFF_BOM;

DROP TYPE DIFF_BOM_TABLE;

DROP TYPE TYPE_OF_DIFF_BOM;


CREATE OR REPLACE TYPE TYPE_OF_DIFF_BOM AS OBJECT
(
    COMPANY_CODE                        VARCHAR2(20),
    DIVISION_CODE                       VARCHAR2(20),
    PRODUCT_CODE                        VARCHAR2(30),
    CURR_ITEM_CODE                      VARCHAR2(30),
    CURR_INPUT_QTY                      NUMBER(19,10),
    CURR_INPUT_BASS_UNIT                VARCHAR2(3),
    CURR_USE_BOM_VERSION                VARCHAR2(8),
    PAST_ITEM_CODE                      VARCHAR2(30),
    PAST_INPUT_QTY                      NUMBER(19,10),
    PAST_INPUT_BASS_UNIT                VARCHAR2(3),
    PAST_USE_BOM_VERSION                VARCHAR2(8),
    NEW_CHANGE_FLAG_NAME                VARCHAR2(30),
    DELETE_CHANGE_FLAG_NAME             VARCHAR2(30),
    QTY_CHANGE_FLAG_NAME                VARCHAR2(30),
    UNIT_CHANGE_FLAG_NAME               VARCHAR2(30)
)
;


CREATE OR REPLACE TYPE DIFF_BOM_TABLE
AS TABLE OF TYPE_OF_DIFF_BOM;



CREATE OR REPLACE FUNCTION FN_GET_DIFF_BOM (
  P_COMPANY_CODE IN VARCHAR2
, P_DIVISION_CODE IN  VARCHAR2
, P_YYYY IN VARCHAR2
, P_QUARTER IN VARCHAR2
, P_PRODUCT_CODE IN VARCHAR2
, P_ITEM_CODE IN VARCHAR2
)
    RETURN DIFF_BOM_TABLE PIPELINED
/******************************************************************
레포트 - BOM 검증 화면용 FUNTION PIPE 테이블
=> "조회년도 BOM"과 "조회년도BOM 이전의 데이터"를 모두 비교해 차이나는 데이터를 리턴한다.
********************************************************************/
IS
    DIFF_BOM_ROW TYPE_OF_DIFF_BOM;
    V_PAST_QUARTER_SDATE VARCHAR(8) := '';  --전분기 시작일
    V_PAST_QUARTER_EDATE VARCHAR(8) := '';  --전분기 종료일
    V_CURR_QUARTER_SDATE VARCHAR(8) := '';  --현분기 시작일
    V_CURR_QUARTER_EDATE VARCHAR(8) := '';  --현분기 종료일
    V_SEARCH_DATE  VARCHAR(8)       := '';

    V_COMPARE_ITEM_CODE VARCHAR2(30)   := '';



     /*현재분기 수출확정건 데이터*/
    CURSOR CURR_LIST IS
    SELECT A.COMPANY_CODE
         , A.DIVISION_CODE
         , B.ITEM_CODE AS PRODUCT_CODE
         , B.USE_BOM_VERSION
      FROM DRWBAK_REQSTDOC_CMMN A
     INNER JOIN DRWBAK_REQSTDOC_TRGET_THNG B
        ON A.COMPANY_CODE = B.COMPANY_CODE
       AND A.PRESENTN_NO = B.PRESENTN_NO
     WHERE 1=1
       AND A.COMPANY_CODE = P_COMPANY_CODE
       AND A.DIVISION_CODE = P_DIVISION_CODE
       AND B.DSPTH_DATE BETWEEN V_CURR_QUARTER_SDATE  AND V_CURR_QUARTER_EDATE
       AND B.ITEM_CODE  LIKE P_PRODUCT_CODE  || '%'
  GROUP BY A.COMPANY_CODE
         , A.DIVISION_CODE
         , B.ITEM_CODE
         , B.USE_BOM_VERSION;


    /*조회년도BOM 이전의 데이터*/
    CURSOR PAST_LIST IS
    SELECT A.COMPANY_CODE
         , A.DIVISION_CODE
         , B.ITEM_CODE AS PRODUCT_CODE
         , B.USE_BOM_VERSION
      FROM DRWBAK_REQSTDOC_CMMN A
     INNER JOIN DRWBAK_REQSTDOC_TRGET_THNG B
        ON A.COMPANY_CODE = B.COMPANY_CODE
       AND A.PRESENTN_NO = B.PRESENTN_NO
     WHERE 1=1
       AND A.COMPANY_CODE = P_COMPANY_CODE
       AND A.DIVISION_CODE = P_DIVISION_CODE
       AND B.DSPTH_DATE < V_CURR_QUARTER_SDATE
       AND B.ITEM_CODE = V_COMPARE_ITEM_CODE
       AND B.ITEM_CODE LIKE P_PRODUCT_CODE  || '%'
  GROUP BY A.COMPANY_CODE
         , A.DIVISION_CODE
         , B.ITEM_CODE
         , B.USE_BOM_VERSION;


BEGIN

    IF P_YYYY IS NULL OR P_QUARTER IS NULL THEN
      RETURN;
    END IF;

    V_SEARCH_DATE := P_YYYY || LPAD(( P_QUARTER * 3)-2,2,0) || '01' ;

    /*현재 분기/이전 분기 구하기 */
    SELECT
           TO_CHAR(TRUNC(ADD_MONTHS(TO_DATE(V_SEARCH_DATE,'YYYYMMDD'),-3), 'Q'), 'YYYYMMDD') AS PAST_QUARTER_SDATE
         , TO_CHAR(TRUNC(TO_DATE(V_SEARCH_DATE,'YYYYMMDD'),'Q')-1, 'YYYYMMDD')               AS PAST_QUARTER_EDATE
         , TO_CHAR(TRUNC(TO_DATE(V_SEARCH_DATE,'YYYYMMDD'),'Q'),'YYYYMMDD')                  AS CURR_QUARTER_SDATE
         , TO_CHAR(TRUNC(ADD_MONTHS(TO_DATE(V_SEARCH_DATE,'YYYYMMDD'),3),'Q')-1,'YYYYMMDD')  AS V_CURR_QUARTER_EDATE
      INTO V_PAST_QUARTER_SDATE
         , V_PAST_QUARTER_EDATE
         , V_CURR_QUARTER_SDATE
         , V_CURR_QUARTER_EDATE
      FROM DUAL;

      FOR CURR_ROW IN CURR_LIST LOOP

          --비교대상 제품 선정
          V_COMPARE_ITEM_CODE := CURR_ROW.PRODUCT_CODE;

          FOR PAST_ROW IN PAST_LIST LOOP

              --BOM 버전이 다른 경우에만 비교
              IF CURR_ROW.USE_BOM_VERSION <> PAST_ROW.USE_BOM_VERSION THEN

                 FOR REC IN (
                      --BOM버전이 다르더라도 내부는 같을수 있으므로 BOM상세 데이터 비교
                      SELECT P_COMPANY_CODE AS COMPANY_CODE
                           , P_DIVISION_CODE AS DIVISION_CODE
                           , CURR_ROW.PRODUCT_CODE AS PRODUCT_CODE
                           , C.ITEM_CODE AS CURR_ITEM_CODE
                           , C.INPUT_QTY AS CURR_INPUT_QTY
                           , C.INPUT_BASS_UNIT AS CURR_INPUT_BASS_UNIT
                           , CURR_ROW.USE_BOM_VERSION AS CURR_USE_BOM_VERSION
                           , P.ITEM_CODE AS PAST_ITEM_CODE
                           , P.INPUT_QTY AS PAST_INPUT_QTY
                           , P.INPUT_BASS_UNIT AS PAST_INPUT_BASS_UNIT
                           , PAST_ROW.USE_BOM_VERSION AS PAST_USE_BOM_VERSION
                           , CASE WHEN (P.ITEM_CODE IS NULL) THEN '신규자재' ELSE '' END AS NEW_CHANGE_FLAG_NAME
                           , CASE WHEN (C.ITEM_CODE IS NULL) THEN '삭제자재' ELSE '' END AS DELETE_CHANGE_FLAG_NAME
                           , CASE WHEN (C.INPUT_QTY <> P.INPUT_QTY) THEN '소요량변경' ELSE '' END AS QTY_CHANGE_FLAG_NAME
                           , CASE WHEN (C.INPUT_BASS_UNIT <> P.INPUT_BASS_UNIT) THEN '단위변경' ELSE '' END AS UNIT_CHANGE_FLAG_NAME
                       FROM (SELECT H.COMPANY_CODE
                                   , H.DIVISION_CODE
                                   , H.BOM_VERSION
                                   , H.PRODUCT_CODE
                                   , H.ITEM_CODE
                                   , H.INPUT_QTY
                                   , H.INPUT_BASS_UNIT
                                FROM RESULT_BOM_AP H
                               WHERE H.BOM_VERSION = CURR_ROW.USE_BOM_VERSION
                                 AND H.PRODUCT_CODE = CURR_ROW.PRODUCT_CODE
                                 AND H.COMPANY_CODE = P_COMPANY_CODE
                                 AND H.DIVISION_CODE = P_DIVISION_CODE
                                 AND H.PRODUCT_CODE LIKE P_PRODUCT_CODE || '%'
                                 AND H.ITEM_CODE LIKE P_ITEM_CODE || '%') C
                  FULL OUTER JOIN (SELECT H.COMPANY_CODE
                                         , H.DIVISION_CODE
                                         , H.BOM_VERSION
                                         , H.PRODUCT_CODE
                                         , H.ITEM_CODE
                                         , H.INPUT_QTY
                                         , H.INPUT_BASS_UNIT
                                      FROM RESULT_BOM_AP H
                                     WHERE H.BOM_VERSION = PAST_ROW.USE_BOM_VERSION
                                       AND H.PRODUCT_CODE = PAST_ROW.PRODUCT_CODE
                                       AND H.COMPANY_CODE = P_COMPANY_CODE
                                       AND H.DIVISION_CODE = P_DIVISION_CODE
                                       AND H.PRODUCT_CODE LIKE P_PRODUCT_CODE  || '%'
                                       AND H.ITEM_CODE LIKE P_ITEM_CODE || '%') P
                           ON C.COMPANY_CODE = P.COMPANY_CODE
                          AND C.DIVISION_CODE = P.DIVISION_CODE
                          AND C.PRODUCT_CODE = P.PRODUCT_CODE
                          AND C.ITEM_CODE = P.ITEM_CODE
                        WHERE (C.ITEM_CODE IS NULL OR P.ITEM_CODE IS NULL      -- BOM구성이 변경된 경우
                           OR C.INPUT_QTY <> P.INPUT_QTY                       -- 투입량이 변경된 경우
                           OR C.INPUT_BASS_UNIT <> P.INPUT_BASS_UNIT)         -- 단위가 변경된 경우
                    )
                    LOOP
                             DIFF_BOM_ROW := TYPE_OF_DIFF_BOM( REC.COMPANY_CODE
                                                             , REC.DIVISION_CODE
                                                             , REC.PRODUCT_CODE
                                                             , REC.CURR_ITEM_CODE
                                                             , REC.CURR_INPUT_QTY
                                                             , REC.CURR_INPUT_BASS_UNIT
                                                             , REC.CURR_USE_BOM_VERSION
                                                             , REC.PAST_ITEM_CODE
                                                             , REC.PAST_INPUT_QTY
                                                             , REC.PAST_INPUT_BASS_UNIT
                                                             , REC.PAST_USE_BOM_VERSION
                                                             , REC.NEW_CHANGE_FLAG_NAME
                                                             , REC.DELETE_CHANGE_FLAG_NAME
                                                             , REC.QTY_CHANGE_FLAG_NAME
                                                             , REC.UNIT_CHANGE_FLAG_NAME
                                                             );
                             PIPE ROW(DIFF_BOM_ROW);
                    END LOOP;
              END IF;
          END LOOP;
      END LOOP;
      RETURN;
END;
