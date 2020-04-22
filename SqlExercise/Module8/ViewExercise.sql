CREATE VIEW Production.vOnlineProducts AS
SELECT p.ProductID, p.Name, p.ProductNumber AS [Product Number], COALESCE(p.Color, 'N/A') AS Color,
CASE p.DaysToManufacture WHEN 0 THEN 'In stock' WHEN 1 THEN 'Overnight' WHEN 2 THEN '2 to 3 days delivery' 
ELSE 'Call us for a quote'
END AS Availability,
p.Size, p.SizeUnitMeasureCode AS [Unit of Measure], p.ListPrice AS Price, p.Weight FROM Production.Product AS p
WHERE p.SellEndDate IS NULL AND p.SellStartDate IS NOT NULL;

CREATE VIEW Production.vAvailableModels AS
SELECT p.ProductID AS [Product ID], p.Name, pm.ProductModelID AS [Product Model ID], pm.Name as [Product Model]
FROM Production.Product AS p INNER JOIN Production.ProductModel AS pm ON p.ProductModelID = pm.ProductModelID
WHERE p.SellEndDate IS NULL AND p.SellStartDate IS NOT NULL;

SELECT * FROM Production.vOnlineProducts;
SELECT * FROM Production.vAvailableModels;

CREATE VIEW Sales.vNewCustomer AS
SELECT CustomerID, FirstName, LastName FROM Sales.CustomerPII;


INSERT INTO Sales.NewCustomer
VALUES
(10001,'Ed', 'Kish'),
(10002, 'Kermit', 'Albritton');

SELECT * FROM Sales.vNewCustomer ORDER BY CustomerID
