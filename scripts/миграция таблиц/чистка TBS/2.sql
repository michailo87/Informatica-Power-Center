create table MH_BERDB_ETL as

select /*+ parallel(s 4) */s.owner,s.segment_name,round(sum(bytes)/1024/1024,2) ssize
from dba_segments s where s.tablespace_name='BERDB_ETL'
group by s.owner,s.segment_name
;
select * from MH_BERDB_ETL order by ssize desc;
