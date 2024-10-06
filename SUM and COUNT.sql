
-- Exercise source: https://sqlzoo.net/wiki/SUM_and_COUNT

-- 1. Show the total population of the world
-- Solution:

SELECT SUM(population) 
FROM world;

-- 2. List all the continents - just once each
-- Solution:

SELECT DISTINCT continent
FROM world;

-- 3. Give the total GDP of Africa
-- Solution:

SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 4. How many countries have an area of at least 1000000
-- Solution:

SELECT COUNT(name)
FROM world
WHERE area >= 1000000;

-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania') 
-- Solution:

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6. For each continent show the continent and number of countries
-- Solution:

SELECT continent, COUNT(continent)
FROM world
GROUP BY continent;

-- 7. For each continent show the continent and number of countries with populations of at least 10 million
-- Solution:

SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. List the continents that have a total population of at least 100 million
-- Solution:

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000; 

