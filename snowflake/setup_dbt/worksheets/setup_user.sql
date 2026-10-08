USE ROLE USERADMIN; 


-- creating user transformer
-- give it a password 
-- dev warehouse is default 
-- transformer to login 
-- job ads warehosue is default name space 
-- set default role to dbt role
CREATE USER IF NOT EXISTS transformer
    PASSWORD = 'Transformerpw123'
    DEFAULT_WAREHOUSE = dev_wh
    LOGIN_NAME = 'transformer'
    DEFAULT_NAMESPACE = 'job_ads.warehouse'
    COMMENT = 'dbt user for transforming data'
    DEFAULT_ROLE = 'job_ads_dbt_role'; 


