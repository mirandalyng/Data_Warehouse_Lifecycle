-- GRANTING TO DIFFERNT USERS 

USE ROLE USERADMIN; 


-- create dbt role for job ads 
CREATE ROLE job_ads_dbt_role; 


GRANT ROLE job_ads_dbt_role TO USER transformer;


GRANT ROLE job_ads_dbt_role TO USER mirandalyng; 