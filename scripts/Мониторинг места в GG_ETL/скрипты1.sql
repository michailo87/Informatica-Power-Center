select s.owner, segment_name,ss.partition_name, trunc(sum(s.BYTES/1024/1024)) nsize 
from dba_segments s inner join dba_tab_subpartitions ss on ss.table_owner='DWH_IPC' and ss.table_name=upper('IPC_CHARGE') and s.partition_name=ss.subpartition_name
where s.tablespace_name = 'GG_ETL' 
 and  segment_name = upper('IPC_CHARGE')  and s.owner='DWH_IPC'
group by s.owner, s.segment_name ,ss.partition_name
order by 2 desc;


--скрипт просмотра 1 партиции
--3255
select  sum (s.nsize)--/1024
from  dba_tab_subpartitions ss inner join GG_ETL_18_04_2016_11_02 s on s.owner='DWH_IPC' and s.segment_name ='IPC_CHARGE' and s.partition_name=ss.subpartition_name-- and s.tablespace_name='GG_ETL'
 where ss.table_name='IPC_CHARGE' and ss.table_owner='DWH_IPC' and ss.partition_name in (select t.partition_name from MH_TEST_CHARGE_PARTITION t)

--скрипт дл€ того чтобы вытащить партиции 1 мес€ца

declare
  d varchar2 (255);
  str varchar2(32000);
begin
  -- Test statements here
   for r in(select * from dba_tab_partitions p  where p.table_owner='DWH_IPC' and p.table_name=upper('IPC_CHARGE') 
             
             )
     loop
    if   r.high_value != 'MAXVALUE'   then 
     
     --  dbms_output.put_line(r.high_value);
   --    str := r.high_value;
       execute immediate 'select '||r.high_value||' from dual' into d;  
     --  dbms_output.put_line(d);   
      if d like  '%03.16' then
        dbms_output.put_line(r.partition_name||' | '||r.high_value);
        insert into MH_TEST_CHARGE_PARTITION
        values (r.partition_name,d);
        commit;
        
--         dbms_output.put_line(r.table_name || ' partition: ' || r.partition_name);
      --   FOR s in (select bytes/1024/1024 Mb, segment_name, partition_name from dba_segments@berdb1 where segment_name = r.table_name)
        --     loop
          --     dbms_output.put_line(r.table_name || ' partition: ' || r.partition_name || ', '||d||' , Mb: ' || s.Mb);
          --    end loop;
       end if;
      -- exit;
      
      
      end if;
     end loop;
--   return retp;
--  dbms_output.put_line(retp);
end;
