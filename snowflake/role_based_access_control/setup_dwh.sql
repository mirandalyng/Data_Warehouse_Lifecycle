-- set what role you want to use 
USE ROLE SYSADMIN;

SHOW WAREHOUSES; 

-- CREATE WAREHOUSE 
CREATE WAREHOUSE IF NOT EXISTS dev_wh
WITH 
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60 -- auto suspended after 60 seconds 
    AUTO_RESUME = TRUE -- to be able to auto_resume when it recievs a query 
    INITIALLY_SUSPENDED = TRUE -- that it's not active 
    COMMENT = "warehouse for development and analysis"; 

SHOW WAREHOUSES; 