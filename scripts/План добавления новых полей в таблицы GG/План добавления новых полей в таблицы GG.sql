--1 Проверяем таблицы
select * from stage02.charge_s;
select * from stage03.charge_s;
select * from stage04.charge_s;
select * from stage05.charge_s;
--2 Создаем вью
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
--3 Проверяем вью селектами в том числе и внутренний скрипт

select * from stage02.VW_CHARGE_S;
select * from stage03.VW_CHARGE_S;
select * from stage04.VW_CHARGE_S;
select * from stage05.VW_CHARGE_S;
--4 даем гранты схеме INFORMATICA_RO

grant select on stage02.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage03.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage04.VW_CHARGE_S to INFORMATICA_RO;
grant select on stage05.VW_CHARGE_S to INFORMATICA_RO;

--5 Открываем WF и редактируем скрипт 
--6 Из последнего лога загрузки потока вытаскиваем скрипт  для ODS
--7 Переделываем под вью и добавляем поле   и запускаем под INFORMATICA_RO
,SSCH_ID
--8 Переделываем селект с параметрами под вью и добавляем поле  
--9 Скрипт добавляем в сессию
--10 Добавляем поле в source
--11 Добавляем поле в target
--12 Протягиваем поле в маппинге
--13  добавляем поле в таргет таблице DWH
--14 Если сессия  с параллелями то меняем скрипт и вних (меняем на вьюху и добавляем поле)
--15 Запускаем поток на проливку
--16 Если ест вьюх в DWH то при необходимости добавить его во вьюху





















