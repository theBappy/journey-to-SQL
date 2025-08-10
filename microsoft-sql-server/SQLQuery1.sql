-- SELECT (to select the col that we want to retrieve)
-- FROM (where to find the data: table name)
SELECT * FROM customers
SELECT first_name FROM customers
SELECT country FROM customers
SELECT
	country,
	score,
	first_name
FROM customers
--WEHRE (in order to filter data based on a condition)
--condition could be anyting 
SELECT * 
FROM customers
WHERE score > 500;
SELECT * 
FROM customers
WHERE country = 'UK';

SELECT * 
FROM customers
WHERE score != 0;

SELECT *
FROM customers
WHERE score < 500;

SELECT 
	first_name,
	country
FROM  customers
WHERE country = 'Germany'

-- Order By (Ascending lowest to highest value or Descending highest to lowest value)
SELECT *
FROM customers
ORDER BY score DESC;

SELECT *
FROM customers
ORDER BY score ASC;

-- Nested Sorting
SELECT *
FROM customers
ORDER BY 
country ASC,
score DESC

SELECT *
FROM customers
ORDER BY
country ASC,
score ASC

SELECT *
FROM customers
ORDER BY
first_name DESC,
country ASC,
score DESC

-- Group By (aggregate column by another column,combines rows with the same value)
SELECT 
	country AS customer_country,
	SUM(score) AS total_score
FROM customers
GROUP BY country

SELECT 
	country AS customer_country,
	sum(score) AS country_score
FROM customers
GROUP BY country

SELECT 
	country,
	SUM(score) AS total_score,
	COUNT(id) AS total_customer
FROM customers
GROUP BY country

-- HAVING (filters data but after the aggregation)
-- WHERE (it is used filtering the data before the aggregation)
SELECT
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country
HAVING SUM(SCORE) > 800

SELECT
	country,
	SUM(score)
FROM customers
WHERE score > 400
GROUP BY country
HAVING SUM(score) > 800

SELECT
	country,
	AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

-- DISTINCT(remove duplicates)
SELECT DISTINCT 
	country
FROM customers

-- TOP(Limit)
SELECT TOP 2
	first_name
FROM customers

SELECT TOP 3
	*
FROM customers

SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

SELECT TOP 2 first_name, score
FROM customers
ORDER BY score DESC;

SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;

SELECT *
FROM customers;

SELECT *
FROM orders;

-- static values
SELECT 123 AS static_number;

SELECT 'Hello World' AS static_string;

SELECT 
	id,
	first_name,
	'new customer' AS customer_type
FROM customers

SELECT *
FROM customers
WHERE country = 'Germany'

SELECT * FROM orders


-- Data definition language(DDL)
-- Create(define a table)
CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)
SELECT * FROM persons

-- ALTER (edit, change, definition of the table)
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

ALTER TABLE persons
ADD address VARCHAR(100) 

ALTER TABLE persons
DROP COLUMN phone 

ALTER TABLE persons
DROP COLUMN address

SELECT * FROM persons

ALTER TABLE persons
ADD phone VARCHAR(15) NOT NULL

ALTER TABLE persons
DROP COLUMN phone

-- DROP (remove the full table and the data inside it)
DROP TABLE persons

-- Date Manipulation Language(DML)
-- manipulate your date inside the table, to add data use command INSERT
-- number of columns and value must match
-- order of the cols that are defined must match the order of the value 
-- can insert multiple in one go
-- always list columns explicitly for clarity and manintaibility
INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6, 'Anna', 'USA', NULL),
	(7, 'Nate',  NULL, 100)

SELECT * FROM customers

INSERT INTO customers
VALUES (8, 'Max', 'Belgium', 220)

INSERT INTO customers (id, first_name)
VALUES (9, 'Jenny')

-- INSERT using SELECT
-- data from source table insert into target table 

INSERT INTO persons (id, person_name, birth_date, phone)

SELECT
	id,
	first_name,
	NULL,
	'Unknown'
FROM customers

SELECT * FROM customers

-- update (DML)
UPDATE customers
SET score = NULL
WHERE id = 6

UPDATE customers
SET country = 'Belgium'
WHERE id = 7

SELECT *
FROM customers
WHERE id = 9

UPDATE customers
SET country = 'UK',
    score = NULL
WHERE id = 9

SELECT * FROM customers

UPDATE customers
set score = 0
WHERE score IS NULL

UPDATE customers
set score = NULL
WHERE score = 0

UPDATE customers
set score = 0
WHERE score IS NULL

-- DELETE (delete row of the table)
DELETE FROM customers
where id > 5

SELECT * FROM persons

TRUNCATE TABLE persons

-- Intermediate level
-- operators
-- comparison (<, <=, != , = , <> , >=), logical(AND , OR, NOT), 
-- range operator(BETWEEN)
-- membership operator(IN, NOT IN)
-- search operator (LIKE)

-- comparison operator(compare two things)
-- condition -> [expression] [operator] [expression]
-- column = column
-- column = value (static or string value)
-- function = value eg. [UPPER(first_name)='JOHN']
-- expression = value (price * quantity = 1000)
-- subquery = value 

SELECT * FROM customers
WHERE country = 'Germany' AND score > 400

SELECT * FROM customers
WHERE country <> 'Germany'

SELECT * FROM customers
WHERE score > 500

SELECT * FROM customers
WHERE score >= 500

SELECT * FROM customers
WHERE score < 500

SELECT * FROM customers
WHERE score <= 500
ORDER BY score DESC

-- logical operator(AND, OR, NOT)
SELECT * FROM customers
WHERE country = 'USA' AND score > 500

SELECT * FROM customers
WHERE country = 'USA' AND score < 500

SELECT * FROM customers
WHERE country = 'USA' OR score > 500

SELECT * FROM customers
WHERE NOT score < 500

SELECT * FROM customers
WHERE score >= 500

SELECT * FROM customers
WHERE NOT id = 3

-- range operator (BETWEEN) -> check if the value falls with a specific range or outside the range
-- need lower boundary + upper boundary
-- everything in the boundary will be True, outside of the boundary evaluate as False
-- boundary is inclusive
SELECT * FROM customers
WHERE score BETWEEN 100 AND 500

SELECT * FROM customers
WHERE score BETWEEN 500 AND 800

SELECT * FROM customers
WHERE score >= 100 AND score <= 500

-- Membership operator
-- IN, NOT IN
SELECT * FROM customers
WHERE country = 'Germany' OR country='USA'

SELECT * FROM customers
WHERE country IN ('Germany', 'UK')

SELECT * FROM customers
WHERE country IN ('Germany', 'USA')

SELECT * FROM customers
WHERE country NOT IN ('USA', 'UK')

-- Search Operator
-- LIKE
-- search for a pattern in a text
-- % = anything
-- _ =  exactly one char
SELECT * FROM customers
WHERE first_name LIKE 'M%'

SELECT * FROM customers
WHERE first_name LIKE 'A%'

SELECT * FROM customers
WHERE first_name LIKE 'MART%'

SELECT * FROM customers
WHERE first_name LIKE '%n'

SELECT * FROM customers
WHERE first_name LIKE '%a'

SELECT * FROM customers
WHERE first_name LIKE '%TIN'

SELECT * FROM customers
WHERE country LIKE 'Ger%'

SELECT * FROM customers
WHERE first_name LIKE '%r%'

SELECT * FROM customers
WHERE first_name LIKE '%t%'

SELECT * FROM customers
WHERE first_name LIKE '__r%'

SELECT * FROM customers
WHERE first_name LIKE '%t__'

-- SQL joins
-- for recombining data (one table customer, another address, another order -> to recombine them we need JOIN)
-- data enrichment 'getting extra data' by reference table or lookup table
-- check existence for the data 'filtering'

-- combines columns using JOIN
-- comining rows SET Operator in a stack form

-- JOIN
-- to use JOIN have to define Key -> columns
-- 4 type
-- 1. INNER JOIN 2. FULL JOIN 3. LEFT JOIN 4. RIGHT JOIN

-- Set Operator
-- 4 type
--  1. UNION 2. UNION ALL 3. EXCEPT 4. INTERSECT
-- for set operator should have exact same number of columns

-- 1. NO JOIN (return data without combining theme, want data from 2 tables)
-- no result, no need to combine them
SELECT * FROM customers
SELECT * FROM orders

-- INNER JOIN(combine data from 2 tables)
-- return only the matching data (common data)
-- order doesn't matter(both table has same priority)
-- big picture and check existing of data
-- table A has the match data with table B and table has the match data from table A
SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id

SELECT * FROM orders
INNER JOIN customers
on orders.customer_id = customers.id

SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- LEFT JOIN
-- returs all rows from left table and only maching from right table
-- main source - left table
-- order of the table is very important
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- RIGHT JOIN
-- return all rows from right table and only matching data from left table
-- main source - right table
-- order of the data is important
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS O
LEFT JOIN customers AS c
ON o.customer_id = c.id

-- FULL JOIN
-- all rows from both table
-- matcing - unmatching all data
-- order of the important is not important
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id

-- Advacne SQL joins
-- LEFT ANTI JOIN
-- return row from left table that has no match in the right table
-- only unmatching rows from table A
-- order is important
-- 2 step
-- first classical left join in two table
-- then use where clause for null key
-- for checking the existence of data
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id is NULL

-- RIGHT ANTI JOIN
-- return rows from right table that has no match with left table
-- unmatching rows from right table
-- left table as a filter
-- order is the table is impportant
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

SELECT *
FROM orders AS o
LEFT JOIN customers AS c
on c.id = o.customer_id
WHERE c.id is NULL

-- FULL ANTI JOIN
-- return only the rows that don't match in either table
-- unmatching data from table A and unmatching data from table B
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

-- CROSS JOIN
-- every row from left table and every row from right table
-- all possible combination - Cartesian Join
-- combinations or total rows = left[row] * right[row] => 2 * 3 => 6
SELECT *
FROM customers
CROSS JOIN orders

-- multiple table data combining
USE SalesDB

SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.Product AS ProductName,
	p.Price, 
	e.FirstName AS SalesPersonFirstName,
	e.LastName AS SalesPersonLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees As e
On o.SalesPersonID = e.EmployeeID

SELECT * FROM Sales.Customers
SELECT * FROM Sales.Employees
SELECT * FROM Sales.Orders
SELECT * FROM Sales.OrdersArchive
SELECT * FROM Sales.Products

--Set Operators
-- set operators can be used almost in all clauses where | join | group by | having
-- Rule
-- 1) ORDER BY can be used only once
-- 2) Same number of columns
-- 3) Matching Data types
-- 4) Same order of cols
-- 5) First query controls aliases
-- 6) Mapping correct cols
SELECT 
	FirstName,
	LastName 
FROM Sales.Customers

UNION

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- UNION
-- return all distinct rows from both queries
-- removes duplicate rows from the result
-- all rows from both tables
-- the order of queries in a UNION operation does not affect the result 

SELECT 
	FirstName,
	LastName
FROM Sales.Cus
UNION
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- UNION ALL
-- return all rows from both table also includes duplicates
SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

-- EXCEPT(minus) ***table A - table B = result remaining A***
-- returns a distinct rows from the first query that are not found in the second query
-- order of the queries affect the result

SELECT 
	FirstName,
	LastName
FROM Sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- INTERSECT
-- return only row that are common in both queries 
-- also remove duplicates
-- common info between two tables
-- order of the query doesn't matter
SELECT
	FirstName,
	LastName
FROM  Sales.Employees
INTERSECT
SELECT 
	FirstName,
	LastName
FROM Sales.Customers

-- Use cases of Set Operators
-- combine information
SELECT
'Orders' AS SourceTable,
	   [OrderID]
	  ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders

UNION

SELECT 
'OrdersArchive' AS SourceTable,
	   [OrderID]
	  ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID

-- Delta Detection by EXCEPT (minus)
-- current data with previous load
-- source system and data warehouse delta detection
-- compare the data with previous load and insert new data into the warehouse
-- data completeness test checking by EXCEPT (to detect discrepencies between databases)


----------
-- SQL Functions
----------
-- transfer, clean, manipulate, analyze by function
-- Function: build in code-blocks that accepts an input value, process it and returns an output value
-- Single-Row Functions eg: LOWER()
-- Multi-Row Functions eg: SUM of some values
-- Nested Functions
-- LEN(LOWER(LEFT('Maria',2)) -- (third(second(first))) functions
-- Types of SQL Functions


-- Single Row Functions
-- 1) String Func.
-- CONCAT
-- combines multiple string value into one
SELECT  
	first_name,
	country,
	CONCAT(first_name, '-' ,country) AS name_country
FROM customers
-- UPPER & LOWER
SELECT
	first_name,
	LOWER(first_name) AS lower_case_name
FROM customers

SELECT 
	first_name,
	UPPER(first_name)
FROM customers

SELECT
	LOWER(first_name)
FROM customers

SELECT 
	UPPER(first_name) AS up_name
FROM customers

-- TRIM
-- remove leading and trailing spaces
SELECT
	first_name
FROM customers
WHERE first_name != TRIM(first_name)

SELECT
	first_name,
	LEN(first_name) AS len_name,
	(LEN(TRIM(first_name))) AS trimmed_len,
	LEN(first_name) - (LEN(TRIM(first_name))) AS flag
FROM customers


-- REPLACE
-- replace a specific char with a new char
-- can also be used in order to remove something
SELECT
'123-456-789' AS PHONE,
REPLACE('123-456-789', '-', '') AS DIGIT

SELECT
'report.txt',
REPLACE('report.txt', '.txt', '.csv')

SELECT 
'report.txt' AS old_file_name,
REPLACE('report.txt', 'report', 'new_report') AS new_file_name 

-- Calculation
-- LEN
SELECT 
LEN('kjfkdjflkdsf')

SELECT
	LEN(first_name) len_name
FROM customers

-- String Extraction
-- LEFT: extract specific number of char from the start of a string value
-- RIHGT: extract from end of the string value
-- LEFT(value, number of char to char)
SELECT
	LEFT(first_name, 2)
FROM customers

SELECT  
	RIGHT(first_name, 3)
FROM customers

SELECT 
	first_name,
	(LEFT(TRIM(first_name), 2)) AS first_2_char
FROM customers


-- SUBSTRING(value, start, length)
-- extract a part of the string at specified position
SELECT 
	first_name,
	SUBSTRING(first_name, 3, 2) as part_name
FROM customers

SELECT
	first_name,
	SUBSTRING(TRIM(first_name), 1, (1- LEN(first_name)) AS result_name
FROM customers

SELECT
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name
FROM customers

-- Number Functions
SELECT 3.516,
ROUND(3.516, 0) AS round_2

-- ABS
SELECT -10,
	ABS(-10)

-- Date & Time Functions
-- Timestamp(Datetime)
SELECT
	OrderID,
	CreationTime,
	'2020-08-10' AS hard_coded_date,
	GETDATE() AS today
FROM Sales.Orders

-- GETDATE()
-- return current date and time at the momeny the query is executed
-- manipulation of Date & Time
-- validation, part extraction, formatting, calculations

-- 4 types of Date & Time Functionality
-- Part Extraction
-- Format & Casting
-- Calculations
-- Validation


-- Part Extraction 
-- DAY(date)
-- MONTH(date)
-- YEAR(date)
SELECT
	OrderID,
	CreationTime,
	YEAR(CreationTime) AS Year,
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day
FROM Sales.Orders

-- DATEPART(part, date)
-- part wants to extract
-- DATEPART(mm, '2025-01-01')
-- DATEPART(month, OrderDate')
-- returns a specific part of the date
-- output is always a integer
SELECT
	OrderID,
	CreationTime,
	DATETRUNC(YEAR,CreationTime) as trunced_year,
	DATETRUNC(MONTH,CreationTime) as trunced_min,
	DATETRUNC(MINUTE,CreationTime) as trunced_min,
	DATETRUNC(hour,CreationTime) as trunced_min,
	DATETRUNC(day,CreationTime) as trunced_min,
	DATENAME(month, CreationTime) as month_dn, 
	DATENAME(WEEKDAY, CreationTime) as month_wk,
	DATENAME(day, CreationTime) as month_wk, 
	DATEPART(year, CreationTime) as  parted_year,
	DATEPART(month, CreationTime) as parted_month,
	DATEPART(day, CreationTime) as parted_day,
	DATEPART(hour, CreationTime) as parted_hour,
	DATEPART(quarter, CreationTime) as quarter,
	DATEPART(weekday, CreationTime) as weekday,
	DATEPART(week, CreationTime) as week_no
FROM Sales.Orders

-- DATENAME(part, date)
-- returns name of the date part
-- output is string
-- DATETRUNC(part, date)
-- reseting the part

SELECT
	DATETRUNC(year, CreationTime) as monthly,
	COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime) 

-- EOMONTH(date)
-- end of the month
-- returns last day of the month
SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) endOfMonth,
-- first day of the month
CAST(DATETRUNC(month, CreationTime)AS DATE) startOfMonth
FROM Sales.Orders

-- Date Aggregation why needs?
-- data aggegating and reporting, show sales by year or month
-- sales by quarted
-- sales by month
-- sales by week
SELECT
	YEAR(OrderDate),
	COUNT(*) num_of_orders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

SELECT
	DATENAME(month, OrderDate),
	COUNT(*) num_of_orders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

SELECT 
*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2

SELECT * FROM Sales.Orders
WHERE MONTH(OrderDate) = 1

-- output data type
-- DAY, MONTH, YEAR, DATEPART => INTEGER
-- DATENAME => STRING
-- DATERUNC => DATETIME
-- EOMONTH => DATE

----------
-- Format & Casting
----------
-- yyyy-MM-dd HH:mm:ss
-- Date time format representation
-- International Standart (ISO 8601)
-- yy-MM-dd
-- USA standard
-- MM-dd-yyyy
-- European standard
-- dd-MM-yyyy
-- Formatting(changing the format of a value from one to another)
-- FORMAT, CONVERT
-- CASTING(change the data type from one to another)
-- CAST

-- FORMAT(value, format, [,culture])
-- Formats a date and time value

SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'dd') AS dd
FROM Sales.Orders

SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'ddd') AS ddd
FROM Sales.Orders

SELECT 
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'mm') as Month
FROM Sales.Orders

SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'dddd') AS dddd
FROM Sales.Orders

SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'MM') as MM,
	FORMAT(CreationTime, 'MMM') as MMM,
	FORMAT(CreationTime, 'MMMM') as MMMM
FROM Sales.Orders

SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'dd-MM-yyyy') as standard_format,
	FORMAT(CreationTime, 'MM-dd-yyyy') as USA_FORMAT
FROM Sales.Orders

SELECT
	OrderID,
	CreationTime,
	'Day ' + FORMAT(CreationTime, 'ddd MMM') 
	+ ' Q' + DATENAME(QUARTER, CreationTime) + ' ' +  
	FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS custom_format
FROM Sales.Orders

-- Data aggregations(format the date before doing aggregations)
SELECT
	FORMAT(OrderDate, 'MMM yy') AS OrderDate,
	COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')

-- Format use case
-- Data Standardization

---------------
-- CONVERT(date_type, value, [,style])
-- Change the value to a different type
---------------
SELECT
	CONVERT(INT, '123') AS [string_to_integer]
SELECT 
    CONVERT(DATE, '2025-02-02')

SELECT 
	CREATIONTIME,
	CONVERT(DATE, CreationTime)  AS [DateTime to Date Convert],
	CONVERT(VARCHAR, CreationTime, 32) AS usa_st_with_32,
	CONVERT(VARCHAR, CreationTime, 34) AS Europe_Standard
FROM Sales.Orders

-- CAST(value AS data_type)
-- convert a value to different data type
SELECT
	CAST('123' AS INT),
	CAST(123 AS VARCHAR),
	CAST('2020-02-02' AS DATE) 
SELECT
	CAST('2020-02-02' AS DATE),
	CAST('2020-02-02' AS datetime2),
	CreationTime,
	CAST(CreationTime AS DATE)
FROM Sales.Orders

-- FORMAT VS CAST VS CONVERT
-- CAST any type to any type
-- CONVERT any type to anythype
-- FORMAT any type to only string


----------
-- Calculations
----------
-- DATEADD(part, interval, date)
-- DATEADD adds or substract a specific time interval to/from a date
SELECT	
	OrderID,
	OrderDate,
	DATEADD(year, 2, OrderDate) AS added_2_year,
	DATEADD(year, -2, OrderDate) AS subtracted_2_year,
	DATEADD(month, 3, OrderDate) AS added_3_month,
	DATEADD(day, -10, OrderDate) AS subtracted_10_days
FROM Sales.Orders


-- DATEDIFF(part, start_date, end_date)
-- DATEDIFF(day, OrderDate, ShipDate)
-- find the diffences between two dates
SELECT
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) AS Age
FROM Sales.Employees

SELECT
	MONTH(OrderDate),
	AVG(DATEDIFF(day, OrderDate, ShipDate)) AS avg_shipping_day
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- LAG() [in order to access value from the previous row]
SELECT
	OrderID,
	OrderDate AS CurrentOrderDate,
	LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate,
	DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) as difference
FROM Sales.Orders

-- Date Validation
-- ISDATE(value)
-- whether is value is a date return 1 else 0
SELECT ISDATE('123')
SELECT ISDATE(2020)
SELECT ISDATE('2020-02-02')
SELECT ISDATE('20-08-2025')
SELECT ISDATE('2024')
SELECT ISDATE('08')

SELECT 
	OrderDate,
	ISDATE(OrderDate) AS IsValidDate,
	CASE 
		WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate as DATE)
			-- ELSE '9999-01-01'
		ELSE NULL
	END AS NewOrderDate
FROM (
	SELECT '2020-02-02' AS OrderDate
	UNION
	SELECT '2020-05-05'
	UNION
	SELECT '2020-08-08'
	UNION
	SELECT '2020-09'
) AS Orders;
-- WHERE ISDATE(OrderDate) = 0

-------------
-- NULL FUNCTIONS
-------------
-- null means nothing, unknown

-- null to value
-- ISNULL
-- COALESCE

-- value to null
-- NULLIF

-- check if we have a null value
-- IS NULL
-- IS NOT NULL


-- ISNULL(value, replacement_value)
-- eg:- ISNULL(Shipping_Address, 'unknown')
-- replace a 'null' with a specific value
-- only 2 values
-- faster than COALESCE

-- COALESCE(value1, value2, value3, ...)
-- return first non-null value from a list
-- for multiple values

-- usecase: Handle null before Data 

SELECT
	CustomerID,
	Score,
	COALESCE(score, 0) Score2,
	AVG(Score) OVER () AS AvgScores,
	AVG(COALESCE(Score,0)) OVER () 
FROM Sales.Customers

-- Mathematical operations
-- NULL + 5 => NULL
-- NULL + `B` => NULL
SELECT
	CustomerID,
	FirstName,
	LastName,
	FirstName + COALESCE(LastName, '') AS FullName,
	Score,
	COALESCE(Score, 0) + 10 AS with_bonus
FROM Sales.Customers

-- JOINS
-- handle the null before doing join
-- NULL = NULL (sql can not compare null values, can loose data with NULL)
-- handle null before sorting data
SELECT 
	CustomerID,
	Score,
	COALESCE(Score, 9999999)
FROM Sales.Customers
ORDER BY COALESCE(Score, 9999999) 


SELECT
	CustomerID,
	Score,
	CASE WHEN Score IS NULL THEN 1 ELSE 0 END
FROM Sales.Customers
ORDER BY COALESCE(Score, 99999)\

SELECT 
	CustomerID,
	Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

SELECT 
	CustomerID,
	Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score

SELECT 
	CustomerID,
	Score
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score -- by flag(forcing)


--------
-- NULLIF(value1, value2)
-- NULLIF(Shipping_Address, 'unknwon')
-- NULLIF(Shipping_Address, Billing_Address)
-- compares two expressions returns
-- NULL if they are equal
-- otherwise First Value(if they are not equal)
-- NULLIF(price, -1) will make the -1 price to NULL
-- use-case : preventing the error of dividing bv zero
SELECT
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity, 0) As Price
FROM Sales.Orders

----------
-- VALUE IS NULL
-- VALUE IS NOT NULL
-- searching for missing info or clean-up data by removing null
SELECT
	*
FROM Sales.Customers
WHERE Score IS NOT NULL

-- use-case: helps to define ANTI-JOIN

SELECT
	c.*,
	o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL

-- NULL VS EMPTY VS SPACE   
-- null means nothing/unknown - special marker - fasted between three
-- empty string - i know the value it is nothing, string value has zero character - string type - size(0)
-- space - string - it is a string but size not zero like empty string 

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4, ' ' 
)

SELECT 
	*, 
	TRIM(Category) Policy1,
	NULLIF(TRIM(Category), '') Policy2,
	COALESCE(NULLIF(TRIM(Category), ''), 'unknown') Policy3
FROM Orders



--------------
-- CASE STATEMENT 
--------------
-- evaluates a list of conditions and returns a values when the first conditions is met
-- use-cases: 10 categorizing data
-- main purpose is data transformation
-- derive new info columns based on existing data
-- CATEGORIZING DATA
SELECT
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END  Category
FROM Sales.Orders

SELECT 
	Category,
	SUM(Sales) AS TotalSales
FROM(
SELECT 
	OrderID,
	Sales,
	CASE 
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END AS Category
FROM Sales.Orders
) AS Categorization
GROUP  BY Category 
ORDER BY  TotalSales DESC
-- Data type of the result must be matching in case statement
-- Mapping Values
-- transfrom data from one from to another to make it more readable 

SELECT
	EmployeeID,
	FirstName,
	LastName,
	Gender,
	CASE
		WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
		ELSE 'N/A'
	END AS Gender
FROM Sales.Employees

SELECT
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA' THEN 'US'
		ELSE 'n/a'
	END AS CountryAbbreviation
FROM Sales.Customers

SELECT DISTINCT Country
FROM Sales.Customers;

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE Country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
		ELSE 'n/a'
	END AS AbbreCountry
FROM Sales.Customers

-- Handling Nulls
-- replace nulls with a value
-- using a window function
SELECT
	CustomerID,
	LastName,
	Score,
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END AS ScoreClean,
AVG(
	CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END
	) 
	OVER() AS Final_Clean,
	AVG(Score) OVER () AS AvgCustomer
FROM Sales.Customers

-- Conditional Aggregation
-- subsets of data that meets specific conditions
SELECT
	CustomerID,
	SUM(CASE
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) AS TotalOrdersHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

-- Use-case of Case Statement
-- 1) Categorizing Data
-- 2) Mapping Values
-- 3) Handling NULLS
-- 4) Conditional Aggregations

--------------
-- Aggregate Functions
--------------
-- COUNT(*) => count the number of rows
-- SUM() 
-- AVG()
-- MAX()
-- MIN()
SELECT
	customer_id,
	COUNT(*) AS total_orders,
	SUM(sales) AS total_sales,
	AVG(sales) AS avg_sales,
	MAX(sales) AS max_sales,
	MIN(sales) AS min_sales
FROM orders
ORDER BY customer_id

-- Window Basics(analytical function)
-- allows calculations on specific subset od data, without loosing level of details of the rows
-- Window VS Group By
USE SalesDB

SELECT 
	SUM(Sales) AS total_sales
FROM Sales.Orders

SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSalesByProduct
FROM Sales.Orders

-- Window Syntax
-- first part window function and second part partition clause, order clause, frame claue
-- Function Expression: arguments you pass to a function(parameter)
-- Define the window by OVER clause
-- PARTITION BY: divide the datasets into window, make partition
-- PARTITION BY: divides the rows into groups, based on the columns

SELECT
	OrderID,
	OrderDate,
	SUM(Sales) OVER() AS TotalSales
FROM Sales.Orders

SELECT
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	Sales,
	SUM(SALES) OVER() AS TotalSalesByOrder,
	SUM(Sales) OVER(PARTITION BY ProductID) AS TotalSalesByProductID,
	SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS SalesByPrductAndStatus
FROM Sales.Orders

-- Window Functions: ORDER BY
-- order: sort data within the window
SELECT
	OrderID,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders

-- WINDOW FRAME
-- ROWS UNBOUNDED PRECIDING
-- defines a subset of rows within each window that is relevant for the calculation
-- window inside a window
-- ORDER BY must be exist
-- lower boundary must before the higher boundary
SELECT
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	SUM(Sales) OVER (PARTITION BY OrderStatus ORDER BY OrderDate 
	ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales
FROM Sales.Orders

-- Rules
-- now allow to do while using window function
-- window function only in SELECT and ORDER BY
-- nesting window fucntions is not allowed
-- window function will execure after WHERE clause
-- first filtering and the aggregation
-- window can be used together with GROUP BY clause in the same query, only if the same columns are used
SELECT
	OrderID,
	OrderStatus,
	OrderDate,
	ProductID,
	Sales,
	SUM(Sales) OVER(PARTITION BY OrderStatus) AS Total_Sales
FROM Sales.Orders
WHERE ProductID IN(101, 102)

SELECT
	CustomerID,
	SUM(Sales) AS TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID

-- Aggregate window functions
-- COUNT() => all data types
-- returns the number of rows within a window
SELECT
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER() AS TotalOrders,
	COUNT(*) OVER(PARTITION BY CustomerID) AS OrderByCustomers
FROM Sales.Orders

SELECT
	*,
	COUNT(*) OVER() TotalCustomersWithStar,
	COUNT(1) OVER() TotalCustomersWithOne,
	COUNT(Score) OVER() TotalScores
FROM Sales.Customers

-- use-case: for cleanup by detecting null value
-- duplicates leads to inaccuracies in analysis
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.Orders

SELECT
*
FROM 
	(SELECT
	 OrderID,
	 COUNT(*) OVER(PARTITION BY OrderID) CheckPK
	FROM Sales.OrdersArchive
) t WHERE CheckPK > 1

-- overall analysis
-- category analysis
-- quality checks: identify nulls
-- quality checks: identify duplicates

-- SUM() => data type only integer(numeric values)
-- sum of all values withing a window
SELECT 
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS SalesByProduct
FROM Sales.Orders

-- comparison analysis
-- "part to whole" analysis
-- shows the contribution of each data point to the overall dataset
SELECT
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS TotalSales,
	ROUND(CAST(Sales AS float) / SUM(Sales) OVER() * 100, 2) AS PercentagetOfTotal
FROM Sales.Orders

-- AVG()
-- NULL will be ignored
SELECT 
	OrderID,
	OrderDate,
	Sales,
	ProductID,
	AVG(Sales) OVER() AS AvgSales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS AvgSalesByProduct
FROM Sales.Orders

-- if NULL = 0
SELECT
	CustomerID,
	LastName,
	Score,
	COALESCE(Score, 0) AS CustomerScore,
	AVG(Score) OVER() AvgScore,
	AVG(COALESCE(Score, 0)) OVER() FinalAvgScore
FROM Sales.Customers

SELECT *
FROM 
	(SELECT
		OrderID,
		ProductID,
		Sales,
		AVG(Sales) OVER() AvgSales
	FROM Sales.Orders)t
WHERE Sales > AvgSales

-- MIN(), MAX()
-- lowest value within a window, highest value within a window
-- NULL will be ignored
SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	MAX(Sales) OVER(PARTITION BY ProductID) AS HigestSalesByProduct,
	MIN(Sales) OVER(PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders

SELECT * FROM
(
SELECT
	*,
	MAX(Salary) OVER() AS HigestSalary
	FROM Sales.Employees
)t WHERE Salary = HigestSalary

SELECT
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() AS HighestSales,
	MIN(Sales) OVER() AS LowestSales,
	Sales - MIN(Sales) OVER() AS DeviationFromMin,
	MAX(Sales) OVER() - Sales AS DeviationFromMax
FROM Sales.Orders

-- Running & Rolling/Shifting Window Total

-- Running Total: Aggregate all values from the beginning up to the current point without dropping off older data
-- Rolling Total: Aggregate all values within a fixed time window eg- 30 days, as new data is added, the oldest data will be dropped
-- aggregate a sequence of number, the aggregation is updated each time a new member is add
-- analysis over time
-- Tracking: Tracking Current Sales with Target Sales
-- Trend Analysis: Providing insights into historical pattrens

-- Moving Average: very similar to the running total
SELECT
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS AvgByProduct,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) As MovingAvg,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAVG
FROM Sales.Orders


-- WINDOW RANKING FUNCTIONS
-- RANK() => expression must be empty, ORDER BY is required
-- only NTILE(6) => accepts a number
-- sorts the data first
-- Two method => 1. Integer based ranking(discrete value) 
--				 2. Percentage based ranking(scale from 0 to 1-normalized scale/continuous values)

-- ROW_NUMBER()
-- first sort the data
-- asign each row a unique number to a row, it doesn't handle ties or draw
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS rank_by_sales
FROM Sales.Orders

-- RANK()
-- assign rank to each row, it handles ties or draw
-- it leaves gaps(skipping) in ranking
SELECT
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) AS rank_by_sales
FROM Sales.Orders

SELECT 
	OrderID,
	ProductID,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) AS rank
FROM Sales.Orders

-- DENSE_RANK()
-- assign each row a number, also handles ties or draw
-- doesn't leave any gaps like RANK()
SELECT
	OrderID,
	ProductID,
	Sales,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS dense_ranking
FROM Sales.Orders

-- ROW_NUMBER()
-- TOP-N Analysis: top performing product for marketing
SELECT * FROM(
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS top_products
FROM Sales.Orders
)t WHERE top_products = 1

-- BOTTOM-N Analysis: help analysis under performance to manage risks and to do optimizations
SELECT * FROM (
SELECT
		CustomerID,
		SUM(Sales) AS TotalSales,
		ROW_NUMBER() OVER(ORDER BY SUM(Sales)) As lowest_two_customer
FROM Sales.Orders
GROUP BY CustomerID
)t WHERE lowest_two_customer <= 2

-- Generate Unique IDs
-- help to assign unique identifier for each row to help paginating
-- importing data or exporting, optimize query using this ID
-- paginating: the process of breaking down a large data into smaller, more manageable chunks
SELECT
	ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) AS UniqueID,
	*
FROM Sales.OrdersArchive

-- Identify Duplicates by ROW_NUMBER()
-- dayta quality issues solving
-- for data cleanup or deleting duplicates
-- if the rank exceeds 1, it indicates that the primary key is not unique
SELECT * FROM(
SELECT
	ROW_NUMBER() 
	OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS unification,
	*
FROM Sales.OrdersArchive
)t WHERE unification > 1


-- NTILE() => need to must define a number, this is the Bucket Number
-- NTILE(2) => accepts an integer
-- divides rows into a specified number of approximately equal groups(Buckets)
-- Bucket Size = Number of Rows / Number of Buckets
-- Bucket Size = 4 / 2 = 2 groups (if row number 2, and NTILE(2))

-- SQL RULE: larger groups comes first than smaller
-- if odd number of rows 5/2, then the larger or fist group will be 3, then second group will be 2
SELECT
	OrderID,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) AS OneBucket,
	NTILE(2) OVER(ORDER BY Sales DESC) AS TwoBucket,
	NTILE(3) OVER(ORDER BY Sales DESC) AS ThreeBucket,
	NTILE(4) OVER(ORDER BY Sales DESC) AS ThreeBucket
FROM Sales.Orders

-- use-case: Data Segmentation for Data Analyst 
-- Segmentation: Divides a datasets into distinct subsets based on certain criteria
-- eg. group customer depends on their behaviour like total_sales, total_no_order
SELECT 
	*,
	CASE 
		 WHEN Buckets = 1 THEN 'High'
		 WHEN Buckets = 2 THEN 'Medium'
		 WHEN Buckets = 3 THEN 'Low'
	END AS SalesSegmentations 
	FROM(
SELECT
	OrderID,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC) AS Buckets
FROM Sales.Orders
)t

-- Equal Load Processing or Load Balancing for Data Engineer(Equalizing Load)
SELECT
	NTILE(4) OVER(ORDER BY OrderID) AS TwoBuckets,
	*
FROM Sales.Orders

---------------------------
-- PERCENTAGE BASED RANKING
-- continuous values or normalize scale from 0 to 1

-- CUME_DIST
-- stands from cumulative distributios that calculates the distribution of data points within a window
-- distribution of data points within a window
-- CUME_DIST = Position Number / Number of Rows
-- Inclusive 
-- Tie-Rule: The position of the last occurrence of the same value will be taken as Position Number
-- if have same value the will share the same rank by 'Last Occurence Tie-Rule'

-- PERCENT_RANK
-- calculates the relative position of each row
-- Percent_Rank = Position Number - 1 / Number of Rows -1(0 to N-1 like programming)
-- Tie-Rule: Here first occurence of the share vlaue will be taken as position number (opposite Tie-Rule like CUME_DIST)
-- Exclusive
-- same value will share the same value by 'First Occurence Tie-Rule'
SELECT 
	*,
CONCAT(DistRank * 100,'%') AS DistRankPercentage
FROM (
SELECT
	Product, 
	Price,
	CUME_DIST() OVER(ORDER BY Price DESC) AS DistRank
FROM Sales.Products
)t
WHERE DistRank <= 0.4

SELECT 
	*,
	CONCAT(DistRank * 100 , '%') AS DistRankPerentage
FROM (
SELECT 
	Product,
	Price,
	PERCENT_RANK() OVER(ORDER BY  Price DESC) As DistRank
FROM Sales.Products
)t 
WHERE DistRank <= 0.4

-- ANALYTICS FUNCTION
-- VALUE WINDOW FUNCTION
-- in order to access a value from another row by using LAG() and LEAD() function
-- FIRST_VALUE()
-- LAST_VALUE()
-- LEAD, LAG, FIRST_VALUE, LAST_VALUE
-- need to use ORDER BY must
-- expression: all data type,partion clause is optional, order claused required
-- LEAD, LAG - frame clause not allowed
-- FIRST_VALUE - frame clause is optional
-- LAST_VALUE - frame clause is required

-- LEAD(Sales, 2, 10) -> 2 is offset: number of rows forward or backward from current row
-- access value from next row
-- LAG()
-- allow to access a value from previous row

-- Year Over Year(YoY) Analysis
-- Month Over Month(MoM) Analysis
-- Time Series Analysis
-- the process of analyzing the data to understand patterns, trends, and behaviors over time

SELECT *,
CurrentMonthSales - PreviousMonthSales AS MoM,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT) / PreviousMonthSales * 100, 1) AS MoMpercentage
FROM (
SELECT
	MONTH(OrderDate) AS OrderMonth,
	SUM(Sales) AS CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate)
)t

-- Customer Retention Analysis
-- measuring the customer behavior and loyalty to build strong relationship with customers based on their needs
SELECT 
    CustomerID,
    AVG(DaysUntilNextOrder) AS AvgDays,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) AS CustomerRank
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate AS CurrentOrder,
        LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
        DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
    FROM Sales.Orders
) t
GROUP BY 
    CustomerID;


-- FIRST_VALUE() => access value from the first row
-- LAST_VALUE() => access value from the last row
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS LowestSales,
	LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS HighestSales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS MaxSales,
	MIN(Sales) OVER(PARTITION BY ProductID) AS ByMinFunc,
	MAX(Sales) OVER(PARTITION BY ProductID) AS ByMaxFunc,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) AS SalesDiff
FROM Sales.Orders



---------------
-- Advanced SQL Techniques
---------------
-- Database Architecture
-- Database Engine => It is the brain of the database, executing multiple operations such as storing, retrieving and managaing data within the database
-- Storage => 1) Disk Storage 2) Cache
-- Disk Storage: Long-term memory, where data is stored permeanantly, can store a lot of data, but slow to read
-- Disk Storage types
-- information schema: a system designed schema with built-in views that provide infor about the database model, like table, columns

SELECT
	*
FROM INFORMATION_SCHEMA.COLUMNS

SELECT
	DISTINCT TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS

-- User data storage: main content of the database, stores the actual data, all content that are relevant for the users, important data user care about
SELECT
	*
FROM Sales.Orders

-- System Catalog storage: internal storage for database for it's own information, a blue print that keeps track of everything about databse itself
-- holds the metadata info about the database
-- metadata: data about data
-- eg. like a table name, column name that are defined inside the database, also stores additional info like which data type is it int or varchar, length of the cols, cols is nullable or not, about schemas or database catalogue

-- Temp data storage:
-- temporary space for short time task like processing queries or sorting data
-- once these tasks are done, the temp storage will clean up it's storage

-- Cache: Short-term memory, where data is stored temporarily, it's like pc's RAM, most frequently used data to access query in order to retrieve data, it is very fast, but data is stored there only for short period


-- SUBQUERY: query inside another query(main query + sub query) eg.below
-- SUBQUERY can be used only from it's main query, it's not globally available to access by a external query
-- JOIN TABLES -> FILTERING -> TRANSFORMATIONS -> AGGREGATIONS
-- Dependency between subquery and main query, there are mainly 2 types
-- 1) Independent or Non-Correlated subquery 2) Dependent or Co-rrelated subquery
-- Result Type: Scalar subquery(returns single value), 
-- row-subquery : returns multiple rows
-- table-subquery: returns multiple rows as well as multiple columns
-- How to categorized sub-query?
-- Based on Location | Clauses Like SELECT Clause or FROM Clause or JOIN Clause or WHERE Clause
-- or together with comparison operator(<, <, = etc) or logical operator(IN, ANY, ALL, EXISTS)

-- Result types of SUBQUERY
-- 1) Scalar Subquery : returns only one single value
SELECT 
	AVG(Sales) AS Scalar_Query
FROM Sales.Orders

-- 2) Row SubQuery: returns multiple rows and single columns
SELECT
	CustomerID AS Row_Subquery
FROM  Sales.Orders

-- 3) Table SubQuery: returns multiple rows as well as multiple columns
SELECT 
	OrderID, 
	CustomerID,
	OrderDate
FROM Sales.Orders
    CustomerID;

-- How to use subquery in location | clauses
-- FROM Subquery: used as temporary table for the main query
SELECT 
    CustomerID,
    AVG(DaysUntilNextOrder) AS AvgDays,
	RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) AS CustomerRank
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate AS CurrentOrder,
        LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrder,
        DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) AS DaysUntilNextOrder
    FROM Sales.Orders
) t
GROUP BY 


-- Main Query(Outer Query) 
SELECT
	*
FROM (
	-- Subquery (Inner Query): only to support the main query
	SELECT
		ProductID,
		Price,
		AVG(Price) OVER() AS AvgPrice
	FROM Sales.Products
) t
-- this where clause done in main query not in subquery
WHERE Price > AvgPrice

SELECT
	*,
	RANK() OVER(ORDER BY TotalSales DESC) AS CusomterRankOnTotalSales
FROM(
	SELECT
		CustomerID,
		SUM(Sales) AS TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID
) t

-- SUBQUERY SELECT CLAUSE
-- only scalar suquery(single value) are allowed to be used
-- Main Query
SELECT
	ProductID,
	Product,
	Price,
	-- Sub Query(single value)
	-- intermediate result to support the main query
	(SELECT COUNT(*) AS TotalOrders FROM Sales.Orders) AS TotalOrders
FROM Sales.Products;

-- Suq Query in JOIN Clause
-- used to prepare the date (filtering or aggregation) before joining it with other tables

-- Main Query
SELECT
	c.*,
	o.TotalOrders
FROM Sales.Customers  AS c
LEFT JOIN(
	-- sub query
	SELECT 
		CustomerID,
		COUNT(*) AS TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID
) AS o
ON C.CustomerID = o.CustomerID

-- Sub Query in WHERE Clause
-- used for complex filtering logic and makes query more flexible and dynamic
-- comparison operator(=, !=, <, <= , >, >=) : in order to compare two values
-- logical operator(IN, ANY, ALL)
-- sub query must be scalar sub query(single return value)

-- main query
SELECT
	ProductID,
	Price,
	(SELECT AVG(Price) FROM Sales.Products) AS AvgPrice
FROM Sales.Products
WHERE Price  > (SELECT AVG(Price) FROM Sales.Products)

-- Sub Query In Operator
-- checks whether a value matches any value from a list
-- filter the data based on multiple values
-- logical operator(IN, ANY, ALL)

-- main query
SELECT
	*
FROM Sales.Orders
WHERE  CustomerID NOT IN (
	-- sub query(static value list)
	SELECT 
		CustomerID
	FROM Sales.Customers
	WHERE Country = 'Germany'
)


-- Suq Query ANY | ALL
-- checks if a value matches ANY value within a list
-- ANY: used to check if a value is true for AT LEAST one of the vlaues in a list
-- <ANY | <ALL

-- main query
SELECT
	EmployeeID,
	FirstName,
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary >ANY (
	-- sub query
	SELECT
		Salary
	FROM Sales.Employees
	WHERE Gender = 'M'
)

-- ALL: checks if a value matches ALL values within a list
SELECT
	EmployeeID,
	FirstName, 
	Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL (
	SELECT
		Salary
	FROM Sales.Employees
	WHERE Gender = 'M'
)

-- Based on Dependency
-- Non-Correlated | Correlated Subqueries
-- Non-Correlated: A stand-alone or A subquery that can run indepently from the main query
-- Correlated: That relies on values from the Main Query

-- main query
SELECT
	*,
	-- sub query
	(SELECT COUNT(*) FROM Sales.Orders AS o 
	WHERE o.CustomerID = c.CustomerID) As TotalSales
FROM Sales.Customers AS c

-- Correlated Subquery EXISTS Operator
-- checks if a subquery returns any result or rows
-- filtering based on a logic

-- main query
SELECT
	*
FROM Sales.Orders AS o
WHERE EXISTS (
	-- sub query
	SELECT 1
	FROM Sales.Customers AS c
	WHERE Country = 'Germany'
	AND o.CustomerID = c.CustomerID
)


--------------
-- Common Table Expressions(CTE)
-- temporary named result set(virtual set) that can be used multiple times within query to simplify and organize complex query
-- improves readability
-- introduces modularity(break into smaller chunks) => a puzzle piece by piece
-- reusability
-- CTE has main priority in database engine
-- CTE types
-- 1) None-Recursive CTE
-- For none-recursive standalone subtype and nested CTE subtypes
-- 2) Recursive CTE


-- Standalone CTE
-- defined and used indepently in the query
-- self-contained, doesn't depend on any other CTEs or queries
-- cannot use only ORDER BY

-- Nested CTE
-- CTE inside another CTE
-- A nested CTE uses the result of another CTE, so it can't run indepently
WITH CTE_Total_Sales AS
(
    SELECT
        CustomerID,
        SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
),
Cte_Last_Order AS
(
    SELECT
        CustomerID,
        MAX(OrderDate) AS Last_Order
    FROM Sales.Orders
    GROUP BY CustomerID
),
-- Step3: rank customers based on total sales per customer
Cte_Customer_Rank AS 
(
	SELECT
		CustomerID,
		TotalSales,
		RANK() OVER(ORDER BY TotalSales DESC) AS Customer_Rank
 	FROM CTE_Total_Sales
),
-- Step4: Segment the customer based on their total sales(Nested CTE)
CTE_Customer_Segments AS (
	SELECT
		CustomerID,
		TotalSales,
	CASE WHEN TotalSales > 100 THEN 'High'
		 WHEN TotalSales > 80 THEN 'Medium'
		 ELSE 'Low'
	END AS Customer_Segments
	FROM CTE_Total_Sales
)
-- Main Query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.TotalSales,
    clo.Last_order,
	ccr.Customer_Rank,
	ccs.Customer_Segments
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales AS cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN Cte_Last_Order AS clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN Cte_Customer_Rank AS ccr
ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments AS ccs
ON ccs.CustomerID = c.CustomerID

-- None-Recursive CTE
--> is executed only once without any repetition
-- Recursive CTE
-- >self referencing query that repeatedly processing the data until a specific condition is met
-- Anchor Query(First interact with the database provide us the initial result, only one execution)
-- Recursive Query(excutes multiple times until the condition is met)

-- Generate a sequence of number from 1 to 20
WITH Series AS (
	-- Anchor Query
	SELECT 
	1 AS MyNumber
	
		UNION ALL

	-- Recursive Query
	SELECT
		 MyNumber + 1
	FROM Series
	WHERE MyNumber < 200
)
-- Main Query
SELECT * FROM Series
OPTION (MAXRECURSION 300)


-- show the employee hierarchy by displaying each employee's level within the organization
WITH CTE_Emp_hierarchy AS
(
-- Anchor Query
	SELECT 
		EmployeeID,
		FirstName,
		ManagerID,
		1 AS Level
	FROM Sales.Employees
	WHERE ManagerID IS NULL

		UNION ALL

	-- Recursive Query
	SELECT
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level + 1
	FROM Sales.Employees AS e
	INNER JOIN CTE_Emp_hierarchy AS ceh
	ON e.ManagerID = ceh.EmployeeID 
)
-- Main Query
SELECT * FROM CTE_Emp_hierarchy




------------- 3 Level Architecture of Database
-- different level of data abstraction

-- 1) Physical Level (internal Layer)
-- lowest level of database where actual data is stored in physical storage -> accessed by database administrator
-- data files, cache, logs, blocks, partitions, catalog

-- 2) Logical Level (conceptual Layer)
-- how to organized data -> accessed by app developer to define the logics of data, how to structure the data
-- tables, reltationships, views, indexes, procedures, modeling, query functions

-- 3) View Level (External Layer)
-- highest level of abstraction, end user access data, a view suitable for business only or data visualization, or create power BI in order to create dashboard


------------
-- VIEWS
------------
-- virtual table that shows data without storing it physically
-- what are views?
-- virtual table based on the result of query, without storing the data in database
-- views are stored or persisted SQL queries in the database

-- views vs tables
-- views virtual(not persisted) table and tables are actual or physical table of data(persisted)
-- views easy to maintain but table hard to main
-- views less faster than table
-- only read in views but table can write and read too

-- why use VIEWS in data project?
-- store central logic, complex query logic in the database for access by multiple queries, reducing project complexity

-- VIEWS VS CTE
-- VIEWS reduce redundancy from multiple queries & CTE improves the reusability
-- VIEWS persist the logic of the database and CTE temporarily store the data only on fly
-- VIEWS need to create/drop but CTE needs no maintainance(that's CTE is auto cleaned-up)


-- SQL VIEWS (CREATE, UPDATE/ALTER, DROP) -- DDL command
-- find the running total of sales for each month
WITH CTE_monthly_summary AS (
	SELECT 
		DATETRUNC(month, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) As TotalOrders,
		SUM(Quantity) AS TotalQuantity
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)
SELECT
	OrderMonth,
	TotalSales,
	SUM(TotalSales) OVER(ORDER BY OrderMonth) AS RunningTotal
FROM CTE_monthly_summary


-- Stored Procedure Vs Query
-- Multiple Requests like a program and One-Time Request
SELECT 
	COUNT(*) AS TotalCustomers,
	AVG(SCORE) AS AvgScore
FROM Sales.Customers
WHERE Country = 'USA'
-- Stored Procedure
CREATE PROCEDURE GetCustomerSummary AS 
BEGIN 
	SELECT
		COUNT(*) TotalCustomers,
		AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE country = 'USA'
END 

EXEC GetCustomerSummary

-- Stored Procedures Parameters
-- placeholder used to pass values as input from caller to the procedure 
-- allowind dynamic data to be processed

ALTER PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
AS
BEGIN
	SELECT
		COUNT(*) TotalCustomers,
		AVG(Score) AvgScore
	FROM Sales.Customers
	WHERE country = @Country;
	SELECT 
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
	FROM Sales.Orders o
	JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	WHERE c.Country = @Country;
END

EXEC  GetCustomerSummary @Country
EXEC  GetCustomerSammary @Country = 'Germany'

DROP PROCEDURE GetGermanCustomer

SELECT 
	COUNT(OrderID) TotalOrders,
	SUM(Sales) TotalSales
FROM Sales.Orders o
JOIN Sales.Customers c
ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'

-------------------------------------------

ALTER PROCEDURE GetInfoCustomers
    @Country NVARCHAR(50) = 'USA'
AS
BEGIN
    BEGIN TRY
        -- =======================================
        -- Step 1: Declare variables and clean data
        -- =======================================
        
        -- Declare variables to hold the total number of customers and the average score.
        DECLARE @TotalCustomers INT, @AvgScore FLOAT;
        
        -- Check for and handle NULL scores by updating them to 0.
        IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
        BEGIN
            PRINT('Updating NULL Scores to 0');
            UPDATE Sales.Customers
            SET Score = 0
            WHERE Score IS NULL AND Country = @Country;
        END
        ELSE
        BEGIN
            PRINT('No NULL Scores found');
        END;

        -- =======================================
        -- Step 2: Calculate and print customer statistics
        -- =======================================
        
        -- Retrieve the customer count and average score for the specified country.
        SELECT
            @TotalCustomers = COUNT(*),
            @AvgScore = AVG(Score)
        FROM Sales.Customers
        WHERE Country = @Country;

        -- Print the total number of customers and the average score.
        PRINT 'Total Customers from ' + @Country + ': ' + CAST(@TotalCustomers AS NVARCHAR);
        PRINT 'Average Score from ' + @Country + ': ' + CAST(@AvgScore AS NVARCHAR);

        -- =======================================
        -- Step 3: Select and return order and sales data
        -- =======================================
        
        -- Select the total orders and sales for the specified country.
        -- NOTE: The '1/0' was a deliberate error for demonstration purposes.
        -- It has been removed to ensure the procedure runs successfully.
        SELECT
            COUNT(o.OrderID) AS TotalOrders,
            SUM(o.Sales) AS TotalSales
        FROM Sales.Orders o
        JOIN Sales.Customers c ON c.CustomerID = o.CustomerID
        WHERE c.Country = @Country;
        
    END TRY
    BEGIN CATCH
        -- =======================================
        -- Step 4: Handle any errors
        -- =======================================
        
        -- Catch and print detailed error information if an exception occurs.
        PRINT('An error occurred.');
        PRINT('Error message: ' + ERROR_MESSAGE());
        PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
        PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
        PRINT('Error Procedure: ' + ERROR_PROCEDURE());
    END CATCH
END
GO

EXEC GetInfoCustomers;
EXEC GetInfoCustomers @Country = 'Germany';


-----------
-- Triggers
-----------
-- special stored procedure that automatically runs in respose to 
-- a specific event on  a table or view
-- trigger types
-- DML triggers: insert, update and delete
-- AFTER and INSTEAD OF triggers(runs during event)

-- DDL triggers: create, alter, drop
-- loggin triggers

-- Trigger use case -> logging

CREATE TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)
CREATE TRIGGER trg_AfterInsertEmployee on Sales.Employees
AFTER INSERT 
AS 
BEGIN
	INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	SELECT 
		EmployeeID,
		'New Employee Added =' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
		-- inserted : a virtual table taht holds a
		-- copy of the rows that are being inserted into 
		-- the target table
	FROM INSERTED
END

SELECT * FROM Sales.EmployeeLogs

INSERT INTO Sales.Employees
VALUES
(7, 'John', 'Doe', 'HR', '1978-11-12', 'M', 85000, 3)


---------------------------
-- Performance Optimization
---------------------------
-- Index: is a data structure that provides a quick
-- access to data, optimizing the speed of your queries
-- like a guide for the database in order to search data faster
-- indexes into 3 categories
-- 1) Structure Index
-- clustered index
-- non-clustered index
-- 2) Storage
-- how the data stored physically? RowStore Index and Columns Store index
-- 3) Functions : Unique Index and Filtered Index
-- Trade-off: some might improve performacne some might improve reading faster
-- and other might improve writing performance


---------- Structured Index
-- Heap Structure: table without a clustered index
-- Page: is a unit of data storage in a database(8kb)->fixed size
-- Data Page start with File ID and fixed size 96bytes
-- Offset Array at the bottom of the Data page: it's like a quick index

-- Clustered Index
-- Balance-Tree(B-Tree): hierarchial structure storing data at leaves, to help quickly locate data
-- start with root and keep branching out
-- Index page : It stores key values(pointers) to another page, it doesn't store the actual data

-- Non-Clustered Index: won't reorganize or change anything on the data page
-- Clusterede VS Non-Clustered
-- clustered index table of content where to find each chapter sorted
-- non-cluster index at the end of the books

-- How to create INDEX???
SELECT 
	*
	INTO Sales.DBCustomers
FROM Sales.Customers

SELECT * FROM Sales.DBCustomers
WHERE CustomerID = 1

CREATE CLUSTERED INDEX  idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)

CREATE CLUSTERED INDEX idex_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)

DROP INDEX idex_DBCustomers_FirstName ON Sales.DBCustomers

SELECT 
	*
FROM Sales.Customers
WHERE FirstName = 'Anna'

CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName
ON Sales.DBCustomers (LastName)

CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)

-- Composite Index

SELECT *
FROM Sales.DBCustomers
WHERE Country = 'USA' AND Score > 500

CREATE INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score)


-- Left Most Prefix Rule
-- Order of the column are important
A,B,C,D
-- Index will be used
A
A,B
A,B,C

-- Index won't be used
B
A,C
A,B,D



-------------
-- Storage Index
-- 1) RowStore Index (default A Heap Structure)
-- store the data row by row

-- 2) ColumnStore Index
-- only value of one columns
-- store the data column by column
-- ColumnStore Process 
-- 1. Row Groups
-- 2. Column Segment
-- 3. Data Compression
-- 4. Storing the Result In Databse by a special Data Page Called: LoB (Large Object) page

CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS
ON Sales.DBCustomers 

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBCustomers

CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_cs_fn
ON Sales.DBCustomers (FirstName)

DROP INDEX idx_DBCustomers_CS ON Sales.DBCustomers


-- HEAP Structure
SELECT *
INTO FactInternetSales_HP
FROM FactInternetSales

-- RowStore
SELECT *
INTO FactInternetSales_RS
FROM FactInternetSales

CREATE CLUSTERED INDEX idx_FactInternetSales_RS_PK
ON FactInternetSales_RS (SalesOrderNumber, SalesOrderLineNumber)

-- ColumnStore
SELECT *
INTO FactInternetSales_CS
FROM FactInternetSales

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactInternetSales_CS_PK
ON FactInternetSales_CS


-- Unique Index: that ensures no duplicate values exist in specific columns
-- to have data integrity, enforce uniqueness
-- slightly increase query performance
SELECT * FROM Sales.Products

CREATE UNIQUE NONCLUSTERED INDEX idx_products
ON Sales.Products (Product)

-- data integrity
INSERT INTO Sales.Products (ProductID, Product)
VALUES(106, 'Bottle')



-- Filtered Index
-- an index that includes only rows meeting the specified conditions
-- the data that fullfills the specific conditions
-- targeted optimization
-- reduces storage: less data in the index
-- cannot use filtered index on a clustered index
-- cannot crate a filtered index on a columnstore index

SELECT * FROM Sales.Customers
WHERE Country = 'USA'

CREATE NONCLUSTERED INDEX idx_customers_score
ON Sales.Customers (Score)
WHERE Country = 'USA'



--------------------------------- Important
-- Index Management & Monitoring


-- 1) Monitor Index Usage
-- list all indexes on a specific table
-- Sys: system schema contains metadata about databases tables, views, indexes etc
sp_helpindex 'Sales.DBCustomers'
-- monitoring usage of index
-- DMV: Dynamic Management View provides real-time insights Database performance and system health
SELECT 
	tbl.name AS TableName,
	idx.name AS IndexName,
	idx.type_desc AS IndexType,
	idx.is_primary_key AS IsPrimaryKey,
	idx.is_unique AS IsUnique,
	idx.is_disabled AS IsDisabled,
	s.user_scans AS UserScans,
	s.user_seeks AS UserSeeks,
	s.user_lookups AS UserLookups,
	s.user_updates AS UserUpdates,
	COALESCE(s.last_user_seek, s.last_user_scan) AS LastUpdates
FROM sys.indexes AS idx
JOIN sys.tables AS tbl
ON idx.object_id = tbl.object_id
LEFT JOIN sys.dm_db_index_usage_stats AS s
ON s.object_id = idx.object_id
AND s.index_id = idx.index_id
ORDER BY tbl.name, idx.name


SELECT * FROM sys.tables
SELECT * FROM sys.dm_db_index_usage_stats

SELECT * FROM Sales.Products
WHERE Product = 'Caps'

-- 2) Monitor Missing Indexes
SELECT
	fs.SalesOrderNumber,
	dp.EnglishProductName,
	dp.color
FROM FactInternetSales AS fs
INNER JOIN DimProduct AS dp
ON fs.ProductKey = dp.ProductKey
WHERE dp.color = 'Black'
AND fs.OrderDateKey  BETWEEN 20101229 AND 20101231

SELECT * FROM sys.dm_db_missing_index_details


-- 3) Monitor Duplicate Indexes
SELECT
	tbl.name AS TableName,
	col.name AS IndexColumn,
	idx.name AS IndexName,
	idx.type_desc AS IndexType,
	COUNT(*) OVER(PARTITION BY tbl.name, col.name) AS ColumnCount
FROM sys.indexes idx
JOIN sys.tables tbl
ON idx.object_id = tbl.object_id
JOIN sys.index_columns ic
ON idx.object_id = ic.object_id  AND idx.index_id = ic.index_id
JOIN sys.columns col
ON ic.object_id = col.object_id AND ic.column_id = col.column_id
ORDER BY tbl.name, col.name;

-- 4) Update Statistics
-- weekly job to update statistics on weekends
-- after migratind data
SELECT
	SCHEMA_NAME(t.schema_id) AS SchemaName,
	t.name AS TableName,
	s.name AS StatisticsName,
	sp.last_updated AS LastUpdate,
	DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
	sp.rows AS 'Rows', 
	sp.modification_counter AS ModificationsSinceLastUpdate
FROM sys.stats AS s
JOIN sys.tables AS t
ON s.object_id = t.object_id
CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
ORDER BY
sp.modification_counter DESC

UPDATE STATISTICS Sales.DBCustomers _WA_Sys_00000005_03F0984C

UPDATE STATISTICS Sales.DBCustomers 

EXECUTE sp_updatestats


-- 5) Monitoring Fragmentations
-- Unused spaces in data pages
-- Data pages are out of order

-- 2 methods of Fragmentations
-- 1) Defragments
-- Defragments leaf nodes to keep them sorted 
-- "Light" Operation

-- 2) Rebuild
-- Recreates Index from scratch
-- "Heavy" Operations

-- First check health of database by DMF
-- avg_fragmentation_in_percent: indicate how out-of-order pages are within the index
-- 0% means no fragementation(perfect)
-- 100% completely out of order
-- 0 to 10% : No action needed
-- 10 to 30%: Reorganize (take action)
-- >30% : Rebuilding is better

SELECT *
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED')

SELECT
	tbl.name AS TableName,
	idx.name AS IndexName,
	s.avg_fragmentation_in_percent,
	s.page_count
FROM sys.dm_db_index_physical_stats  (DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl
ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx
ON idx.object_id = s.object_id AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC

ALTER INDEX idx_customers_country ON Sales.Customers REORGANIZE

ALTER INDEX idx_customers_country ON Sales.Customers REBUILD



------------------
-- Execution Plan
-- roadmap generated by a database on how it will execute query step by step
-- basics of execution plan
SELECT 
	*
INTO FactResellerSales_HP
FROM FactResellerSales

SELECT *
FROM FactResellerSales_HP

-- Display Estimated Execution Plan
-- predict the execution plan without actually running the query(prediction)

-- Actual Execution Plan
-- shows the execution plan as it occurred aftrer running the query

-- Live Execution Plan
-- Shows the real-time execution flow as the query runs
-- 3 types of Scan
-- Table Scan: Scan the entire table page by page and row by row in Heap Structure
-- Index Scan: Real all entries in an index to find results
-- Index Seek: A targeted search within an index, retrieving specific rows, quickly locates specific rows in an index

-- JOIN ALGORITHMS
-- 1) Nested Loop : Compare tables row by row; best for small tables
-- 2) Hash Match: Matches rows using a hash table, best for large tables
-- 2) Merge Join: Merge two sorted  tables, efficient when both are soreted

-- RowStore VS ColumnStore for Execution Plan

SELECT *
FROM FactResellerSales_HP 
WHERE CarrierTrackingNumber = '4911-403C-98'

SELECT 
	p.EnglishProductName AS ProductName,
	SUM(s.SalesAmount) AS TotalSales
FROM FactResellerSales_HP AS s
JOIN DimProduct AS p
ON p.ProductKey = s.ProductKey
GROUP BY p.EnglishProductName

CREATE CLUSTERED COLUMNSTORE INDEX idx_FactResellerSalesHP
ON FactResellerSales_HP

-- SQL HINTS
-- Commands you add to a query to force the database to run it in a specific way for better performance
SELECT 
	o.Sales,
	c.Country
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c WITH (FORCESEEK)
ON o.CustomerID = c.CustomerID
-- OPTION (HASH JOIN)

-- INDEXING STRATEGY
-- The Golden Rule: Avoid over indexing, biggest mistake
-- Indexes slow down WRITE perfermance; CRUD task will be effected
-- too many indexes can confuse execution plan
-- increase execution plan time, choose a supoptimal plan
-- Mindset should be 'LESS IS MORE'

-- Phase-1: Initital Indexing Strategy
-- objective of the project should be cleared, what is the main goal
-- 2 types of database:
-- 1) OLAP(Online Analytical Processing) -> ColumnStore is best
-- eg: Date Warehouse
-- OLTP(Online Transaction Processing) -> Normalized Table, clustered index PrimaryKey making
-- eg: E-commerce, finance, banking
-- 2 strategies: either want to improve READ performance or  the WRITE performance

-- Phase-2: Usage Patterns Indexing
-- Identify frequently used table columns, how filtering the data in query
-- Identyfiy the query pattern in end use
-- Chosose the Right Index type
-- Clustered Index: If columns are primary_keys
-- Non-Clustered Index: Columns that are not PK where doing joining,filtering etc
-- ColumnStore Index: If table is very big, ColumnStore Index is must
-- Filtered Index: If Targeting subset of data like 1 year, 1 month information
-- Unique Index: Unique column where don't have any duplicates
-- Last step: Test the Index


-- Phase-3: Scenario-Based Index
-- First identify slow queries
-- Then analyze the slow query one by one
-- Checking Execution Plan
-- Then choose Right Index to optimized the query
-- Test and compare the execution plan before and after


-- Phase-4: Monitoring And Maintenance
-- By keeping eye on health of index using metadata,statistics etc
-- Dynamic Management View, by this we can see the last time our query used
-- Monitor the Mission Indexes
-- Monitor Duplicate Indexes
-- Update the Statistics
-- Monitoring the Fragmentation in Indexes
-- Fragmentation between 0 to 10% , there is no issue if higher than 10-30% needs reorganize and  more than 30% , it's better to rebuild whole index


-----------------
-- SQL Partitions
-----------------
-- Technique to divide big table into smaller partitions 
-- While database still will treat the table as a single logical table
-- Partitions allows scalability and paraller processing which reduces the execution time and faster performance will occur

-- 4 Steps of Partitioning
-- 1) Define Partition Functions
-- how to divide the data into partion logic
-- based on Partition Key Like(Column, Region, ...); date is mostly used
-- like define by paritition range like first day of the reay or the last day of the year

CREATE PARTITION FUNCTION PartitionByYear (DATE)
AS RANGE LEFT FOR VALUES ('2023-12-31', '2024-12-31', '2025-12-31')

SELECT
	name,
	function_id,
	type,
	type_desc,
	boundary_value_on_right
FROM sys.partition_functions

-- 2) FILEGROUP for partitioning
-- logical container for one or more data files

ALTER DATABASE SalesDB ADD FILEGROUP FG_2023
ALTER DATABASE SalesDB ADD FILEGROUP FG_2024
ALTER DATABASE SalesDB ADD FILEGROUP FG_2025
ALTER DATABASE SalesDB ADD FILEGROUP FG_2026

ALTER DATABASE SalesDB REMOVE FILEGROUP FG_2023

SELECT * FROM sys.filegroups
WHERE TYPE = 'FG'

-- Primary Filegroup: defuault filegroup where all objects of database is stored


-- 3) Data Files
-- Data files will contain the actual data, the file format is .ndf 

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2023, -- Logical name
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf' -- File path
) TO FILEGROUP FG_2023;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2024, -- Logical name
	FILENAME = 'C:\Pro3gram Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf' -- File path
) TO FILEGROUP FG_2024;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2025, -- Logical name
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf' -- File path
) TO FILEGROUP FG_2025;

ALTER DATABASE SalesDB ADD FILE
(
	NAME = P_2026, -- Logical name
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf' -- File path
) TO FILEGROUP FG_2026;

SELECT
	fg.name AS FilegroupName,
	mf.name AS LogicalFileName,
	mf.physical_name AS PhysicalFilePath,
	mf.size / 128 AS SizeInMB
FROM
	sys.filegroups AS fg
JOIN
	sys.master_files AS mf ON fg.data_space_id = mf.data_space_id
WHERE 
	mf.database_id = DB_ID('SalesDB')

-- 4) Define Partition Schemes
-- Map partition to a file group
-- create partition scheme

-- 3 Boundaries = 4 Partitions = 4 Filegroups

CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION PartitionByYear
TO (FG_2023, FG_2024, FG_2025, FG_2026)

-- Query lists all Partition Scheme
SELECT
	ps.name AS PartitionSchemeName,
	pf.name AS PartitionFunctionName,
	ds.destination_id AS PartitionNumber,
	fg.name AS FilegroupName
FROM sys.partition_schemes AS ps
JOIN sys.partition_functions AS pf ON ps.function_id = pf.function_id
JOIN sys.destination_data_spaces AS ds ON ps.data_space_id = ds.partition_scheme_id
JOIN sys.filegroups AS fg ON ds.data_space_id = fg.data_space_id

-- 5) Create the Partition Table
CREATE TABLE Sales.Orders_Partitioned
(
	OrderID INT,
	OrderDate Date,
	Sales INT
) ON SchemePartitionByYear (OrderDate)

-- 6) Insert Data into the created Partitioned Table
INSERT INTO Sales.Orders_Partitioned VALUES(1, '2023-05-15', 100)
INSERT INTO Sales.Orders_Partitioned VALUES(1, '2024-07-10', 100)
INSERT INTO Sales.Orders_Partitioned VALUES(1, '2025-12-31', 35)
INSERT INTO Sales.Orders_Partitioned VALUES(1, '2026-12-31', 350)
INSERT INTO Sales.Orders_Partitioned VALUES(1, '2026-01-01', 575)

SELECT * FROM  Sales.Orders_Partitioned

SELECT 
	p.partition_number AS PartitionNumber,
	f.name AS PartitionFileGroup,
	p.rows AS NumberOfRows
FROM sys.partitions AS P
JOIN sys.destination_data_spaces AS dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups AS f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitioned'

SELECT * 
	INTO Sales.Orders_NoPartitioned
FROM Sales.Orders_Partitioned

SELECT *
FROM Sales.Orders_NoPartitioned
WHERE OrderDate = '2026-01-01'



------------------------
-- 30 x Performance Tips
------------------------

-- Select Only What You Need

SELECT * FROM Sales.Customers
-- Good Practice what needs
SELECT CustomerID, FirstName, LastName FROM Sales.Customers


-- Avoid unnecessary DISTINCT & ORDER BY
-- DISTINCT, ORDER BY expensive operation takes lot of resources, and slow down query
SELECT DISTINCT
	FirstName
FROM Sales.Customers
ORDER BY FirstName

SELECT FirstName
FROM Sales.Customers


-- For Exploration purpose, limit Rows
SELECT 
	OrderID,
	Sales
FROM Sales.Orders

SELECT TOP 10
	OrderID,
	Sales
FROM Sales.Orders


-- Filtering Data
-- create a nonclustered index on frequently used columns in WHERE clause
SELECT * FROM Sales.Orders WHERE OrderStatus = 'Delivered'

CREATE NONCLUSTERED INDEX idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)


-- Avoid applying functions to columns in WHERE clause
-- Functions on columns can block index usage
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

SELECT * FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

SELECT * FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'

SELECT * FROM Sales.Customers
WHERE FirstName LIKE 'A%'

SELECT * FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'


-- Avoid using leading wildcards, as they prevent index usage
SELECT * FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

-- Good Practice
SELECT * FROM Sales.Customers
WHERE LastName LIKE 'Gold%'


-- Use IN instead of multiple OR conditions
SELECT * FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

SELECT * FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3)


-- JOINING DATA
-- always try to use INNER JOIN
-- Best Performance
SELECT 
	c.FirstName, o.OrderID
FROM Sales.Customers c 
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

-- Slightly Slower Performance
SELECT 
	c.FirstName, o.OrderID
FROM Sales.Customers c 
RIGHT JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

SELECT 
	c.FirstName, o.OrderID
FROM Sales.Customers c 
LEFT JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

-- Worst Performance
SELECT 
	c.FirstName, o.OrderID
FROM Sales.Customers c 
OUTER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID


-- Use Explicit Join (ANSI Join) instead of Implicit Join(non-ANSI Join)
SELECT 
	o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

-- Good Practice
SELECT
	o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

-- Ensure that the columns used in the ON clause are indexed
-- bkz index speed up look-up process
SELECT
	o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Sales.Orders(CustomerID)



-- Filter before Joining (Big Tables

-- Filter after join (WHERE)
SELECT
	o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered'

-- Filter During Join (ON)
SELECT
	o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID
AND o.OrderStatus = 'Delivered'

-- Filter Before Join (SUBQUERY)
SELECT
	o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN (SELECT OrderID, CustomerID FROM Sales.Orders WHERE OrderStatus ='Delivered') o 
ON c.CustomerID = o.CustomerID


-- Aggregate Before Joining (Big Tables)
-- Try to use Pre-Aggregate Subquery
-- if small table Grouping and Joining will also be enough

-- Use UNION instead of OR while Joining Tables
-- Bad Practice
SELECT 
	o.orderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.customerID = o.customerID
OR c.customerID = o.SalesPersonID -- this 'OR' performance killer

-- Good Practice
SELECT 
	o.orderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.customerID = o.customerID
	UNION
SELECT 
	o.orderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.customerID = o.SalesPersonID


-- Check for Nested Loops and use SQL Hints when necessary
-- Bad Practice
SELECT 
	o.orderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.customerID = o.customerID

-- Good Practice
SELECT 
	o.orderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o
ON c.customerID = o.customerID
OPTION (HASH JOIN)



-- Use UNION ALL instead of using UNION if duplicates are acceptable
-- Bad Practice, needs more time to be executed
SELECT CustomerID FROM Sales.Orders
	UNION
SELECT CustomerID FROM Sales.OrdersArchive

-- Best Practice if duplicates are acceptable
SELECT CustomerID FROM Sales.Orders
	UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive






































 













	




















 

























	























	

	











