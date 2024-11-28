--1--
DECLARE @Months TABLE (
    MonthNumber INT,
    MonthName VARCHAR(20),
    DaysInMonth INT
);

INSERT INTO @Months (MonthNumber, MonthName, DaysInMonth)
VALUES
(1, 'Январь', 31),
(2, 'Февраль', 28),
(3, 'Март', 31),
(4, 'Апрель', 30),
(5, 'Май', 31),
(6, 'Июнь', 30),
(7, 'Июль', 31),
(8, 'Август', 31),
(9, 'Сентябрь', 30),
(10, 'Октябрь', 31),
(11, 'Ноябрь', 30),
(12, 'Декабрь', 31);

SELECT * FROM @Months;

--2--
CREATE FUNCTION IsPalindrom (@P INT)
RETURNS INT
AS
BEGIN
    DECLARE @Original INT, @Reversed INT, @Digit INT;

    IF @P <= 0
        RETURN 0;

    SET @Original = @P;
    SET @Reversed = 0;

    WHILE @P > 0
    BEGIN
        SET @Digit = @P % 10;
        SET @Reversed = @Reversed * 10 + @Digit;
        SET @P = @P / 10;
    END

    IF @Original = @Reversed
        RETURN 1;
    ELSE
        RETURN 0;
END;

SELECT dbo.IsPalindrom(121);  -- Результат: 1 (палиндром)
SELECT dbo.IsPalindrom(123);  -- Результат: 0 (не палиндром)


--3--
CREATE FUNCTION Quarter (@x FLOAT, @y FLOAT)
RETURNS INT
AS
BEGIN
    IF @x > 0 AND @y > 0
        RETURN 1;
    IF @x < 0 AND @y > 0
        RETURN 2;
    IF @x < 0 AND @y < 0
        RETURN 3; 
    IF @x > 0 AND @y < 0
        RETURN 4; 
    RETURN 0;
END;

SELECT dbo.Quarter(5, 10); 
SELECT dbo.Quarter(-5, 10);  
SELECT dbo.Quarter(-5, -10); 
SELECT dbo.Quarter(5, -10); 

--4--
CREATE FUNCTION IsPrime (@N INT)
RETURNS INT
AS
BEGIN
    IF @N <= 1
        RETURN 0;

    DECLARE @i INT = 2;
    WHILE @i <= SQRT(@N)
    BEGIN
        IF @N % @i = 0
            RETURN 0;
        SET @i = @i + 1;
    END

    RETURN 1;
END;

SELECT dbo.IsPrime(7);  
SELECT dbo.IsPrime(10);

