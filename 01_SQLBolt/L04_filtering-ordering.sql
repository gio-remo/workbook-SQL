-- L4: https://sqlbolt.com/lesson/filtering_sorting_query_results

-- Unique results
SELECT DISTINCT col1 FROM mytable

-- Ordered results
SELECT col1, col2 FROM mytable
ORDER BY col1 ASC

-- Limited rows
SELECT * FROM mytable
LIMIT num_rows OFFSET num_offset

-- Exercises

-- 4.1 List all directors of Pixar movies (alphabetically), without duplicates
SELECT DISTINCT director FROM movies
ORDER BY director ASC -- ASC/DESC

-- 4.2 List the last four Pixar movies released (ordered from most recent to least)
SELECT title FROM movies
ORDER BY year DESC
LIMIT 4

-- 4.3 List the first five Pixar movies sorted alphabetically
SELECT title, year FROM movies
ORDER BY title ASC
LIMIT 5

-- 4.4 List the next five Pixar movies sorted alphabetically
SELECT title, year FROM movies
ORDER BY title ASC
LIMIT 5 OFFSET 5