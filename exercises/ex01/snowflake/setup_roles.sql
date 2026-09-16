CREATE ROLE IF NOT EXISTS marketing_dlt_role; 

USE ROLE SECURITYADMIN; 


-- grant role to warehouse to be able to run querys 
GRANT USAGE ON WAREHOUSE marketing_wh TO ROLE marketing_dlt_role;
-- grant usage to the database to the role 
GRANT USAGE ON DATABASE ifood TO ROLE marketing_dlt_role; 


-- GRANT USAGE TO STAGING SCHEMA TO MARKETING DLT ROLE 
GRANT USAGE ON SCHEMA ifood.STAGING TO ROLE marketing_dlt_role ;


-- schema: grant create table to role 
GRANT CREATE TABLE ON SCHEMA ifood.staging TO ROLE marketing_dlt_role; 

-- ASSIGN THE MARKETING - DLT ROLE TO USER EXTRACT and to myself  
GRANT ROLE marketing_dlt_role TO USER extract_loader; 
GRANT ROLE marketing_dlt_role TO USER mirandalyng; 






