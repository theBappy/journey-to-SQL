
-- T-SQL 
-- Transact-sql is an extension of sql that adds programming features
IF OBJECT_ID('Sales.V_Monthly_Summary', 'V') IS NOT NULL
	DROP VIEW Sales.V_Monthly_Summary
GO

CREATE VIEW Sales.V_Monthly_Summary AS
(	
	SELECT 
		DATETRUNC(month, OrderDate) AS OrderMonth,
		SUM(Sales) AS TotalSales,
		COUNT(OrderID) As TotalOrders,
		SUM(Quantity) AS TotalQuantity
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)

SELECT 
	*
FROM Sales.V_Order_Details

SELECT 
	*
FROM Sales.V_EU_ORDER_DETAILS
