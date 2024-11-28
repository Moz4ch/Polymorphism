--1--
CREATE PROCEDURE GetCountriesWithHigherThanAverageDensity
AS
BEGIN
    DECLARE @AvgDensity FLOAT;
    
    SELECT @AvgDensity = AVG(Population / Area) 
    FROM Countries 
    GROUP BY Continent;
    
    SELECT Country, Capital
    FROM Countries
    WHERE (Population / Area) > @AvgDensity;
END


--2--
CREATE PROCEDURE GetAllCountries
AS
BEGIN
    SELECT * FROM Countries;
END

--3--
CREATE PROCEDURE GetCountriesExceptContinent (@ContinentName VARCHAR(50))
AS
BEGIN
    SELECT * FROM Countries
    WHERE Continent <> @ContinentName;
END

EXEC GetCountriesExceptContinent 'Asia';


--4--
CREATE PROCEDURE GetCountriesByPopulationRange (@MinPopulation INT, @MaxPopulation INT)
AS
BEGIN
    SELECT Country, Population
    FROM Countries
    WHERE Population BETWEEN @MinPopulation AND @MaxPopulation;
END

EXEC GetCountriesByPopulationRange 1000000, 50000000;


--5--
CREATE PROCEDURE GetCountriesWithoutLetter (@Letter CHAR(1))
AS
BEGIN
    SELECT COUNT(*) AS CountryCount
    FROM Countries
    WHERE country NOT LIKE '%' + @Letter + '%';
END

EXEC GetCountriesWithoutLetter 'A';


--6--
CREATE PROCEDURE GetTop5CountriesByPopulationInContinent (@ContinentName VARCHAR(50) = 'Africa')
AS
BEGIN
    SELECT TOP 5 country, Population
    FROM Countries
    WHERE Continent = @ContinentName
    ORDER BY Population DESC;
END

EXEC GetTop5CountriesByPopulationInContinent 'Asia';


--7--
CREATE PROCEDURE CreateTableWithCountriesStartingWithLetter
AS
BEGIN
    DECLARE @TableName NVARCHAR(128) = 'Countries_' + LEFT('ВашеФамилия', 1);

    EXEC('CREATE TABLE ' + @TableName + ' (Name NVARCHAR(100), Capital NVARCHAR(100), Population INT, Area FLOAT, Continent NVARCHAR(50));');

    EXEC('INSERT INTO ' + @TableName + ' (Name, Capital, Population, Area, Continent)
          SELECT Name, Capital, Population, Area, Continent
          FROM Countries
          WHERE Name LIKE ''В%'';'); 
END


--8--
CREATE PROCEDURE DropCountriesTableStartingWithLetter
AS
BEGIN
    DECLARE @TableName NVARCHAR(128) = 'Countries_' + LEFT('ВашеФамилия', 1);
    DECLARE @RowsDeleted INT;

    EXEC('SELECT @RowsDeleted = COUNT(*) FROM ' + @TableName);

    EXEC('DROP TABLE ' + @TableName);

    SELECT @RowsDeleted AS RowsDeleted;
END


--9--
DECLARE @ProcName NVARCHAR(128);
DECLARE proc_cursor CURSOR FOR
    SELECT name
    FROM sys.objects
    WHERE type = 'P' AND name LIKE 'Get%'
OPEN proc_cursor
FETCH NEXT FROM proc_cursor INTO @ProcName
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP PROCEDURE ' + @ProcName);
    FETCH NEXT FROM proc_cursor INTO @ProcName
END
CLOSE proc_cursor;
DEALLOCATE proc_cursor;

