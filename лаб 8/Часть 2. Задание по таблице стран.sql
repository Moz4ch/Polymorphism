--1--
CREATE VIEW AfricanCountries AS
SELECT Country, Population, Area
FROM Countries
WHERE Continent = 'Africa'
  AND Population > 10000000
  AND Area > 500000;


--2--
CREATE VIEW ContinentalStatistics AS
SELECT Continent,
       AVG(Area) AS AvgArea,
       AVG(Population / NULLIF(Area, 0)) AS AvgDensity
FROM Countries
GROUP BY Continent;



--3--
DECLARE @SmallCountries TABLE (
    CountryName VARCHAR(255),
    Area INT,
    Continent VARCHAR(255)
);

INSERT INTO @SmallCountries (CountryName, Area, Continent)
SELECT c.Country, c.Area, c.Continent
FROM Countries c
JOIN ContinentalStatistics cs ON c.Continent = cs.Continent
WHERE c.Area < (cs.AvgArea / 100);

SELECT * FROM @SmallCountries;


--4--
CREATE TABLE ##ContinentAreaStats (
    Continent VARCHAR(255),
    MaxArea INT,
    MinArea INT
);

INSERT INTO ##ContinentAreaStats (Continent, MaxArea, MinArea)
SELECT Continent,
       MAX(Area) AS MaxArea,
       MIN(Area) AS MinArea
FROM Countries
GROUP BY Continent;

SELECT * FROM ##ContinentAreaStats;



--5--
CREATE TABLE ##CountryDensity (
    CountryName VARCHAR(255),
    PopulationDensity FLOAT
);

INSERT INTO ##CountryDensity (CountryName, PopulationDensity)
SELECT Country, Population / NULLIF(Area, 0) AS PopulationDensity
FROM Countries;

SELECT * FROM ##CountryDensity;


--6--
DROP VIEW IF EXISTS AfricanCountries;
DROP VIEW IF EXISTS ContinentalStatistics;

DROP TABLE IF EXISTS ##ContinentAreaStats;
DROP TABLE IF EXISTS ##CountryDensity;

