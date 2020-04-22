CREATE FUNCTION IntegerListToTable(@InputList nvarchar(MAX),@Delimiter nchar(1) = N',')
RETURNS @OutputTable TABLE (PositionInList int IDENTITY(1, 1) NOT NULL,IntegerValue int)
AS BEGIN
		INSERT INTO @OutputTable (IntegerValue)
		SELECT Value FROM STRING_SPLIT ( @InputList , @Delimiter );
	RETURN;
END;
GO

SELECT * FROM IntegerListToTable('123-456789-1234-1','-');
SELECT * FROM IntegerListToTable('123,456789,1234,1',',');