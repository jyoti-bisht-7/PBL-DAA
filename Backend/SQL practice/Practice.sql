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
-- practice
SELECT * FROM customers WHERE first_name REGEXP 'ELKA | AMBUR';
SELECT * FROM customers WHERE last_name REGEXP 'EY$ |ON$';
SELECT * FROM customers WHERE last_name REGEXP '^MY | SE';
SELECT * FROM customers WHERE last_name REGEXP 'b[ru]';

-- IS NULL operator 
SELECT * FROM customers WHERE phone IS NULL;
SELECT * FROM customers WHERE phone IS NOT NULL;

-- practice
SELECT * FROM orders WHERE shipper_id IS NULL;

-- ORDER BY
SELECT * FROM customers ORDER BY first_name;
SELECT * FROM customers ORDER BY first_name DESC;
SELECT first_name,last_name FROM customers ORDER BY state DESC,first_name;
SELECT first_name,last_name,10 AS points FROM customers ORDER BY points,first_name; -- valid in mysql
SELECT first_name,last_name,10 AS points FROM customers ORDER BY 1,2; -- using numbers instead of column names(not advised)

-- practice
SELECT * FROM order_items WHERE order_id=2 ORDER BY (quantity*unit_price) DESC;

-- LIMIT clause
SELECT * FROM customers LIMIT 3;-- displays only 3 records
SELECT * FROM customers LIMIT 3000;-- greater than number of records so displays all
SELECT * FROM customers LIMIT 6,3; -- skips the first 6 and displays next 3

-- practice
SELECT * FROM customers ORDER BY points DESC LIMIT 3; -- LIMIT always at end

-- INNER JOIN
SELECT order_id, first_name FROM orders 
JOIN customers ON orders.customer_id =customers.customer_id;
/*SELECT order_id,customer_id, first_name FROM orders 
JOIN customers ON orders.customer_id =customers.customer_id; -- ambiguity on customer_id */
SELECT order_id,orders.customer_id, first_name FROM orders 
JOIN customers ON orders.customer_id =customers.customer_id ;-- ambiguity solved
SELECT order_id,o.customer_id, first_name FROM orders o
JOIN customers c ON o.customer_id =c.customer_id; -- using alias

-- practice
SELECT order_id,p.product_id,name,o.quantity,o.unit_price FROM order_items o JOIN products p ON o.product_id=p.product_id;


