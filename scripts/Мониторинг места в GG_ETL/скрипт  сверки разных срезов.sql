with q1 as
 (select owner, segment_name, sum(nsize)
    from GG_ETL_21_03_2016__11_27
   group by owner, segment_name
   order by 3 desc),
q2 as
 (
  
  select owner, segment_name, sum(nsize)
    from GG_ETL_14_03_2016_12_57
   group by owner, segment_name
   order by 3 desc
  
  )

select *
  from q1
  full outer join q2
    on q1.owner = q2.owner
   and q1.segment_name = q2.segment_name;

;
select * from user_tables t where t.table_name like '%GG_ETL%';
