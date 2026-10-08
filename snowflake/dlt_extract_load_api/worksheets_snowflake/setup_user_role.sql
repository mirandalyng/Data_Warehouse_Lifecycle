USE ROLE USERADMIN;



CREATE USER IF NOT EXISTS extract_loader
    PASSWORD = 'lyng12345' -- create a password and fill in here
    DEFAULT_WAREHOUSE = dev_wh;

