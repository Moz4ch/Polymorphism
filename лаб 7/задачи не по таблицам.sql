--1--
DECLARE @A INT = 5, @B INT = 10;
SELECT @A * @B AS Product;

--2--
DECLARE @D INT = 28, @M INT = 2;
DECLARE @Year INT = 2023;
DECLARE @Date DATE = CAST(CONCAT(@Year, '-', @M, '-', @D) AS DATE);
SELECT DATEADD(DAY, 1, @Date) AS NextDate;

--3--
DECLARE @N INT = 10; 
DECLARE @Sum INT = 0;
WHILE @N > 0
BEGIN
    IF @N % 2 <> 0
        SET @Sum = @Sum + @N * @N;
    SET @N = @N - 1;
END
SELECT @Sum AS SumOfSquares;

--4--
DECLARE @Number INT = 1234;
DECLARE @Sum INT = 0;
WHILE @Number > 0
BEGIN
    SET @Sum = @Sum + (@Number % 10);
    SET @Number = @Number / 10;
END

SELECT @Sum AS SumOfDigits;


--5--
DECLARE @A INT = 5, @B INT = 10, @C INT = 3; -- Пример значений a, b, c
SELECT 
    CASE 
        WHEN @A <= @B AND @A <= @C THEN @A
        WHEN @B <= @A AND @B <= @C THEN @B
        ELSE @C 
    END AS SmallestNumber;

--6--
DECLARE @A INT = 121;
IF @A % 11 = 0
    SELECT 'Yes' AS Result;
ELSE
    SELECT 'No' AS Result;

--7--
DECLARE @N INT = 81;
DECLARE @IsPowerOf3 BIT = 0;

WHILE @N > 1
BEGIN
    IF @N % 3 <> 0
        SET @IsPowerOf3 = 0;
    SET @N = @N / 3;
END

IF @IsPowerOf3 = 1 OR @N = 1
    SELECT 'Yes' AS Result;
ELSE
    SELECT 'No' AS Result;

--8--
DECLARE @A INT = 12, @B INT = 18;
DECLARE @GCD INT;
DECLARE @TempA INT = @A;
DECLARE @TempB INT = @B;

WHILE @TempB <> 0
BEGIN
    SET @GCD = @TempB;
    SET @TempB = @TempA % @TempB;
    SET @TempA = @GCD;
END

DECLARE @LCM INT;
SET @LCM = (@A * @B) / @GCD;
SELECT @LCM AS LCM;


--9--
DECLARE @A INT = 1, @B INT = 5;
DECLARE @Sum INT = 0;

WHILE @A <= @B
BEGIN
    SET @Sum = @Sum + @A * @A;
    SET @A = @A + 1;
END

SELECT @Sum AS SumOfSquares;

--10--
DECLARE @Number INT = 1;

WHILE 1 = 1
BEGIN
    IF @Number % 2 = 1 AND @Number % 3 = 1 AND @Number % 4 = 1 AND @Number % 5 = 1 AND @Number % 6 = 1 AND @Number % 7 = 0
    BEGIN
        SELECT @Number AS Result;
        BREAK;
    END
    SET @Number = @Number + 1;
END


--11--
DECLARE @Surname NVARCHAR(50) = 'Перекрестов';
DECLARE @Length INT = LEN(@Surname);
DECLARE @I INT = 1;

WHILE @I <= @Length
BEGIN
    PRINT @Surname;
    SET @I = @I + 1;
END

--12--
SELECT SERVERPROPERTY('MachineName') AS ServerName,
       DB_NAME() AS DatabaseName,
       SYSTEM_USER AS CurrentUser,
       GETDATE() AS CurrentTime;

--13--
DECLARE @BaseStr NVARCHAR(100) = 'НиЖневартовск'; 
DECLARE @CurrentStr NVARCHAR(100) = ''; 
DECLARE @Length INT = LEN(@BaseStr); 

DECLARE @Index INT = 1;

WHILE @Index <= @Length
BEGIN
    SET @CurrentStr = @CurrentStr + SUBSTRING(@BaseStr, @Index, 1);

    PRINT @CurrentStr;

    SET @Index = @Index + 1;
END















