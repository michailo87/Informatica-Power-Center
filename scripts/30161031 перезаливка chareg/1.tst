PL/SQL Developer Test script 3.0
79
-- Created on 28.10.2016 by MKRTICH.PUDEYAN 
declare 
  -- Local variables here
  i_date date;
begin



  





 for cur in (SELECT 
trunc(to_date('30.10.2016','DD.MM.YYYY')-2)+LEVEL ddate 

FROM dual 
WHERE level between 1 and 241 CONNECT BY LEVEL < = 5)
loop
  
 for curr in 1..24
   loop

  i_date:=cur.ddate;
 --dbms_output.put_line (to_date(to_char(i_date,'DD.MM.YYYY'),'DD.MM.YYYY'));
 --to_date(to_char(sysdate,'DD.MM.YYYY'),'DD.MM.YYYY')
 
 
        insert into MH_TEST_CHARGE_05
        WITH Q1 AS (
      SELECT /*+ para llel(4) */ T.CHRG_ID, T.GG_OP_CMT_SCN,GG_OP_CODE
        FROM (SELECT LEAD(OB_ID) OVER(PARTITION BY GG_OP_CMT_SCN ORDER BY GG_SEQ_RBA) OB_ID_NEW,
                     LEAD(GG_OP_CODE) OVER(PARTITION BY GG_OP_CMT_SCN ORDER BY GG_SEQ_RBA) GG_OP_CODE_NEW,
                     C.CHRG_ID,
                     C.GG_OP_CMT_SCN,
                     C.OB_ID,
                     C.GG_OP_CODE,
                     C.GG_BEFORE_AFTER
                FROM STAGE05.CHARGE_S C
               WHERE 1 = 1
          AND GG_OP_CMT_TIME >=  i_date+curr/24 -- TO_DATE('01.10.2016 3:26:12', 'DD.MM.YYYY HH24:MI:SS') - 1 / (24 * 60) * 30
          AND GG_OP_CMT_TIME < i_date+(curr+1)/24 --TO_DATE('01.10.2016 3:26:12', 'DD.MM.YYYY HH24:MI:SS') + 1 / (24 * 60) * (360)--180
       --  and CHRG_ID = 6233975303
      /*    AND GG_OP_CMT_SCN > 2328345529816
          AND GG_OP_CMT_SCN < 2328358676479
          AND GG_OP_CMT_SCN < 2328358539202
      */    AND  CHRG_ID > 0
          
          AND GG_OP_CODE IN ('U', 'P')
        ORDER BY GG_OP_CMT_SCN, GG_SEQ_RBA)  T 
       WHERE T.GG_OP_CODE_NEW = 'U'
         AND T.GG_OP_CODE = 'U'
         AND T.GG_BEFORE_AFTER = 'B'
         AND T.OB_ID IS NULL
         AND T.OB_ID_NEW IS NOT NULL
      ),
      q2 as (
      select chrg_id ,GG_OP_CMT_SCN, GG_OP_CODE
      from  STAGE05.VW_CHARGE_S  c
      where 
      c.GG_OP_CMT_TIME >= i_date+curr/24 --TO_DATE('01.10.2016 3:26:12', 'DD.MM.YYYY HH24:MI:SS') - 1 / (24 * 60) * 30
          AND c.GG_OP_CMT_TIME <i_date+(curr+1)/24 -- TO_DATE('01.10.2016 3:26:12', 'DD.MM.YYYY HH24:MI:SS') + 1 / (24 * 60) * (360)--180
           AND
            (C.CHRG_ID, C.GG_OP_CMT_SCN)  IN (SELECT Q1.CHRG_ID, Q1.GG_OP_CMT_SCN FROM Q1)
          
      --group by chrg_id,GG_OP_CMT_SCN
      )
      select CASE WHEN chrg_id>=0 THEN chrg_id+300000000000 ELSE chrg_id END chrg_id, gg_op_code--count(distinct chrg_id)
       from q2 where  gg_op_code in ('I','D','P');
        
        commit;
        
        insert into MH_TEST_CHARGE_STATUS values('STAGE05',i_date+curr/24);
        commit;
        
        end loop;
end loop;  
end;
0
0
