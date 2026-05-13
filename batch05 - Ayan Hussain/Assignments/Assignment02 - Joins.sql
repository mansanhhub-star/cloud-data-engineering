USE BikeStores

-- ============================================================
--  ASSIGNMENT 02 — Joins
--  Database : BikeStores
-- ============================================================


-- ============================================================
--  Question 1
--  Retrieve the product_name, list_price, and category_name
--  for every product.
--  Use production.products and production.categories.
--  Sort the results by product_name ascending.
-- ============================================================

-- Write your query below:
SELECT 
	 PP.product_name
	,PP.list_price
	,PC.category_name
FROM Production.Products AS PP
JOIN Production.Categories AS PC
ON PP.category_id = PC.category_id
ORDER BY PP.product_name





-- ============================================================
--  Question 2
--  Show the customer full name (as full_name), order_id,
--  and order_date for all customers who have placed an order.
--  Use sales.customers and sales.orders.
--  Sort by order_date descending.
-- ============================================================

-- Write your query below:
SELECT 
	 SC.first_name + ' ' + SC.last_name AS full_name
	,SO.order_id
	,SO.order_date
FROM Sales.Orders AS SO
JOIN Sales.Customers AS SC
	ON SO.customer_id = SC.customer_id
ORDER BY SO.order_date DESC;




-- ============================================================
--  Question 3
--  Retrieve product_name, list_price, category_name, and
--  brand_name for every product.
--  Use production.products, production.categories,
--  and production.brands.
--  Sort by brand_name then product_name (both ascending).
-- ============================================================

-- Write your query below:
SELECT 
	 PP.product_name
	,PP.list_price
	,PC.category_name
	,PB.brand_name
FROM Production.Products AS PP
JOIN Production.Categories AS PC
	ON PP.category_id = PC.category_id
JOIN Production.Brands AS PB
	ON PP.brand_id = PB.brand_id
ORDER BY PB.brand_name



-- ============================================================
--  Question 4
--  List all products along with their order_id and item_id.
--  Make sure products that have NEVER been ordered also appear
--  in the result (those rows will have NULL for order_id
--  and item_id).
--  Use production.products and sales.order_items.
--  Sort by order_id ascending.
-- ============================================================

-- Write your query below:

SELECT 
	 PP.product_id
	,PP.product_name
	,SOI.order_id
	,SOI.item_id 
FROM Production.Products AS PP
LEFT JOIN Sales.Order_items AS SOI
	ON PP.product_id = SOI.product_id
ORDER BY SOI.order_id

-- ============================================================
--  Question 5
--  Using your answer from Question 4 as a base, filter the
--  results to show ONLY the products that have never been
--  ordered.
--  Display only product_id and product_name.
-- ============================================================

-- Write your query below:

SELECT 
	 PP.product_id
	,PP.product_name
FROM Production.Products AS PP
LEFT JOIN Sales.Order_items AS SOI
	ON PP.product_id = SOI.product_id
WHERE SOI.order_id IS NULL


-- ============================================================
--  Question 6
--  Show all stores along with any orders placed at each store.
--  Display store_name, store_id (from stores), order_id,
--  and order_date.
--  Every store must appear in the result, even if it has
--  no orders yet.
--  Use sales.orders and sales.stores.
-- ============================================================

-- Write your query below:
SELECT 
	 SS.store_id
	,SS.store_name
	,SO.order_id
	,SO.order_date
FROM Sales.Orders AS SO
RIGHT JOIN Sales.Stores AS SS
	ON SO.store_id = SS.store_id
--INSERT INTO Sales.Stores VALUES ('Ahsan Store', '(92) 321-2827700', 'ahsan@gmail.com', 'Korangi', 'Karachi', 'Sindh', 74900)

-- ============================================================
--  Question 7
--  List every staff member alongside their manager's name.
--  Display:
--    • staff full name   (as staff_name)
--    • manager full name (as manager_name)
--  Use only the sales.staffs table.
--  Staff who have no manager should NOT appear in the result.
-- ============================================================

-- Write your query below:
SELECT 
	 SS.first_name + ' ' + SS.last_name AS staff_name
	,SM.first_name + ' ' + SM.last_name AS manager_name
FROM Sales.Staffs AS SS
JOIN Sales.Staffs AS SM
	ON SM.staff_id = SS.manager_id




-- ============================================================
--  Question 8
--  Generate every possible combination of store name and
--  brand name.
--  Display store_name and brand_name.
--  Use sales.stores and production.brands.
--  How many total rows do you expect?
--  Write the expected count as a comment next to your query.
-- ============================================================

-- Write your query below:
SELECT SS.store_name, PB.brand_name
	FROM Sales.Stores AS SS
	CROSS JOIN Production.Brands AS PB
-- Your ans is 27  3 * 9
-- because if created an extra record in store so mine is 36 4 * 9

-- ============================================================
--  Question 9
--  Retrieve the customer full name (as full_name), order_id,
--  order_date, product_name, and list_price for every order
--  that has been placed.
--  Use sales.customers, sales.orders, sales.order_items,
--  and production.products.
--  Sort by order_date ascending, then full_name ascending.
-- ============================================================

-- Write your query below:
SELECT 
	 SC.first_name + ' ' + SC.last_name AS full_name
	,SO.order_id
	,SO.order_date
	,PP.product_name
	,PP.list_price
FROM Sales.Orders AS SO
JOIN Sales.Customers AS SC
	ON SO.customer_id = SC.customer_id
JOIN Sales.Order_items AS SOI
	ON SO.order_id = SOI.order_id
JOIN Production.Products AS PP
	ON SOI.product_id = PP.product_id
ORDER BY SO.order_date