# SQL Fundamentals

## Joining Data in SQL

### Lesson 04 - Subqueries

### Semi and anti join

A semi join chooses records in the first table where its values are also in the second table. To do so, we build a SUBQUERY:

```
SELECT president, country, continent
FROM presidents
WHERE country IN
    (SELECT country
    FROM states
    WHERE indep_year < 1800);
```

1) Create a semi join out of the two queries you've written, which filters unique languages returned in the first query for only those languages spoken in the 'Middle East'.

```
SELECT DISTINCT name
FROM languages
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;
```

2) 

```
SELECT code, name
FROM countries
WHERE continent = 'Oceania'
AND code NOT IN
    (SELECT code
    FROM currencies);
```

### Subqueries inside WHERE and SELECT

3) 

```
SELECT *
FROM populations
WHERE year = 2015
    AND life_expectancy > 1.15 *
    (SELECT AVG(life_expectancy)
    FROM populations
    WHERE year = 2015);
```

4) Get the urban area population for capital cities only.

```
SELECT name, country_code, urbanarea_pop
FROM cities
WHERE name IN
    (SELECT DISTINCT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;
```

5) Using LEFT JOIN

```
SELECT countries.name AS country, COUNT(cities.name) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code
GROUP BY countries.name
ORDER BY cities_num DESC
LIMIT 9;
```

6) Using SUBQUERY

```
SELECT countries.name AS country, 
    (SELECT COUNT(cities.name)
    FROM cities
    WHERE country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;
```

### Subqueries inside FROM

7) Begin with a query that groups by each country code from languages, and counts the languages spoken in each country as lang_num

```
SELECT code, COUNT(name) as lang_num
FROM languages
GROUP BY code;
```

8) Select local_name from countries, with the aliased lang_num from your subquery

```
SELECT local_name, sub.lang_num
FROM countries,
    (SELECT code, COUNT(*) AS lang_num
    FROM languages
    GROUP BY code) AS sub
WHERE countries.code = sub.code
ORDER BY lang_num DESC;
```

9) Suppose you're interested in analyzing inflation and unemployment rate for certain countries in 2015. You are interested in countries with "Republic" or "Monarchy" as their form of government.

You will use the field gov_form to filter for these two conditions, which represents a country's form of government. You can review the different entries for gov_form in the countries table.

```
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 AND code IN
    (SELECT code
    FROM countries
    WHERE gov_form LIKE '%Republic%' OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;
```

10) Your task is to determine the top 10 capital cities in Europe and the Americas by city_perc, a metric you'll calculate.

```
SELECT name, country_code, city_proper_pop, metroarea_pop, (city_proper_pop / metroarea_pop * 100) as city_perc
FROM cities
WHERE name IN
(
    SELECT capital
    FROM countries
    WHERE continent = 'Europe' OR continent LIKE '%America'
)
AND metroarea_pop IS NOT NULL
GROUP BY cities.name
ORDER BY city_perc DESC
LIMIT 10;
```