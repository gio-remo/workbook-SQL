# SQL Fundamentals

## Intermediate SQL

### Lesson 03 - Aggregate Functions

- AVG(), numerical only
- SUM(), numerical only
- MIN(), various data type, eg A-Z, 0-100, 1997-2024
- MAX(), various data type
- COUNT()

Example:

```
SELECT AVG(budget)
FROM films;
```

1)  Use the SUM() function to calculate the total duration of all films and alias with total_duration

```
SELECT SUM(duration) as total_duration
FROM films
```

2) Calculate the average duration of all films and alias with average_duration

```
SELECT AVG(duration) as average_duration
FROM films
```

3) Find the most recent release_year in the films table, aliasing as latest_year

```
SELECT MAX(release_year) as latest_year
FROM films
```

4) Find the duration of the shortest film and use the alias shortest_film

```
SELECT MIN(duration) as shortest_film
FROM films
```

### Summarizing subsets

When combining aggregate functions with WHERE, you get a powerful tool that allows you to get more granular with your insights.

Example:

```
SELECT AVG(budget) AS avg_budget
FROM films
WHERE release_year >= 2010;
```

This combination is useful when you only want to summarize a subset of your data.

ROUND(): Round a number to a specified decimal

```
SELECT ROUND(AVG(budget), 2) AS avg_budget
FROM films
WHERE release_year >= 2010;
```

5) Use SUM() to calculate the total gross for all films made in the year 2000 or later, and use the alias total_gross

```
SELECT SUM(gross) as total_gross
FROM films
WHERE release_year >= 2000;
```

6) Calculate the average amount grossed by all films whose titles start with the letter 'A' and alias with avg_gross_A

```
SELECT AVG(gross) as avg_gross_A
FROM films
WHERE title LIKE 'A%';
```

7) Calculate the lowest gross film in 1994 and use the alias lowest_gross

```
SELECT MIN(gross) as lowest_gross
FROM films
WHERE release_year = 1994
```

8) Calculate the highest gross film between 2000 and 2012, inclusive, and use the alias highest_gross

```
SELECT MAX(gross) as highest_gross
FROM films
WHERE release_year BETWEEN 2000 AND 2012;
```

9) Calculate the average facebook_likes to one decimal place and assign to the alias, avg_facebook_likes

```
SELECT ROUND(AVG(facebook_likes), 1) as avg_facebook_likes
FROM reviews
```

10) Calculate the average budget from the films table, aliased as avg_budget_thousands, and round to the nearest thousand

```
SELECT ROUND(AVG(budget), -3) as avg_budget_thousands
FROM films
```

11) Select the title and duration in hours for all films and alias as duration_hours

```
SELECT title, (duration / 60.0) as duration_hours
FROM films;
```

12) Calculate the percentage of people who are no longer alive and alias the result as percentage_dead

```
SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead
FROM people;
```

13) Find how many decades (period of ten years) the films table covers by using MIN() and MAX(); alias as number_of_decades

```
SELECT (MAX(release_year)-MIN(release_year)) / 10.0 AS number_of_decades
FROM films;
```