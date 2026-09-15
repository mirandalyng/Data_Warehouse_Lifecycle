USE ROLE movies_reader_role; 

SHOW DATABASES; 

USE DATABASE movies; 

DESCRIBE DATABASE movies;


DESCRIBE SCHEMA staging;

DESC table staging.netflix; 



SELECT * FROM staging.netflix;  

SELECT COUNT(*) FROM STAGING.NETFLIX; 