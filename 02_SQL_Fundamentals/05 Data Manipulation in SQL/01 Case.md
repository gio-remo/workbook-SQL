# SQL Fundamentals

## Data Manipulation in SQL

### Lesson 01 - We'll take the CASE

**CASE** statement contains a WHEN, THEN, and ELSE statement, finished with END:

```
CASE WHEN x = 1 THEN 'a'
    WHEN x = 2 THEN 'b'
    ELSE 'c' END AS new_column
```

1) 

```
SELECT team_long_name, team_api_id
FROM teams_germany
WHERE team_long_name IN ('FC Schalke 04', 'FC Bayern Munich');
```

2) Basic CASE statements

```
SELECT 
    CASE WHEN hometeam_id = 10189 THEN 'FC Schalke 04'
        WHEN hometeam_id = 9823 THEN 'FC Bayern Munich'
        ELSE 'Other' END AS home_team,
    COUNT(id) AS total_matches
FROM matches_germany
GROUP BY home_team;
```

3) CASE statements comparing column values

```
SELECT m.date, t.team_long_name AS opponent,
    CASE WHEN m.home_goal > m.away_goal THEN 'Barcelona win!'
    WHEN m.home_goal < m.away_goal THEN 'Barcelona loss :(' 
    ELSE 'Tie' END AS outcome 
FROM matches_spain AS m
LEFT JOIN teams_spain AS t 
ON m.awayteam_id = t.team_api_id
WHERE m.hometeam_id = 8634;
```

4) You will construct a query to determine the outcome of Barcelona's matches where they played as the away team.

```
SELECT m.date, t.team_long_name AS opponent,
	CASE WHEN m.home_goal < m.away_goal THEN 'Barcelona win!'
    WHEN m.home_goal > m.away_goal THEN 'Barcelona loss :(' 
    ELSE 'Tie' END AS outcome
FROM matches_spain AS m
LEFT JOIN teams_spain AS t 
ON m.hometeam_id = t.team_api_id
WHERE m.awayteam_id = 8634;
```

5) Complete the first CASE statement, identifying Barcelona or Real Madrid as the home team using the hometeam_id column

```
SELECT date,
	CASE WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
    ELSE 'Real Madrid CF' END AS home,
	CASE WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
    ELSE 'Real Madrid CF' END AS away
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634) AND (awayteam_id = 8633 OR hometeam_id = 8633);
```

6) Construct the final CASE statement identifying who won each match. Note there are 3 possible outcomes, but 5 conditions that you need to identify

```
SELECT 
	date,
	CASE WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
        ELSE 'Real Madrid CF' END as home,
	CASE WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
        ELSE 'Real Madrid CF' END as away,
	CASE WHEN home_goal > away_goal AND hometeam_id = 8634 THEN 'Barcelona win!'
        WHEN home_goal > away_goal AND hometeam_id = 8633 THEN 'Real Madrid win!'
        WHEN home_goal < away_goal AND awayteam_id = 8634 THEN 'Barcelona win!'
        WHEN home_goal < away_goal AND awayteam_id = 8633 THEN 'Real Madrid win!'
        ELSE 'Tie!' END AS outcome
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634)
      AND (awayteam_id = 8633 OR hometeam_id = 8633);
```

7) Create a CASE statement that identifies the id of matches played in the 2012/2013 season. Specify that you want ELSE values to be NULL

```
SELECT season, date, home_goal, away_goal
FROM matches_italy
WHERE CASE WHEN hometeam_id = 9857 AND home_goal > away_goal THEN 'Bologna Win'
    WHEN awayteam_id = 9857 AND away_goal > home_goal THEN 'Bologna Win'
    END IS NOT NULL;
```

**CASE** statements are great for
- Categorizing data
- Filtering data
- Aggregating data

8) Create 3 CASE WHEN statements counting the matches played in each country across the 3 seasons

```
SELECT 
	c.name AS country,
	COUNT(CASE WHEN m.season = '2012/2013' THEN m.id END) AS matches_2012_2013,
	COUNT(CASE WHEN m.season = '2013/2014' THEN m.id END) AS matches_2013_2014,
	COUNT(CASE WHEN m.season = '2014/2015' THEN m.id END) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
GROUP BY c.name;
```

9) Your goal here is to use the country and match table to determine the total number of matches won by the home team in each country during the 2012/2013, 2013/2014, and 2014/2015 seasons.

```
SELECT 
	c.name AS country,
	SUM(CASE WHEN m.season = '2012/2013' AND m.home_goal > m.away_goal 
        THEN 1 ELSE 0 END) AS matches_2012_2013,
 	SUM(CASE WHEN m.season = '2013/2014' AND m.home_goal > m.away_goal  
        THEN 1 ELSE 0 END) AS matches_2013_2014,
	SUM(CASE WHEN m.season = '2014/2015' AND m.home_goal > m.away_goal
        THEN 1 ELSE 0 END) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
GROUP BY c.name;
```

10) 

```
SELECT 
	c.name AS country,
	ROUND(AVG(CASE WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
		WHEN m.season='2013/2014' AND m.home_goal != m.away_goal THEN 0
		END),2) AS pct_ties_2013_2014,
	ROUND(AVG(CASE WHEN m.season='2014/2015' AND m.home_goal = m.away_goal THEN 1
		WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
		END),2) AS pct_ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;
```