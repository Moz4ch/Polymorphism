--1--
WITH world_density AS (
    SELECT SUM(population) / SUM(area) AS avg_density
    FROM countries
),
continent_density AS (
    SELECT continent, SUM(population) / SUM(area) AS continent_density
    FROM countries
    GROUP BY continent
)
SELECT c.country
FROM countries c
JOIN continent_density cd ON c.continent = cd.continent
JOIN world_density wd ON 1 = 1
WHERE cd.continent_density > wd.avg_density;



--2--
WITH total_area AS (
    SELECT SUM(area) AS total_area
    FROM countries
)
SELECT country, (area * 100.0 / ta.total_area) AS area_percentage
FROM countries c
JOIN total_area ta ON 1 = 1;



--3--
WITH world_density AS (
    SELECT 
        SUM(population) * 1.0 / NULLIF(SUM(area), 0) AS avg_density
    FROM countries
)
SELECT country
FROM countries
WHERE area > 0 
  AND (population * 1.0 / area) > (SELECT avg_density FROM world_density);


