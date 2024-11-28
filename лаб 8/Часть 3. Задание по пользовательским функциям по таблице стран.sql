--1--
CREATE FUNCTION GetCountryByCapital (@Capital VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @CountryName VARCHAR(255);
    SELECT @CountryName = Country
    FROM Countries
    WHERE Capital = @Capital;
    RETURN @CountryName;
END;

SELECT dbo.GetCountryByCapital('Токио');

--2--
CREATE FUNCTION ConvertPopulationToMillions (@Population INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Population / 1000000.0;
END;


SELECT dbo.ConvertPopulationToMillions(15000000);

--3--
CREATE FUNCTION GetPopulationDensity (@Continent VARCHAR(255))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalPopulation INT;
    DECLARE @TotalArea INT;
    SELECT @TotalPopulation = SUM(Population), @TotalArea = SUM(Area)
    FROM Countries
    WHERE Continent = @Continent;
    RETURN CAST(@TotalPopulation AS DECIMAL(10,2)) / @TotalArea;
END;

SELECT dbo.GetPopulationDensity('Europe');

--4--
CREATE FUNCTION GetThirdMostPopulatedCountry()
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @CountryName VARCHAR(255);
    WITH RankedCountries AS (
        SELECT Country, Population, ROW_NUMBER() OVER (ORDER BY Population DESC) AS Rank
        FROM Countries
    )
    SELECT @CountryName = Country
    FROM RankedCountries
    WHERE Rank = 3;
    RETURN @CountryName;
END;


SELECT dbo.GetThirdMostPopulatedCountry();


--5--
CREATE FUNCTION GetCountryWithMaxPopulation (@Continent VARCHAR(255) = 'Asia')
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @CountryName VARCHAR(255);
    SELECT TOP 1 @CountryName = Country
    FROM Countries
    WHERE Continent = @Continent
    ORDER BY Population DESC;
    RETURN @CountryName;
END;

SELECT dbo.GetCountryWithMaxPopulation('Europe');

--6--
CREATE FUNCTION ReplaceSubstring (@Word VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @NewWord VARCHAR(255);
    SET @NewWord = STUFF(@Word, 3, LEN(@Word) - 3, 'тест');
    RETURN @NewWord;
END;


SELECT dbo.ReplaceSubstring('Москва');


--7--
CREATE FUNCTION CountCountriesWithoutLetter (@Letter CHAR(1))
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM Countries
    WHERE Country NOT LIKE '%' + @Letter + '%';
    RETURN @Count;
END;

SELECT dbo.CountCountriesWithoutLetter('а');



--8--
CREATE FUNCTION GetCountriesByArea (@MaxArea INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Country, Area
    FROM Countries
    WHERE Area < @MaxArea
);


SELECT * FROM dbo.GetCountriesByArea(500000);


--9--
CREATE FUNCTION GetCountriesByPopulationRange (@MinPop INT, @MaxPop INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Country, Population
    FROM Countries
    WHERE Population BETWEEN @MinPop AND @MaxPop
);

SELECT * FROM dbo.GetCountriesByPopulationRange(10000000, 50000000);


--10--
CREATE FUNCTION GetContinentPopulation()
RETURNS TABLE
AS
RETURN
(
    SELECT Continent, SUM(Population) AS TotalPopulation
    FROM Countries
    GROUP BY Continent
);

SELECT * FROM dbo.GetContinentPopulation();


--11--
DROP FUNCTION dbo.GetCountryByCapital;
DROP FUNCTION dbo.ConvertPopulationToMillions;
DROP FUNCTION dbo.GetPopulationDensity;
DROP FUNCTION dbo.GetThirdMostPopulatedCountry;
DROP FUNCTION dbo.GetCountryWithMaxPopulation;
DROP FUNCTION dbo.ReplaceSubstring;
DROP FUNCTION dbo.CountCountriesWithoutLetter;
DROP FUNCTION dbo.GetCountriesByArea;
DROP FUNCTION dbo.GetCountriesByPopulationRange;
DROP FUNCTION dbo.GetContinentPopulation;

