create table MH_DIM_DATA2 as

select /*+ paral lel(s 4) */s.owner,s.segment_name,round(sum(bytes)/1024/1024,2) ssize
from dba_segments s where s.tablespace_name='DIM_DATA2'
group by s.owner,s.segment_name
;

select * from PUDEYAN_MH.MH_DIM_DATA2 order by ssize desc for update;
alter table dwh.SUBS_LIST MOVE tablespace AGGREGATES_DATA

;  
print 2 ;

select case
         when t.comments = 'del' then
          'drop ' || s.segment_type || ' ' || t.owner || '.' ||
          t.segment_name || ' purge;'
         else
          case
            when t.comments = 'move' then
             case
               when segment_type in ('TABLE') then
                'alter  ' || segment_type || ' ' || t.owner || '.' ||
                t.segment_name || ' move tablespace;'
               else
                case
                  when segment_type in ('INDEX')
                  
                   then
                   'ALTER index ' || t.owner || '.' || t.segment_name ||
                   ' rebuild tablespace AGGREGATES_DATA parallel 4;'
                  else
                   'error;'
                end
             end
          
            else
             'error;'
          end
       end,
t.*, s.segment_type,s.tablespace_name
  from PUDEYAN_MH.MH_DIM_DATA2 t
 inner join dba_segments s
    on t.segment_name = s.segment_name
   and t.owner = s.owner
   where t.segment_name not in ('SUBS_LIST','SUBS_LIST_TMP') --and t.comments='move'
   --and s.tablespace_name='DIM_INDX2'
   ;

select * from PUDEYAN_MH.MH_DIM_DATA2_2 order by ssize desc;

