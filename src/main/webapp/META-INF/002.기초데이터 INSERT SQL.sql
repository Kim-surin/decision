/*COMPANY*/
insert into COMPANY (company_code, company_nm, ectmrk, presentn_no, rprsntv_nm, nation_code, bizrno, zip, adres, telno_1, fxnum, email_adres, cstbrkr, csmhse_code, acnutno, bank_code, item_group_at, cstms_amount_unit, drwbak_se_code, rtroact_pd, reqreqy_calc_mth, pric_rqest_type, auto_drwbak_flag)
values ('1100', '아모레퍼시픽', 'VC106864337301', '84060', '김승환', 'KR', '1068643373', '31919', '서울특별시 용산구 한강대로 100', '041-661-9107', '041-661-9399', 'abc@testita.com', null, '154', '100014713490', '0213376', 'Y', null, '1', '4', '5', null, 'N');
insert into COMPANY (company_code, company_nm, ectmrk, presentn_no, rprsntv_nm, nation_code, bizrno, zip, adres, telno_1, fxnum, email_adres, cstbrkr, csmhse_code, acnutno, bank_code, item_group_at, cstms_amount_unit, drwbak_se_code, rtroact_pd, reqreqy_calc_mth, pric_rqest_type, auto_drwbak_flag)
values ('1200', '에뛰드', 'VC135810503301', '88835', '이수연', 'KR', '1358105033', null, '서울특별시 용산구 한강대로 100', null, null, null, null, null, null, null, null, null, null, null, null, null, 'N');
insert into COMPANY (company_code, company_nm, ectmrk, presentn_no, rprsntv_nm, nation_code, bizrno, zip, adres, telno_1, fxnum, email_adres, cstbrkr, csmhse_code, acnutno, bank_code, item_group_at, cstms_amount_unit, drwbak_se_code, rtroact_pd, reqreqy_calc_mth, pric_rqest_type, auto_drwbak_flag)
values ('1300', '이니스프리', 'VC106866812701', '60304', '최민정', 'KR', '1068668127', null, '서울특별시 용산구 한강대로 100', null, null, null, null, null, null, null, null, null, null, null, null, null, 'N');
insert into COMPANY (company_code, company_nm, ectmrk, presentn_no, rprsntv_nm, nation_code, bizrno, zip, adres, telno_1, fxnum, email_adres, cstbrkr, csmhse_code, acnutno, bank_code, item_group_at, cstms_amount_unit, drwbak_se_code, rtroact_pd, reqreqy_calc_mth, pric_rqest_type, auto_drwbak_flag)
values ('1500', '코스비젼', null, null, '전봉철', 'KR', '1428111377', null, '대전광역시 대덕구 대화로 80(대화동)', null, null, null, null, null, null, null, null, null, null, null, null, null, 'N');
commit;

/*COM_AUTHOR_GROUP*/
insert into COM_AUTHOR_GROUP (author_group_code, company_code, author_group_nm, author_group_dc, use_at, start_page_url, create_date, create_by, update_date, update_by)
values ('TEST', '1100', 'TEST', '2', 'Y', '2', to_date('24-01-2024 15:09:07', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:09:07', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_GROUP (author_group_code, company_code, author_group_nm, author_group_dc, use_at, start_page_url, create_date, create_by, update_date, update_by)
values ('TEST1', '1100', 'TEST2', '1', 'Y', '1', to_date('24-01-2024 15:22:37', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:22:37', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_GROUP (author_group_code, company_code, author_group_nm, author_group_dc, use_at, start_page_url, create_date, create_by, update_date, update_by)
values ('VAR', '1100', 'VA', null, 'Y', null, to_date('24-01-2024 15:24:01', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:01', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_GROUP (author_group_code, company_code, author_group_nm, author_group_dc, use_at, start_page_url, create_date, create_by, update_date, update_by)
values ('ADMIN', '1100', 'ADMIN', '111', 'Y', '12', to_date('24-01-2024 14:50:37', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 14:50:37', 'dd-mm-yyyy hh24:mi:ss'), '1');
commit;

/*COM_AUTHOR_MENU*/
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('729', 'VAR', 'CUSVEN', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('730', 'VAR', 'CUSVEN001', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('731', 'VAR', 'CUSVEN005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('732', 'VAR', 'CUSVEN006', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('733', 'VAR', 'CUSVEN007', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('734', 'VAR', 'DRWBAK', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('735', 'VAR', 'DRWBAK005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('736', 'VAR', 'DRWBAK006', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('737', 'VAR', 'DRWBAK007', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('738', 'VAR', 'DRWBAK008', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('739', 'VAR', 'FTA', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('740', 'VAR', 'FTA001', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('741', 'VAR', 'FTA002', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('742', 'VAR', 'FTA003', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('743', 'VAR', 'FTA004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('744', 'VAR', 'FTA005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('745', 'VAR', 'MASTER', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('746', 'VAR', 'MASTER001', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('747', 'VAR', 'MASTER004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('748', 'VAR', 'MASTER005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('749', 'VAR', 'REFUND', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('750', 'VAR', 'REFUND004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('751', 'VAR', 'REFUND005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('752', 'VAR', 'REFUND006', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('753', 'VAR', 'REFUND007', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('754', 'VAR', 'REFUND008', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('755', 'VAR', 'REFUND009', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('756', 'VAR', 'REFUND011', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('757', 'VAR', 'REFUND020', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('758', 'VAR', 'REPORT', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('759', 'VAR', 'REPORT002', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('760', 'VAR', 'REPORT004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('761', 'VAR', 'REPORT005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('762', 'VAR', 'REPORT008', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('763', 'VAR', 'REPORT009', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('764', 'VAR', 'SAMPLE', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('765', 'VAR', 'SAMPLE000', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('766', 'VAR', 'SAMPLE001', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('767', 'VAR', 'SAMPLE002', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('768', 'VAR', 'SAMPLE003', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('769', 'VAR', 'SAMPLE004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('770', 'VAR', 'SYSTEM', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('771', 'VAR', 'SYSTEM002', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('772', 'VAR', 'SYSTEM003', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('773', 'VAR', 'SYSTEM004', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('774', 'VAR', 'SYSTEM005', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('775', 'VAR', 'SYSTEM006', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('776', 'VAR', 'SYSTEM007', '1100', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:16', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('825', 'ADMIN', 'CUSVEN', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('826', 'ADMIN', 'CUSVEN001', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('827', 'ADMIN', 'CUSVEN005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('828', 'ADMIN', 'CUSVEN006', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('829', 'ADMIN', 'CUSVEN007', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('830', 'ADMIN', 'DRWBAK', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('831', 'ADMIN', 'DRWBAK005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('832', 'ADMIN', 'DRWBAK006', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('833', 'ADMIN', 'DRWBAK007', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('834', 'ADMIN', 'DRWBAK008', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('835', 'ADMIN', 'FTA', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('836', 'ADMIN', 'FTA001', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('837', 'ADMIN', 'FTA002', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('838', 'ADMIN', 'FTA003', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('839', 'ADMIN', 'FTA004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('840', 'ADMIN', 'FTA005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('841', 'ADMIN', 'MASTER', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('842', 'ADMIN', 'MASTER001', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('843', 'ADMIN', 'MASTER004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('844', 'ADMIN', 'MASTER005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('845', 'ADMIN', 'REFUND', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('846', 'ADMIN', 'REFUND004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('847', 'ADMIN', 'REFUND005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('848', 'ADMIN', 'REFUND006', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('849', 'ADMIN', 'REFUND007', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('850', 'ADMIN', 'REFUND008', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('851', 'ADMIN', 'REFUND009', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('852', 'ADMIN', 'REFUND011', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('853', 'ADMIN', 'REFUND020', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('854', 'ADMIN', 'REPORT', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('855', 'ADMIN', 'REPORT002', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('856', 'ADMIN', 'REPORT004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('857', 'ADMIN', 'REPORT005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('858', 'ADMIN', 'REPORT008', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('859', 'ADMIN', 'REPORT009', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('860', 'ADMIN', 'SAMPLE000', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('861', 'ADMIN', 'SAMPLE001', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('862', 'ADMIN', 'SAMPLE002', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('863', 'ADMIN', 'SAMPLE003', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('864', 'ADMIN', 'SAMPLE004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('865', 'ADMIN', 'SYSTEM', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('866', 'ADMIN', 'SYSTEM002', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('867', 'ADMIN', 'SYSTEM003', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('868', 'ADMIN', 'SYSTEM004', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('869', 'ADMIN', 'SYSTEM005', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('870', 'ADMIN', 'SYSTEM006', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_AUTHOR_MENU (role_menu_id, author_group_code, menu_id, company_code, create_date, create_by, update_date, update_by)
values ('871', 'ADMIN', 'SYSTEM007', '1100', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1', to_date('24-01-2024 15:24:30', 'dd-mm-yyyy hh24:mi:ss'), '1');
commit;


/*COM_CD*/
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '37', '수출형태', '개성공단 이외의 북한 지역 임가공물품 외국 수출', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '000', '세관부호', '관세청', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '001', '세관부호', '관세청(기획관리관실)', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '002', '세관부호', '관세청(감사관실)', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '003', '세관부호', '관세청(조사감시국)', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '004', '세관부호', '관세청(정보협력국)', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '005', '세관부호', '관세청(통관지원국)', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '006', '세관부호', '관세청(심사정책국)', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '007', '세관부호', '관세평가분류원', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '008', '세관부호', '중앙관세분석소', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '009', '세관부호', '관세국경관리연수원', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '10', '세관부호', '서울세관', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '11', '세관부호', '성남세관 의정부세관비즈니스센터', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '12', '세관부호', '성남세관', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '13', '세관부호', '인천공항국제우편세관', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '14', '세관부호', '안산세관', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '16', '세관부호', '평택세관', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '17', '세관부호', '파주세관', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '20', '세관부호', '인천세관', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '21', '세관부호', '수원세관', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '23', '세관부호', '안산세관 부평세관비즈니스센터', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '30', '세관부호', '부산세관', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '33', '세관부호', '양산세관', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '35', '세관부호', '북부산세관', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '37', '세관부호', '북부산세관 부산우편세관비즈니스센터', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '39', '세관부호', '북부산세관', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '40', '세관부호', '인천세관', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '41', '세관부호', '김포공항세관', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '50', '세관부호', '마산세관', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '51', '세관부호', '경남남부세관', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '52', '세관부호', '경남서부세관 사천세관비즈니스센터', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '53', '세관부호', '창원세관', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '54', '세관부호', '경남남부세관 통영세관비즈니스센터', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '56', '세관부호', '경남서부세관', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '59', '세관부호', '마산수출자유지역', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '60', '세관부호', '여수세관', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '62', '세관부호', '광양세관', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '70', '세관부호', '목포세관', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '71', '세관부호', '광주세관', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DS', '3', '환급구분코드', '개별', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DS', '2', '환급구분코드', '간이', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DS', '1', '환급구분코드', '연산품', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RP', '4', '원재료소급기간', '24개월(2년)', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RP', '3', '원재료소급기간', '18개월', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RP', '2', '원재료소급기간', '12개월(1년)', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RP', '1', '원재료소급기간', '6개월', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '6', '소요량산정방법', '위탁건별 소요량', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '5', '소요량산정방법', '회계년도 소요량', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '4', '소요량산정방법', '일정기간별 단위 소요량', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '3', '소요량산정방법', '수출건별 총소요량', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '2', '소요량산정방법', '설계 소요량', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('RCM', '1', '소요량산정방법', '단위 실량(표준)', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B1', '대금청구유형', '리베이트 대변메모', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B1E', '대금청구유형', '확장리베이트대변메모', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B2', '대금청구유형', '리베이트수정', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B2E', '대금청구유형', '확장 리베이트 수정', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B3', '대금청구유형', '리베이트파트정산', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B3E', '대금청구유형', '확장리베이트부분정산', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'B4', '대금청구유형', '리베이트수작업이자', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BIND', '대금청구유형', '간접 송장 리베이트', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BINP', '대금청구유형', '간접계획정산리베이트', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BK1', '대금청구유형', '차변메모계약', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BK3', '대금청구유형', '차변메모계약', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BM1', '대금청구유형', '차변메모계약', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BM3', '대금청구유형', '차변메모계약', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'BV', '대금청구유형', '현금 판매', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'CHFK', '대금청구유형', '어음 CH 거래 D', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'CHFX', '대금청구유형', '어음 CH 거래 C', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'F1', '대금청구유형', '송장 (F1)', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'F2', '대금청구유형', '송장', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'F5', '대금청구유형', '오더 견적', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'F8', '대금청구유형', '납품 견적 송장', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FADP', '대금청구유형', '선금 요청', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FAS', '대금청구유형', '선금 요청 취소', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FAZ', '대금청구유형', '선금 요청', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FL', '대금청구유형', 'LB 견적', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FP', '대금청구유형', '청구 POS-인터페이스', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FR', '대금청구유형', '수리송장', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FV', '대금청구유형', '일괄계약송장', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FX', '대금청구유형', '외부거래 대금청구', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FXG', '대금청구유형', '대변메모 S-b w.i.', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FXL', '대금청구유형', '차변메모 S-b w.i.', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'FXS', '대금청구유형', '송장 S-b w.i.', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'G2', '대금청구유형', '대변 메모', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'G2S', '대금청구유형', '제 3자 대변메모', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'HR', '대금청구유형', '교육관리 대금청구', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IG', '대금청구유형', '내부대변메모', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IGA', '대금청구유형', 'ICM 오더관련', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IGS', '대금청구유형', 'ICM 취소', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IV', '대금청구유형', '회사 간 대금청구', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IVA', '대금청구유형', 'IB 오더 관련', 39, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'IVS', '대금청구유형', 'IB 취소', 40, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'JEX', '대금청구유형', 'Excise invoice India', 41, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'L2', '대금청구유형', '차변 메모', 42, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'LG', '대금청구유형', '대변 메모 리스트', 43, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'LGS', '대금청구유형', '대변메모리스트 취소', 44, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'LR', '대금청구유형', '송장 리스트', 45, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'LRS', '대금청구유형', '송장 리스트 취소', 46, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'RE', '대금청구유형', '반품의 대변', 47, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'S1', '대금청구유형', '송장취소 (SI)', 48, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'S2', '대금청구유형', '취소대변메모', 49, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'S3', '대금청구유형', '송장취소 (S3)', 50, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'SHR', '대금청구유형', '교육관리취소', 51, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'SV', '대금청구유형', '현금판매취소', 52, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('PR', 'WIA', '대금청구유형', '해외 플랜트', 53, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '72', '세관부호', '목포세관 완도세관비즈니스센터', 39, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '80', '세관부호', '군산세관', 40, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '81', '세관부호', '전주세관 익산세관비즈니스센터', 41, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '82', '세관부호', '전주세관', 42, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '90', '세관부호', '제주세관', 43, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '100', '세관부호', '동해세관', 44, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '101', '세관부호', '속초세관', 45, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '102', '세관부호', '동해세관 원주세관비즈니스센터', 46, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '103', '세관부호', '속초세관 고성세관비즈니스센터', 47, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '110', '세관부호', '울산세관', 48, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '120', '세관부호', '대구세관', 49, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '121', '세관부호', '구미세관', 50, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '122', '세관부호', '포항세관', 51, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '130', '세관부호', '안양세관 구로세관비즈니스센터', 52, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '131', '세관부호', '안양세관', 53, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '140', '세관부호', '김해공항세관', 54, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '150', '세관부호', '대전세관', 55, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '151', '세관부호', '청주세관', 56, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '152', '세관부호', '천안세관', 57, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '153', '세관부호', '청주세관 충주세관비즈니스센터', 58, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CUSC', '154', '세관부호', '대전세관 대산세관비즈니스센터', 59, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '100', '수출거래구분', '화폐 등 지급수단의 수출', 1, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '101', '수출거래구분', '자유무역지역에서의 수출(GDC 국외반출물품)', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '11', '수출거래구분', '일반형태 수출', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '15', '수출거래구분', '전자상거래에 의한 수출물품', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MT', '국가코드', '몰타', 69, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MN', '국가코드', '몽골', 70, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'US', '국가코드', '미국', 71, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VI', '국가코드', '미국령 버진아일랜드', 72, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AS', '국가코드', '미국령 사모아', 73, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'UM', '국가코드', '미국령 태평양군도', 74, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MM', '국가코드', '미얀마', 75, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FM', '국가코드', '미크로네시아', 76, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VU', '국가코드', '바누아투', 77, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BH', '국가코드', '바레인', 78, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BB', '국가코드', '바베이도스', 79, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VA', '국가코드', '바티칸 시국', 80, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BS', '국가코드', '바하마', 81, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BD', '국가코드', '방글라데시', 82, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BM', '국가코드', '버뮤다', 83, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BJ', '국가코드', '베냉', 84, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VE', '국가코드', '베네수엘라', 85, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VN', '국가코드', '베트남', 86, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BE', '국가코드', '벨기에', 87, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BY', '국가코드', '벨라루스', 88, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BZ', '국가코드', '벨리즈', 89, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BA', '국가코드', '보스니아 헤르체고비나', 90, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BW', '국가코드', '보츠와나', 91, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BO', '국가코드', '볼리비아', 92, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BI', '국가코드', '부룬디', 93, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BF', '국가코드', '부르키나 파소', 94, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BV', '국가코드', '부베도', 95, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BT', '국가코드', '부탄', 96, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MP', '국가코드', '북마리아나군도', 97, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KP', '국가코드', '북한', 98, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BG', '국가코드', '불가리아', 99, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BR', '국가코드', '브라질', 100, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BN', '국가코드', '브루나이', 101, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ZZ', '국가코드', '비역내', 102, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SA', '국가코드', '사우디아라비아', 103, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CY', '국가코드', '사이프러스', 104, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SM', '국가코드', '산마리노', 105, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ST', '국가코드', '상투메 프린시페', 106, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PM', '국가코드', '생피에르 미클롱', 107, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'WS', '국가코드', '서사모아', 108, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'EH', '국가코드', '서사하라', 109, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SN', '국가코드', '세네갈', 110, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'RS', '국가코드', '세르비아', 111, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SC', '국가코드', '세이셸', 112, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LC', '국가코드', '세인트 루치아', 113, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MF', '국가코드', '세인트 마틴', 114, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'BL', '국가코드', '세인트 바돌로메', 115, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VC', '국가코드', '세인트 빈센트 그레나딘', 116, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KN', '국가코드', '세인트 킷츠 네비스', 117, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '11', '수입거래구분', '일반수입', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '12', '수입거래구분', '주문자 상표부착에 의한 수입물품(OEM방식)', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '13', '수입거래구분', '방위산업용 시설재 및 원자재의 수입', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '14', '수입거래구분', '계획조선용 원자재의 수입', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '15', '수입거래구분', '전자상거래에 의한 수입물품', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '21', '수입거래구분', '국내외국인 투자업체가 수탁가공 수출을 위한 원자재 수입', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '22', '수입거래구분', '기타 일반업체가 수탁가공 수출을 위한 원자재 수입', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '29', '수입거래구분', ' 위탁가공(국외가공)후 수입', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '31', '수입거래구분', '공공차관', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '39', '수입거래구분', '기타차관', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '41', '수입거래구분', '국내투자', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '49', '수입거래구분', '자유무역지역 입주', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '51', '수입거래구분', '수탁판매를 위한 물품의 수입', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '52', '수입거래구분', '연계(구상)무역 수출을 위한 물품의 수입', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '53', '수입거래구분', '소유권이전 조건부수입', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '54', '수입거래구분', '소유권불이전 조건부수입', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '55', '수입거래구분', ' 임대방식에 의한 수출후 다시 수입되는 물품', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '59', '수입거래구분', ' 내국인이 미군 등에 납품할 자재 또는 국내에서 외화를 받고 판매할 물품의 구입', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '61', '수입거래구분', ' 상계원재료', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '70', '수입거래구분', ' 국내보세공장에서 건조된 국적취득 조건부 나용선의 수입', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '71', '수입거래구분', 'SOFA특례법 제9조에 의거, 세관장의 양수도 승인을 받은 물품의 수입', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '72', '수입거래구분', '외교관물품으로서 양수도 승인수입', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '81', '수입거래구분', '국내에서 수리하기 위한 선박, 항공기 수입', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '82', '수입거래구분', '검사수리 목적으로 외국에 반출된 선박·항공기 수입 및 운항 중 해외 현지에서 선..', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '83', '수입거래구분', '외국에서 검사·수리 목적으로 반출하였던 물품의 수입(선·기 제외)', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '84', '수입거래구분', '외국물품을 국내에서 수리·검사후 다시 반출하기 위해 수입(선·기 제외)', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '85', '수입거래구분', '외국에서 개최된 국제행사, 체육대회, 전시회, 박람회, 문화예술공연 등에 출품했..', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '86', '수입거래구분', '우리나라에서 개최하는 국제행사, 체육대회, 전시회, 박람회, 문화예술공연 등에 ..', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '88', '수입거래구분', '우리나라에서 수출하였던 물품을 수리 후 재반출하기 위해 수입하는 경우', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '89', '수입거래구분', '우리나라에서 수출되었던 물품을 크레임 등의 사유로 반입하는 경우', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '80', '수입거래구분', '기타 외국환거래가 수반되지 아니하는 물품의 수입', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '91', '수입거래구분', '이사화물 수입', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '92', '수입거래구분', '수출계약이행에 필요한 물품의 수입 등 무역거래 원활을 위한 물품', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '87', '수입거래구분', '무상으로 반입하는 상품의 견품 및 광고용품', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '90', '수입거래구분', '수출물품의 성능보장 기간내의 수리·검사를 위해 반출했던 물품의 수입, 해외에 검..', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '93', '수입거래구분', '수입된 물품이 계약조건과 상이하거나, 하자 보증이행 또는 용도변경 등의 부득이한..', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '94', '수입거래구분', '기타 수입승인 면제물품', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '95', '수입거래구분', ' 외교관 용품 등 수입', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '96', '수입거래구분', ' 여행자 또는 승무원 휴대품 수입', 40, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '97', '수입거래구분', ' SOFA 협정에 의한 면세 대상물품 반입', 41, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '98', '수입거래구분', '대북반입 대상물품이나 과세를 한 경우', 42, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '99', '수입거래구분', '대북반입 또는 직수입물품', 43, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPT', '100', '수입거래구분', '화폐 등 지급수단의 수입', 44, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '11', '수입종류', '일반수입(외화 획득용)', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '12', '수입종류', '외국으로부터 수출할 목적으로 보세공장에 반입되는 물품', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '13', '수입종류', '보세공장으로부터 수입(제품과세)', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '14', '수입종류', '외국자유무역지역 반입물품(원재료)', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '15', '수입종류', '자유무역지역 제조가공물품통관', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '16', '수입종류', '해외진출기업 제작물품 수입(외화획득용)', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '17', '수입종류', '보세건설장반입물품 수리전사용승인 물품', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '18', '수입종류', '보세판매장 반입물품(보세공장, 수출자유지역반입)', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '19', '수입종류', '해외진출기업 제작물품 수입(내수용)', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '20', '수입종류', '보세건설장반입물품 수리전사용승인물품(분할신고)', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '21', '수입종류', '일반수입(내수용)', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '21', '수출거래구분', '국내 외국인 투자업체가 외국으로부터 수탁받아 가공후 수출', 5, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '22', '수출거래구분', '기타 일반업체가 수탁받아 가공후 수출', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '29', '수출거래구분', '위탁가공(국외가공)을 위한 원자재수출', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '31', '수출거래구분', '위탁판매를 위한 물품의 수출', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '32', '수출거래구분', '연계무역에 의한 물품의 수출(구상무역 포함)', 9, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '33', '수출거래구분', '임대방식에 의한 수출(소유권 이전조건)', 10, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '39', '수출거래구분', '임대방식에 의한 수출(소유권 불이전조건)', 11, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '40', '수출거래구분', '임차방식에 의한 수입 후 다시수출되는 물품', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '41', '수출거래구분', '대외 원조수출(정부원조)', 13, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '49', '수출거래구분', '대외 원조수출(민간원조)', 14, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '51', '수출거래구분', '현물차관수출', 15, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '59', '수출거래구분', '현물상환수출', 16, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '61', '수출거래구분', '해외투자 수출', 17, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '69', '수출거래구분', '산업설비', 18, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '70', '수출거래구분', '국내보세공장에서 국적취득조건부 나용선으로 건조한 선박에수출', 19, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '71', '수출거래구분', '주한 미군 불하물품 수출', 20, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '72', '수출거래구분', '외국물품을 수입통관후 원상태로 수출', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '73', '수출거래구분', '수출조건부 공매물품의 수출', 22, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '78', '수출거래구분', '외국으로부터 보세구역에 반입된 물품으로 다시 반송되는 물품', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '79', '수출거래구분', '중계무역수출', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '81', '수출거래구분', '선박,항공기를 국내수리후 수출', 25, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '82', '수출거래구분', '선박,항공기를 외국에서 수리,검사받을 목적으로 수출', 26, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '83', '수출거래구분', '외국에서 수리,검사 목적으로 반출하는 물품(선,기 제외)', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '84', '수출거래구분', '외국물품 수리,검사(가공제외) 후 반출하는 물품(선,기제외)', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '85', '수출거래구분', '외국에서 개최 국제행사 참가하기 위해 무상 반출하는 물품', 29, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '010', '세관', '서울세관', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '011', '세관', '의정부출장소', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '012', '세관', '성남세관', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '013', '세관', '국제우편출장소', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '014', '세관', '안산세관', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '016', '세관', '평택세관', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '017', '세관', '파주감시소', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '018', '세관', '동두천감시소', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '020', '세관', '인천세관', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '021', '세관', '수원세관', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '022', '세관', '주안출장소', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '023', '세관', '부평출장소', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '030', '세관', '부산세관', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '032', '세관', '동래세관', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '033', '세관', '양산세관', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '035', '세관', '사상출장소', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '036', '세관', '감천감시소', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '038', '세관', '삼남감시소', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '039', '세관', '용당세관', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '040', '세관', '인천공항세관', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '041', '세관', '김포출장소', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '050', '세관', '마산세관', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '051', '세관', '거제세관', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '052', '세관', '사천출장소', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '053', '세관', '창원세관', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '054', '세관', '통영출장소', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '055', '세관', '진해감시소', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '056', '세관', '진주출장소', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '057', '세관', '온산감시소', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '058', '세관', '미포감시소', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '059', '세관', '마산수출자유지역', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '060', '세관', '여수세관', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '062', '세관', '광양세관', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '070', '세관', '목포세관', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '071', '세관', '광주세관', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '072', '세관', '완도감시소', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '073', '세관', '노화도감시소', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '080', '세관', '군산세관', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '081', '세관', '익산출장소', 39, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '082', '세관', '전주출장소', 40, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '083', '세관', '군산외항감시소', 41, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '090', '세관', '제주세관', 42, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '100', '세관', '동해세관', 43, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '101', '세관', '속초출장소', 44, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '110', '세관', '울산세관', 45, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '111', '세관', '삼량감시소', 46, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '120', '세관', '대구세관', 47, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '121', '세관', '구미세관', 48, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '122', '세관', '포항세관', 49, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '130', '세관', '구로세관', 50, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '131', '세관', '안양세관', 51, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '140', '세관', '김해세관', 52, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '150', '세관', '대전세관', 53, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '151', '세관', '청주세관', 54, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '152', '세관', '천안세관', 55, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '153', '세관', '충주출장소', 56, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CT', '154', '세관', '대산출장소', 57, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GH', '국가코드', '가나', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GA', '국가코드', '가봉', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GY', '국가코드', '가이아나', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GM', '국가코드', '감비아', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GG', '국가코드', '건지', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GP', '국가코드', '과달루프', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GT', '국가코드', '과테말라', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GU', '국가코드', '괌', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GD', '국가코드', '그레나다', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GE', '국가코드', '그루지아', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GR', '국가코드', '그리스', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GL', '국가코드', '그린랜드', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GN', '국가코드', '기니', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GW', '국가코드', '기니비사우', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NA', '국가코드', '나미비아', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NR', '국가코드', '나우루', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NG', '국가코드', '나이지리아', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AQ', '국가코드', '남극', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ZA', '국가코드', '남아프리카공화국', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GS', '국가코드', '남조지아·남샌드위치군도', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NL', '국가코드', '네덜란드', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AN', '국가코드', '네덜란드령 안틸레스', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NP', '국가코드', '네팔', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NO', '국가코드', '노르웨이', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NF', '국가코드', '노퍽섬', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NZ', '국가코드', '뉴질랜드', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NC', '국가코드', '뉴칼레도니아', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NU', '국가코드', '니우에', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NE', '국가코드', '니제르', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'NI', '국가코드', '니카라과', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TW', '국가코드', '대만', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KR', '국가코드', '대한민국', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DK', '국가코드', '덴마크', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DO', '국가코드', '도미니카 공화국', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DM', '국가코드', '도미니카연방', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DE', '국가코드', '독일', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TL', '국가코드', '동티모르', 37, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LA', '국가코드', '라오스', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LR', '국가코드', '라이베리아', 39, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LV', '국가코드', '라트비아', 40, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'RU', '국가코드', '러시아', 41, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LB', '국가코드', '레바논', 42, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LS', '국가코드', '레소토', 43, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'RE', '국가코드', '레위니옹', 44, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'RO', '국가코드', '루마니아', 45, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LU', '국가코드', '룩셈부르크', 46, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'RW', '국가코드', '르완다', 47, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LY', '국가코드', '리비아', 48, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LT', '국가코드', '리투아니아', 49, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LI', '국가코드', '리히텐슈타인', 50, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MG', '국가코드', '마다가스카르', 51, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MH', '국가코드', '마샬군도', 52, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'YT', '국가코드', '마요티', 53, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MO', '국가코드', '마카오', 54, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MK', '국가코드', '마케도니아 공화국', 55, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MW', '국가코드', '말라위', 56, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MY', '국가코드', '말레이지아', 57, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ML', '국가코드', '말리', 58, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MA', '국가코드', '모로코', 59, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MQ', '국가코드', '말티니크', 60, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IM', '국가코드', '맨섬', 61, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MX', '국가코드', '멕시코', 62, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MR', '국가코드', '모리타니', 63, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MZ', '국가코드', '모잠비크', 64, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ME', '국가코드', '몬테네그로', 65, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MS', '국가코드', '몬트세라트', 66, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MD', '국가코드', '몰도바', 67, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'MV', '국가코드', '몰디브', 68, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DL', '1', '환급제한규정', '단축고시규정', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DL', '2', '환급제한규정', '조정고시규정', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SH', '국가코드', '세인트헬레나', 118, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SO', '국가코드', '소말리아', 119, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SB', '국가코드', '솔로몬군도', 120, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SD', '국가코드', '수단', 121, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SR', '국가코드', '수리남', 122, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'LK', '국가코드', '스리랑카', 123, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SJ', '국가코드', '스발바르 얀마옌', 124, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SZ', '국가코드', '스와질랜드', 125, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SE', '국가코드', '스웨덴', 126, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CH', '국가코드', '스위스', 127, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ES', '국가코드', '스페인', 128, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SK', '국가코드', '슬로바키아', 129, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SI', '국가코드', '슬로베니아', 130, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SY', '국가코드', '시리아', 131, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SL', '국가코드', '시에라리온', 132, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SG', '국가코드', '싱가포르', 133, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AE', '국가코드', '아랍에미리트', 134, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AW', '국가코드', '아루바', 135, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AM', '국가코드', '아르메니아', 136, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AR', '국가코드', '아르헨티나', 137, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IS', '국가코드', '아이슬란드', 138, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HT', '국가코드', '아이티', 139, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IE', '국가코드', '아일랜드', 140, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AZ', '국가코드', '아제르바이잔', 141, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AF', '국가코드', '아프가니스탄', 142, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AI', '국가코드', '안길라', 143, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AD', '국가코드', '안도라', 144, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AL', '국가코드', '알바니아', 145, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DZ', '국가코드', '알제리', 146, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AO', '국가코드', '앙골라', 147, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AG', '국가코드', '앤티가 바부다', 148, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ER', '국가코드', '에리트리아', 149, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'EE', '국가코드', '에스토니아', 150, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'EC', '국가코드', '에콰도르', 151, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ET', '국가코드', '에티오피아', 152, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'SV', '국가코드', '엘살바도르', 153, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GB', '국가코드', '영국', 154, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'VG', '국가코드', '영국령 버진아일랜드', 155, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IO', '국가코드', '영국령 인도양지역', 156, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'YE', '국가코드', '예멘', 157, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'OM', '국가코드', '오만', 158, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AU', '국가코드', '오스트레일리아', 159, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AT', '국가코드', '오스트리아', 160, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HN', '국가코드', '온두라스', 161, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'AX', '국가코드', '올란드 제도', 162, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'JO', '국가코드', '요르단', 163, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'UG', '국가코드', '우간다', 164, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'UY', '국가코드', '우르과이', 165, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'UZ', '국가코드', '우즈베키스탄', 166, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'UA', '국가코드', '우크라이나', 167, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'WF', '국가코드', '월리스 푸투나', 168, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'YU', '국가코드', '유고슬라비아', 169, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IQ', '국가코드', '이라크', 170, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IR', '국가코드', '이란', 171, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IL', '국가코드', '이스라엘', 172, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'EG', '국가코드', '이집트', 173, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IT', '국가코드', '이탈리아', 174, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'IN', '국가코드', '인도', 175, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ID', '국가코드', '인도네시아', 176, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'JP', '국가코드', '일본', 177, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'JM', '국가코드', '자메이카', 178, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ZR', '국가코드', '자이르', 179, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ZM', '국가코드', '잠비아', 180, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'JE', '국가코드', '저지', 181, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GQ', '국가코드', '적도 기니', 182, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CN', '국가코드', '중국', 183, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CF', '국가코드', '중앙아프리카공화국', 184, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'DJ', '국가코드', '지부티', 185, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GI', '국가코드', '지브롤터', 186, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'ZW', '국가코드', '짐바브웨', 187, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TD', '국가코드', '차드', 188, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CZ', '국가코드', '체코', 189, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CL', '국가코드', '칠레', 190, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CM', '국가코드', '카메룬', 191, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CV', '국가코드', '카보베르데', 192, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KZ', '국가코드', '카자흐스탄', 193, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'QA', '국가코드', '카타르', 194, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KH', '국가코드', '캄보디아', 195, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CA', '국가코드', '캐나다', 196, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KE', '국가코드', '케냐', 197, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KY', '국가코드', '케이만군도', 198, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KM', '국가코드', '코모로', 199, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CR', '국가코드', '코스타리카', 200, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CC', '국가코드', '코코스군도', 201, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CI', '국가코드', '코트디브아르', 202, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CO', '국가코드', '콜롬비아', 203, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CG', '국가코드', '콩고', 204, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CD', '국가코드', '콩고민주공화국', 205, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CU', '국가코드', '쿠바', 206, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KW', '국가코드', '쿠웨이트', 207, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CK', '국가코드', '쿠크군도', 208, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HR', '국가코드', '크로아티아', 209, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'CX', '국가코드', '크리스마스도', 210, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KG', '국가코드', '키르기스스탄', 211, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'KI', '국가코드', '키리바시', 212, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TJ', '국가코드', '타지키스탄', 213, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TZ', '국가코드', '탄자니아', 214, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TH', '국가코드', '태국', 215, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TC', '국가코드', '터크스·카이코스군도', 216, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TR', '국가코드', '터키', 217, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TG', '국가코드', '토고', 218, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TK', '국가코드', '토켈라우', 219, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TO', '국가코드', '통가', 220, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TM', '국가코드', '투르크메니스탄', 221, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TV', '국가코드', '투발루', 222, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TN', '국가코드', '튀니지', 223, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TT', '국가코드', '트리니다드·토바고', 224, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PA', '국가코드', '파나마', 225, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PY', '국가코드', '파라과이', 226, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FO', '국가코드', '파로에군도', 227, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PK', '국가코드', '파키스탄', 228, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PG', '국가코드', '파푸아뉴기니', 229, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PE', '국가코드', '페루', 230, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PT', '국가코드', '포르투갈', 231, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PL', '국가코드', '폴란드', 232, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PR', '국가코드', '푸에토리코', 233, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FR', '국가코드', '프랑스', 234, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FX', '국가코드', '프랑스 본국', 235, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'TF', '국가코드', '프랑스령 극남군도', 236, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'GF', '국가코드', '프랑스령 기아나', 237, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PF', '국가코드', '프랑스령 폴리네시아', 238, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FJ', '국가코드', '피지', 239, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'FI', '국가코드', '핀란드', 240, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PH', '국가코드', '필리핀', 241, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'PN', '국가코드', '핏카인도', 242, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HM', '국가코드', '허드 맥도날드 제도', 243, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HU', '국가코드', '헝가리', 244, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('NA', 'HK', '국가코드', '홍콩', 245, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '86', '수출거래구분', '국내에서 개최된 국제행사에 참가한 후 재반출하는 물품', 30, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '89', '수출거래구분', '수리,검사,기타사유로 반입되어 작업후 다시 반출되는 물품', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '90', '수출거래구분', '수출된 물품이 계약내용과 상이하여 반출하는 물품', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '91', '수출거래구분', '해외 이주자가 반출하는 원자재,시설재,장비등의 물품의 수출', 33, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '92', '수출거래구분', '무상으로 반출하는 상품의 견품 및 광고용품', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '93', '수출거래구분', '수입된 물품이 계약내용과 상이하여 반출하는 물품', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '94', '수출거래구분', '기타 수출승인 면제물품', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '95', '수출거래구분', '외교관 용품등 수출', 37, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ETC', '96', '수출거래구분', '물품의 수리 또는 검사를 위하여 반출하는 물품', 38, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBR381', '환급 통보서', '환급금지급결정통지서', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBR5DF', '환급 통보서', '환급 완료통보', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBRR54', '환급 통보서', '환급 접수통보', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBR5DU', '환급 통보서', '기초원재료납세증명서 양수자통보서', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBR5DV', '환급 통보서', '분할증명서양수자통보서', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBRR58', '환급 통보서', '환급 보완통보서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBRR57', '환급 통보서', '환급 자료제출요구서', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCR', 'GOVCBR5DY', '환급 통보서', '정산납부서', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBR5DB', '환급 신고서', '기초원재료납세증명서', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBR5DE', '환급 신고서', '분할증명서', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBR5DC', '환급 신고서', '평균세액증명서', 17, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBR5DX', '환급 신고서', '제증명 정정취하신청서', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDEY', '환급 신고서', '평균세액증명서 발급대상물품 지정신청서', 15, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBR5DA', '환급 신고서', '환급신청서', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDFA', '환급 신고서', '환급단위신청서', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDEX', '환급 신고서', '조견표제출', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDEZ', '환급 신고서', '환급금계좌(신규 · 변경) 통보서', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRD93', '환급 신고서', 'BOM제출', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCB', '환급 신고서', '간이정액환급(적용 · 비적용) 승인신청서', 9, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCC', '환급 신고서', '과다환급금 자진신고서', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCD', '환급 신고서', 'P/L발급업체 지정신청서', 7, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCE', '환급 신고서', '소요량 산정방법 등 신고서', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCF', '환급 신고서', '환급신청기관 변경신청서', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCG', '환급 신고서', '소요량계산서 제출', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCK', '환급 신고서', '가산금액 지급신청서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDCO', '환급 신고서', '기초원재료납세증명서 거래기간 연장승인 신청서', 2, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('GOVCS', 'GOVCBRDJ9', '환급 신고서', '소요량사전심사신청서', 1, 'N');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DL', '3', '환급제한규정', '제한고시규정', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'CSTMS', '세목(세금종류)', '관세', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'INTTAX', '세목(세금종류)', '개소세', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'ECX', '세목(세금종류)', '교육세', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'AGSPT', '세목(세금종류)', '농특세', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'TRANTAX', '세목(세금종류)', '교통세', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('TT', 'LQTX', '세목(세금종류)', '주세', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SUDT', '3', '고객사 근거서류 구분', '물품거래확인서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SUDT', '2', '고객사 근거서류 구분', '매매계약서', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SUDT', '1', '고객사 근거서류 구분', '구매확인서', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CFRSN', 'A', '확정실패사유', 'BOM누락', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CFRSN', 'B', '확정실패사유', '잔량부족', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('CFRSN', 'Z', '확정실패사유', '기타오류', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DC', '1', '환급구분', '연산품', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DC', '2', '환급구분', '간이', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DC', '3', '환급구분', '개별', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DC', '4', '환급구분', '자동간이', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DC', '5', '환급구분', '원상태', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '00', '원재료구분', '수입신고필증', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '02', '원재료구분', '기초원재료납세증명서', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '03', '원재료구분', '평균세액증명서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '04', '원재료구분', '분할증명서', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '05', '원재료구분', '부산물', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('LMC', '06', '원재료구분', '위탁가공', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '01', '소요량구분', '단위실량', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '02', '소요량구분', '단위설계소요량', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '03', '소요량구분', '수출건별등총소요량', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '04', '소요량구분', '일정기간별단위소요량', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '05', '소요량구분', '1회계년도단위소요량', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BOMC', '06', '소요량구분', '위탁건별총소요량', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DEDC', 'A', '공제구분', '지급제한 (덤핑, 보복, 상계 관세 적용 물품)', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DEDC', 'B', '공제구분', '부산물 (부산물내역서 작성)', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DEDC', 'C', '공제구분', '부산물 (부산물내역서 작성 생략)', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BSDC', '01', '기납증 근거서류구분', '내국신용장', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BSDC', '02', '기납증 근거서류구분', '구매확인서', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BSDC', '03', '기납증 근거서류구분', '수출신용장 또는 수출계약서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('BSDC', '04', '기납증 근거서류구분', '매매계약서 등', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '01', '분증 근거서류구분', '내국신용장', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '02', '분증 근거서류구분', '구매확인서', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '03', '분증 근거서류구분', '수출신용장 또는 수출계약서', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '04', '분증 근거서류구분', '매매계약서 등', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '05', '분증 근거서류구분', '양도승인서', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '06', '분증 근거서류구분', '물품배정서', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('DSDC', '07', '분증 근거서류구분', '비축물자배정통지서', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '01', '수출형태', '관세법 규정에 의한 수출신고수리된 유환수출물품', 1, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '02', '수출형태', '유환수출신고 수리물품중 수입원상태수출물품', 2, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '03', '수출형태', '보세구역 또는 자유무역지역에의 제조.가공후 공급물품', 3, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '04', '수출형태', '보세구역 또는 자유무역지역에의 수입원상태 공급물품', 4, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '05', '수출형태', '외국무역선(기)에 선용품으로 제조.가공후 공급하는 물품', 5, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '06', '수출형태', '외국무역선(기)에 선용품으로 수입원상태 공급하는 물품', 6, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '07', '수출형태', '원양어선에 선수품으로 제조.가공후 공급하는 물품', 7, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '08', '수출형태', '원양어선에 선수품으로 수입원상태 공급하는 물품', 8, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '09', '수출형태', '박람회등에 출품물품', 9, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '10', '수출형태', '해외투자, 건설용역등의 물품중 제조 가공후 반출하는 물품수출', 10, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '11', '수출형태', '계약조건과 상이하여 반품된 물품의 대체수출', 11, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '12', '수출형태', '주한미군에 판매물품', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '13', '수출형태', '주한외국기관의 공사용품', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '14', '수출형태', '주한 외국기관에 판매하는 국산자동차', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '15', '수출형태', '외자도입법상 출자한 자본재', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '16', '수출형태', '차관자금에 의한 국제경쟁 낙찰물품', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '17', '수출형태', '해외취업근로자에 대한 면세쿠폰 판매물품', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '18', '수출형태', '수출계약을 위해 무상으로 송부하는 견본용 물품', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '19', '수출형태', '수탁가공물품 및 잔존원재료의 수출', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '20', '수출형태', '외국에서 위탁가공할 목적으로 제조 가공후 반출하는 물품 수출', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '21', '수출형태', '위탁판매를 위한 반출물품', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '22', '수출형태', '연계무역에 의한 물품의 수출', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '23', '수출형태', '북한에서의 위탁가공용 반출물품(현지판매또는제3국수출)', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '24', '수출형태', '전자상거래 수출', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '25', '수출형태', '유한수출신고 수리물품중 국내구매된 상태 그대로 수출된 물품', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '26', '수출형태', '외국에서 위탁가공할 목적으로 국내구매된 상태 그대로 반출물품', 26, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '27', '수출형태', '보세구역또는자유무역지역에 국내구매된상태그대로 공급하는물품', 27, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '28', '수출형태', '외국무역선(기)에 국내구매된상태그대로 공급하는물품', 28, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '29', '수출형태', '원양어선에 선수품으로 국내 구매된 상태 그대로 공급하는 물품', 29, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '30', '수출형태', '현물차관 수출 등 기타 유상수출', 30, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '31', '수출형태', '관세등일괄납부업체의 사후정산결과 환급금 지급', 31, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '32', '수출형태', '해외투자, 건설용역등의 물품중 수입원상태로 반출하는 물품수출', 32, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '33', '수출형태', '해외투자, 건설용역등의 국내생산물품을 구매한상태 그대로 수출', 33, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '34', '수출형태', '외국에서 위탁가공할 목적으로 수입원상태로 반출하는 물품 수출', 34, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '35', '수출형태', '수탁가공물품 계약상이 대체수출', 35, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('ET', '36', '수출형태', '개성공단 임가공물품 외국 수출', 36, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '22', '수입종류', '수리전반출승인수입(외화획득용)', 12, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '23', '수입종류', '수리전반출승인수입(내수용)', 13, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '24', '수입종류', '면세품 판매장 수입(반입)', 14, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '25', '수입종류', '면세품 판매장의 잉여품 수입(반입)', 15, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '26', '수입종류', '우편물품(국제우체국 면허분)', 16, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '27', '수입종류', '종합보세구역에 반입, 자유무역지역에 반입', 17, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '28', '수입종류', '보세공장물품, 자유무역지역 잉여품통관', 18, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '29', '수입종류', '보세공장으로부터 수입(원료과세)', 19, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '30', '수입종류', '보세판매장 반입물품(외국에서 직수입)', 20, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '31', '수입종류', '외국으로부터 수입을 목적으로 보세공장에 반입되는 물품', 21, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '32', '수입종류', '종합보세구역으로부터 수입', 22, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '33', '수입종류', '보세판매장 반입물품(기타 환급대상물품반입)', 23, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '34', '수입종류', '보세공장, 자유무역지역, 종합보세구역에서 잉여품수입-외화획득용', 24, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '35', '수입종류', '외국자유무역지역 반입물품(시설재)', 25, 'Y');
insert into COM_CD (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('IMPD', '36', '수입종류', '종합보세구역(보세공장기능) 원료과세', 26, 'Y');
commit;



/*COM_MENU*/
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM004', 'SYSTEM', '인터페이스 수동 실행', '인터페이스 수동 실행', '인터페이스 수동 실행', 'L', 'fa-circle-thin', 'N', '/sm-004', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND008', 'REFUND', 'New_표준 BOM', 'Standard BOM', 'New_표준 BOM', 'L', 'fa-circle-thin', 'N', '/refundBasis-008', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK007', 'DRWBAK', 'New_내수매출확정', 'Domestic Sales Confirmation', 'New_매출확정(내수)', 'L', 'fa-circle-thin', 'N', '/db-007', 2, 'Y', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND006', 'REFUND', '매출내역 관리', 'Sales Ledger', '매출내역 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-006', 11, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER', null, '마스터관리', '마스터관리', '마스터관리', 'L', 'fa-tasks', 'N', '#', 9, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER001', 'MASTER', '회사관리', '회사관리', '회사관리', 'L', 'fa-circle-thin', 'N', '/mm-001', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER002', 'MASTER', '고객사관리', '고객사관리', '고객사관리', 'L', 'fa-circle-thin', 'N', '/mm-002', 3, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER003', 'MASTER', '협력사관리', '협력사관리', '협력사관리', 'L', 'fa-circle-thin', 'N', '/mm-003', 5, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER004', 'MASTER', '환급제한규정 관리', '환급제한규정 관리', '환급제한규정 관리', 'L', 'fa-circle-thin', 'N', '/mm-004', 7, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK004', 'DRWBAK', '관세청관리-기납증', '관세청관리', '관세청관리', 'L', 'fa-circle-thin', 'N', '/db-004', 7, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('MASTER005', 'MASTER', '거래처 관리', '거래처 관리', '거래처 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-016', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK008', 'DRWBAK', 'New_기납증/분증 신청', 'New_기납/분증 관리', '생성한 기납/분증을 전송 및 관리하는 프로그램', 'L', 'fa-circle-thin', 'N', '/db-008', 4, 'Y', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM007', 'SYSTEM', '잔량사용이력', 'Residual quantity usage history', '잔량사용이력', 'L', 'fa-circle-thin', 'N', '/sm-007', 7, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT009', 'REPORT', 'new_환급금액 효과분석', 'new_환급금액 효과분석', 'new_환급금액 효과분석', 'L', 'fa-circle-thin', 'N', '/report-009', 20, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA', null, '임시', '임시', '임시', 'L', 'fa-cog', 'N', '#', 11, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA001', 'FTA', '임시1', '임시1', '임시1', 'L', 'fa-circle-thin', 'N', '/fta-001', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA002', 'FTA', '임시2', '임시2', '임시2', 'L', 'fa-circle-thin', 'N', '/fta-002', 2, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA003', 'FTA', '임시3', '임시3', '임시3', 'L', 'fa-circle-thin', 'N', '/fta-003', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA004', 'FTA', '임시4', '임시4', '임시4', 'L', 'fa-circle-thin', 'N', '/fta-004', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('FTA005', 'FTA', '임시5', '임시5', '임시5', 'L', 'fa-circle-thin', 'N', '/fta-005', 5, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK005', 'DRWBAK', 'New_환급 신청', '환급신청서 관리', '환급신청서 관리', 'L', 'fa-circle-thin', 'N', '/db-005', 3, 'Y', to_date('25-02-2019', 'dd-mm-yyyy'), 'cheezred', to_date('25-02-2019', 'dd-mm-yyyy'), 'cheezred');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN', null, '문서관리', 'Document management', '문서관리', 'L', 'fa-paperclip', 'N', '#', 5, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN001', 'CUSVEN', 'New_고객사 구매확인서', 'New_고객사 구매확인서', 'New_고객사 구매확인서', 'L', 'fa-circle-thin', 'N', '/cv-001', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN002', 'CUSVEN', '매매 계약서', 'Contract Note', '매매 계약서', 'L', 'fa-circle-thin', 'N', '/cv-002', 7, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN003', 'CUSVEN', '공급사 구매 확인서', '공급사 구매 확인서', '공급사 구매 확인서', 'L', 'fa-circle-thin', 'N', '/cv-003', 6, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND020', 'REFUND', 'New_양수자 통보', 'Assignee Notification', '양수자 통보', 'L', 'fa-circle-thin', 'N', '/cv-004', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN005', 'CUSVEN', '협력사 차이 정산', '협력사 차이 정산', '협력사 차이 정산', 'L', 'fa-circle-thin', 'N', '/cv-005', 5, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK006', 'DRWBAK', 'New_수출매출확정', 'Export Sales Confirmation', '수출확정', 'L', 'fa-circle-thin', 'N', '/db-006', 1, 'Y', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT008', 'REPORT', 'new_환급금액 레포트', 'new_환급금액 레포트', 'new_환급금액 레포트', 'L', 'fa-circle-thin', 'N', '/report-008', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN008', 'CUSVEN', 'New_제증명 정정/취하', '제증명 정정/취하 신청', '제증명 정정/취하 신청', 'L', 'fa-circle-thin', 'N', '/db-011', 4, 'N', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN007', 'CUSVEN', 'New_가산금액지급신청', '가산금액지급신청', '가산금액지급신청', 'L', 'fa-circle-thin', 'N', '/db-010', 3, 'Y', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('CUSVEN006', 'CUSVEN', 'New_과다환급자진신고', '과다환급자진신고', '과다환급자진신고', 'L', 'fa-circle-thin', 'N', '/db-009', 2, 'Y', to_date('28-02-2019', 'dd-mm-yyyy'), 'System', to_date('28-02-2019', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND007', 'REFUND', '자재수불부 관리', 'Inventory book for raw materials', '자재수불부 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-007', 12, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND012', 'REFUND', '월별수입물품집계', '월별수입물품집계', '월별수입물품집계', 'L', 'fa-circle-thin', 'N', '/refundBasis-012', 7, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM005', 'SYSTEM', '권한관리', '권한관리', '권한관리', 'L', 'fa-circle-thin', 'N', '/sm-005', 5, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM006', 'SYSTEM', '메뉴관리', 'Menu management', '메뉴관리', 'L', 'fa-circle-thin', 'N', '/sm-006', 6, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND014', 'REFUND', 'New_간이정액환급관리', '간이정액환급관리', '간이정액환급관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-014', 6, 'N', to_date('18-02-2019', 'dd-mm-yyyy'), 'cheezred', to_date('18-02-2019', 'dd-mm-yyyy'), 'cheezred');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND015', 'REFUND', 'New_단축고시정보관리', '단축고시정보관리', 'MM-004 사용 하기로함', 'L', 'fa-circle-thin', 'N', '/refundBasis-015', 15, 'N', to_date('18-02-2019', 'dd-mm-yyyy'), 'cheezred', to_date('18-02-2019', 'dd-mm-yyyy'), 'cheezred');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND005', 'REFUND', 'New_수입신고', 'Import declaration', 'New_수입신고', 'L', 'fa-circle-thin', 'N', '/refundBasis-002', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE000', 'SAMPLE', 'DEVELOPING GUIDE', 'DEVELOPING GUIDE', null, 'L', 'fa-circle-thin', 'N', '/sample-000 ', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('24-01-2024 13:44:18', 'dd-mm-yyyy hh24:mi:ss'), '1');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND009', 'REFUND', 'New_수출신고', 'Export declaration', '수출신고', 'L', 'fa-circle-thin', 'N', '/refundBasis-009', 2, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND010', 'REFUND', '부산물비율관리', '부산물비율관리', '부산물비율관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-010', 5, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND011', 'REFUND', '생산일자관리', '생산일자관리', '생산일자관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-011', 9, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK', null, '환급관리', '환급관리', '환급관리', 'L', 'fa-pencil', 'N', '#', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT', null, '레포트', '레포트', '레포트', 'L', 'fa-signal', 'N', '#', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK001', 'DRWBAK', '환급모니터링', '환급모니터링', '환급모니터링', 'L', 'fa-circle-thin', 'N', '/db-001', 8, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK002', 'DRWBAK', '문서발급관리', 'Document Issuance Management', '문서발급관리', 'L', 'fa-circle-thin', 'N', '/db-002', 5, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('DRWBAK003', 'DRWBAK', '관세청관리-환급', '관세청관리', '관세청관리', 'L', 'fa-circle-thin', 'N', '/db-003', 6, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT001', 'REPORT', '기간별환급레포트', '기간별환급레포트', '기간별환급레포트', 'L', 'fa-circle-thin', 'N', '/report-001', 1, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT002', 'REPORT', 'new_잔량레포트', 'new_잔량레포트', 'new_잔량레포트', 'L', 'fa-circle-thin', 'N', '/report-002', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT003', 'REPORT', '조견표관리', '조견표관리', '조견표관리', 'L', 'fa-circle-thin', 'N', '/report-003', 5, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT004', 'REPORT', '기납증/분증수취레포트', '기납증/분증수취레포트', '기납증/분증수취레포트', 'L', 'fa-circle-thin', 'N', '/report-004', 7, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT005', 'REPORT', '월별협력업체정산레포트', '월별협력업체정산레포트', '월별협력업체정산레포트', 'L', 'fa-circle-thin', 'N', '/report-005', 9, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT006', 'REPORT', '월별고객사기납증레포트', '월별고객사기납증레포트', '월별고객사기납증레포트', 'L', 'fa-circle-thin', 'N', '/report-006', 11, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REPORT007', 'REPORT', 'HSCODE 비교 레포트', 'HSCODE 비교 레포트', 'HSCODE 비교 레포트', 'L', 'fa-circle-thin', 'N', '/report-007', 13, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE', null, 'Sample Menu', 'Sample Menu', 'Sample Menu', 'L', 'fa-folder-open', 'N', '#', 0, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE001', 'SAMPLE', 'Grid Sample', 'Grid Sample', 'Grid Sample', 'L', 'fa-circle-thin', 'N', '/sample-001', 1, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE002', 'SAMPLE', 'Form Sample', 'Form Sample', 'Form Sample', 'L', 'fa-circle-thin', 'N', '/sample-002', 2, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE003', 'SAMPLE', 'Popup Sample', 'Popup Sample', 'Popup Sample', 'L', 'fa-circle-thin', 'N', '/sample-003', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SAMPLE004', 'SAMPLE', 'Etc Sample', 'Etc Sample', 'Etc Sample', 'L', 'fa-circle-thin', 'N', '/sample-004', 4, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND', null, '기초정보관리', '기초정보관리', '기초정보관리', 'L', 'fa-foursquare', 'N', '#', 7, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND001', 'REFUND', '구매처정보 관리', '구매처정보 관리', '구매처정보 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-001', 14, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND013', 'REFUND', '연간수입물량집계', '연간수입물량집계', '연간수입물량집계', 'L', 'fa-circle-thin', 'N', '/refundBasis-013', 8, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND003', 'REFUND', '품목마스터 관리', '품목마스터 관리', '품목마스터 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-003', 13, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('REFUND004', 'REFUND', '매입원장 관리', 'Purchase Ledger', '매입원장 관리', 'L', 'fa-circle-thin', 'N', '/refundBasis-004', 10, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM', null, '시스템관리', '시스템관리', '시스템관리', 'L', 'fa-cog', 'N', '#', 11, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM001', 'SYSTEM', '스케줄 관리', '스케줄 관리', '스케줄 관리', 'L', 'fa-circle-thin', 'N', '/sm-001', 1, 'N', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM002', 'SYSTEM', '인터페이스 항목 조회', '인터페이스 항목 조회', '인터페이스 항목 조회', 'L', 'fa-circle-thin', 'N', '/sm-002', 2, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
insert into COM_MENU (menu_id, parent_menu_id, menu_name, menu_name_eng, menu_desc, menu_ty, menu_se, menu_boxstyle, link_url, sort_no, using_yn, create_date, create_user, update_date, update_user)
values ('SYSTEM003', 'SYSTEM', '인터페이스 이력 조회', '인터페이스 이력 조회', '인터페이스 이력 조회', 'L', 'fa-circle-thin', 'N', '/sm-003', 3, 'Y', to_date('29-09-2016', 'dd-mm-yyyy'), 'System', to_date('29-09-2016', 'dd-mm-yyyy'), 'System');
commit;


/*COM_USER*/
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('8000', '1100', '8', 'Q?q?', '수출만', null, '8000Com', '8000Com', '8000Com', '123456', '055-3333-3333', '055-4444-4444', 'tester@FOVS.com', '010-5555-5555', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('11-08-2017 11:33:31', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20180706');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('9000', '1100', '9', 'Q?q?', '수출_면세', null, '9000Com', '9000Com', '9000Com', '123456', '055-3333-3333', '055-4444-4444', 'tester@FOVS.com', '010-5555-5555', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('11-08-2017 11:33:31', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20180706');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('9100', '1100', '91', 'Q?q?', '사용자', null, '9100Com', '9100Com', '9100Com', '123456', '055-3333-3333', '055-4444-4444', 'tester@FOVS.com', '010-5555-5555', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('11-08-2017 11:33:31', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20180706');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('1100', '1100', '1', '?？\{&??', '관리자', null, '과장', 'ADMIN', '국내역업팀', '412162', '055-1234-3333', '00-0000-000', 'cheezred@naver.com', '000-1234-3333', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('23-08-2017 15:01:15', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20160301');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('2000', '1100', '2', 'Q?q?', '사용자', null, '2000Com', '2000Com', '2000Com', '123456', '055-3333-3333', '055-4444-4444', 'tester@FOVS.com', '010-5555-5555', 'Y', 'ENG', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('11-08-2017 11:33:31', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20180706');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('3000', '1100', '3', 'Q?q?', '사용자', null, '3000Com', '3000Com', '3000Com', '123456', '055-3333-3333', '055-4444-4444', 'tester@FOVS.com', '010-5555-5555', 'Y', 'ENG', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('11-08-2017 11:33:31', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20180706');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('1200', '1200', '1200', '극\{?', '에뛰드', null, '과장', 'ADMIN', '국내역업팀', '412162', '055-1234-3333', '00-0000-000', 'cheezred@naver.com', '000-1234-3333', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('23-08-2017 15:01:15', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20160301');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('1300', '1300', '1300', '극\{?', '이니스프리', null, '과장', 'ADMIN', '국내역업팀', '412162', '055-1234-3333', '00-0000-000', 'cheezred@naver.com', '000-1234-3333', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('23-08-2017 15:01:15', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20160301');
insert into COM_USER (company_code, division_code, user_id, user_pw, user_name, user_name_eng, position_name, position_name_eng, dept_name, emp_no, tel_no, fax_no, email, mobile_phone_no, using_yn, default_language, create_date, create_user, update_date, update_user, work_date)
values ('1500', '1500', '1500', '극\{?', '코스비젼', null, '과장', 'ADMIN', '국내역업팀', '412162', '055-1234-3333', '00-0000-000', 'cheezred@naver.com', '000-1234-3333', 'Y', 'KOR', to_date('14-12-2016 14:18:14', 'dd-mm-yyyy hh24:mi:ss'), 'System', to_date('23-08-2017 15:01:15', 'dd-mm-yyyy hh24:mi:ss'), 'isc', '20160301');
commit;

/*INTERFACE_ITEM_DTL*/
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6646, 'RFC019', '1100', 'O', 'ITEM_CODE', 'ITEM_CODE', 'ATTRIBUTE02', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6647, 'RFC019', '1100', 'O', 'DIVISION_CODE', 'DIVISION_CODE', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6648, 'RFC019', '1100', 'O', 'REQ_QTY', 'REQ_QTY', 'ATTRIBUTE04', 'REQ_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6649, 'RFC019', '1100', 'O', 'START_DATE', 'START_DATE', 'ATTRIBUTE05', 'START_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6650, 'RFC019', '1100', 'O', 'END_DATE', 'END_DATE', 'ATTRIBUTE06', 'END_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6651, 'RFC022', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6652, 'RFC022', '1100', 'O', 'BL_NO', 'INVOICE_NO', 'ATTRIBUTE01', 'INVOICE_NO', 0, 50, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('24-11-2015 17:19:16', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6653, 'RFC022', '1100', 'O', 'BL_DOCS_NO', 'PRODUCT_CODE', 'ATTRIBUTE02', 'PRODUCT_CODE', 0, 50, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('24-11-2015 17:19:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6654, 'RFC022', '1100', 'O', 'PROD_DESC', 'PROD_DESC', 'ATTRIBUTE03', 'PROD_DESC', 0, 500, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6655, 'RFC022', '1100', 'O', 'EXPORT_DECLARE_NO', 'EXPORT_DECLARE_NO', 'ATTRIBUTE04', 'EXPORT_DECLARE_NO', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6656, 'RFC022', '1100', 'O', 'EXPORT_DECLARE_DATE', 'EXPORT_DECLARE_DATE', 'ATTRIBUTE05', 'EXPORT_DECLARE_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6657, 'RFC022', '1100', 'O', 'EXPORT_ACCEPT_DATE', 'EXPORT_ACCEPT_DATE', 'ATTRIBUTE06', 'EXPORT_ACCEPT_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6658, 'RFC022', '1100', 'O', 'VEHICLE_TYPE', 'VEHICLE_TYPE', 'ATTRIBUTE07', 'VEHICLE_TYPE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6659, 'RFC022', '1100', 'O', 'VEHICLE_NAME', 'VEHICLE_NAME', 'ATTRIBUTE08', 'VEHICLE_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6660, 'RFC022', '1100', 'O', 'DEPARTURE_PORT_CODE', 'DEPARTURE_PORT_CODE', 'ATTRIBUTE09', 'DEPARTURE_PORT_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6661, 'RFC022', '1100', 'O', 'DEPARTURE_PORT_NAME', 'DEPARTURE_PORT_NAME', 'ATTRIBUTE10', 'DEPARTURE_PORT_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6662, 'RFC022', '1100', 'O', 'SHIPPING_DATE', 'SHIPPING_DATE', 'ATTRIBUTE11', 'SHIPPING_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6663, 'RFC022', '1100', 'O', 'ARRIVAL_CUSTOMER', 'ARRIVAL_CUSTOMER', 'ATTRIBUTE12', 'ARRIVAL_CUSTOMER', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6664, 'RFC022', '1100', 'O', 'ARRIVAL_NATION', 'ARRIVAL_NATION', 'ATTRIBUTE13', 'ARRIVAL_NATION', 0, 3, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6665, 'RFC022', '1100', 'O', 'ARRIVAL_PORT_CODE', 'ARRIVAL_PORT_CODE', 'ATTRIBUTE14', 'ARRIVAL_PORT_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6849, 'RFC019', '1100', 'O', 'ITEM_CODE_ANOTHER', 'ITEM_CODE_ANOTHER', 'ATTRIBUTE07', 'ITEM_CODE_ANOTHER', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('11-03-2013 17:08:53', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('11-03-2013 17:08:53', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6860, 'RFC007', '1100', 'O', 'WAREHOUSING_NO', 'ATTRIBUTE01', 'ATTRIBUTE01', 'WAREHOUSING_NO', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6866, 'RFC007', '1100', 'O', 'VENDOR_CODE', 'ATTRIBUTE07', 'ATTRIBUTE07', 'VENDOR_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6868, 'RFC007', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE09', 'ATTRIBUTE09', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6871, 'RFC007', '1100', 'O', 'WAREHOUSING_QTY', 'ATTRIBUTE12', 'ATTRIBUTE12', 'WAREHOUSING_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 15:31:56', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6875, 'RFC007', '1100', 'O', 'BL_NO', 'ATTRIBUTE16', 'ATTRIBUTE16', 'BL_NO', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6876, 'RFC007', '1100', 'O', 'BL_QUANTITY', 'ATTRIBUTE17', 'ATTRIBUTE17', 'BL_QUANTITY', 6, 18, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6881, 'RFC019', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6882, 'RFC019', '1100', 'O', 'PRODUCT_CODE', 'PRODUCT_CODE', 'ATTRIBUTE01', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6883, 'RFC019', '1100', 'O', 'ITEM_CODE', 'ITEM_CODE', 'ATTRIBUTE02', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6884, 'RFC019', '1100', 'O', 'DIVISION_CODE', 'DIVISION_CODE', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6885, 'RFC019', '1100', 'O', 'REQ_QTY', 'REQ_QTY', 'ATTRIBUTE04', 'REQ_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6886, 'RFC019', '1100', 'O', 'START_DATE', 'START_DATE', 'ATTRIBUTE05', 'START_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6887, 'RFC019', '1100', 'O', 'END_DATE', 'END_DATE', 'ATTRIBUTE06', 'END_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6888, 'RFC022', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6889, 'RFC022', '1100', 'O', 'BL_NO', 'INVOICE_NO', 'ATTRIBUTE01', 'INVOICE_NO', 0, 50, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('24-11-2015 17:19:16', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6890, 'RFC022', '1100', 'O', 'BL_DOCS_NO', 'PRODUCT_CODE', 'ATTRIBUTE02', 'PRODUCT_CODE', 0, 50, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('24-11-2015 17:19:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6891, 'RFC022', '1100', 'O', 'PROD_DESC', 'PROD_DESC', 'ATTRIBUTE03', 'PROD_DESC', 0, 500, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6892, 'RFC022', '1100', 'O', 'EXPORT_DECLARE_NO', 'EXPORT_DECLARE_NO', 'ATTRIBUTE04', 'EXPORT_DECLARE_NO', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6893, 'RFC022', '1100', 'O', 'EXPORT_DECLARE_DATE', 'EXPORT_DECLARE_DATE', 'ATTRIBUTE05', 'EXPORT_DECLARE_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6894, 'RFC022', '1100', 'O', 'EXPORT_ACCEPT_DATE', 'EXPORT_ACCEPT_DATE', 'ATTRIBUTE06', 'EXPORT_ACCEPT_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6895, 'RFC022', '1100', 'O', 'VEHICLE_TYPE', 'VEHICLE_TYPE', 'ATTRIBUTE07', 'VEHICLE_TYPE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6896, 'RFC022', '1100', 'O', 'VEHICLE_NAME', 'VEHICLE_NAME', 'ATTRIBUTE08', 'VEHICLE_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6897, 'RFC022', '1100', 'O', 'DEPARTURE_PORT_CODE', 'DEPARTURE_PORT_CODE', 'ATTRIBUTE09', 'DEPARTURE_PORT_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6898, 'RFC022', '1100', 'O', 'DEPARTURE_PORT_NAME', 'DEPARTURE_PORT_NAME', 'ATTRIBUTE10', 'DEPARTURE_PORT_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6899, 'RFC022', '1100', 'O', 'SHIPPING_DATE', 'SHIPPING_DATE', 'ATTRIBUTE11', 'SHIPPING_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6900, 'RFC022', '1100', 'O', 'ARRIVAL_CUSTOMER', 'ARRIVAL_CUSTOMER', 'ATTRIBUTE12', 'ARRIVAL_CUSTOMER', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6901, 'RFC022', '1100', 'O', 'ARRIVAL_NATION', 'ARRIVAL_NATION', 'ATTRIBUTE13', 'ARRIVAL_NATION', 0, 3, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6902, 'RFC022', '1100', 'O', 'ARRIVAL_PORT_CODE', 'ARRIVAL_PORT_CODE', 'ATTRIBUTE14', 'ARRIVAL_PORT_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6709, 'RFC001', '1100', 'O', 'CUSTOMER_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'CUSTOMER_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6710, 'RFC001', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6711, 'RFC001', '1100', 'O', 'BUSINESS_NO', 'ATTRIBUTE02', 'ATTRIBUTE02', 'BUSINESS_NO', 0, 15, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6712, 'RFC001', '1100', 'O', 'CUSTOMER_NAME', 'ATTRIBUTE03', 'ATTRIBUTE03', 'CUSTOMER_NAME', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6713, 'RFC001', '1100', 'O', 'CUSTOMER_NAME_ENG', 'ATTRIBUTE04', 'ATTRIBUTE04', 'CUSTOMER_NAME_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6714, 'RFC001', '1100', 'O', 'OFFICER_NAME', 'ATTRIBUTE05', 'ATTRIBUTE05', 'OFFICER_NAME', 0, 50, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6715, 'RFC001', '1100', 'O', 'OFFICER_NAME_ENG', 'ATTRIBUTE06', 'ATTRIBUTE06', 'OFFICER_NAME_ENG', 0, 50, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6716, 'RFC001', '1100', 'O', 'NATION_CODE', 'ATTRIBUTE07', 'ATTRIBUTE07', 'NATION_CODE', 0, 2, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6717, 'RFC001', '1100', 'O', 'ZIP_CODE', 'ATTRIBUTE08', 'ATTRIBUTE08', 'ZIP_CODE', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6718, 'RFC001', '1100', 'O', 'ADDRESS', 'ATTRIBUTE09', 'ATTRIBUTE09', 'ADDRESS', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6719, 'RFC001', '1100', 'O', 'ADDRESS_ENG', 'ATTRIBUTE10', 'ATTRIBUTE10', 'ADDRESS_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('07-06-2017 17:20:42', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6720, 'RFC001', '1100', 'O', 'TEL_NO', 'ATTRIBUTE11', 'ATTRIBUTE11', 'TEL_NO', 0, 35, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6721, 'RFC002', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6722, 'RFC002', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6723, 'RFC002', '1100', 'O', 'ITEM_NAME', 'ATTRIBUTE02', 'ATTRIBUTE02', 'ITEM_NAME', 0, 200, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6724, 'RFC002', '1100', 'O', 'ITEM_NAME_ENG', 'ATTRIBUTE03', 'ATTRIBUTE03', 'ITEM_NAME_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6725, 'RFC002', '1100', 'O', 'SPEC', 'ATTRIBUTE04', 'ATTRIBUTE04', 'SPEC', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6726, 'RFC002', '1100', 'O', 'HS_CODE', 'ATTRIBUTE05', 'ATTRIBUTE05', 'HS_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6727, 'RFC002', '1100', 'O', 'PRODUCT_CODE', 'ATTRIBUTE06', 'ATTRIBUTE06', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6728, 'RFC002', '1100', 'O', 'UNIT', 'ATTRIBUTE07', 'ATTRIBUTE07', 'UNIT', 0, 10, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6729, 'RFC002', '1100', 'O', 'WEIGHT', 'ATTRIBUTE08', 'ATTRIBUTE08', 'WEIGHT', 6, 20, 6, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6730, 'RFC002', '1100', 'O', 'ATTRIBUTE01', 'ATTRIBUTE09', 'ATTRIBUTE09', 'ATTRIBUTE01', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6732, 'RFC003', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6733, 'RFC003', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6734, 'RFC003', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6735, 'RFC003', '1100', 'O', 'ASSETS_TYPE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'ASSETS_TYPE', 0, 5, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6736, 'RFC004', '1100', 'O', 'VENDOR_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'VENDOR_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6737, 'RFC004', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6738, 'RFC004', '1100', 'O', 'BUSINESS_NO', 'ATTRIBUTE02', 'ATTRIBUTE02', 'BUSINESS_NO', 0, 15, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6739, 'RFC004', '1100', 'O', 'VENDOR_NAME', 'ATTRIBUTE03', 'ATTRIBUTE03', 'VENDOR_NAME', 0, 200, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6740, 'RFC004', '1100', 'O', 'VENDOR_NAME_ENG', 'ATTRIBUTE04', 'ATTRIBUTE04', 'VENDOR_NAME_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6741, 'RFC004', '1100', 'O', 'OFFICER_NAME', 'ATTRIBUTE05', 'ATTRIBUTE05', 'OFFICER_NAME', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3045, 'RFC001', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3046, 'RFC001', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3047, 'RFC001', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3048, 'RFC001', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 14:44:15', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3049, 'RFC001', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3050, 'RFC001', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3051, 'RFC002', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3052, 'RFC002', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3053, 'RFC002', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3054, 'RFC002', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3055, 'RFC002', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3056, 'RFC002', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3057, 'RFC003', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3058, 'RFC003', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3059, 'RFC003', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3060, 'RFC003', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3061, 'RFC003', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3062, 'RFC003', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3063, 'RFC004', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3064, 'RFC004', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3065, 'RFC004', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3066, 'RFC004', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3069, 'RFC006', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3070, 'RFC006', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3071, 'RFC006', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3072, 'RFC006', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3073, 'RFC006', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3074, 'RFC006', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3075, 'RFC007', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3076, 'RFC007', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3077, 'RFC007', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3078, 'RFC007', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3079, 'RFC007', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3080, 'RFC007', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3081, 'RFC010', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3082, 'RFC010', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3083, 'RFC010', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3084, 'RFC010', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3085, 'RFC010', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3086, 'RFC010', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6789, 'RFC001', '1100', 'O', 'FAX_NO', 'ATTRIBUTE12', 'ATTRIBUTE12', 'FAX_NO', 0, 35, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6791, 'RFC002', '1100', 'O', 'FLOWCHART_CODE', 'ATTRIBUTE10', 'ATTRIBUTE10', 'FLOWCHART_CODE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6792, 'RFC003', '1100', 'O', 'DELETE_YN', 'ATTRIBUTE04', 'ATTRIBUTE04', 'DELETE_YN', 0, 1, 0, null, 'N', null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6793, 'RFC004', '1100', 'O', 'DELETE_YN', 'ATTRIBUTE13', 'ATTRIBUTE13', 'DELETE_YN', 0, 1, 0, null, 'N', null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6794, 'RFC004', '1100', 'O', 'VENDOR_EMAIL', 'ATTRIBUTE14', 'ATTRIBUTE14', 'VENDOR_EMAIL', 0, 50, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6796, 'RFC007', '1100', 'O', 'EXCHANGE_RATE', 'ATTRIBUTE19', 'ATTRIBUTE19', 'EXCHANGE_RATE', 6, 20, 8, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6797, 'RFC007', '1100', 'O', 'EXCHANGE_DATE', 'ATTRIBUTE20', 'ATTRIBUTE20', 'EXCHANGE_DATE', 0, 8, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6798, 'RFC007', '1100', 'O', 'UNIT_PRICE_FOREIGN', 'ATTRIBUTE21', 'ATTRIBUTE21', 'UNIT_PRICE_FOREIGN', 6, 24, 10, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6799, 'RFC007', '1100', 'O', 'AMOUNT_FOREIGN', 'ATTRIBUTE22', 'ATTRIBUTE22', 'AMOUNT_FOREIGN', 6, 24, 10, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6800, 'RFC007', '1100', 'O', 'TARIFF_TYPE', 'ATTRIBUTE23', 'ATTRIBUTE23', 'TARIFF_TYPE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6801, 'RFC007', '1100', 'O', 'TARIFF_AMOUNT', 'ATTRIBUTE24', 'ATTRIBUTE24', 'TARIFF_AMOUNT', 6, 18, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6802, 'RFC007', '1100', 'O', 'FROM_DIVISION', 'ATTRIBUTE25', 'ATTRIBUTE25', 'FROM_DIVISION', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6803, 'RFC007', '1100', 'O', 'DELIVERY_NO', 'ATTRIBUTE26', 'ATTRIBUTE26', 'DELIVERY_NO', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6084, 'RFC014', '1100', 'O', 'ARRIVAL_NATION', 'ATTRIBUTE08', 'ATTRIBUTE08', 'ARRIVAL_NATION', 0, 2, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6085, 'RFC014', '1100', 'O', 'INVOICE_NO', 'ATTRIBUTE09', 'ATTRIBUTE09', 'INVOICE_NO', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6086, 'RFC014', '1100', 'O', 'BL_NO', 'ATTRIBUTE10', 'ATTRIBUTE10', 'BL_NO', 0, 50, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6087, 'RFC014', '1100', 'O', 'EXPORT_DECLARE_NO', 'ATTRIBUTE11', 'ATTRIBUTE11', 'EXPORT_DECLARE_NO', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6088, 'RFC014', '1100', 'O', 'EXPORT_DECLARE_DATE', 'ATTRIBUTE12', 'ATTRIBUTE12', 'EXPORT_DECLARE_DATE', 0, 8, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6089, 'RFC014', '1100', 'O', 'VEHICLE_NAME', 'ATTRIBUTE13', 'ATTRIBUTE13', 'VEHICLE_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6090, 'RFC014', '1100', 'O', 'DEPARTURE_PORT_NAME', 'ATTRIBUTE14', 'ATTRIBUTE14', 'DEPARTURE_PORT_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6091, 'RFC014', '1100', 'O', 'SHIPPING_DATE', 'ATTRIBUTE15', 'ATTRIBUTE15', 'SHIPPING_DATE', 0, 8, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6092, 'RFC014', '1100', 'O', 'ARRIVAL_PORT_NAME', 'ATTRIBUTE16', 'ATTRIBUTE16', 'ARRIVAL_PORT_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6093, 'RFC014', '1100', 'O', 'PACKING_MARK', 'ATTRIBUTE17', 'ATTRIBUTE17', 'PACKING_MARK', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6094, 'RFC014', '1100', 'O', 'PACKING_COUNT', 'ATTRIBUTE18', 'ATTRIBUTE18', 'PACKING_COUNT', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6095, 'RFC014', '1100', 'O', 'TOTAL_WEIGHT', 'ATTRIBUTE19', 'ATTRIBUTE19', 'TOTAL_WEIGHT', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6096, 'RFC014', '1100', 'O', 'COUNT_UNIT', 'ATTRIBUTE20', 'ATTRIBUTE20', 'COUNT_UNIT', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6097, 'RFC014', '1100', 'O', 'DELETE_YN', 'ATTRIBUTE21', 'ATTRIBUTE21', 'DELETE_YN', 0, 1, 0, null, 'N', null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6098, 'RFC014', '1100', 'O', 'DELIVERY_CUSTOMER_CODE', 'ATTRIBUTE22', 'ATTRIBUTE22', 'DELIVERY_CUSTOMER_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6804, 'RFC008', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6805, 'RFC008', '1100', 'O', 'YYYYMM', 'ATTRIBUTE01', 'ATTRIBUTE01', 'YYYYMM', 0, 6, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6806, 'RFC008', '1100', 'O', 'FROM_ITEM_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'FROM_ITEM_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6807, 'RFC008', '1100', 'O', 'TO_ITEM_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'TO_ITEM_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6808, 'RFC008', '1100', 'O', 'FROM_DIVISION_CODE', 'ATTRIBUTE04', 'ATTRIBUTE04', 'FROM_DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:27:41', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6809, 'RFC008', '1100', 'O', 'TO_DIVISION_CODE', 'ATTRIBUTE05', 'ATTRIBUTE05', 'TO_DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:28:08', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6810, 'RFC008', '1100', 'O', 'FROM_ASSETS_TYPE', 'ATTRIBUTE06', 'ATTRIBUTE06', 'FROM_ASSETS_TYPE', 0, 5, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:28:29', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6811, 'RFC008', '1100', 'O', 'TO_ASSETS_TYPE', 'ATTRIBUTE07', 'ATTRIBUTE07', 'TO_ASSETS_TYPE', 0, 5, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6812, 'RFC008', '1100', 'O', 'UNIT', 'ATTRIBUTE08', 'ATTRIBUTE08', 'UNIT', 0, 5, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6813, 'RFC008', '1100', 'O', 'TRANS_QTY', 'ATTRIBUTE09', 'ATTRIBUTE09', 'TRANS_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6814, 'RFC008', '1100', 'I', 'I_BUKRS', 'NULL', 'NULL', '회사 코드', 0, 4, 0, 'NULL', 'NULL', 'NULL', 'Y', 'N', 'Y', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', 'NULL');
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6815, 'RFC008', '1100', 'I', 'I_ERDAT_FROM', 'NULL', 'NULL', '기준일자 From', 1, 8, 0, 'NULL', 'NULL', 'NULL', 'N', 'N', 'Y', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', 'NULL');
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6816, 'RFC008', '1100', 'I', 'I_ERDAT_TO', 'NULL', 'NULL', '기준일자 To', 1, 8, 0, 'NULL', 'NULL', 'NULL', 'N', 'N', 'Y', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', to_date('16-09-2015', 'dd-mm-yyyy'), 'ADMIN', 'NULL');
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6642, 'RFC015', '1100', 'O', 'GROSS_WEIGHT', 'ATTRIBUTE15', 'ATTRIBUTE15', 'GROSS_WEIGHT', 6, 15, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3087, 'RFC011', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3088, 'RFC011', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3089, 'RFC011', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3090, 'RFC011', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3091, 'RFC011', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3092, 'RFC011', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3093, 'RFC014', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3094, 'RFC014', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3095, 'RFC014', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3096, 'RFC014', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3097, 'RFC014', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3098, 'RFC014', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3099, 'RFC015', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3100, 'RFC015', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3101, 'RFC015', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3102, 'RFC015', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3103, 'RFC015', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3104, 'RFC015', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3105, 'RFC019', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3106, 'RFC019', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3107, 'RFC019', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3108, 'RFC019', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3109, 'RFC019', '1100', 'I', 'I_MATNR', 'PRODUCT_CODE', null, '자재코드', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('15-12-2015 16:03:07', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3110, 'RFC019', '1100', 'I', 'I_WERKS', 'DIVISION_CODE', null, '사업부코드', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3111, 'RFC022', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3112, 'RFC022', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3113, 'RFC022', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3114, 'RFC022', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3115, 'RFC022', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3116, 'RFC022', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3117, 'RFC023', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3118, 'RFC023', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3119, 'RFC023', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6790, 'RFC001', '1100', 'O', 'DELETE_YN', 'ATTRIBUTE13', 'ATTRIBUTE13', 'DELETE_YN', 0, 1, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3120, 'RFC023', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3121, 'RFC023', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3122, 'RFC023', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3123, 'RFC031', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3124, 'RFC031', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3125, 'RFC031', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3126, 'RFC031', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3127, 'RFC031', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3128, 'RFC031', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3129, 'RFC202', '1100', 'I', 'E_LINES', null, null, '결과 레코드 수', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '6', null, null, null, null, to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:44:25', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3130, 'RFC202', '1100', 'I', 'E_RETURN', null, null, '결과값', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', '4', null, null, null, null, to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:23', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3131, 'RFC202', '1100', 'I', 'E_RETURNMSG', null, null, '결과 메시지', 0, 100, 0, null, null, null, 'Y', 'N', 'Y', '5', null, null, null, null, to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:43:57', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3132, 'RFC202', '1100', 'I', 'I_BUKRS', 'COMPANY_CODE', null, '회사코드', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', '1', null, null, null, null, to_date('18-11-2015 16:39:03', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:35', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3133, 'RFC202', '1100', 'I', 'I_ERDAT_FROM', 'FROM_DATE', null, '조회 시작일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '2', null, null, null, null, to_date('18-11-2015 16:39:27', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:39:48', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (3134, 'RFC202', '1100', 'I', 'I_ERDAT_TO', 'TO_DATE', null, '조회 완료일', 0, 8, 0, null, null, null, 'Y', 'N', 'Y', '3', null, null, null, null, to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('18-11-2015 16:40:15', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6667, 'RFC022', '1100', 'O', 'PACKING_MARK', 'PACKING_MARK', 'ATTRIBUTE16', 'PACKING_MARK', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6668, 'RFC022', '1100', 'O', 'PACKING_COUNT', 'PACKING_COUNT', 'ATTRIBUTE17', 'PACKING_COUNT', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6669, 'RFC022', '1100', 'O', 'TOTAL_WEIGHT', 'TOTAL_WEIGHT', 'ATTRIBUTE18', 'TOTAL_WEIGHT', 6, 15, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6670, 'RFC022', '1100', 'O', 'COUNT_UNIT', 'COUNT_UNIT', 'ATTRIBUTE19', 'COUNT_UNIT', 0, 5, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6671, 'RFC022', '1100', 'O', 'CUSTOMS_CODE', 'CUSTOMS_CODE', 'ATTRIBUTE20', 'CUSTOMS_CODE', 0, 6, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6672, 'RFC022', '1100', 'O', 'FOB_AMOUNT', 'FOB_AMOUNT', 'ATTRIBUTE21', 'FOB_AMOUNT', 6, 18, 3, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6673, 'RFC023', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6674, 'RFC023', '1100', 'O', 'PRODUCT_CODE', 'PRODUCT_CODE', 'ATTRIBUTE01', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6675, 'RFC023', '1100', 'O', 'ITEM_CODE', 'ITEM_CODE', 'ATTRIBUTE02', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6676, 'RFC023', '1100', 'O', 'DIVISION_CODE', 'DIVISION_CODE', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6677, 'RFC023', '1100', 'O', 'REQ_QTY', 'REQ_QTY', 'ATTRIBUTE04', 'REQ_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6678, 'RFC023', '1100', 'O', 'START_DATE', 'START_DATE', 'ATTRIBUTE05', 'START_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6679, 'RFC023', '1100', 'O', 'END_DATE', 'END_DATE', 'ATTRIBUTE06', 'END_DATE', 1, 8, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6680, 'RFC202', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6681, 'RFC202', '1100', 'O', 'APPLY_DATE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'APPLY_DATE', 0, 6, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6682, 'RFC202', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6683, 'RFC202', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'ITEM_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6666, 'RFC022', '1100', 'O', 'ARRIVAL_PORT_NAME', 'ARRIVAL_PORT_NAME', 'ATTRIBUTE15', 'ARRIVAL_PORT_NAME', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6684, 'RFC202', '1100', 'O', 'STANDARD_COST_AMOUNT', 'ATTRIBUTE04', 'ATTRIBUTE04', 'STANDARD_COST_AMOUNT', 6, 20, 13, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6687, 'RFC010', '1100', 'O', 'YYYYMM', 'ATTRIBUTE01', 'ATTRIBUTE01', 'YYYYMM', 1, 6, 0, 'yyyyMM', null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6688, 'RFC010', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'ITEM_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6689, 'RFC010', '1100', 'O', 'PRODUCT_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'PRODUCT_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6690, 'RFC010', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE04', 'ATTRIBUTE04', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6691, 'RFC010', '1100', 'O', 'FROM_DIVISION_CODE', 'ATTRIBUTE05', 'ATTRIBUTE05', 'FROM_DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6692, 'RFC010', '1100', 'O', 'REQ_QTY', 'ATTRIBUTE06', 'ATTRIBUTE06', 'REQ_QTY', 6, 20, 8, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6693, 'RFC011', '1100', 'O', 'YYYYMM', 'ATTRIBUTE01', 'ATTRIBUTE01', 'YYYYMM', 1, 6, 0, 'yyyyMM', null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6694, 'RFC011', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6695, 'RFC011', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6742, 'RFC004', '1100', 'O', 'OFFICER_NAME_ENG', 'ATTRIBUTE06', 'ATTRIBUTE06', 'OFFICER_NAME_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6696, 'RFC011', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6697, 'RFC011', '1100', 'O', 'INITIAL_QTY', 'ATTRIBUTE04', 'ATTRIBUTE04', 'INITIAL_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6698, 'RFC011', '1100', 'O', 'INITIAL_AMOUNT', 'ATTRIBUTE05', 'ATTRIBUTE05', 'INITIAL_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6699, 'RFC011', '1100', 'O', 'INPUT_QTY', 'ATTRIBUTE06', 'ATTRIBUTE06', 'INPUT_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6700, 'RFC011', '1100', 'O', 'INPUT_AMOUNT', 'ATTRIBUTE07', 'ATTRIBUTE07', 'INPUT_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6701, 'RFC011', '1100', 'O', 'EXTRA_INPUT_QTY', 'ATTRIBUTE08', 'ATTRIBUTE08', 'EXTRA_INPUT_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6607, 'RFC031', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6608, 'RFC031', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6609, 'RFC031', '1100', 'O', 'ITEM_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6610, 'RFC031', '1100', 'O', 'CUSTOMER_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'CUSTOMER_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6611, 'RFC031', '1100', 'O', 'CUSTOMER_ITEM_CODE', 'ATTRIBUTE04', 'ATTRIBUTE04', 'CUSTOMER_ITEM_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6612, 'RFC031', '1100', 'O', 'CUSTOMER_ITEM_NAME', 'ATTRIBUTE05', 'ATTRIBUTE05', 'CUSTOMER_ITEM_NAME', 0, 300, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('15-02-2013 16:31:59', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6615, 'RFC014', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6616, 'RFC014', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6617, 'RFC014', '1100', 'O', 'CUSTOMER_CODE', 'ATTRIBUTE02', 'ATTRIBUTE02', 'CUSTOMER_CODE', 0, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6618, 'RFC014', '1100', 'O', 'EXPORT_FLAG', 'ATTRIBUTE03', 'ATTRIBUTE03', 'EXPORT_FLAG', 0, 1, 0, null, 'D', null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6619, 'RFC014', '1100', 'O', 'SALES_NO', 'ATTRIBUTE04', 'ATTRIBUTE04', 'SALES_NO', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6620, 'RFC014', '1100', 'O', 'DEPARTMENT_CODE', 'ATTRIBUTE05', 'ATTRIBUTE05', 'DEPARTMENT_CODE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('03-07-2017 18:05:42', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6621, 'RFC014', '1100', 'O', 'INVOICE_DATE', 'ATTRIBUTE06', 'ATTRIBUTE06', 'INVOICE_DATE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6622, 'RFC015', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6623, 'RFC015', '1100', 'O', 'SALES_NO', 'ATTRIBUTE01', 'ATTRIBUTE01', 'SALES_NO', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6624, 'RFC015', '1100', 'O', 'SALES_SEQ', 'ATTRIBUTE02', 'ATTRIBUTE02', 'SALES_SEQ', 6, 10, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6625, 'RFC015', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6626, 'RFC015', '1100', 'O', 'PRODUCT_CODE', 'ATTRIBUTE04', 'ATTRIBUTE04', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6627, 'RFC015', '1100', 'O', 'PROD_DIVISION_CODE', 'ATTRIBUTE05', 'ATTRIBUTE05', 'PROD_DIVISION_CODE', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6628, 'RFC015', '1100', 'O', 'QUANTITY', 'ATTRIBUTE06', 'ATTRIBUTE06', 'QUANTITY', 6, 16, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6629, 'RFC015', '1100', 'O', 'UNIT_PRICE', 'ATTRIBUTE07', 'ATTRIBUTE07', 'UNIT_PRICE', 6, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6630, 'RFC015', '1100', 'O', 'PRODUCT_UNIT', 'ATTRIBUTE08', 'ATTRIBUTE08', 'PRODUCT_UNIT', 0, 5, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6631, 'RFC015', '1100', 'O', 'AMOUNT', 'ATTRIBUTE09', 'ATTRIBUTE09', 'AMOUNT', 6, 20, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6632, 'RFC015', '1100', 'O', 'AMOUNT_FOREIGN', 'ATTRIBUTE10', 'ATTRIBUTE10', 'AMOUNT_FOREIGN', 6, 18, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6633, 'RFC015', '1100', 'O', 'CURRENCY', 'ATTRIBUTE11', 'ATTRIBUTE11', 'CURRENCY', 0, 5, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6634, 'RFC015', '1100', 'O', 'EXCHANGE_RATE', 'ATTRIBUTE12', 'ATTRIBUTE12', 'EXCHANGE_RATE', 6, 9, 6, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6635, 'RFC015', '1100', 'O', 'EXCHANGE_DATE', 'ATTRIBUTE13', 'ATTRIBUTE13', 'EXCHANGE_DATE', 0, 10, 0, 'yyyyMMdd', null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('26-04-2017 21:03:52', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6636, 'RFC015', '1100', 'O', 'NET_WEIGHT', 'ATTRIBUTE14', 'ATTRIBUTE14', 'NET_WEIGHT', 6, 15, 3, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6638, 'RFC015', '1100', 'O', 'WEIGHT_UNIT', 'ATTRIBUTE16', 'ATTRIBUTE16', 'WEIGHT_UNIT', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6639, 'RFC015', '1100', 'O', 'PRODUCT_ASSETS_TYPE', 'ATTRIBUTE17', 'ATTRIBUTE17', 'PRODUCT_ASSETS_TYPE', 0, 1, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6848, 'RFC023', '1100', 'O', 'ITEM_CODE_ANOTHER', 'ITEM_CODE_ANOTHER', 'ATTRIBUTE07', 'ITEM_CODE_ANOTHER', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('11-03-2013 17:09:03', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('11-03-2013 17:09:03', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6772, 'RFC010', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6775, 'RFC023', '1100', 'O', 'ITEM_CODE_ANOTHER', 'ITEM_CODE_ANOTHER', 'ATTRIBUTE07', 'ITEM_CODE_ANOTHER', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('11-03-2013 17:09:03', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('11-03-2013 17:09:03', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6777, 'RFC019', '1100', 'O', 'ITEM_CODE_ANOTHER', 'ITEM_CODE_ANOTHER', 'ATTRIBUTE07', 'ITEM_CODE_ANOTHER', 0, 30, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('11-03-2013 17:08:53', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('11-03-2013 17:08:53', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6743, 'RFC004', '1100', 'O', 'NATION_CODE', 'ATTRIBUTE07', 'ATTRIBUTE07', 'NATION_CODE', 0, 2, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6744, 'RFC004', '1100', 'O', 'ZIP_CODE', 'ATTRIBUTE08', 'ATTRIBUTE08', 'ZIP_CODE', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:01:53', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6745, 'RFC004', '1100', 'O', 'ADDRESS', 'ATTRIBUTE09', 'ATTRIBUTE09', 'ADDRESS', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:02:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6746, 'RFC004', '1100', 'O', 'ADDRESS_ENG', 'ATTRIBUTE10', 'ATTRIBUTE10', 'ADDRESS_ENG', 0, 200, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:02:49', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6747, 'RFC004', '1100', 'O', 'TEL_NO', 'ATTRIBUTE11', 'ATTRIBUTE11', 'TEL_NO', 0, 35, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6748, 'RFC004', '1100', 'O', 'FAX_NO', 'ATTRIBUTE12', 'ATTRIBUTE12', 'FAX_NO', 0, 100, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6749, 'RFC006', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6750, 'RFC006', '1100', 'O', 'PRODUCT_CODE', 'ATTRIBUTE01', 'ATTRIBUTE01', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6751, 'RFC006', '1100', 'O', 'PRODUCT_NAME', 'ATTRIBUTE02', 'ATTRIBUTE02', 'PRODUCT_NAME', 0, 30, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6752, 'RFC007', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6754, 'RFC007', '1100', 'O', 'SEQ', 'ATTRIBUTE02', 'ATTRIBUTE02', 'SEQ', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6755, 'RFC007', '1100', 'O', 'DIVISION_CODE', 'ATTRIBUTE03', 'ATTRIBUTE03', 'DIVISION_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6756, 'RFC007', '1100', 'O', 'WAREHOUSING_DATE', 'ATTRIBUTE04', 'ATTRIBUTE04', 'WAREHOUSING_DATE', 0, 10, 0, 'yyyyMMdd', null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:27:41', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6757, 'RFC007', '1100', 'O', 'ORDER_NO', 'ATTRIBUTE05', 'ATTRIBUTE05', 'ORDER_NO', 0, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:28:08', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6758, 'RFC007', '1100', 'O', 'ORDER_SEQ', 'ATTRIBUTE06', 'ATTRIBUTE06', 'ORDER_SEQ', 6, 20, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('31-01-2017 15:28:29', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6760, 'RFC007', '1100', 'O', 'MAKER_NAME', 'ATTRIBUTE08', 'ATTRIBUTE08', 'MAKER_NAME', 0, 70, 0, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6762, 'RFC007', '1100', 'O', 'UNIT', 'ATTRIBUTE10', 'ATTRIBUTE10', 'UNIT', 0, 10, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 15:29:50', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6763, 'RFC007', '1100', 'O', 'UNIT_PRICE', 'ATTRIBUTE11', 'ATTRIBUTE11', 'UNIT_PRICE', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6765, 'RFC007', '1100', 'O', 'WAREHOUSING_AMOUNT', 'ATTRIBUTE13', 'ATTRIBUTE13', 'WAREHOUSING_AMOUNT', 6, 30, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 15:30:33', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6766, 'RFC007', '1100', 'O', 'ASSETS_TYPE', 'ATTRIBUTE14', 'ATTRIBUTE14', 'ASSETS_TYPE', 0, 5, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 15:31:07', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6767, 'RFC007', '1100', 'O', 'WAREHOUSING_TYPE', 'ATTRIBUTE15', 'ATTRIBUTE15', 'WAREHOUSING_TYPE', 0, 4, 0, null, 'DOM', null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6770, 'RFC007', '1100', 'O', 'CURRENCY', 'ATTRIBUTE18', 'ATTRIBUTE18', 'CURRENCY', 0, 3, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017 15:39:51', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6788, 'RFC014', '1100', 'O', 'INCOTERMS', 'ATTRIBUTE07', 'ATTRIBUTE07', 'INCOTERMS', 0, 3, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('09-12-2015 08:46:04', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('09-12-2015 08:46:04', 'dd-mm-yyyy hh24:mi:ss'), '201112304', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6640, 'RFC015', '1100', 'O', 'ATTRIBUTE01', 'ATTRIBUTE18', 'ATTRIBUTE18', 'ATTRIBUTE01', 0, 4, 0, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6641, 'RFC015', '1100', 'O', 'ATTRIBUTE02', 'ATTRIBUTE19', 'ATTRIBUTE19', 'ATTRIBUTE02', 6, 20, 10, null, null, null, 'N', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6644, 'RFC019', '1100', 'O', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 'COMPANY_CODE', 0, 20, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6645, 'RFC019', '1100', 'O', 'PRODUCT_CODE', 'PRODUCT_CODE', 'ATTRIBUTE01', 'PRODUCT_CODE', 0, 30, 0, null, null, null, 'Y', 'Y', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6702, 'RFC011', '1100', 'O', 'EXTRA_INPUT_AMOUNT', 'ATTRIBUTE09', 'ATTRIBUTE09', 'EXTRA_INPUT_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6703, 'RFC011', '1100', 'O', 'ISSUE_QTY', 'ATTRIBUTE10', 'ATTRIBUTE10', 'ISSUE_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6704, 'RFC011', '1100', 'O', 'ISSUE_AMOUNT', 'ATTRIBUTE11', 'ATTRIBUTE11', 'ISSUE_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6705, 'RFC011', '1100', 'O', 'EXTRA_ISSUE_QTY', 'ATTRIBUTE12', 'ATTRIBUTE12', 'EXTRA_ISSUE_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6706, 'RFC011', '1100', 'O', 'EXTRA_ISSUE_AMOUNT', 'ATTRIBUTE13', 'ATTRIBUTE13', 'EXTRA_ISSUE_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6707, 'RFC011', '1100', 'O', 'INVENTORY_QTY', 'ATTRIBUTE14', 'ATTRIBUTE14', 'INVENTORY_QTY', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
insert into INTERFACE_ITEM_DTL (interface_item_dtl_id, if_code, company_code, column_trans_type, target_column, source_column, history_column, column_name, column_type, column_length, column_dcmlpoint_length, column_format_form, column_dflt_value, column_vrify_program_name, column_required_yn, pk_yn, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, sample_data)
values (6708, 'RFC011', '1100', 'O', 'INVENTORY_AMOUNT', 'ATTRIBUTE15', 'ATTRIBUTE15', 'INVENTORY_AMOUNT', 6, 20, 8, null, null, null, 'Y', 'N', 'Y', null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null);
commit;



/*INTERFACE_ITEM_MST*/
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC902', '1100', '원산지 판정', 'NA', 'NA', 'NA', null, 'NA', 'I', 'NA', null, 'NA', '원산지 판정 실행 프로시져 호출', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'Y', 'N', 'Y', null);
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC001', '1100', '고객사', 'DBO.RFC001', 'CUSTOMER_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC002', '1100', '자재마스터', 'DBO.RFC002', 'ITEM_MST_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC003', '1100', '자재상세', 'DBO.RFC003', 'ITEM_DTL_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC004', '1100', '공급업체', 'DBO.RFC004', 'VENDOR_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC006', '1100', '제품군', 'DBO.RFC006', 'PRODUCT_LINE_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC007', '1100', '구매원장', 'DBO.RFC007', 'PO_LEDGER_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC010', '1100', 'BOM', 'DBO.RFC010', 'RESULT_BOM_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('26-04-2017 19:00:24', 'dd-mm-yyyy hh24:mi:ss'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC011', '1100', '원재료 수불부', 'DBO.RFC011', 'MATERIAL_INV_BAL_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', '구매한 원부원료 및 상품 그리고 완성품에 대한 불출 내역을 인터페이스 한다.', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC014', '1100', '매출 마스터', 'DBO.RFC014', 'SALES_MST_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC015', '1100', '매출 상세', 'DBO.RFC015', 'SALES_DTL_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', '매출 오더에 대한 판매상세 내역을 인터페이스 한다.  원산지 판정의 대상 정보이며, 수출 건에 대한 증명서 발급 시 인보이스 번호별로 발급된다.', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC202', '1100', '표준원가', 'DBO.RFC202', 'STANDARD_COST_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', '회사에서 시뮬레이션한 원가에 대한 표준 정보 인터페이스', 'N', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC031', '1100', '고객사 자재관리', 'DBO.RFC031', 'CUSTOMER_MODEL_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', '판매자재와 고객사 품번 맵핑을 위한 정보 인터페이스', 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
insert into INTERFACE_ITEM_MST (if_code, company_code, if_name, source_table, target_table, history_table, vrify_program_name, source_program_name, interface_type, return_column_name, return_column_value, return_msg_column_name, remark, using_yn, attribute01, attribute02, attribute03, attribute04, attribute05, create_date, create_by, update_date, update_by, trans_program_name, trans_company_code_yn, trans_division_code_yn, excel_upload_yn, item_type)
values ('RFC008', '1100', '공장간이체', 'DBO.RFC008', 'MANUFACT_TRANS_INFO_INF', 'INTG_INTERFACE_TRANS_DTL', null, null, 'I', 'E_RETURN', 'S', 'E_RETURNMSG', null, 'Y', null, null, null, null, null, to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', to_date('31-01-2017', 'dd-mm-yyyy'), 'fta', null, 'N', 'N', 'N', 'B');
commit;


/*INTERFACE_SCHEDULE*/
insert into INTERFACE_SCHEDULE (interface_schedule_id, schedule_code, company_code, schedule_name, schedule_desc, execution_program, apply_from_date, apply_to_date, month, week, day, hour, minutes, status, system_batch_yn, last_execution_date, extcution_message, batch_yyyymm, batch_yyyymm_yn, exec_type, exec_daily_period, exec_monthly_period, exec_manual_start_yyyymm, exec_manual_end_yyyymm, create_date, create_by, update_date, update_by)
values (1, 'DAILY_BATCH', '1100', '일배치', '일배치 스케쥴러', 'BatchStarter', '20160101', '20401231', '*', null, '*', '5', '00', '0', 'Y', to_date('04-07-2018 07:13:23', 'dd-mm-yyyy hh24:mi:ss'), null, null, 'N', '1', 5, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('14-05-2018 09:33:44', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE (interface_schedule_id, schedule_code, company_code, schedule_name, schedule_desc, execution_program, apply_from_date, apply_to_date, month, week, day, hour, minutes, status, system_batch_yn, last_execution_date, extcution_message, batch_yyyymm, batch_yyyymm_yn, exec_type, exec_daily_period, exec_monthly_period, exec_manual_start_yyyymm, exec_manual_end_yyyymm, create_date, create_by, update_date, update_by)
values (2, 'MONTHLY_BATCH', '1100', '월마감배치', 'Monthly Batch 18,02,40 / 19,21,10', 'BatchStarter', '20160101', '20401231', '*', null, '18', '17', '00', '0', 'Y', to_date('04-07-2018 07:21:55', 'dd-mm-yyyy hh24:mi:ss'), null, null, 'N', '1', null, 1, '201811', '201812', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('04-07-2018 07:21:42', 'dd-mm-yyyy hh24:mi:ss'), 'han');
insert into INTERFACE_SCHEDULE (interface_schedule_id, schedule_code, company_code, schedule_name, schedule_desc, execution_program, apply_from_date, apply_to_date, month, week, day, hour, minutes, status, system_batch_yn, last_execution_date, extcution_message, batch_yyyymm, batch_yyyymm_yn, exec_type, exec_daily_period, exec_monthly_period, exec_manual_start_yyyymm, exec_manual_end_yyyymm, create_date, create_by, update_date, update_by)
values (3, 'NON_SCHEDULE', '1100', '수동배치', '스케쥴러를 통하지 않고, 사용자에 의해 직접 구동된 배치', 'none', '20160101', '20401231', '?', null, '?', '?', '?', null, 'N', null, null, null, null, null, null, null, null, null, to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
commit;


/*INTERFACE_SCHEDULE_MAPPING*/
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (1, 'DAILY_BATCH', '1100', 1, 'RFC001', null, 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (2, 'DAILY_BATCH', '1100', 2, 'RFC004', null, 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (3, 'DAILY_BATCH', '1100', 3, 'RFC002', null, 'N', 'M', null, 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (4, 'DAILY_BATCH', '1100', 4, 'RFC003', 'RFC002', 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (5, 'DAILY_BATCH', '1100', 5, 'RFC006', null, 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (6, 'DAILY_BATCH', '1100', 6, 'RFC007', null, 'N', 'M', 'FTA_DAILY_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (7, 'DAILY_BATCH', '1100', 7, 'RFC022', 'RFC015', 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (8, 'DAILY_BATCH', '1100', 8, 'RFC014', 'RFC022', 'N', 'M', null, 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (9, 'DAILY_BATCH', '1100', 9, 'RFC015', 'RFC014', 'N', 'M', 'FTA_DAILY_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (10, 'DAILY_BATCH', '1100', 10, 'RFC031', null, 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (11, 'DAILY_BATCH', '1100', 12, 'RFC008', null, 'N', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta', to_date('24-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (12, 'MONTHLY_BATCH', '1100', 2, 'RFC007', null, 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (13, 'MONTHLY_BATCH', '1100', 3, 'RFC011', null, 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (14, 'MONTHLY_BATCH', '1100', 5, 'RFC202', null, 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('26-05-2017 16:03:21', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('26-05-2017 16:03:21', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (15, 'MONTHLY_BATCH', '1100', 7, 'RFC022', null, 'Y', 'M', 'FTA_MASTER_PROCESS', 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (16, 'MONTHLY_BATCH', '1100', 8, 'RFC014', 'RFC022', 'Y', 'M', null, 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (17, 'MONTHLY_BATCH', '1100', 9, 'RFC015', 'RFC014', 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (18, 'MONTHLY_BATCH', '1100', 10, 'RFC202', null, 'N', 'M', 'FTA_MONTHLY_PROCESS', 'N', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (19, 'MONTHLY_BATCH', '1100', 12, 'RFC023', null, 'N', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta', to_date('25-01-2013 08:49:19', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (20, 'MONTHLY_BATCH', '1100', 15, 'RFC010', null, 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('25-04-2017', 'dd-mm-yyyy'), 'fta', to_date('25-04-2017', 'dd-mm-yyyy'), 'fta');
insert into INTERFACE_SCHEDULE_MAPPING (interface_schedule_mapping, schedule_code, company_code, schedule_seq, if_code, if_parent_code, required_yn, if_method, procedure_id, auto_batch_yn, create_date, create_by, update_date, update_by)
values (21, 'MONTHLY_BATCH', '1100', 16, 'RFC902', null, 'Y', 'M', 'FTA_MONTHLY_PROCESS', 'Y', to_date('30-11-2015 13:23:08', 'dd-mm-yyyy hh24:mi:ss'), '201112304', to_date('28-04-2017 17:42:32', 'dd-mm-yyyy hh24:mi:ss'), 'fta');
commit;


/*NY_CODE*/
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_MST_TYPE', 'R', 'SR Type', '일반', 1, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_MST_TYPE', 'E', 'SR Type', '긴급', 2, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_MST_TYPE', 'X', 'SR Type', '기타', 3, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_TARGET', 'W', '요청대상', 'Web-FTA', 1, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_TARGET', 'S', '요청대상', 'SAP-FTA', 2, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_TARGET', 'X', '요청대상', 'ETC', 3, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_DIV', '1', '요청유형', '단순문의', 1, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_DIV', '2', '요청유형', '장애', 2, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_DIV', '3', '요청유형', '오류', 3, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_DIV', '4', '요청유형', '변경요청', 4, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_DIV', '5', '요청유형', '신규개발', 5, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_STATUS', 'R', 'SR 상태', '진행중', 1, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_STATUS', 'C', 'SR 상태', '완료', 2, 'Y');
insert into NY_CODE (category_cd, code_cd, category_nm, code_nm, sort_no, using_yn)
values ('SR_STATUS', 'P', 'SR 상태', '보류', 3, 'Y');
commit;


/*PLANT*/
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('200', '9000', null, '생산플랜트', 'PRODUCT PLANT', 'P', 'Y', '1438500115', null, '경기도  여의동길 38-40', '38-40,Yeouidong-gi,Gyeonggi-do', '화성시', 'Hwaseong-si', 'N', '020-11-200498', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('22-08-2017 18:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1111-1111', '02-2222-2222', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '전우치');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1100', '9000', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '마산작두');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('200', '8000', null, '생산플랜트', 'PRODUCT PLANT', 'P', 'Y', '1438500115', null, '경기도  여의동길 38-40', '38-40,Yeouidong-gi,Gyeonggi-do', '화성시', 'Hwaseong-si', 'N', '020-11-200498', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('22-08-2017 18:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1111-1111', '02-2222-2222', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '전우치');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1100', '8000', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '마산작두');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('200', '9100', null, '생산플랜트', 'PRODUCT PLANT', 'P', 'Y', '1438500115', null, '경기도  여의동길 38-40', '38-40,Yeouidong-gi,Gyeonggi-do', '화성시', 'Hwaseong-si', 'N', '020-11-200498', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('22-08-2017 18:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1111-1111', '02-2222-2222', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '전우치');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1100', '9100', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '마산작두');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1200', '1200', null, '생산플랜트', 'PRODUCT PLANT', 'P', 'Y', '1438500115', null, '경기도  여의동길 38-40', '38-40,Yeouidong-gi,Gyeonggi-do', '화성시', 'Hwaseong-si', 'N', '020-11-200498', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('22-08-2017 18:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1111-1111', '02-2222-2222', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '홍길동');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1300', '1300', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '임꺽정');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1500', '1500', null, '생산플랜트', 'PRODUCT PLANT', 'P', 'Y', '1438500115', null, '경기도  여의동길 38-40', '38-40,Yeouidong-gi,Gyeonggi-do', '화성시', 'Hwaseong-si', 'N', '020-11-200498', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('22-08-2017 18:29:28', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1111-1111', '02-2222-2222', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '전우치');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1100', '1100', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '마산작두');
insert into PLANT (division_code, company_code, parent_division_code, division_name, division_name_eng, division_type, status, bizrno, zip_code, address, address_eng, city_name, city_name_eng, co_certified_exporter_yn, certification_no, div_de_minimis_rate, div_rvc_rate, div_intermediate_prod_type, verify_order_seq, division_group_code, inv_eval_method, create_date, create_by, update_date, update_by, send_receive_identifier_code, division_full_name, organ_user_id, organ_doc_no, coo_receipt_division_code, division_phone_no, division_fax_no, division_email, erp_division_code, cstbrkr, csmhse_code, acnutno, bank_code, ectmrk, telno_1, csmhse_nm, rprsntv_nm)
values ('1100', '3000', null, '본사', 'Head office', 'S', 'Y', '123-456-7890', '14524', '서울특별시 중구 세종대로 110', '110, Sejong-daero, Jung-gu, Seoul, Republic of Korea', '서울', 'Seoul', 'Y', '011-94-100045', 0, 0, null, null, '00', null, to_date('01-03-2017 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 'isource', to_date('08-08-2017 11:24:57', 'dd-mm-yyyy hh24:mi:ss'), 'isc', null, null, null, null, null, '02-1234-5678', '02-3344-5566', null, null, null, '154', '100014713490', '0213376', '현대파워1011017', null, null, '임꺽정');
commit;



/*PRINT_FORMS_DTL*/
insert into PRINT_FORMS_DTL (form_id, form_seq, default_selection_yn, create_date, create_by, update_date, update_by)
values ('prt00000', 1, 'Y', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
commit;


/*PRINT_FORMS_MST*/
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (2, 'prt00100', '가산금액 지급신청서', 'prt00100.jasper', '19000101', '99991231', 2, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (4, 'prt00400', '환급원재료 단위변경 신청서', 'prt00400.jasper', '19000101', '99991231', 4, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (5, 'prt00500', '자재명세서(BOM)', 'prt00500.jasper', '19000101', '99991231', 5, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (6, 'prt00600', '소요량 계산서', 'prt00600.jasper', '19000101', '99991231', 6, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (7, 'prt00700', '분할증명서', 'prt00700.jasper', '19000101', '99991231', 7, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (8, 'prt00800', '반입(적재)확인 정정(취하) 승인(신청)서', 'prt00800.jasper', '19000101', '99991231', 8, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (9, 'prt00900', '반입확인서', 'prt00900.jasper', '19000101', '99991231', 9, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (3, 'prt00300', '제증명 정정취하 신청서', 'prt00300.jasper', '19000101', '99991231', 3, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (10, 'prt01000', '환급신청서', 'prt01000.jasper', '19000101', '99991231', 10, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (11, 'prt01100', '기초원재료납세증명서', 'prt01100.jasper', '19000101', '99991231', 11, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
insert into PRINT_FORMS_MST (form_seq, form_id, form_name, form_file_name, start_date, end_date, form_index, create_date, create_by, update_date, update_by)
values (1, 'prt00000', '과다환급금', 'prt00000.jasper', '19000101', '99991231', 1, to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM', to_date('20-06-2019', 'dd-mm-yyyy'), 'SYSTEM');
commit;
