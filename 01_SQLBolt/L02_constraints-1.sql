-- L2: https://sqlbolt.com/lesson/select_queries_with_constraints

SELECT col1, col2 FROM mytable
WHERE col1="xxx" AND col2="yyy";

-- Numerical operators
-- =, !=, <, <=, >, >=

-- Number is within range of two values
-- BETWEEN 1 AND 10

-- Number is NOT within range of two values
-- NOT BETWEEN 1 AND 10

-- Number exists in a list
-- IN(2,3,4)

-- Number does not exist in a list
-- NOT IN(2,3,4)

-- Exercises

-- 2.1 Find the movie with a row id of 6
SELECT * FROM movies
WHERE id=6;

-- 2.2 Find the movies released in the years between 2000 and 2010
SELECT * FROM movies
WHERE year BETWEEN 2000 AND 2010;

-- 2.3 Find the movies not released in the years between 2000 and 2010
SELECT * FROM movies
WHERE year NOT BETWEEN 2000 AND 2010;

-- 2.4 Find the first 5 Pixar movies and their release year
SELECT * FROM movies
WHERE year < 2004;