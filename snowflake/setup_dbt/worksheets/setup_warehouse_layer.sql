USE ROLE SYSADMIN; 

-- use database
USE DATABASE job_ads; 

-- create schema warehouse
CREATE SCHEMA IF NOT EXISTS warehouse; 

SHOW SCHEMAS IN DATABASE job_ads; 

-- use role secirity admin to grant 
USE ROLE SECURITYADMIN; 

-- grant job ads dlt to dbt role 
-- because I want the dbt role to have access to staging 
-- for be able to select 

GRANT ROLE job_ads_dlt_role TO ROLE job_ads_dbt_role; 

SHOW GRANTS TO ROLE job_ads_dbt_role; 

-- GRANT USAGE 
GRANT USAGE, 
CREATE TABLE, 
CREATE VIEW ON SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; 


-- GRANT CRUD AND SELECT TABLES AND VIEWS 
GRANT 
SELECT, 
INSERT, 
UPDATE, 
DELETE ON ALL TABLES IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; 

GRANT SELECT ON ALL VIEWS IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; 

-- grant CRUD and select on future tables and views 
GRANT 
SELECT, 
INSERT, 
UPDATE, 
DELETE ON FUTURE TABLES IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; 

GRANT SELECT ON FUTURE VIEWS IN SCHEMA job_ads.warehouse TO ROLE job_ads_dbt_role; 

USE ROLE job_ads_dbt_role; 

USE WAREHOUSE DEV_WH; 

SELECT * FROM job_ads.staging.data_field_job_ads LIMIT 10; 

SHOW GRANTS ON SCHEMA job_ads.warehouse; 

USE SCHEMA job_ads.warehouse; 

CREATE TABLE test (id INTEGER);

SHOW TABLES;

DROP TABLE TEST;


