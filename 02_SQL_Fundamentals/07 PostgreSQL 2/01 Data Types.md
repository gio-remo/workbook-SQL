# SQL Fundamentals

## PostgreSQL 2

### Lesson 01 - Overview of Common Data Types

- Text data types: CHAR, VARCHAR and TEXT
- Numeric data types: INT and DECIMAL
- Date / time data types: DATE, TIME, TIMESTAMP, INTERVAL
- Arrays

### Date and time data types

ISO 8601 format: yyyy-mm-dd

1) 

```
SELECT
 	-- Select the rental and return dates
	rental_date,
	return_date,
 	-- Calculate the expected_return_date
	rental_date + INTERVAL '3 days' AS expected_return_date
FROM rental;
```

### Working with ARRAYs

Let's create a simple table with two array columns:

```
CREATE TABLE grades (
student_id int,
email text[][],
test_scores int[]
);

INSERT INTO grades
VALUES (1,
'{{"work","work1@datacamp.com"},{"other","other1@datacamp.com"}}',
'{92,85,96,88}' );

SELECT
email[1][1] AS type,
email[1][2] AS address,
test_scores[1],
FROM grades;
```

2) Select all films that have Deleted Scenes in the second index of the special_features ARRAY.

```
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[2] = 'Deleted Scenes';
```

PostgreSQL also provides the ability to filter results by searching for values in an ARRAY. The ANY function allows you to search for a value in any index position of an ARRAY

3) Match 'Trailers' in any index of the special_features ARRAY regardless of position

```
SELECT
  title, 
  special_features 
FROM film
WHERE 'Trailers' = ANY(special_features);
```

### Searching an ARRAY with @>

The contains operator @> operator is alternative syntax to the ANY function and matches data in an ARRAY

4) Use the contains operator to match the text Deleted Scenes in the special_features column.

```
SELECT 
  title, 
  special_features 
FROM film 
-- Filter where special_features contains 'Deleted Scenes'
WHERE special_features @> ARRAY['Deleted Scenes'];
```
