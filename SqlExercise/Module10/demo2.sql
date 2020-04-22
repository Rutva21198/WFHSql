USE AdventureWorks;

CREATE FUNCTION Sales.GetLastOrdersForCustomer(@CustomerID int, @NumberOfOrders int)
RETURNS TABLE
AS
RETURN (SELECT TOP(@NumberOfOrders),soh.SalesOrderID,soh.OrderDate,soh.PurchaseOrderNumber 
	FROM Sales.SalesOrderHeader AS soh
    WHERE soh.CustomerID = @CustomerID
	ORDER BY soh.OrderDate DESC
	);

SELECT * FROM Sales.GetLastOrdersForCustomer(12345,3);

SELECT c.CustomerID,c.AccountNumber,glofc.SalesOrderID,glofc.OrderDate FROM Sales.Customer AS c
CROSS APPLY Sales.GetLastOrdersForCustomer(c.CustomerID,5) AS glofc ORDER BY c.CustomerID,glofc.SalesOrderID;

DROP FUNCTION Sales.GetLastOrdersForCustomer;
