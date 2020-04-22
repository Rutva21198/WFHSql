USE tempdb;

CREATE TABLE dbo.CurrentPrice
(
	CurrentPriceID int IDENTITY(1,1) CONSTRAINT PK_CurrentPrice PRIMARY KEY,
	SellingPrice decimal(18,2) NOT NULL,
	LastModified datetime2 NOT NULL CONSTRAINT DF_CurrentPrice_LastModified DEFAULT (SYSDATETIME()),
	ModifiedBy sysname NOT NULL CONSTRAINT DF_CurrentPrice_ModifiedBy
	DEFAULT (ORIGINAL_LOGIN())
);

INSERT INTO CurrentPrice (SellingPrice) VALUES (3.3), (2.3), (4);

SELECT * FROM CurrentPrice;

UPDATE CurrentPrice SET SellingPrice = 15 WHERE CurrentPriceID = 1;

SELECT * FROM CurrentPrice;

CREATE TRIGGER trCurrentPrice_Update
ON dbo.CurrentPrice
AFTER UPDATE AS BEGIN SET NOCOUNT ON;
  UPDATE cp SET cp.LastModified = SYSDATETIME(), cp.ModifiedBy = ORIGINAL_LOGIN() FROM dbo.CurrentPrice AS cp
  INNER JOIN inserted AS i ON cp.CurrentPriceID = i.CurrentPriceID;
END;
 
UPDATE CurrentPrice SET SellingPrice = 10 WHERE CurrentPriceID = 2;

SELECT * FROM CurrentPrice;

SELECT * FROM sys.triggers;

DROP TABLE CurrentPrice;

