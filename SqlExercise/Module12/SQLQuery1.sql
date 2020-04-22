USE InternetSales

CREATE TABLE ShoppingCart
(SessionID INT NOT NULL,TimeAdded DATETIME NOT NULL,CustomerKey INT NOT NULL,ProductKey INT NOT NULL,Quantity INT NOT NULL
PRIMARY KEY NONCLUSTERED (SessionID, ProductKey)) WITH  (MEMORY_OPTIMIZED = ON,  DURABILITY = SCHEMA_AND_DATA);

INSERT INTO ShoppingCart(SessionID,TimeAdded,CustomerKey,ProductKey,Quantity)VALUES (1,GETDATE(),2,3,1);

---------Add Procedure-----------

CREATE PROCEDURE spAddItemToCart
	@SessionID INT,@TimeAdded DATETIME, @CustomerKey INT, @ProductKey INT, @Quantity INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	INSERT INTO ShoppingCart(SessionID, TimeAdded, CustomerKey, ProductKey, Quantity)
	VALUES (@SessionID, @TimeAdded, @CustomerKey, @ProductKey, @Quantity)
END

DECLARE @now DATETIME = GETDATE();
EXEC spAddItemToCart @SessionID = 3,@TimeAdded = @now,@CustomerKey = 2,@ProductKey = 3,@Quantity = 1;

------Delete Procedure-------

CREATE PROCEDURE spDeleteItemFromCart
	@SessionID INT, @ProductKey INT WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM ShoppingCart WHERE SessionID = @SessionID  AND ProductKey = @ProductKey
END

EXEC spDeleteItemFromCart @SessionID = 3, @ProductKey = 4;

--------EmptyCart Procedure---------

CREATE PROCEDURE spEmptyCart
	@SessionID INT
	WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN 
	ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = 'us_english')  
	DELETE FROM ShoppingCart   WHERE SessionID = @SessionID
END

EXEC spEmptyCart @SessionID = 3;