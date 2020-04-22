USE AdventureWorks;

CREATE TRIGGER trSalesOrderHeader_Insert
ON Sales.SalesOrderHeader
AFTER INSERT AS BEGIN
  IF EXISTS( SELECT 1 
             FROM inserted AS i
             WHERE i.SubTotal > 10000
             AND i.PurchaseOrderNumber IS NULL
           ) BEGIN
    PRINT 'Orders above 10000 must have PO numbers';
    ROLLBACK;           
  END;
END;

INSERT INTO Sales.SalesOrderHeader 
  (RevisionNumber, OrderDate, DueDate, Status, OnlineOrderFlag, PurchaseOrderNumber,
   CustomerID, SalespersonID, BillToAddressID,0 ShipToAddressID, ShipMethodID, SubTotal, TaxAmt, Freight)
  VALUES (1, SYSDATETIME(), SYSDATETIME(), 1, 1, 'XYZ-$%^', 3, 180, 4, 2, 1, 10400, 15, 100);

INSERT INTO Sales.SalesOrderHeader 
  (RevisionNumber, OrderDate, DueDate, Status, 
   OnlineOrderFlag, PurchaseOrderNumber,
   CustomerID, SalespersonID, BillToAddressID, ShipToAddressID, 
   ShipMethodID, SubTotal, TaxAmt, Freight)
  VALUES (1, SYSDATETIME(), SYSDATETIME(), 1, 1, NULL, 3, 230, 3, 3, 1, 15000, 10, 110);


INSERT INTO Sales.SalesOrderHeader 
  (RevisionNumber, OrderDate, DueDate, Status, OnlineOrderFlag, PurchaseOrderNumber,
   CustomerID, SalespersonID, BillToAddressID, ShipToAddressID, 
   ShipMethodID, SubTotal, TaxAmt, Freight)
  VALUES (1, SYSDATETIME(), SYSDATETIME(), 1, 1, NULL, 3, 230, 3, 3, 1, 15000, 10, 110);

DROP TRIGGER Sales.trSalesOrderHeader_Insert;

DELETE soh FROM Sales.SalesOrderHeader AS soh
WHERE NOT EXISTS (SELECT 1 FROM Sales.SalesOrderDetail AS sod WHERE soh.SalesOrderID = sod.SalesOrderID);


CREATE TRIGGER trSalesTerritoryHistory_Delete ON Sales.SalesTerritoryHistory
AFTER DELETE AS BEGIN
  IF EXISTS(SELECT 1
            FROM deleted AS d
            WHERE d.EndDate IS NULL) BEGIN
    PRINT 'Current Sales Territory History rows cannot be deleted';
    ROLLBACK;
  END;
END;

SELECT * FROM Sales.SalesTerritoryHistory WHERE BusinessEntityID = 243;

DELETE FROM Sales.SalesTerritoryHistory WHERE BusinessEntityID = 243;

DROP TRIGGER Sales.trSalesTerritoryHistory_Delete;

