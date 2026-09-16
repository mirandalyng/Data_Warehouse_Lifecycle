
USE ROLE SYSADMIN; 
--  warehouse setup 
-- a) Create a marketing virtual warehouse called marketing_wh with size xs, 1 min suspend time, it should autoresume, suspend initially and give it a suitable comment.
CREATE WAREHOUSE IF NOT EXISTS marketing_wh 
WITH 
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60 
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE 
    COMMENT = "warehouse for development and analyst in ex 01"; 

SHOW WAREHOUSES; 

