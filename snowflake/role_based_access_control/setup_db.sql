
-- SYSADMIN is responsible for creating warehouse and databases
USE ROLE SYSADMIN;

-- function to run current role 
SELECT current_role(); 

-- see seconday roles that are current 
-- I will be able to use the privilages on these as well 
SELECT CURRENT_SECONDARY_ROLES(); 

-- see currenct user 
SELECT CURRENT_USER(); 


-- create database 
CREATE DATABASE IF NOT EXISTS ICE_CREAM_DB; 

