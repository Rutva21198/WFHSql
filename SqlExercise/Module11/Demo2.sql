USE tempdb;

CREATE TRIGGER trCurrentPrice_Delete ON CurrentPrice INSTEAD OF DELETE AS BEGIN
  SET NOCOUNT ON;
  UPDATE cp SET cp.IsValid = 0 FROM dbo.CurrentPrice AS cp
  INNER JOIN deleted AS d ON cp.CurrentPriceID = d.CurrentPriceID;
END; 

DELETE CurrentPrice WHERE CurrentPriceID = 2;

SELECT * FROM CurrentPrice;

SELECT * FROM sys.triggers;

DROP TABLE CurrentPrice;

CREATE TABLE PostalCode
( CustomerID int PRIMARY KEY,
  PostalCode nvarchar(5) NOT NULL,
  PostalSubCode nvarchar(5) NULL
);

CREATE VIEW vPostalRegion AS
SELECT CustomerID,PostalCode + COALESCE('-' + PostalSubCode,'') AS PostalRegion FROM dbo.PostalCode;  

INSERT dbo.PostalCode (CustomerID,PostalCode,PostalSubCode) VALUES (1,'11111','111'),(2,'22222',NULL);

SELECT * FROM vPostalRegion;

UPDATE PostalRegion SET PostalRegion = '12345-123' WHERE CustomerID = 2;

DELETE FROM PostalRegion WHERE CustomerID = 2;

CREATE TRIGGER trPostalRegion_Insert ON PostalRegion INSTEAD OF INSERT AS
INSERT INTO PostalCode 
SELECT CustomerID, SUBSTRING(PostalRegion,1,5),
       CASE WHEN SUBSTRING(PostalRegion,7,5) <> '' THEN SUBSTRING(PostalRegion,7,5) END
FROM inserted;

INSERT INTO PostalRegion (CustomerID,PostalRegion) VALUES (2,'22222-222');

ALTER TRIGGER trPostalRegion_Insert ON PostalRegion INSTEAD OF INSERT AS
SET NOCOUNT ON;
INSERT INTO dbo.PostalCode 
SELECT CustomerID, SUBSTRING(PostalRegion,1,5),
       CASE WHEN SUBSTRING(PostalRegion,7,5) <> '' THEN SUBSTRING(PostalRegion,7,5) END FROM inserted;

INSERT INTO PostalRegion (CustomerID,PostalRegion) VALUES (3,'33333-333');

INSERT INTO PostalRegion (CustomerID,PostalRegion) VALUES (4,'44444-444'),(5,'55555-555');

SELECT * FROM vPostalRegion;

DROP VIEW PostalRegion;

DROP TABLE PostalCode;
