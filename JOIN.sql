
-- Exercise source: https://sqlzoo.net/wiki/The_JOIN_operation

-- 1. Show the matchid and player name for all goals scored by Germany
-- Solution:

SELECT matchid, player
FROM goal
WHERE teamid = 'GER';

-- 2. Show id, stadium, team1, team2 for just game 1012
-- Solution:

SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

-- 3. Show the player, teamid, stadium and mdate for every German goal
-- Solution:

SELECT player, teamid, stadium, mdate
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE teamid = 'GER';

-- 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
-- Solution:

SELECT team1, team2, player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE 'Mario%';

-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
-- Solution:

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam
ON goal.teamid = eteam.id
WHERE gtime <= 10;

-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
-- Solution:

SELECT mdate, teamname
FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
-- Solution:

SELECT player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- 8. Show the name of all players who scored a goal against Germany
-- Solution:

SELECT DISTINCT player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE (team1 = 'GER' OR team2 = 'GER') AND (teamid != 'GER');

-- 9. Show teamname and the total number of goals scored
-- Solution:

SELECT teamname, COUNT(goal.matchid) AS goals_scored
FROM goal
JOIN eteam
ON goal.teamid = eteam.id 
GROUP BY teamname;

-- 10. Show the stadium and the number of goals scored in each stadium
-- Solution:

SELECT stadium, COUNT(goal.matchid) AS goals_scored 
FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored
-- Solution:

SELECT matchid, mdate, COUNT(matchid) AS goals_scored
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
-- Solution:

SELECT matchid, mdate, COUNT(matchid) AS goals_scored
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY matchid, mdate;

-- 13. List every match with the goals scored by each team. Sort your result by mdate, team1 and team2
-- Solution:

SELECT mdate, team1, 
SUM(CASE WHEN team1=teamid THEN 1 ELSE 0 END) AS score1, team2,
SUM(CASE WHEN team2=teamid THEN 1 ELSE 0 END) AS score2
FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY mdate, team1, team2
ORDER BY STR_TO_DATE(mdate, '%d %M %Y'), team1, team2;

