
-- Exercise source: https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial

-- 1. List each country name where the population is larger than that of 'Russia'
-- Solution:

SELECT name
FROM world
WHERE population > 
      (SELECT population 
       FROM world 
       WHERE NAME = 'Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'
-- Solution:

SELECT name
FROM world
WHERE continent = 'Europe' AND
      (gdp/population) > (SELECT gdp/population 
                          FROM world 
                          WHERE name = 'United Kingdom');

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country
-- Solution:

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent 
                    FROM world 
                    WHERE name IN ('Argentina', 'Australia'))
ORDER BY name;

-- 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population
-- Solution:

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'United Kingdom') AND 
      population < (SELECT population FROM world WHERE name = 'Germany');

-- 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany
-- Solution:

SELECT name, 
CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100),'%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
-- Solution:

SELECT name
FROM world
WHERE gdp > (SELECT MAX(gdp) 
             FROM world 
             WHERE continent = 'Europe');

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area
-- Solution:

SELECT continent, name, area
FROM world
WHERE area IN (SELECT MAX(area)
               FROM world 
               GROUP BY continent);

-- 8. List each continent and the name of the country that comes first alphabetically
-- Solution:

SELECT continent, name 
FROM world AS x 
WHERE name <= ALL(SELECT name 
                  FROM world AS y 
                  WHERE x.continent = y.continent);

-- 9. Find the continents where all countries have a population <= 25000000. 
--    Then find the names of the countries associated with these continents. Show name, continent and population 
-- Solution:

SELECT name, continent, population
FROM world
WHERE continent IN 
    (SELECT continent FROM world
     GROUP BY continent
     HAVING MAX(population) <= 25000000);

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). 
--     Give the countries and continents
-- Solution:

SELECT name, continent
FROM world AS x
WHERE x.population > 
    ALL(SELECT 3*population
        FROM world AS y
        WHERE x.continent = y.continent AND x.name != y.name);

