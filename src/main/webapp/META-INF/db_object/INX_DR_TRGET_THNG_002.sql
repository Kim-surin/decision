-- Create/Recreate indexes
create index INX_DR_TRGET_THNG_002 on DRWBAK_REQSTDOC_TRGET_THNG (company_code, division_code, xport_sttemnt_no, lne_no, pouch_no);