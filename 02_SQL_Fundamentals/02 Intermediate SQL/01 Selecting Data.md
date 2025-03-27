# SQL Fundamentals

## Intermediate SQL

### Lesson 01 - Selecting Data

### COUNT() and DISTINCT

COUNT() = counts the number of records with a value in a field

```
SELECT COUNT(birthdate) AS count_birthdates
FROM people;
```

COUNT(*) counts records in a table

```
SELECT COUNT(*) AS total_records
FROM people;
```

Combine COUNT() with DISTINCT to count unique values

```
SELECT COUNT(DISTINCT birthdate) AS count_distinct_birthdates
FROM people;
```

### Exercises

1) Count the total number of records in the people table, aliasing the result as count_records

```
SELECT COUNT(*) as count_records
FROM people
```

2) Count the number of records with a birthdate in the people table, aliasing the result as count_birthdate

```
SELECT COUNT(birthdate) as count_birthdate
FROM people
```

3) Count the records for languages and countries in the films table; alias as count_languages and count_countries

```
SELECT COUNT(language) as count_languages, COUNT(country) as count_countries
FROM films
```

4) Return the unique countries represented in the films table using DISTINCT

```
SELECT DISTINCT country
FROM films
```

Often query results will include many duplicate values. You can use the DISTINCT keyword to select the unique values from a field.

5) Return the number of unique countries represented in the films table, aliased as count_distinct_countries

```
SELECT COUNT(DISTINCT country) as count_distinct_countries
FROM films
```
