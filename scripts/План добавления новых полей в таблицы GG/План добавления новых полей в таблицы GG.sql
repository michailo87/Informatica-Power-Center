--1 ��������� �������
select * from stage02.charge_s;
select * from stage03.charge_s;
select * from stage04.charge_s;
select * from stage05.charge_s;
--2 ������� ���
create or replace view stage02.VW_CHARGE_S as
select 
  chrg_id        ,
  clnt_id        ,
  clnt_bal_id    ,
  charge_date    ,
  chtype_id      ,
  curr_id        ,
  summ_$         ,
  vat_$          ,
  wovat_$        ,
  cre_user_id    ,
  cre_date       ,
  serv_id        ,
  subs_id        ,
  trpl_id        ,
  ob_id          ,
  invd_id        ,
  del_user_id    ,
  del_date       ,
  chrg_comment   ,
  tax_rate       ,
  quota_id       ,
  summ_wo_dis_$  ,
  owner_chrg_id  ,
  ssch_id        ,
  gg_op_code     ,
  gg_op_time     ,
  gg_op_cmt_scn  ,
  gg_op_cmt_time ,
  gg_op_seq      ,
  gg_seq_rba     ,
  gg_before_after
from stage02.charge_S
;
--3 ��������� ��� ��������� � ��� ����� � ���������� ������

select * from stage02.VW_CHARGE_S;
select * from stage03.VW_CHARGE_S;
select * from stage04.VW_CHARGE_S;
select * from stage05.VW_CHARGE_S;
--4 ���� ������ ����� INFORMATICA_RO

grant select on stage02.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage03.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage04.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage05.VW_CHARGE_S to INFORMATICA_RO;

--5 ��������� WF � ����������� ������ 
--6 �� ���������� ���� �������� ������ ����������� ������  ��� ODS
--7 ������������ ��� ��� � ��������� ����   � ��������� ��� INFORMATICA_RO
,SSCH_ID
--8 ������������ ������ � ����������� ��� ��� � ��������� ����  
--9 ������ ��������� � ������
--10 ��������� ���� � source
--11 ��������� ���� � target
--12 ����������� ���� � ��������
--13  ��������� ���� � ������ ������� DWH
--14 ���� ������  � ����������� �� ������ ������ � ���� (������ �� ����� � ��������� ����)
--15 ��������� ����� �� ��������
--16 ���� ��� ���� � DWH �� ��� ������������� �������� ��� �� �����





















