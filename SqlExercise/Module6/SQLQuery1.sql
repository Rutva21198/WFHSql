
IF OBJECT_ID(N'Sales.SalesOrderDetailHeap', N'U') IS NOT NULL
	DROP TABLE Sales.SalesOrderDetailHeap;


SELECT SalesOrderID, ISNULL(SalesOrderDetailID * 2, 0) AS 'SalesOrderDetailID', CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
	INTO Sales.SalesOrderDetailHeap
	FROM Sales.SalesOrderDetail;


IF OBJECT_ID(N'Sales.SalesOrderDetailClustered', N'U') IS NOT NULL
	DROP TABLE Sales.SalesOrderDetailClustered;


SELECT SalesOrderID, ISNULL(SalesOrderDetailID * 2, 0) AS 'SalesOrderDetailID', CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
	INTO Sales.SalesOrderDetailClustered
	FROM Sales.SalesOrderDetail;


ALTER TABLE SalesOrderDetailClustered
	ADD PRIMARY KEY CLUSTERED (SalesOrderID, SalesOrderDetailID);


SET STATISTICS XML ON;
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM SalesOrderDetailHeap;

SELECT * FROM SalesOrderDetailClustered;

SELECT * FROM SalesOrderDetailHeap ORDER BY SalesOrderID, SalesOrderDetailID OPTION (MAXDOP 1);

SELECT * FROM SalesOrderDetailClustered ORDER BY SalesOrderID, SalesOrderDetailID;

SELECT * FROM SalesOrderDetailHeap WHERE SalesOrderID BETWEEN 50000 AND 53000;

SELECT * FROM SalesOrderDetailClustered WHERE SalesOrderID BETWEEN 50000 AND 53000;

SELECT * FROM SalesOrderDetailHeap WHERE SalesOrderID BETWEEN 50000 AND 53000 ORDER BY SalesOrderID, SalesOrderDetailID;

SELECT * FROM SalesOrderDetailClustered WHERE SalesOrderID BETWEEN 50000 AND 53000 ORDER BY SalesOrderID, SalesOrderDetailID;


INSERT INTO SalesOrderDetailHeap (SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate)
	SELECT SalesOrderID, ISNULL((SalesOrderDetailID * 2) + 1, 0) AS 'SalesOrderDetailID', CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
		FROM Sales.SalesOrderDetail;

INSERT INTO SalesOrderDetailClustered (SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate)
	SELECT SalesOrderID, ISNULL((SalesOrderDetailID * 2) + 1, 0) AS 'SalesOrderDetailID', CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
		FROM Sales.SalesOrderDetail
	OPTION (MAXDOP 1);

SET STATISTICS XML OFF;
SET STATISTICS IO OFF;
SET STATISTICS TIME ON;
