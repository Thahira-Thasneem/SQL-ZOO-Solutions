
-- Exercise source: https://sqlzoo.net/wiki/SELECT_names

-- 1. Find the country that start with Y
-- Solution:

SELECT name FROM world
WHERE name LIKE 'Y%';

-- 2. Find the countries that end with y
-- Solution:

SELECT name FROM world
WHERE name LIKE '%y';

-- 3. Find the countries that contain the letter x
-- Solution:

SELECT name FROM world
WHERE name LIKE '%x%';

-- 4. Find the countries that end with land
-- Solution:

SELECT name FROM world
WHERE name LIKE '%land';

-- 5. Find the countries that start with C and end with ia
-- Solution:

SELECT name FROM world
WHERE name LIKE 'C%ia';

-- 6. Find the country that has oo in the name
-- Solution:

SELECT name FROM world
WHERE name LIKE '%oo%';

-- 7. Find the countries that have three or more a in the name
-- Solution:

SELECT name FROM world
WHERE name LIKE '%a%a%a%';

-- 8. Find the countries that have "t" as the second character
-- Solution:

SELECT name FROM world
WHERE name LIKE '_t%';

-- 9. Find the countries that have two "o" characters separated by two others
-- Solution:

SELECT name FROM world
WHERE name LIKE '%o__o%';

-- 10. Find the countries that have exactly four characters
--Solution:

SELECT name FROM world
WHERE name LIKE '____';

-- 11. Find the country where the name is the capital city
-- Solution:

SELECT name
FROM world
WHERE name = capital;

-- 12. Find the country where the capital is the country plus "City"
-- Solution:

SELECT name
FROM world
WHERE capital = concat(name, ' City');

-- 13. Find the capital and the name where the capital includes the name of the country
-- Solution:

SELECT capital, name
FROM world
WHERE capital like concat('%',name,'%');

-- 14. Find the capital and the name where the capital is an extension of name of the country
-- Solution:

SELECT capital, name
FROM world
WHERE capital like concat(name, '%') and capital != name;

-- 15. Find the capital and the name where the capital is an extension of name of the country
-- Solution1 using substring:

SELECT name, substring(capital,(length(name)+1)) as extension
FROM world
WHERE capital like concat(name, '%') and capital != name;

--(or) Solution2 using replace:

SELECT name, REPLACE(capital, name, '') as extension
FROM world
WHERE capital LIKE concat('%', name, '%') AND capital != name;
