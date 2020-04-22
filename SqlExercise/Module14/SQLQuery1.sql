USE AdventureWorks;

CREATE PROCEDURE Production.spGetAvailableModelsAsXML
AS BEGIN
  SELECT p.ProductID,p.Name as ProductName,p.ListPrice,p.Color,p.SellStartDate,pm.ProductModelID,pm.Name as ProductModel
  FROM Production.Product AS p INNER JOIN Production.ProductModel AS pm ON p.ProductModelID = pm.ProductModelID 
  WHERE p.SellStartDate IS NOT NULL AND p.SellEndDate IS NULL ORDER BY p.SellStartDate, p.Name DESC FOR XML RAW('AvailableModel'), ROOT('AvailableModels');
END;

EXEC Production.spGetAvailableModelsAsXML;

CREATE TRIGGER Production.trProductListPrice_Update ON Production.Product AFTER UPDATE
AS BEGIN
	SET NOCOUNT ON;
	INSERT Production.ProductAudit(ProductID, UpdateTime, ModifyingUser, OriginalListPrice,NewListPrice)
	SELECT Inserted.ProductID,SYSDATETIME(),ORIGINAL_LOGIN(),deleted.ListPrice, inserted.ListPrice
	FROM deleted INNER JOIN inserted ON deleted.ProductID = inserted.ProductID WHERE deleted.ListPrice > 1000 OR inserted.ListPrice > 1000;
END;

UPDATE Production.Product SET ListPrice=3978.00 WHERE ProductID BETWEEN 749 and 753;

SELECT * FROM Production.ProductAudit;
