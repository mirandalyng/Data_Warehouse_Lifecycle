USE ROLE ICE_CREAM_WRITER; 
USE WAREHOUSE DEV_WH; 

USE SCHEMA ICE_CREAM_DB.PUBLIC; 


INSERT INTO flavors (flavor_name, price) VALUES
('Vanilla', 2.50),
('Chocolate', 2.75),
('Strawberry', 2.50),
('Mint Chocolate Chip', 3.00),
('Cookie Dough', 3.25);

INSERT INTO customers (customer_name, email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com'),
('Alice Johnson', 'alice.johnson@example.com');

INSERT INTO transactions (
    customer_id, flavor_id, quantity, transaction_date
) VALUES
(1, 1, 2, CURRENT_TIMESTAMP),
(2, 2, 1, CURRENT_TIMESTAMP),
(3, 3, 3, CURRENT_TIMESTAMP),
(1, 4, 1, CURRENT_TIMESTAMP),
(2, 5, 2, CURRENT_TIMESTAMP);

SELECT * FROM flavors;

-- change to ice_cream_reader and select data 
USE ROLE ice_cream_reader;
SELECT * FROM customers;

-- insufficient privilege for ice_Cream_reader to insert data
INSERT INTO customers (customer_name, email) VALUES
('John Doe2', 'john.doe@example.com');

-- VSC snowflake extension by default enables the use of secondary roles, so check below if there are any active secondary roles
SELECT CURRENT_SECONDARY_ROLES();

SELECT * FROM transactions;