select * from stage02.pay_doc_s

ALTER TABLE PAY_DOC ADD (
  PAY_BRANCH_ID     NUMBER(4)
, PAY_PDOC_ID       NUMBER(10)
, PARENT_PDOC_ID    NUMBER(10)
);
create view stage04.vW_pay_doc_s as
select * from stage04.pay_doc_s

  
 grant select on  stage02.vW_pay_doc_s to user_from_dwh,gbc,informatica_ro;
 grant select on  stage04.vW_pay_doc_s to user_from_dwh,gbc,informatica_ro; 
 grant select on  stage04.vW_pay_doc_s to user_from_dwh,gbc,informatica_ro;
 
 
 grant select on  stage04.vW_pay_doc_s to user_from_dwh,gbc,informatica_ro;
 
 select * from  stage05.vW_pay_doc_s ;
 
 
 create or replace view stage05.vw_pay_doc_s as
select "PDOC_ID",
       "PAYDT_ID",
       "PT_ID",
       "PDOC_DATE",
       "SUMM_$",
       "VAT_$",
       "WOVAT_$",
       "NSP_$",
       "CRE_USER_ID",
       "CRE_DATE",
       "CURR_ID",
       "PDOC_NUM",
       "PREFIX",
       "PAYR_ID",
       "PLST_ID",
       "USED_PDOC_SUM",
       "PASSPORT",
       "CORRESP",
       "PDOC_COMMENT",
       "DEL_USER_ID",
       "DEL_DATE",
       "PAY_CLNT_ID",
       "PAY_SUBS_ID",
       "PAYER",
       "CHECK_NUM",
       "SUMM_R$",
       "VAT_R$",
       "WOVAT_R$",
       "NSP_R$",
       "RATE",
       "XCARD_ID",
       "OWNER_PDOC_ID",
       null "PAY_BRANCH_ID",
       null "PAY_PDOC_ID",
       null "PARENT_PDOC_ID",
       "GG_OP_CODE",
       "GG_OP_TIME",
       "GG_OP_CMT_SCN",
       "GG_OP_CMT_TIME",
       "GG_OP_SEQ",
       "GG_SEQ_RBA",
       "GG_BEFORE_AFTER"
  from stage05.pay_doc_s;
