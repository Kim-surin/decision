CREATE OR REPLACE PACKAGE BODY PKG00_PROCEDURE_LOG IS
    /******************************************************************************/
    /* Project      : K-origin Project                                            */
    /* Module       : BATCH                                                       */
    /* Program Name : PKG00_PROCEDURE_LOG                                               */
    /* Description  : BATCH LOG PKG                                             */
    /*                                                                            */
    /* Program History                                                            */
    /*----------------------------------------------------------------------------*/
    /*   Date       In Charge      Description                                    */
    /*----------------------------------------------------------------------------*/
    /* 2010/04/14  Tombow            Initial Version                                 */
    /*                                                                            */
    /* Reference by :                                                             */
    /******************************************************************************/
    PROCEDURE BATCH_LOG(
                         O_LOG_ID          OUT PROCEDURE_LOG_MST.LOG_ID%TYPE
                       , P_APPLY_DATE      IN  PROCEDURE_LOG_MST.APPLY_DATE%TYPE
                       , P_PROCEDURE_ID    IN  PROCEDURE_LOG_MST.PROCEDURE_ID%TYPE
                       , P_JOB_TYPE        IN  PROCEDURE_LOG_MST.JOB_TYPE%TYPE
                       , P_COMPANY_CODE    IN  PROCEDURE_LOG_MST.COMPANY_CODE%TYPE
                       , P_INPUT_PARAMETER IN  PROCEDURE_LOG_MST.INPUT_PARAMETER%TYPE  DEFAULT NULL
                       , P_FORCE_DB_LOG_YN IN  VARCHAR2 DEFAULT 'N'
                         ) AS

        -- 로그처리를 위해서 별도의 트랜젝션으로 처리를 한다
        PRAGMA AUTONOMOUS_TRANSACTION;

        /******************************************************************************/
        /* Project      :  K-origin  origin Project                                    */
        /* Module       : BATCH_LOG                                                   */
        /* Program Name : BATCH_LOG                                                   */
        /* Description  : BATCH LOG 저장                                              */
        /*                - P_COMPANY_CODE : 회사코드                                 */
        /*                - P_BATCH_LOG_ID : BATCH LOG ID (BATCH_LOG_ID_S)            */
        /*                - P_SCHEDULE_CODE : BATCH SCHEDULE CODE                     */
        /*                  INTERFACE_SCHEDULE.SCHEDULE_CODE                          */
        /*                   . NULL 일경우 ==> 수적업 PROCEDURE 실행                  */
        /*                   . NOT NULL 일경우 ==> 시스템 SCHEDULER 실행              */
        /* Program History                                                            */
        /*----------------------------------------------------------------------------*/
        /*   Date       In Charge      Description                                    */
        /*----------------------------------------------------------------------------*/
        /* 2011/03/14  Tombow            Initial Version                              */
        /*                                                                            */
        /* Reference by :                                                             */
        /******************************************************************************/

    BEGIN

         -- DB에 로그를 쌓을경우에만
        IF VG_DB_LOG_YN = 'Y' OR P_FORCE_DB_LOG_YN = 'Y' THEN

            BEGIN
                 SELECT BATCH_LOG_ID_S.NEXTVAL
                   INTO O_LOG_ID
                   FROM DUAL;

                    INSERT INTO PROCEDURE_LOG_MST
                         (
                            LOG_ID
                          , APPLY_DATE
                          , PROCEDURE_ID
                          , JOB_TYPE
                          , COMPANY_CODE
                          , INPUT_PARAMETER
                          , START_DATE
                          , END_DATE
                          , STATUS
                          , RESULT_CODE
                          , RESULT_MESSAGE
                         )
                    VALUES (
                            O_LOG_ID
                          , P_APPLY_DATE
                          , P_PROCEDURE_ID
                          , P_JOB_TYPE
                          , P_COMPANY_CODE
                          , P_INPUT_PARAMETER
                          , SYSDATE
                          , NULL
                          , 'N'
                          , NULL
                          , NULL
                          );

                     COMMIT;
             EXCEPTION
                  WHEN OTHERS THEN
                       ROLLBACK;
             END;

        END IF;

        COMMIT;

    END BATCH_LOG;

    /******************************************************************************/
    /* Function Name  : BATCH_LOG_DTL                                             */
    /* Description    : BATCH LOG 상세 저장                                       */
    /******************************************************************************/
    PROCEDURE BATCH_LOG_DTL(
                             P_LOG_ID          IN PROCEDURE_LOG_MST.LOG_ID%TYPE
                           , P_LOG_CONTENTS    IN PROCEDURE_LOG_DTL.LOG_CONTENTS%TYPE
                           , P_FORCE_DB_LOG_YN IN VARCHAR2 DEFAULT 'N'
                            ) AS

        -- 로그처리를 위해서 별도의 트랜젝션으로 처리를 한다
        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        -- DB에 로그를 쌓을경우에만
        IF VG_DB_LOG_YN = 'Y' OR P_FORCE_DB_LOG_YN = 'Y' THEN

            BEGIN
                INSERT INTO PROCEDURE_LOG_DTL
                     (
                       LOG_ID
                     , SEQ
                     , LOG_DATETIME
                     , LOG_CONTENTS
                     )
               VALUES(
                       P_LOG_ID
                     , (SELECT NVL(MAX(SEQ), 0) + 1
                          FROM PROCEDURE_LOG_DTL
                         WHERE LOG_ID     = P_LOG_ID
                         )
                     , SYSDATE
                     , P_LOG_CONTENTS
                     )
                 ;

              COMMIT;

            EXCEPTION
                WHEN OTHERS THEN
                     ROLLBACK;
            END;

        END IF;

        COMMIT;

    END BATCH_LOG_DTL;

    /******************************************************************************/
    /* Function Name  : BATCH_LOG_LAST                                            */
    /* Description    : BATCH_LOG 마스터 상태 업데이트                            */
    /******************************************************************************/
    PROCEDURE BATCH_LOG_LAST(
                              P_LOG_ID          IN PROCEDURE_LOG_MST.LOG_ID%TYPE
                            , P_STATUS          IN PROCEDURE_LOG_MST.STATUS%TYPE         DEFAULT 'N'
                            , P_RESULT_CODE     IN PROCEDURE_LOG_MST.RESULT_CODE%TYPE    DEFAULT NULL
                            , P_RESULT_MESSAGE  IN PROCEDURE_LOG_MST.RESULT_MESSAGE%TYPE DEFAULT NULL
                            , P_FORCE_DB_LOG_YN IN VARCHAR2 DEFAULT 'N'
                            ) AS

        -- 로그처리를 위해서 별도의 트랜젝션으로 처리를 한다
        PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN

        -- DB에 로그를 쌓을경우에만
        IF VG_DB_LOG_YN = 'Y' OR P_FORCE_DB_LOG_YN = 'Y' THEN

            BEGIN
                UPDATE PROCEDURE_LOG_MST
                   SET END_DATE        = SYSDATE
                     , STATUS          = P_STATUS
                     , RESULT_CODE     = P_RESULT_CODE
                     , RESULT_MESSAGE  = P_RESULT_MESSAGE
                 WHERE LOG_ID          = P_LOG_ID
                ;

                COMMIT;

            EXCEPTION
                WHEN OTHERS THEN
                     ROLLBACK;
            END;

        END IF;

        COMMIT;

    END BATCH_LOG_LAST;

END PKG00_PROCEDURE_LOG;
/******************************************************************************
/* END OF PROCEDURE
/******************************************************************************/
