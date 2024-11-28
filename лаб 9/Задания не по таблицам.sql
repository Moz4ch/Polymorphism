--1--
CREATE PROCEDURE GetServerInfo
AS
BEGIN
    PRINT 'Server Name: ' + CONVERT(VARCHAR, SERVERPROPERTY('MachineName'))
    PRINT 'SQL Server Version: ' + CONVERT(VARCHAR, SERVERPROPERTY('ProductVersion'))
    
    PRINT 'Current Database: ' + DB_NAME()

    PRINT 'Current User: ' + SYSTEM_USER

    PRINT 'Current Time: ' + CONVERT(VARCHAR, GETDATE(), 120)
END;

EXEC GetServerInfo;

--2--
CREATE PROCEDURE CountDigits
    @Number INT,
    @DigitCount INT OUTPUT
AS
BEGIN
    SET @DigitCount = LEN(CONVERT(VARCHAR, ABS(@Number)))
END;

DECLARE @Count INT;
EXEC CountDigits @Number = 1234, @DigitCount = @Count OUTPUT;
PRINT @Count;


--3--
CREATE PROCEDURE AddRightDigit
    @K INT OUTPUT, 
    @D INT
AS
BEGIN
    SET @K = @K * 10 + @D
END;

DECLARE @Number INT = 123;
EXEC AddRightDigit @K = @Number OUTPUT, @D = 7;
PRINT @Number;


--4--
CREATE PROCEDURE InvDigit
    @K INT OUTPUT
AS
BEGIN
    DECLARE @Reversed INT = 0;
    WHILE @K > 0
    BEGIN
        SET @Reversed = @Reversed * 10 + @K % 10;
        SET @K = @K / 10;
    END
    SET @K = @Reversed;
END;

DECLARE @Number INT = 12345;
EXEC InvDigit @K = @Number OUTPUT;
PRINT @Number;


--5--
CREATE PROCEDURE Swap(
    @X FLOAT,
    @Y FLOAT 
)
AS
BEGIN
    DECLARE @temp FLOAT;
    
    SET @temp = @X;
    SET @X = @Y;
    SET @Y = @temp;
END;

--6--
CREATE PROCEDURE SortInc(
    @A FLOAT, 
    @B FLOAT, 
    @C FLOAT 
)
AS
BEGIN
    DECLARE @temp FLOAT;
    
    IF @A > @B
    BEGIN
        SET @temp = @A;
        SET @A = @B;
        SET @B = @temp;
    END

    IF @B > @C
    BEGIN
        SET @temp = @B;
        SET @B = @C;
        SET @C = @temp;
    END

    IF @A > @B
    BEGIN
        SET @temp = @A;
        SET @A = @B;
        SET @B = @temp;
    END
END;


--7--
CREATE PROCEDURE DigitCountSum(
    @K INT,
    @C INT OUTPUT,
    @S INT OUTPUT
)
AS
BEGIN
    DECLARE @temp INT;
    SET @temp = @K;
    SET @S = 0;
    SET @C = 0;
    
    IF @K = 0
    BEGIN
        SET @C = 1;
        SET @S = 0;
        RETURN;
    END
    
    WHILE @temp > 0
    BEGIN
        SET @S = @S + (@temp % 10);
        SET @C = @C + 1;       
        SET @temp = @temp / 10;   
    END
END;



--8--
DROP PROCEDURE IF EXISTS GetServerInfo;
DROP PROCEDURE IF EXISTS CountDigits;
DROP PROCEDURE IF EXISTS AddRightDigit;
DROP PROCEDURE IF EXISTS InvDigit;
DROP PROCEDURE IF EXISTS Swap;
DROP PROCEDURE IF EXISTS SortInc;
DROP PROCEDURE IF EXISTS DigitCountSum;
