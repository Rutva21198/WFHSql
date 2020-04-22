CREATE TABLE Sales.MediaOutlet
(
MediaOutletID INT NOT NULL,
MediaOutletName NVARCHAR(40) NULL,
PrimaryContact NVARCHAR(50) NULL,
City NVARCHAR(50) NULL
);



CREATE TABLE Sales.PrintMediaPlacement
(
PrintMediaPlacementID INT NOT NULL,
MediaOutletID INT NULL,
PlacementDate DATETIME NULL,
PublicationDate DATETIME NULL,
ProductID INT NULL,
PlacementCost DECIMAL(18,2) NULL
);

ALTER TABLE Sales.MediaOutlet ADD UNIQUE (MediaOutletID);

ALTER TABLE Sales.PrintMediaPlacement ADD UNIQUE (PrintMediaPlacementID);

Declare @start int=1, @end int=32767

;With MediaIDS( Number ) as
(
    Select @start as Number
        union all
    Select Number + 1
        from MediaIDS
        where Number < @end
)

INSERT INTO Sales.MediaOutlet
           (MediaOutletID
           ,MediaOutletName
           ,PrimaryContact
           ,City)
Select Number, 
NEWID() Name, 
NEWID() Contact,
NEWID() City
from MediaIDS Option (MaxRecursion 32767);

;With MediaIDS( Number ) as
(
    Select @start as Number
        union all
    Select Number + 1
        from MediaIDS
        where Number < @end
)

INSERT INTO Sales.PrintMediaPlacement
           (PrintMediaPlacementID
           ,MediaOutletID
           ,PlacementDate
           ,PublicationDate
		   ,RelatedProductID
		   ,PlacementCost)
Select Number,
ABS(CHECKSUM(NewId())) % 32767 MediaID,
GETDATE() - ABS(CHECKSUM(NewId())) % 365,
GETDATE() - ABS(CHECKSUM(NewId())) % 365,
ABS(CHECKSUM(NewId())) % 32767 ProductID,
RAND(ABS(CHECKSUM(NewId())) % 32767)*1000
from MediaIDS Option (MaxRecursion 32767);


SELECT PMP.*, MO.City 
FROM Sales.PrintMediaPlacement PMP
JOIN Sales.MediaOutlet MO ON PMP.MediaOutletID=MO.MediaOutletID
WHERE PublicationDate BETWEEN '2015-09-1' AND '2015-09-30'
AND PlacementCost BETWEEN 1 AND 2000
ORDER BY PlacementCost DESC;
