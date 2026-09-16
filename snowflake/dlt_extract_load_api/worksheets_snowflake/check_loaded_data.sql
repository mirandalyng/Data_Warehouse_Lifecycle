USE ROLE job_ads_dlt_role;

USE DATABASE job_ads; 

SHOW SCHEMAS; 


SHOW TABLES IN SCHEMA STAGING;


DESC table staging.data_field_job_ads;

select headline, employer__workplace, description__text
from staging.data_field_job_ads;

select * from staging.data_field_job_ads 
where employer__workplace = 'ATG';