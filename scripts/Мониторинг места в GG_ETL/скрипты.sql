CREate table MH_SUBPART as 
select sss.table_owner,sss.table_name,sss.partition_name,sss.subpartition_name from dba_tab_subpartitions sss where 
sss.table_owner='DWH_IPC' and sss.table_name=upper('IPC_CHARGE');

CREate table MH_PART as 
select s.owner, segment_name,s.partition_name, trunc(sum(s.BYTES/1024/1024)) nsize 
from dba_segments s 
where s.tablespace_name = 'GG_ETL' 
 and  segment_name = upper('IPC_CHARGE')  and s.owner='DWH_IPC'
group by s.owner, s.segment_name ,s.partition_name
order by 2 desc;




with q1 as (
select t.owner, t.segment_name,tt.partition_name,
 sum(nsize)
  from MH_PART t
 inner join MH_SUBPART tt
    on tt.subpartition_name = t.partition_name
   and tt.table_name = t.segment_name
   and t.owner = 'DWH_IPC'
   and tt.table_owner = 'DWH_IPC'

group by  t.owner, t.segment_name,tt.partition_name
having sum(nsize)>1000
)

select to_char(high_value)
 from dba_tab_partitions p  where p.table_owner='DWH_IPC'and p.table_name = 'IPC_CHARGE'
group by to_char(high_value);
select t.owner, t.segment_name,tt.partition_name,
 sum(nsize)
  from MH_PART t
 inner join MH_SUBPART tt
    on tt.subpartition_name = t.partition_name
   and tt.table_name = t.segment_name
   and t.owner = 'DWH_IPC'
   and tt.table_owner = 'DWH_IPC'

group by  t.owner, t.segment_name,tt.partition_name

;
SYS_SUBP2226084
;
select * from dba_tab_subpartitions  t  where t.table_name='IPC_CHARGE' and t.table_owner ='DWH_IPC'   and t.partition_name='SYS_P2226182'
;

select t.owner, t.segment_name,tt.partition_name,--tt.subpartition_name,
 sum(nsize)
  from MH_PART t
 inner join MH_SUBPART tt
    on tt.subpartition_name = t.partition_name
   and tt.table_name = t.segment_name
   and t.owner = 'DWH_IPC'
   and tt.table_owner = 'DWH_IPC'
  --and tt.partition_name='SYS_P2238351'

group by  t.owner, t.segment_name,tt.partition_name--,tt.subpartition_name
having sum(nsize)>1000;

select *--count(*) 
from DWH_IPC.ipc_charge --  partition (SYS_P2274411)
where branch_id=14 and charge_date;


select *--min(charge_date),max(charge_date)
 from DWH_IPC.ipc_charge  partition (SYS_P2278327)--1768279 SYS_P2278461 SYS_P2278327 SYS_P2277165
where branch_id=14
;
select * from   DWH_IPC.ipc_charge t where t.charge_date> to_date('14.03.2016 10:27:47','DD.MM.YYYY HH24:MI:SS') and branch_id=14
;
select * from branch where branch_id=14

