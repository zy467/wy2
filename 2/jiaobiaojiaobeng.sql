---------------------------------------------------
-- Export file for user WY2@ORCL                 --
-- Created by Administrator on 2017/1/4, 9:42:56 --
---------------------------------------------------

set define off
spool jiaobiaojiaobeng.log

prompt
prompt Creating table ROLE
prompt ===================
prompt
create table ROLE
(
  rid   INTEGER not null,
  rname VARCHAR2(10)
)
;
comment on table ROLE
  is '角色表';
alter table ROLE
  add constraint PRIMARY_ROLEID primary key (RID);

prompt
prompt Creating table STATUS
prompt =====================
prompt
create table STATUS
(
  sid   INTEGER not null,
  sname VARCHAR2(20)
)
;
comment on table STATUS
  is '用户状态表';
alter table STATUS
  add constraint PRIMARY_SID primary key (SID);

prompt
prompt Creating table ACCOUNT
prompt ======================
prompt
create table ACCOUNT
(
  accountid INTEGER not null,
  username  VARCHAR2(20),
  password  VARCHAR2(50),
  balance   NUMBER,
  sid       INTEGER,
  rid       INTEGER
)
;
comment on table ACCOUNT
  is '账户表';
alter table ACCOUNT
  add constraint PRIMARY_ACCOUNTID primary key (ACCOUNTID);
alter table ACCOUNT
  add constraint UNIQUE_USERNAME unique (USERNAME);
alter table ACCOUNT
  add constraint FOREIGN_RID foreign key (RID)
  references ROLE (RID);
alter table ACCOUNT
  add constraint FOREIGN_SID foreign key (SID)
  references STATUS (SID);

prompt
prompt Creating table ADMIN
prompt ====================
prompt
create table ADMIN
(
  aid      INTEGER not null,
  username VARCHAR2(20) not null,
  password VARCHAR2(60) not null
)
;
alter table ADMIN
  add constraint AID primary key (AID);

prompt
prompt Creating table TRANSACTION_TYPE
prompt ===============================
prompt
create table TRANSACTION_TYPE
(
  typeid   INTEGER not null,
  typename VARCHAR2(10)
)
;
comment on column TRANSACTION_TYPE.typeid
  is '交易类型id';
comment on column TRANSACTION_TYPE.typename
  is '交易类型';
alter table TRANSACTION_TYPE
  add constraint PRIMARY_TYPEID primary key (TYPEID);

prompt
prompt Creating table ALLTRANSACTION
prompt =============================
prompt
create table ALLTRANSACTION
(
  trid         NUMBER(10) not null,
  myaccount    VARCHAR2(50),
  tr_money     NUMBER,
  typeid       INTEGER,
  orderstatus  INTEGER,
  otheraccount VARCHAR2(50),
  datetime     DATE
)
;
alter table ALLTRANSACTION
  add constraint PRIMKEY_TRID primary key (TRID);
alter table ALLTRANSACTION
  add constraint FOREIGNKEY_TYPEID foreign key (TYPEID)
  references TRANSACTION_TYPE (TYPEID);

prompt
prompt Creating table BOUND
prompt ====================
prompt
create table BOUND
(
  bid       VARCHAR2(50) not null,
  paymentid INTEGER,
  accountid INTEGER
)
;
alter table BOUND
  add constraint PK_BID primary key (BID);
alter table BOUND
  add constraint UK_ACCOUTID_PAYMENTID unique (PAYMENTID, ACCOUNTID);
alter table BOUND
  add constraint FK_ACCOUNTID foreign key (ACCOUNTID)
  references ACCOUNT (ACCOUNTID);

prompt
prompt Creating table NBTRANSACTIONLOG
prompt ===============================
prompt
create table NBTRANSACTIONLOG
(
  trid        INTEGER not null,
  tr_money    NUMBER,
  datetime    DATE,
  orderstatus INTEGER,
  paymentsn   VARCHAR2(50),
  accountid   INTEGER not null,
  typeid      INTEGER
)
;
alter table NBTRANSACTIONLOG
  add constraint PRIMARYTRID primary key (TRID);
alter table NBTRANSACTIONLOG
  add constraint FOREIGNACCOUNTID foreign key (ACCOUNTID)
  references ACCOUNT (ACCOUNTID);
alter table NBTRANSACTIONLOG
  add constraint FOREIGNTYPEID foreign key (TYPEID)
  references TRANSACTION_TYPE (TYPEID);

prompt
prompt Creating table PAYTRANSACTIONLOG
prompt ================================
prompt
create table PAYTRANSACTIONLOG
(
  trid        NUMBER(10) not null,
  tr_money    FLOAT,
  datetime    DATE not null,
  typeid      NUMBER(10),
  orderstatus NUMBER(10),
  paymentsn   VARCHAR2(255 CHAR) not null,
  bid         VARCHAR2(255 CHAR) not null
)
;
alter table PAYTRANSACTIONLOG
  add constraint PK_TRID primary key (TRID);
alter table PAYTRANSACTIONLOG
  add constraint UK_PAYMENTSN unique (PAYMENTSN);
alter table PAYTRANSACTIONLOG
  add constraint FK_BID foreign key (BID)
  references BOUND (BID);
alter table PAYTRANSACTIONLOG
  add constraint FK_TYPEID foreign key (TYPEID)
  references TRANSACTION_TYPE (TYPEID);

prompt
prompt Creating table PERSONINFO
prompt =========================
prompt
create table PERSONINFO
(
  pid       VARCHAR2(20) not null,
  accountid INTEGER,
  realname  VARCHAR2(8),
  age       INTEGER,
  sex       VARCHAR2(6),
  cardid    VARCHAR2(20),
  telephone VARCHAR2(20)
)
;
comment on table PERSONINFO
  is '用户信息表';
alter table PERSONINFO
  add constraint PRIMARY_PID primary key (PID);
alter table PERSONINFO
  add constraint UNIQUE_CARDID unique (CARDID);
alter table PERSONINFO
  add constraint FOREIGN_ACCONTID foreign key (ACCOUNTID)
  references ACCOUNT (ACCOUNTID);

prompt
prompt Creating table TRANSACTION_LOG
prompt ==============================
prompt
create table TRANSACTION_LOG
(
  trid        INTEGER not null,
  tr_money    NUMBER,
  datetime    DATE default sysdate not null,
  typeid      INTEGER,
  otherid     VARCHAR2(20),
  orderstatus INTEGER,
  accountid   INTEGER
)
;
comment on table TRANSACTION_LOG
  is '交易信息表';
comment on column TRANSACTION_LOG.trid
  is '流水号';
comment on column TRANSACTION_LOG.tr_money
  is '交易金额';
comment on column TRANSACTION_LOG.datetime
  is '默认系统时间';
comment on column TRANSACTION_LOG.typeid
  is '交易类型ID';
comment on column TRANSACTION_LOG.otherid
  is '对方卡号';
comment on column TRANSACTION_LOG.orderstatus
  is '订单状态';
alter table TRANSACTION_LOG
  add constraint PRIMARY_TRID primary key (TRID);
alter table TRANSACTION_LOG
  add constraint FOREIGN_ACCOUNTID foreign key (ACCOUNTID)
  references ACCOUNT (ACCOUNTID);
alter table TRANSACTION_LOG
  add constraint FOREIGN_TYPEID foreign key (TYPEID)
  references TRANSACTION_TYPE (TYPEID);

prompt
prompt Creating sequence HIBERNATE_ACCOUNT_SEQUENCE
prompt ============================================
prompt
create sequence HIBERNATE_ACCOUNT_SEQUENCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 242
increment by 1
cache 20;

prompt
prompt Creating sequence HIBERNATE_BOUND_SEQUENCE
prompt ==========================================
prompt
create sequence HIBERNATE_BOUND_SEQUENCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 22
increment by 1
cache 20;

prompt
prompt Creating sequence HIBERNATE_PERSONIFO_SEQUENCE
prompt ==============================================
prompt
create sequence HIBERNATE_PERSONIFO_SEQUENCE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence HIBERNATE_TRANSACTION_SEQUENCE
prompt ================================================
prompt
create sequence HIBERNATE_TRANSACTION_SEQUENCE
minvalue 0
maxvalue 99999999999999999
start with 491
increment by 1
cache 20;

prompt
prompt Creating trigger AFTERDELETEPAYTRANSACTIONLOG
prompt =============================================
prompt
create or replace trigger afterdeletepaytransactionlog
  after delete
  on paytransactionlog
  for each row
declare
  -- local variables here
begin
   delete from alltransaction where trid=:old.trid;
end;
/

prompt
prompt Creating trigger AFTERDELETETRANSACTIONLOG
prompt ==========================================
prompt
create or replace trigger afterdeletetransactionlog
  after delete
  on transaction_log
  for each row
declare
  -- local variables here
begin
  delete from alltransaction where trid=:old.trid;
end;
/

prompt
prompt Creating trigger AFTERPAYTRANSACTIONLOG
prompt =======================================
prompt
create or replace trigger afterpaytransactionlog
  after insert
  on paytransactionlog
  for each row
declare
  var_myaccount varchar2(50);
  var_otheraccount varchar2(50);
begin
   select username into var_myaccount from account a inner join bound b on a.accountid=b.accountid where b.bid=:new.bid;
   select paymentid into var_otheraccount from account a inner join bound b on a.accountid=b.accountid where b.bid=:new.bid;
    insert into alltransaction values (:new.trid,var_myaccount,:new.tr_money,:new.typeid,:new.orderstatus,var_otheraccount,:new.datetime);
end;
/

prompt
prompt Creating trigger AFTERTRANSACTIONLOG
prompt ====================================
prompt
create or replace trigger aftertransactionlog
  after insert
  on transaction_log
  for each row
declare
  var_myaccount varchar2(50);
  var_otheraccount varchar2(50);
begin
   select username into var_myaccount from account where accountid=:new.accountid;
   select username into var_otheraccount from personinfo p inner join account a on p.accountid=a.accountid where cardid=:new.otherid;
   insert into alltransaction values (:new.trid,var_myaccount,:new.tr_money,:new.typeid,:new.orderstatus,var_otheraccount,:new.datetime);
end;
/

prompt
prompt Creating trigger DELETE_ACCOUT_ALL
prompt ==================================
prompt
create or replace trigger delete_accout_all
  before delete
  on ACCOUNT
  for each row
declare
  -- local variables here
begin
  delete from personinfo where accountid=:old.accountid;
  delete from bound where accountid=:old.accountid;
  delete from transaction_log where accountid=:old.accountid;
end;
/

prompt
prompt Creating trigger DELETE_BOUND_ALL
prompt =================================
prompt
create or replace trigger delete_bound_all
  before delete
  on BOUND
  for each row
declare
  -- local variables here
begin
   delete from paytransactionlog where bid=:old.bid;
end;
/

prompt
prompt Creating trigger UPDATEPAYTRANSACTIONLOG
prompt ========================================
prompt
create or replace trigger updatepaytransactionlog
  after update
  on paytransactionlog
  for each row
declare
  -- local variables here
begin
  update alltransaction set orderstatus=:new.orderstatus where trid=:old.trid;
end;
/


spool off
