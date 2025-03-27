# SQL Fundamentals

## Intermediate SQL

### Lesson 04 - Sorting and Grouping

### Sorting results

ORDER BY

Example:

```
SELECT title, budget
FROM films
ORDER BY budget (ASC/DESC)
```

- Multiple fields: ORDER BY field_one, field_two ...
- Different orders: ORDER BY field_one ASC, field_two DESC

1) Select the name of each person in the people table, sorted alphabetically

```
SELECT name
FROM people
ORDER BY name
```

2) Select the title and duration for every film, from longest duration to shortest

```
SELECT title, duration
FROM films
ORDER BY duration DESC;
```

3) Select the release_year, duration, and title of films ordered by their release year and duration, in that order

```
SELECT release_year, duration, title
FROM films
ORDER BY release_year, duration;
```

4) Select the certification, release_year, and title from films ordered first by certification (alphabetically) and second by release year, starting with the most recent year

```
SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year DESC;
```

### Grouping data

GROUP BY is a SQL keyword that allows you to group and summarize results with the additional use of aggregate functions.

Example:

```
SELECT certification, COUNT(title) AS title_count
FROM films
GROUP BY certification;
```

5) Select the release_year and count of films released in each year aliased as film_count

```
SELECT release_year, COUNT(title) as film_count
FROM films
GROUP BY release_year;
```

6) Select the release_year and average duration aliased as avg_duration of all films, grouped by release_year

```
SELECT release_year, AVG(duration) as avg_duration
FROM films
GROUP BY release_year;
```

GROUP BY becomes more powerful when used across multiple fields or combined with ORDER BY and LIMIT.

7) Select the release_year, country, and the maximum budget aliased as max_budget for each year and each country; sort your results by release_year and country

```
SELECT release_year, country, MAX(budget) as max_budget
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;
```

### Filtering grouped data

WHERE filters individual records, **HAVING** filters grouped records

Example: In what years was the average film duration over two hours?

```
SELECT release_year
FROM films
GROUP BY release_year
HAVING AVG(duration) > 120;
```

8) Select country from the films table, and get the distinct count of certification aliased as certification_count. Group the results by country. Filter the unique count of certifications to only results greater than 10.

```
SELECT country, COUNT(DISTINCT certification) as certification_count
FROM films
GROUP BY country
HAVING COUNT(DISTINCT certification) > 10;
```

9) Select the country and the average budget as average_budget, rounded to two decimal, from films. Group the results by country. Filter the results to countries with an average budget of more than one billion. Sort by descending order of the average_budget.

```
SELECT country, ROUND(AVG(budget), 2) as average_budget
FROM films
GROUP BY country
HAVING AVG(budget) > 1000000000
ORDER BY average_budget DESC;
```

10) 

```
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY avg_gross DESC
LIMIT 1;
```