USE ROLE USERADMIN; 
-- create roles 
CREATE ROLE IF NOT EXISTS movies_dlt_role; 
CREATE ROLE IF NOT EXISTS movies_reader_role;



-- TO BE ABLE TO GRANT USE SECURITY ADMIN 
USE ROLE SECURITYADMIN; 
GRANT ROLE movies_dlt_role TO USER extract_loader;


-- grant it to myself to be able to see in snowflake 
GRANT ROLE movies_reader_role TO USER mirandalyng;

-- GRANT USAGE 
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE movies_dlt_role; 
GRANT USAGE ON DATABASE movies TO ROLE movies_dlt_role; 
GRANT USAGE ON SCHEMA movies.staging TO ROLE movies_dlt_role; 

-- crud , grant previlige to role 
GRANT CREATE TABLE ON SCHEMA movies.staging TO ROLE movies_dlt_role; 
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA movies.staging TO ROLE movies_dlt_role; 
GRANT INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA movies.staging TO ROLE movies_dlt_role; 

 -- CHECK GRANTS 
 SHOW GRANTS ON SCHEMA movies.staging; 
 SHOW FUTURE GRANTS IN SCHEMA movies.staging; 
 SHOW GRANTS TO ROLE movies_dlt_role;
 SHOW GRANTS TO USER extract_loader;  



-- grant previlige to role 
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE movies_reader_role; 
GRANT USAGE ON DATABASE movies TO ROLE movies_reader_role; 
GRANT USAGE ON SCHEMA movies.staging TO ROLE movies_reader_role; 
GRANT SELECT ON ALL TABLES IN SCHEMA movies.staging TO ROLE movies_reader_role; 
GRANT SELECT ON FUTURE TABLES IN DATABASE movies TO ROLE movies_reader_role; 


