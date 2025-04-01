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