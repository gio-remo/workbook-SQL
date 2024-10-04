-- L1: https://sqlbolt.com/lesson/select_queries_introduction

-- SELECT query for a specific columns
SELECT col1, col2 FROM mytable

-- SELECT query for all columns
SELECT * FROM mytable

-- Exercises

-- 1. Find the title of each film
SELECT Title FROM movies;

-- 2. Find the director of each film
SELECT Director FROM Movies;

-- 3. Find the title and director of each film
SELECT title, director FROM movies;

-- 4. Find the title and year of each film
SELECT title, year FROM movies;