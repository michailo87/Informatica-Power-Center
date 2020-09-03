select * from INFA_REP_X86_DWH_PROD.OPB_DTL_SWIDG_LOG t
where t.WORKFLOW_RUN_ID(


SELECT WORKFLOW_RUN_ID
                             FROM OPB_WFLOW_RUN
                            WHERE END_TIME <= :1
                              AND END_TIME IS NOT NULL
);

select * from dba_segments s where s.owner='INFA_REP_X86_DWH_PROD' and s.segment_name='OPB_DTL_SWIDG_LOG';


                             SELECT trunc(END_TIME),count(*)
                             FROM INFA_REP_X86_DWH_DEV.OPB_WFLOW_RUN
                             group by  trunc(END_TIME)
                         --   WHERE END_TIME <= :1
                           --   AND END_TIME IS NOT NULL
