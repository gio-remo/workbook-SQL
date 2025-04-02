# SQL Fundamentals

## Data Manipulation in SQL

### Lesson 02 - Short and Simple Subqueries

1) Uou will generate a list of matches where the total goals scored (for both teams in total) is more than 3 times the average for games in the matches_2013_2014 table.

```
SELECT date, home_goal, away_goal
FROM matches_2013_2014
WHERE (home_goal + away_goal) >
    (SELECT 3 * AVG(home_goal + away_goal)
    FROM matches_2013_2014); 
```

2) Your goal in this exercise is to generate a list of teams that never played a game in their home city

```
SELECT team_long_name, team_short_name
FROM team 
WHERE team_api_id NOT IN
    (SELECT DISTINCT hometeam_id FROM match);
```

3) Create a list of teams that scored 8 or more goals in a home match.

```
SELECT team_long_name, team_short_name
FROM team
WHERE team_api_id IN
	(SELECT hometeam_id 
    FROM match
    WHERE home_goal >= 8);
```

**Subqueries in FROM**, to:
- Restructure and transform your data
- Calculating aggregates of aggregates

4) Your goal in this exercise is to generate a subquery using the match table, and then join that subquery to the country table to calculate information about matches with 10 or more goals in total.

```
SELECT c.name AS country_name, COUNT(sub.id) AS matches
FROM country AS c
INNER JOIN (SELECT country_id, id 
           FROM match
           WHERE (home_goal + away_goal) >= 10) AS sub
ON c.id = sub.country_id
GROUP BY country_name;
```

5) 

```
SELECT country, date, home_goal, away_goal
FROM
	(SELECT c.name AS country, 
     	    m.date, 
     		m.home_goal, 
     		m.away_goal,
           (m.home_goal + m.away_goal) AS total_goals
    FROM match AS m
    LEFT JOIN country AS c
    ON m.country_id = c.id) AS subq
WHERE total_goals >= 10;
```

**Subqueries in SELECT** need to return a **SINGLE value**, will generate an error otherwise!

6) You will construct a query that calculates the average number of goals per match in each country's league.

```
SELECT l.name AS league,
    ROUND(AVG(m.home_goal + m.away_goal), 2) AS avg_goals,
    (SELECT ROUND(AVG(home_goal + away_goal), 2) 
     FROM match
     WHERE season = '2013/2014') AS overall_avg
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
WHERE season = '2013/2014'
GROUP BY l.name;
```

7) 

```
SELECT
	l.name AS league,
	ROUND(AVG(home_goal + m.away_goal),2) AS avg_goals,
	ROUND(AVG(m.home_goal + m.away_goal) - 
		(SELECT AVG(home_goal + away_goal)
		 FROM match 
         WHERE season = '2013/2014'),2) AS diff
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
WHERE season = '2013/2014'
GROUP BY l.name;
```

8) You will build a final query across 3 exercises that will contain three subqueries -- one in the SELECT clause, one in the FROM clause, and one in the WHERE clause. In the final exercise, your query will extract data examining the average goals scored in each stage of a match.

```
SELECT
	stage,
	ROUND(s.avg_goals,2) AS avg_goals
FROM
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');
```

9) 

```
SELECT 
	stage,
    ROUND(s.avg_goals,2) AS avg_goal,
    (SELECT AVG(home_goal + away_goal) FROM match WHERE season = '2012/2013') AS overall_avg
FROM 
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');
```