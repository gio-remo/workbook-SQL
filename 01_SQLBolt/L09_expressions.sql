-- https://sqlbolt.com/lesson/select_queries_with_expressions

-- Exercises

-- 9.1 List all movies and their combined sales in millions of dollars
SELECT title, (domestic_sales+international_sales)/1000000 AS sales
FROM movies INNER JOIN boxoffice ON id=movie_id

-- 9.2 List all movies and their ratings in percent
SELECT title, rating*10
FROM movies INNER JOIN boxoffice ON id=movie_id

-- 9.3 List all movies that were released on even number years
SELECT title, year FROM movies
WHERE (year%2)=0