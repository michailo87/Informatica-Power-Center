--create table MH_DIM_INDX2_3 as

select /*+ parallel(s 4) */s.owner,s.segment_name,round(sum(bytes)/1024/1024,2) ssize
from dba_segments s where s.tablespace_name='DIM_INDX2'
group by s.owner,s.segment_name
;

select * from MH_DIM_INDX2_3;

GRANT EXECUTE ON STAT.RS_P_NEW_LOCATION_CALC TO SHEPTULYA_AS;

select * from area_history;

select * from QUOTA_HISTORY;


select COLUMN_VALUE IPC_TABLE_NAME
                               from table(dwh.ipc_check_loading(trunc(sysdate)));
                               select * from MH_DIM_INDX2_2
                        ;       
                        select * from dba_objects o where o.OBJECT_NAME='IMEI_BLACKLIST$PK2';
                        
                        select * from dba_indexes i where i.INDEX_NAME='IMEI_BLACKLIST$PK2'
