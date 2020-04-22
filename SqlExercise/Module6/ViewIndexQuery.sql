IF OBJECT_ID(N'vTransactionHistorySummary', N'V') IS NOT NULL
	DROP VIEW vTransactionHistorySummary;
GO

CREATE VIEW vTransactionHistorySummary
	WITH SCHEMABINDING
	AS
		SELECT ProductID, SUM(Quantity) AS 'Quantity', COUNT_BIG(*) AS 'Count' FROM Production.TransactionHistory GROUP BY ProductID;

CREATE UNIQUE CLUSTERED INDEX ON vTransactionHistorySummary(ProductID);

SELECT C.Name AS 'ProductCategory', S.Name AS 'ProductSubcategory', P.ProductNumber, P.Name AS 'ProductName', T.Quantity
	FROM Production.ProductCategory AS C
		INNER JOIN Production.ProductSubcategory AS S
			ON S.ProductCategoryID = C.ProductCategoryID
		INNER JOIN Production.Product AS P
			ON P.ProductSubcategoryID = S.ProductSubcategoryID
		INNER JOIN dbo.vw_TransactionHistorySummary AS T
			ON T.ProductID = P.ProductID;

UPDATE STATISTICS vTransactionHistorySummary
	WITH ROWCOUNT = 60000000, PAGECOUNT = 10000000;

