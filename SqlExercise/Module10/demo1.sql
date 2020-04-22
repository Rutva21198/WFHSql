USE tempdb;

CREATE FUNCTION EndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN DATEADD(day, 0 - DAY(@DateToTest), @DateToTest);
END;

SELECT EndOfPreviousMonth(SYSDATETIME());

SELECT OBJECTPROPERTY(OBJECT_ID('EndOfPreviousMonth'),'IsDeterministic');

DROP FUNCTION EndOfPreviousMonth;


CREATE FUNCTION EndOfPreviousMonth (@DateToTest date)
RETURNS date
AS BEGIN
  RETURN EOMONTH ( dateadd(month, -1, @DateToTest ));
END;

SELECT EndOfPreviousMonth('2020-06-02');

DROP FUNCTION EndOfPreviousMonth;
