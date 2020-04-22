sp_configure;
GO
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;

GO
sp_configure 'clr strict security', 1;
RECONFIGURE;
GO 

USE master
GO

IF EXISTS ( SELECT * FROM sys.server_principals WHERE name = N'sign_assemblies' )
	DROP LOGIN sign_assemblies

IF EXISTS ( SELECT * FROM sys.asymmetric_keys WHERE name = N'assembly_key')
	DROP ASYMMETRIC KEY M13;
	

CREATE ASYMMETRIC KEY  FROM FILE = 'F:\download\20762A\Labfiles\Lab13\Starter\strong_name.snk' ENCRYPTION BY PASSWORD = 'admin123';

CREATE LOGIN sign_assemblies FROM ASYMMETRIC KEY M13;

GRANT UNSAFE ASSEMBLY TO sign_assemblies;

create assembly toyfactoryDB AUTHORIZATION [dbo]
FROM 'C:\Users\Rutva\source\repos\M13\M13\obj\Debug\M13.dll' WITH PERMISSION_SET = SAFE
GO

SELECT * FROM dbo.RegexMatches(N'admin abc', N' ');