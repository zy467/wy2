prompt PL/SQL Developer import file
prompt Created on 2017年1月4日 by Administrator
set feedback off
set define off
prompt Disabling triggers for ROLE...
alter table ROLE disable all triggers;
prompt Disabling triggers for STATUS...
alter table STATUS disable all triggers;
prompt Disabling triggers for ACCOUNT...
alter table ACCOUNT disable all triggers;
prompt Disabling triggers for ADMIN...
alter table ADMIN disable all triggers;
prompt Disabling triggers for TRANSACTION_TYPE...
alter table TRANSACTION_TYPE disable all triggers;
prompt Disabling triggers for ALLTRANSACTION...
alter table ALLTRANSACTION disable all triggers;
prompt Disabling triggers for BOUND...
alter table BOUND disable all triggers;
prompt Disabling triggers for NBTRANSACTIONLOG...
alter table NBTRANSACTIONLOG disable all triggers;
prompt Disabling triggers for PAYTRANSACTIONLOG...
alter table PAYTRANSACTIONLOG disable all triggers;
prompt Disabling triggers for PERSONINFO...
alter table PERSONINFO disable all triggers;
prompt Disabling triggers for TRANSACTION_LOG...
alter table TRANSACTION_LOG disable all triggers;
prompt Disabling foreign key constraints for ACCOUNT...
alter table ACCOUNT disable constraint FOREIGN_RID;
alter table ACCOUNT disable constraint FOREIGN_SID;
prompt Disabling foreign key constraints for ALLTRANSACTION...
alter table ALLTRANSACTION disable constraint FOREIGNKEY_TYPEID;
prompt Disabling foreign key constraints for BOUND...
alter table BOUND disable constraint FK_ACCOUNTID;
prompt Disabling foreign key constraints for NBTRANSACTIONLOG...
alter table NBTRANSACTIONLOG disable constraint FOREIGNACCOUNTID;
alter table NBTRANSACTIONLOG disable constraint FOREIGNTYPEID;
prompt Disabling foreign key constraints for PAYTRANSACTIONLOG...
alter table PAYTRANSACTIONLOG disable constraint FK_BID;
alter table PAYTRANSACTIONLOG disable constraint FK_TYPEID;
prompt Disabling foreign key constraints for PERSONINFO...
alter table PERSONINFO disable constraint FOREIGN_ACCONTID;
prompt Disabling foreign key constraints for TRANSACTION_LOG...
alter table TRANSACTION_LOG disable constraint FOREIGN_ACCOUNTID;
alter table TRANSACTION_LOG disable constraint FOREIGN_TYPEID;
prompt Deleting TRANSACTION_LOG...
delete from TRANSACTION_LOG;
commit;
prompt Deleting PERSONINFO...
delete from PERSONINFO;
commit;
prompt Deleting PAYTRANSACTIONLOG...
delete from PAYTRANSACTIONLOG;
commit;
prompt Deleting NBTRANSACTIONLOG...
delete from NBTRANSACTIONLOG;
commit;
prompt Deleting BOUND...
delete from BOUND;
commit;
prompt Deleting ALLTRANSACTION...
delete from ALLTRANSACTION;
commit;
prompt Deleting TRANSACTION_TYPE...
delete from TRANSACTION_TYPE;
commit;
prompt Deleting ADMIN...
delete from ADMIN;
commit;
prompt Deleting ACCOUNT...
delete from ACCOUNT;
commit;
prompt Deleting STATUS...
delete from STATUS;
commit;
prompt Deleting ROLE...
delete from ROLE;
commit;
prompt Loading ROLE...
insert into ROLE (rid, rname)
values (0, 'personuser');
insert into ROLE (rid, rname)
values (1, 'business');
insert into ROLE (rid, rname)
values (2, 'admin');
commit;
prompt 3 records loaded
prompt Loading STATUS...
insert into STATUS (sid, sname)
values (1, 'frozen');
insert into STATUS (sid, sname)
values (0, 'normal');
commit;
prompt 2 records loaded
prompt Loading ACCOUNT...
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (182, 'zhang_junbai', 'SxkW5tFcrkwRrzXCa5jlNQ==', 19998999.5, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (222, 'yczxss1', 'mVniGFh+C1AlnjuGHl6+ag==', 5600, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (224, 'en_gesi', 'vx22UyPIxXQ81qnMr/Mnyg==', 5000, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (226, 'xiao_bona', 'KZnj68U/VnPTq8z4gV2a6A==', 5690, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (202, 'dengyanjun', 'EZViADNeN+ukyuJ5bSGIxA==', 10000125554, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (184, 'zhangHuaJian', 'VEDK02CZqVSWyZ6UF7jR7g==', 99874449, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (171, 'zhj', '4c0Xqjj2jze7XMYruu9WXA==', 20000555.5, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (183, 'zhou_yaping', 'iDP+sggTDXtcW03DQ7E27Q==', 9999999994, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (225, 'xiao_bang', 'LD1RqXwCk6hgBRZa8uU/lw==', 9000, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (227, 'gao_wen', 'gD7nGM4JwIyUPbYNYuSeog==', 3960, 0, 0);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (2, 'zf2', 'iDP+sggTDXtcW03DQ7E27Q==', 11193536, 0, 1);
insert into ACCOUNT (accountid, username, password, balance, sid, rid)
values (1, 'zf1', 'iDP+sggTDXtcW03DQ7E27Q==', 19883890, 0, 1);
commit;
prompt 12 records loaded
prompt Loading ADMIN...
insert into ADMIN (aid, username, password)
values (1, 'admin', 'iiErWSxM/X3hAoPj34CMvQ==');
commit;
prompt 1 records loaded
prompt Loading TRANSACTION_TYPE...
insert into TRANSACTION_TYPE (typeid, typename)
values (1, '转账');
insert into TRANSACTION_TYPE (typeid, typename)
values (0, '充值');
insert into TRANSACTION_TYPE (typeid, typename)
values (2, '提现');
insert into TRANSACTION_TYPE (typeid, typename)
values (3, '退款');
commit;
prompt 4 records loaded
prompt Loading ALLTRANSACTION...
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (437, 'zhang_junbai', -20, 0, 1, '100000', to_date('26-12-2016 12:32:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (447, 'zhangHuaJian', -55555, 1, 1, 'dengyanjun', to_date('26-12-2016 16:02:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (448, 'dengyanjun', 55555, 1, 1, 'zhangHuaJian', to_date('26-12-2016 16:02:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (449, 'zhangHuaJian', -66666, 1, 1, 'dengyanjun', to_date('26-12-2016 16:03:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (450, 'dengyanjun', 66666, 1, 1, 'zhangHuaJian', to_date('26-12-2016 16:03:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (471, 'zhang_junbai', -666, 0, 1, '100000', to_date('26-12-2016 12:45:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (477, 'zhou_yaping', -1, 1, 1, 'zhangHuaJian', to_date('29-12-2016 12:50:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (438, 'zhang_junbai', -20, 0, 1, '100000', to_date('26-12-2016 12:32:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (446, 'zhang_junbai', 1000, 2, 1, '100000', to_date('26-12-2016 12:32:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (475, 'zhou_yaping', -1, 1, 1, 'zhangHuaJian', to_date('29-12-2016 12:50:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (476, 'zhangHuaJian', 1, 1, 1, 'zhou_yaping', to_date('29-12-2016 12:50:10', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (478, 'zhangHuaJian', 1, 1, 1, 'zhou_yaping', to_date('29-12-2016 12:50:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (440, 'zhang_junbai', -20, 0, 1, '100000', to_date('26-12-2016 12:32:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (442, 'zhang_junbai', -1, 0, 1, '100000', to_date('26-12-2016 12:32:26', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (443, 'zhang_junbai', -1, 0, 1, '100000', to_date('26-12-2016 12:32:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (480, 'zhangHuaJian', 1, 1, 1, 'zhou_yaping', to_date('29-12-2016 12:52:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (439, 'zhang_junbai', -20, 0, 1, '100000', to_date('26-12-2016 12:32:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (451, 'zhangHuaJian', -3333, 1, 1, 'dengyanjun', to_date('26-12-2016 16:27:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (452, 'dengyanjun', 3333, 1, 1, 'zhangHuaJian', to_date('26-12-2016 16:27:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (479, 'zhou_yaping', -1, 1, 1, 'zhangHuaJian', to_date('29-12-2016 12:52:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (434, 'zhj', 20, 1, 1, 'zhang_junbai', to_date('26-12-2016 11:51:18', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (472, 'zhang_junbai', -335.5, 1, 1, 'zhj', to_date('28-12-2016 16:35:45', 'dd-mm-yyyy hh24:mi:ss'));
insert into ALLTRANSACTION (trid, myaccount, tr_money, typeid, orderstatus, otheraccount, datetime)
values (473, 'zhj', 335.5, 1, 1, 'zhang_junbai', to_date('28-12-2016 16:35:45', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 23 records loaded
prompt Loading BOUND...
insert into BOUND (bid, paymentid, accountid)
values ('10996138', 100000, 182);
insert into BOUND (bid, paymentid, accountid)
values ('20522433', 200000, 184);
commit;
prompt 2 records loaded
prompt Loading NBTRANSACTIONLOG...
prompt Table is empty
prompt Loading PAYTRANSACTIONLOG...
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (437, -20, to_date('26-12-2016 12:32:20', 'dd-mm-yyyy hh24:mi:ss'), 0, 1, '10928852', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (471, -666, to_date('26-12-2016 12:45:19', 'dd-mm-yyyy hh24:mi:ss'), 0, 1, '10628853', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (446, 1000, to_date('26-12-2016 12:32:39', 'dd-mm-yyyy hh24:mi:ss'), 2, 1, '10237659', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (438, -20, to_date('26-12-2016 12:32:50', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, '10928859', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (440, -20, to_date('26-12-2016 12:32:53', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, '10227859', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (442, -1, to_date('26-12-2016 12:32:26', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, '10227759', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (443, -1, to_date('26-12-2016 12:32:36', 'dd-mm-yyyy hh24:mi:ss'), 0, 1, '10227659', '10996138');
insert into PAYTRANSACTIONLOG (trid, tr_money, datetime, typeid, orderstatus, paymentsn, bid)
values (439, -20, to_date('26-12-2016 12:32:55', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, '10927859', '10996138');
commit;
prompt 8 records loaded
prompt Loading PERSONINFO...
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320902199601137537', 182, '张俊柏', 20, '男', '2000369801236956', '13024338912');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320145199501163579', 226, '萧伯纳', 30, '男', '2000369856321236', '13965227896');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320169874123658974', 222, '马克思', 20, '男', '2000369812693654', '13026995678');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320156788901137539', 224, '恩格斯', 20, '男', '2000235689123654', '13026998912');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320911199410220617', 184, '张华健', 22, '男', '2000000000000000', '15195818735');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320911199410220616', 202, '邓彦君', 22, '女', '2000111111111111', '18761615252');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('320902199632217549', 225, '肖邦', 20, '男', '2000369812369856', '19632114589');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('201254123246512', 171, '周雅萍', 23, '男', '2000154231546789', '123456');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('123456789123456', 183, '周雅萍', 21, '男', '2000123456789456', '15751592791');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('369632011936697539', 227, '高文', 34, '男', '2000369874123695', '15902338945');
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('100000', 1, '支付1', null, null, '2234100000000000', null);
insert into PERSONINFO (pid, accountid, realname, age, sex, cardid, telephone)
values ('200000', 2, '支付2', null, null, '2234200000000000', null);
commit;
prompt 12 records loaded
prompt Loading TRANSACTION_LOG...
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (449, -66666, to_date('26-12-2016 16:03:54', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000111111111111', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (450, 66666, to_date('26-12-2016 16:03:54', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 202);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (477, -1, to_date('29-12-2016 12:50:36', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 183);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (447, -55555, to_date('26-12-2016 16:02:54', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000111111111111', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (448, 55555, to_date('26-12-2016 16:02:54', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 202);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (475, -1, to_date('29-12-2016 12:50:10', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 183);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (476, 1, to_date('29-12-2016 12:50:10', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000123456789456', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (478, 1, to_date('29-12-2016 12:50:36', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000123456789456', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (480, 1, to_date('29-12-2016 12:52:11', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000123456789456', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (479, -1, to_date('29-12-2016 12:52:11', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 183);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (451, -3333, to_date('26-12-2016 16:27:48', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000111111111111', 1, 184);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (452, 3333, to_date('26-12-2016 16:27:48', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000000000000000', 1, 202);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (472, -335.5, to_date('28-12-2016 16:35:45', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000154231546789', 1, 182);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (434, 20, to_date('26-12-2016 11:51:18', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000369801236956', 1, 171);
insert into TRANSACTION_LOG (trid, tr_money, datetime, typeid, otherid, orderstatus, accountid)
values (473, 335.5, to_date('28-12-2016 16:35:45', 'dd-mm-yyyy hh24:mi:ss'), 1, '2000369801236956', 1, 171);
commit;
prompt 15 records loaded
prompt Enabling foreign key constraints for ACCOUNT...
alter table ACCOUNT enable constraint FOREIGN_RID;
alter table ACCOUNT enable constraint FOREIGN_SID;
prompt Enabling foreign key constraints for ALLTRANSACTION...
alter table ALLTRANSACTION enable constraint FOREIGNKEY_TYPEID;
prompt Enabling foreign key constraints for BOUND...
alter table BOUND enable constraint FK_ACCOUNTID;
prompt Enabling foreign key constraints for NBTRANSACTIONLOG...
alter table NBTRANSACTIONLOG enable constraint FOREIGNACCOUNTID;
alter table NBTRANSACTIONLOG enable constraint FOREIGNTYPEID;
prompt Enabling foreign key constraints for PAYTRANSACTIONLOG...
alter table PAYTRANSACTIONLOG enable constraint FK_BID;
alter table PAYTRANSACTIONLOG enable constraint FK_TYPEID;
prompt Enabling foreign key constraints for PERSONINFO...
alter table PERSONINFO enable constraint FOREIGN_ACCONTID;
prompt Enabling foreign key constraints for TRANSACTION_LOG...
alter table TRANSACTION_LOG enable constraint FOREIGN_ACCOUNTID;
alter table TRANSACTION_LOG enable constraint FOREIGN_TYPEID;
prompt Enabling triggers for ROLE...
alter table ROLE enable all triggers;
prompt Enabling triggers for STATUS...
alter table STATUS enable all triggers;
prompt Enabling triggers for ACCOUNT...
alter table ACCOUNT enable all triggers;
prompt Enabling triggers for ADMIN...
alter table ADMIN enable all triggers;
prompt Enabling triggers for TRANSACTION_TYPE...
alter table TRANSACTION_TYPE enable all triggers;
prompt Enabling triggers for ALLTRANSACTION...
alter table ALLTRANSACTION enable all triggers;
prompt Enabling triggers for BOUND...
alter table BOUND enable all triggers;
prompt Enabling triggers for NBTRANSACTIONLOG...
alter table NBTRANSACTIONLOG enable all triggers;
prompt Enabling triggers for PAYTRANSACTIONLOG...
alter table PAYTRANSACTIONLOG enable all triggers;
prompt Enabling triggers for PERSONINFO...
alter table PERSONINFO enable all triggers;
prompt Enabling triggers for TRANSACTION_LOG...
alter table TRANSACTION_LOG enable all triggers;
set feedback on
set define on
prompt Done.
