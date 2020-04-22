USE master;

CREATE LOGIN TestContext WITH PASSWORD = 'P@ssw0rd',CHECK_POLICY = OFF;

USE AdventureWorks;

CREATE USER TestContext FOR LOGIN TestContext;

CREATE FUNCTION CheckContext()
RETURNS TABLE AS
RETURN ( SELECT * FROM sys.user_token);

SELECT * FROM CheckContext();

ALTER FUNCTION CheckContext()
RETURNS TABLE WITH EXECUTE AS 'TestContext'
AS RETURN ( SELECT * FROM sys.user_token);

DROP FUNCTION CheckContext;

CREATE FUNCTION CheckContext()
RETURNS @UserTokenList TABLE (principal_id int,sid varbinary(85),type nvarchar(128),usage nvarchar(128),name nvarchar(128))
WITH EXECUTE AS 'TestContext'
AS BEGIN
  INSERT @UserTokenList 
    SELECT principal_id,sid,type,usage,name FROM sys.user_token;
  RETURN 
END;

SELECT * FROM CheckContext();

DROP FUNCTION CheckContext;

DROP USER TestContext;

DROP LOGIN TestContext;
