USE BikeStores;
-- ============================================================
--  ASSIGNMENT 01 — Querying, Sorting & Filtering
--  Database : BikeStores
--  Topics   : SELECT, WHERE, ORDER BY, TOP/OFFSET-FETCH,
--             DISTINCT, AND / OR
-- ============================================================
SELECT 
	DISTINCT brand_id, model_year 
FROM Production.Products;

SELECT 
	TOP(10) * 
FROM Production.Products 
ORDER BY list_price DESC;

SELECT 
	* 
FROM Production.Products
WHERE list_price > 500 AND (model_year = 2016 OR model_year = 2017)
ORDER BY list_price DESC
OFFSET 10 ROWS
FETCH NEXT 50 ROWS ONLY;



-- ============================================================
--  Question 1 — SELECT & WHERE
--  Retrieve the first name, last name, city, and phone number
--  of all customers who live in the state of 'CA' (California)
--  and have a phone number on record.
-- ============================================================

-- Write your query below:
SELECT 
	 first_name
	,last_name
	,city
	,phone 
FROM Sales.Customers
WHERE state = 'CA' AND phone IS NOT NULL

-- ============================================================
--  Question 2 — ORDER BY (Multiple Columns)
--  Fetch the product_id, product_name, model_year, and
--  list_price of all products.
--  Sort the results by model_year in descending order, and
--  within the same year sort by list_price in ascending order.
-- ============================================================

-- Write your query below:

SELECT 
	* 
FROM Production.Products
ORDER BY model_year DESC, list_price 


-- ============================================================
--  Question 3 — TOP N & TOP PERCENT
--  a) Return the top 5 most expensive products showing only
--     product_name and list_price.
--  b) Return the top 5% of cheapest products (all columns).
--     How many rows does the 5% result return? Add the row
--     count as a comment in your answer.
-- ============================================================

-- Part a:
SELECT 
	TOP(5) * 
FROM Production.Products 
ORDER BY list_price DESC


-- Part b:
SELECT TOP(5) PERCENT * FROM Production.Products 
ORDER BY list_price


-- ============================================================
--  Question 4 — OFFSET & FETCH (Pagination)
--  The sales team wants to browse products page by page,
--  10 products per page, sorted by list_price descending.
--  Write queries to return:
--    a) Page 1  (rows  1 – 10)
--    b) Page 2  (rows 11 – 20)
--    c) Page 3  (rows 21 – 30)
-- ============================================================
DROP PROCEDURE #GetProductsPaged
CREATE PROCEDURE #GetProductsPaged
    @PageNumber INT,
    @PageSize INT
AS
BEGIN
    SELECT *
    FROM Production.Products
    ORDER BY list_price DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END;

-- Page 1:
EXEC #GetProductsPaged 1, 10;

-- Page 2:
EXEC #GetProductsPaged 2, 10;

-- Page 3:
EXEC #GetProductsPaged 2, 10;

-- ============================================================
--  Question 5 — DISTINCT
--  a) List all unique states in which BikeStores has customers.
--     Sort the result alphabetically.
--  b) List every unique combination of state and city,
--     sorted by state then city (both ascending).
--  c) How many unique model years exist in the products table?
--     (Retrieve the distinct values; count them manually or
--     use COUNT — your choice.)
-- ============================================================

-- Part a:
SELECT DISTINCT state
FROM Sales.Customers
ORDER BY state ASC;

-- Part b:
SELECT DISTINCT state, city
FROM Sales.Customers
ORDER BY state, city;

-- Part c:
SELECT DISTINCT model_year FROM Production.Products



-- ============================================================
--  Question 6 — Logical Operators (AND / OR)
--  Write a single query that returns the product_id,
--  product_name, brand_id, category_id, and list_price for
--  products that meet ALL of the following conditions:
--    • list_price is between $500 and $1500 (inclusive)
--    • model_year is 2019 OR 2020
--  Sort the results by list_price ascending.
--  Hint: use parentheses to control the order of evaluation.
-- ============================================================

-- Write your query below:
SELECT product_id, product_name, brand_id, category_id, list_price
FROM Production.Products
WHERE 
    list_price BETWEEN 500 AND 1500
    AND model_year IN (2019, 2020)
ORDER BY list_price 