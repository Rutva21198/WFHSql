USE AdventureWorks

CREATE TABLE Production.ProductAudit(ProductID int NOT NULL,UpdateTime datetime2(7) NOT NULL,
ModifyingUser nvarchar(100) NOT NULL,OriginalListPrice money NULL,NewListPrice money NULL)


CREATE TRIGGER Production.trProductListPrice_Update ON Production.Product AFTER UPDATE
AS BEGIN SET NOCOUNT ON;
	INSERT Production.ProductAudit(ProductID, UpdateTime, ModifyingUser, OriginalListPrice,NewListPrice)
	SELECT Inserted.ProductID,SYSDATETIME(),ORIGINAL_LOGIN(),deleted.ListPrice, inserted.ListPrice
	FROM deleted INNER JOIN inserted ON deleted.ProductID = inserted.ProductID WHERE deleted.ListPrice > 1000 OR inserted.ListPrice > 1000;
END;


UPDATE Production.Product SET ListPrice=3978.00 WHERE ProductID BETWEEN 749 and 753;

SELECT * FROM Production.ProductAudit
