# SQL Fundamentals

## Data Manipulation in SQL

### Lesson 03 - Correlated Queries, Nested Queries, and Common Table Expressions

### Correlated subquery

- Uses values from the outer query to generate a result
- Re-run for every row generated in the final data set
- Used for advanced joining, filtering, and evaluating data

1) You will practice using correlated subqueries to examine matches with scores that are extreme outliers for each country -- above 3 times the average score.

```
SELECT
	main.country_id,
    main.date,
    main.home_goal, 
    main.away_goal
FROM match AS main
WHERE
	(home_goal + away_goal) > 
        (SELECT AVG((sub.home_goal + sub.away_goal) * 3)
         FROM match AS sub
         WHERE main.country_id = sub.country_id);
```
2) 

```
SELECT
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE
	(home_goal + away_goal) = 
        (SELECT MAX(sub.home_goal + sub.away_goal)
         FROM match AS sub
         WHERE main.country_id = sub.country_id
               AND main.season = sub.season);
```
**Nested subqueries** --> Subquery inside another subquery!

3) You will practice creating a nested subquery to examine the highest total number of goals in each season, overall, and during July across all seasons.

```
SELECT
	-- Select the season and max goals scored in a match
	season,
    MAX(home_goal + away_goal) AS max_goals,
    -- Select the overall max goals scored in a match
   (SELECT MAX(home_goal + away_goal) FROM match) AS overall_max_goals,
   -- Select the max number of goals scored in any match in July
   (SELECT MAX(home_goal + away_goal) 
    FROM match
    WHERE id IN (
          SELECT id FROM match WHERE EXTRACT(MONTH FROM date) = 07)) AS july_max_goals
FROM match
GROUP BY season;
```
4) 

```
SELECT
	c.name AS country,
    -- Calculate the average matches per season
	AVG(outer_s.matches) AS avg_seasonal_high_scores
FROM country AS c
-- Left join outer_s to country
LEFT JOIN (
  SELECT country_id, season,
         COUNT(id) AS matches
  FROM (
    SELECT country_id, season, id
	FROM match
	WHERE home_goal >= 5 OR away_goal >= 5) AS inner_s
  -- Close parentheses and alias the subquery
  GROUP BY country_id, season) AS outer_s
ON c.id = outer_s.country_id
GROUP BY country;
```
### Common Table Expressions (CTE)

- Executed once
- CTE is then stored in memory
- Improves query performance
- Improving organization of queries
- Referencing other CTEs

You can list one (or more) subqueries as common table expressions (CTEs) by declaring them ahead of your main query, which is an excellent tool for organizing information and placing it in a logical order.

5) 

```
WITH match_list AS (
    SELECT 
  		country_id, 
  		id
    FROM match
    WHERE (home_goal + away_goal) >= 10)
-- Select league and count of matches from the CTE
SELECT
    l.name AS league,
    COUNT(match_list.id) AS matches
FROM league AS l
-- Join the CTE to the league table
LEFT JOIN match_list ON l.id = match_list.country_id
GROUP BY l.name;
```
6) 

```
WITH match_list AS (
    SELECT 
  		l.name AS league, 
     	m.date, 
  		m.home_goal, 
  		m.away_goal,
       (m.home_goal + m.away_goal) AS total_goals
    FROM match AS m
    LEFT JOIN league as l ON m.country_id = l.id)
SELECT league, date, home_goal, away_goal
FROM match_list
WHERE total_goals >= 10;
```