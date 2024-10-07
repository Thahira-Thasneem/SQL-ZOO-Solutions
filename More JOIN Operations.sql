
-- Exercise source: https://sqlzoo.net/wiki/More_JOIN_operations

-- 1. List the films where the yr is 1962 [Show id, title]
-- Solution:

SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'
-- Solution:

SELECT yr 
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
--    Order results by year
-- Solution:

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
-- Solution:

SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'
-- Solution:

SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'
-- Solution:

SELECT name
FROM actor
JOIN casting
ON actor.id = casting.actorid
WHERE movieid = (SELECT id FROM movie
                 WHERE title = 'Casablanca');

-- 7. Obtain the cast list for the film 'Alien'
-- Solution:

SELECT name
FROM actor
JOIN casting
ON actor.id = casting.actorid
WHERE movieid = (SELECT id 
                 FROM movie WHERE title = 'Alien');

-- 8. List the films in which 'Harrison Ford' has appeared
-- Solution:

SELECT title
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE actorid = (SELECT id FROM actor 
                 WHERE name = 'Harrison Ford');

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role
-- Solution:

SELECT title
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE actorid = (SELECT id FROM actor 
                 WHERE name = 'Harrison Ford') AND ord!= 1;

-- 10. List the films together with the leading star for all 1962 films
-- Solution:

SELECT title, name 
FROM (actor JOIN casting ON actor.id = casting.actorid)
JOIN movie
ON casting.movieid = movie.id
WHERE yr = 1962 and ord=1;

-- 11. Which were the busiest years for 'Rock Hudson', 
--     show the year and the number of movies he made each year for any year in which he made more than 2 movies
-- Solution:

SELECT yr, COUNT(movie.id) 
FROM (actor JOIN casting ON actor.id = casting.actorid)
JOIN movie 
ON casting.movieid = movie.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(movie.id) > 2 ;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in
-- Solution:

SELECT title, name 
FROM (actor JOIN casting ON actor.id = casting.actorid)
JOIN movie
ON movie.id = casting.movieid
WHERE ord= 1 AND movie.id IN (SELECT movieid FROM casting 
                              WHERE actorid = (SELECT id FROM actor
                                               WHERE name = 'Julie Andrews'));

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles
-- Solution:

SELECT name
FROM actor
JOIN casting
ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(*) >= 15
ORDER BY name ASC;

-- 14. List the films released in the year 1978, and how many actors they cast, ordered first by the number of actors in the cast, then by title
-- Solution:

SELECT title, COUNT(actorid)
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;

-- 15. List all the people who have worked with 'Art Garfunkel'
-- Solution:

SELECT name
FROM casting
JOIN actor
ON actor.id = casting.actorid
WHERE movieid IN (SELECT movieid FROM casting
                  WHERE actorid = (SELECT id FROM actor 
                  WHERE name = 'Art Garfunkel')) AND name!= 'Art Garfunkel';



