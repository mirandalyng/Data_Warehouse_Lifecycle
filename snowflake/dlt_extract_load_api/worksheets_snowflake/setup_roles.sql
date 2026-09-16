USE ROLE USERADMIN; 
-- create roles 
CREATE ROLE IF NOT EXISTS job_ads_dlt_role; 

USE ROLE SECURITYADMIN; 

GRANT ROLE job_ads_dlt_role TO USER extract_loader; 
GRANT ROLE job_ads_dlt_role TO USER mirandalyng; 


-- grant previliges to role job_ads_dlt_role 

GRANT USAGE ON WAREHOUSE dev_wh TO ROLE job_ads_dlt_role;

GRANT USAGE ON DATABASE job_ads TO ROLE job_ads_dlt_role; 

GRANT USAGE ON SCHEMA job_ads.staging TO ROLE job_ads_dlt_role; 

GRANT CREATE TABLE ON SCHEMA job_ads.staging TO ROLE job_ads_dlt_role; 


-- CRUD OPERATIONS 
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role; 
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role; 

SHOW GRANTS ON SCHEMA job_ads.staging; 

SHOW FUTURE GRANTS IN SCHEMA job_ads.staging; 
SHOW GRANTS TO ROLE job_ads_dlt_role; 
SHOW GRANTS TO user extract_loader; 

SHOW GRANTS TO user mirandalyng;

