-- L3: https://sqlbolt.com/lesson/select_queries_with_constraints_pt_2

-- Case sensitive exact string comparison
col_name = "abc"

-- Case sensitive exact string inequality comparison
col_name != "abc"

-- Case INSENSITIVE exact string comparison
col_name LIKE "ABC"

-- Case INSENSITIVE exact string inequality comparison
col_name NOT LIKE "ABC"

-- Anywhere in a string to match a sequence of zero or more characters
col_name LIKE "%AT%"
-- (matches "AT", "ATTIC", "CAT" or even "BATS")

-- Anywhere in a string to match a SINGLE character
col_name LIKE "AN_"
-- (matches "AND", but not "AN")

-- Exercises

-- 3.1 Find all the Toy Story movies
SELECT * FROM movies
WHERE title LIKE "toy story%"

-- 3.2 Find all the movies directed by John Lasseter
SELECT * FROM movies
WHERE director="John Lasseter"

-- 3.3 Find all the movies (and director) not directed by John Lasseter
SELECT title, director FROM movies
WHERE director!="John Lasseter"

-- 3.4 Find all the WALL-* movies
SELECT * FROM movies
WHERE title LIKE "WALL-_"