 --сверка с биллингом
   --1) вытаскиваем скрипт заливки  
    WITH RES AS 
    (
        SELECT
          ROW_NUMBER() OVER(ORDER BY T.COLUMN_ID) AS RN1,
            ROW_NUMBER() OVER(ORDER BY T.COLUMN_ID) + 1 AS RN2,
            COUNT(1) OVER() AS CNT,
            CASE WHEN ROW_NUMBER() OVER(ORDER BY T.COLUMN_ID) = 1 THEN 'SELECT ' || '' || ' ' ELSE NULL END ||
            T.COLUMN_NAME || 
            CASE 
              WHEN T.COLUMN_ID != MAX(T.COLUMN_ID) OVER() THEN ',' 
              ELSE ' FROM ' ||' '|| ' T '
            END AS ORIGINAL_QUERY,
            CASE 
                WHEN ROW_NUMBER() OVER(ORDER BY T.COLUMN_ID) = 1 
                  THEN 'SELECT ' || '' || ' T.ORA_ROWSCN AS RSCN, SYSDATE AS DT, ' 
                ELSE NULL 
            END ||
            dwh.FLD_CASE(IN_DB_ID => 5, IN_FLD_NAME => T.COLUMN_NAME,IN_ALIAS => 'T') ||
            ' AS ' || T.COLUMN_NAME ||
            CASE 
              WHEN ROW_NUMBER() OVER(ORDER BY T.COLUMN_ID) != COUNT(1) OVER() THEN ',' 
              ELSE 
                ' FROM ' || 
               ' TARIFF_PLAN_HISTORY'|| 
                '@$DB_LINK$ T ' || 
                'WHERE NVL(T.ORA_ROWSCN, 1) > $LAST_MAX$'
            END AS MODIFIED_QUERY
        FROM 
            ALL_TAB_COLUMNS T
        LEFT JOIN ALL_COL_COMMENTS CC ON
          CC.TABLE_NAME = T.TABLE_NAME
        AND CC.COLUMN_NAME = T.COLUMN_NAME
        WHERE
            T.TABLE_NAME = 'TARIFF_PLAN_HISTORY' and t.owner='DWH' and cc.OWNER='DWH'
        AND CC.COMMENTS IS NULL
        ORDER BY
            T.COLUMN_ID
        )
        SELECT
          REPLACE(SYS_CONNECT_BY_PATH(ORIGINAL_QUERY, '#'), '#', '') AS ORIGINAL_QUERY,
          REPLACE(SYS_CONNECT_BY_PATH(MODIFIED_QUERY, '#'), '#', '') AS MODIFIED_QUERY
           -- INTO P_SETTING.BUFF_SQL, P_SETTING.SQL_TEXT
        FROM 
            RES
        WHERE
            RES.RN1 = RES.CNT
        START WITH RN1 = 1 CONNECT BY RN1 = PRIOR RN2;

-- 2 создаем таблицу с  исходником и различиями

create table sh_bill5 as select * from subs_history@berdb5 where subs_id>0;
create table sh_bill_ttt as
 SELECT 
        CASE
          WHEN t.subs_id >= 17996071 THEN
           t.subs_id + 100000000000
          ELSE
           t.subs_id
        END AS SUBS_ID,
        t.num_history AS NUM_HISTORY,
        CASE
          WHEN t.clnt_id >= 17944566 THEN
           t.clnt_id + 100000000000
          ELSE
           t.clnt_id
        END AS CLNT_ID,
        t.st_id AS ST_ID,
        CASE
          WHEN t.phone_id >= 15861738 THEN
           t.phone_id + 100000000000
          ELSE
           t.phone_id
        END AS PHONE_ID,
        t.stat_id AS STAT_ID,
        CASE
          WHEN t.trpl_id >= 2529 THEN
           t.trpl_id + 10000000
          ELSE
           t.trpl_id
        END AS TRPL_ID,
        t.weight AS WEIGHT,
        t.zone_id AS ZONE_ID,
        t.stime AS STIME,
        t.etime AS ETIME,
        CASE
          WHEN t.cre_user_id >= 3902 THEN
           t.cre_user_id + 10000000
          ELSE
           t.cre_user_id
        END AS CRE_USER_ID,
        t.cre_date AS CRE_DATE,
        t.rlb_id AS RLB_ID,
        t.close_date AS CLOSE_DATE,
        t.csc_id AS CSC_ID,
        t.clnt_notification AS CLNT_NOTIFICATION,
        CASE
          WHEN t.def_pay_pack_clnt >= 17944566 THEN
           t.def_pay_pack_clnt + 100000000000
          ELSE
           t.def_pay_pack_clnt
        END AS DEF_PAY_PACK_CLNT,
        t.block_quota AS BLOCK_QUOTA
   FROM subs_history@berdb2 T
  WHERE subs_id>0
;
create table  diff as 
select /*+ parallel(4) */ subs_id,num_history,clnt_id,st_id,phone_id,stat_id,trpl_id,weight,zone_id,stime,etime,cre_user_id,cre_date,rlb_id,close_date,csc_id from sh_bill_ttt
minus
select /*+ parallel(4) */ subs_id,num_history,clnt_id,st_id,phone_id,stat_id,trpl_id,weight,zone_id,stime,etime,cre_user_id,cre_date,rlb_id,close_date,csc_id from dwh_ipc.ipc_subs_history;



-- 3 сверяем данные

 select *--subs_id,num_history,clnt_id,st_id,phone_id,stat_id,trpl_id,weight,zone_id,stime,etime,cre_user_id,cre_date,rlb_id,close_date,csc_id
 from diff_4 where etime  <trunc(sysdate)--and subs_id=849157 and num_history=66
 ;


select subs_id,num_history,clnt_id,st_id,phone_id,stat_id,trpl_id,weight,zone_id,stime,etime,cre_user_id,cre_date,rlb_id,close_date,csc_id  ,clnt_notification,def_pay_pack_clnt,block_quota
 from subs_history@berdb1  where subs_id=33427154 and num_history=4
 union 
 select subs_id,num_history,clnt_id,st_id,phone_id,stat_id,trpl_id,weight,zone_id,stime,etime,cre_user_id,cre_date,rlb_id,close_date,csc_id ,clnt_notification,def_pay_pack_clnt,block_quota
 from dwh_ipc.ipc_subs_history t  where subs_id=33427154
 and num_history=4;

 
