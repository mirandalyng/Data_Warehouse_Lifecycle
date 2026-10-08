USE ROLE USERADMIN; 

-- SETUP reporter USER 
-- jobads.marts  
CREATE USER IF NOT EXISTS reporter
    PASSWORD = 'Reporterpw123'
    DEFAULT_WAREHOUSE = dev_wh
    LOGIN_NAME = 'reporter'
    DEFAULT_NAMESPACE = 'job_ads.marts'
    COMMENT = 'reporter user for making analysis and BI'
    DEFAULT_ROLE = 'job_ads_reporter_role'; 


