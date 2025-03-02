-- USE clause
USE store;
-- SELECT clause for all columns
SELECT * FROM customers;
-- SELECT clause for showing specific fields
SELECT state FROM customers;
-- SELECT clause with AS (alias)
SELECT last_name,first_name,points,(points+10)*100 AS discount_factor FROM customers;
-- DISTINCT keyword
SELECT DISTINCT state
FROM customers;
-- practice
SELECT name,unit_price,(unit_price*1.1) AS "new price" FROM products;
-- WHERE clause
SELECT * from customers -- WHERE points>3000; -- WHERE state!='VA';
WHERE birth_date >'1990-01-01'; -- customers born after jan 1990
-- practice
SELECT * FROM orders WHERE order_date>='2019-01-01';
-- AND operator
SELECT * FROM customers WHERE birth_date>'1990-01-01' AND points>1000;
-- OR operator
SELECT * FROM customers WHERE birth_date>'1990-01-01' OR (points>1000 AND state='VA');
-- NOT operator
SELECT birth_date,points FROM customers WHERE NOT(birth_date>'1990-01-01' OR points>1000);
-- practice
SELECT * FROM order_items WHERE order_id=6 AND (quantity*unit_price)>30;
-- IN operator
SELECT * FROM customers WHERE state IN ('VA','GA','FL'); -- multiple OR conditions
SELECT * FROM customers WHERE state NOT IN ('VA','GA','FL');
-- practice
SELECT * FROM products WHERE quantity_in_stock IN (49,38,72);
-- BETWEEN operator
SELECT * FROM customers WHERE birth_date BETWEEN '1990-1-1' AND '2000-1-1';
-- LIKE operator
SELECT * FROM CUSTOMERS WHERE last_name LIKE 'b%'; -- starts with b
SELECT * FROM CUSTOMERS WHERE last_name LIKE '%y';-- ends with y
SELECT * FROM CUSTOMERS WHERE last_name LIKE '%a%'; -- contains a 
SELECT * FROM CUSTOMERS WHERE last_name LIKE '_____y';-- exactly 5 characters before y as end
SELECT * FROM CUSTOMERS WHERE last_name LIKE 'b____y';-- starts with b then 4 characters ends with y
-- practice
SELECT * FROM customers WHERE address LIKE '%TRAIL%' OR address LIKE '%AVENUE%';
SELECT * FROM customers where phone NOT LIKE '%9';

-- REGEXP operator (regular expression)
SELECT * FROM CUSTOMERS WHERE last_name REGEXP 'field'; -- contains field (same as %field%)
-- ^ for beginning 
-- $ for end 
-- | for OR
-- [abcd]
-- [a-f]
SELECT * FROM CUSTOMERS WHERE last_name REGEXP '^field';
SELECT * FROM CUSTOMERS WHERE last_name REGEXP 'field$';
SELECT * FROM CUSTOMERS WHERE last_name REGEXP 'field |mac|rose'; -- contains field or mac or rose
SELECT * FROM CUSTOMERS WHERE last_name REGEXP '^field |mac$|rose'; -- starts with field OR ends with mac or has rose
SELECT * FROM CUSTOMERS WHERE last_name REGEXP '[gim]e'; -- contains either g or i or m before e
SELECT * FROM CUSTOMERS WHERE last_name REGEXP '[a-h]e'; -- contains any one from a to h before e




