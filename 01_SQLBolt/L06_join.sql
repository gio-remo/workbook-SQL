-- L6: https://sqlbolt.com/lesson/select_queries_with_joins

-- Exercises

-- 6.1 Find the domestic and international sales for each movie
SELECT title, domestic_sales, international_sales
FROM movies INNER JOIN boxoffice ON movies.id=boxoffice.movie_id

-- 6.2 Show the sales numbers for each movie that did better internationally rather than domestically
SELECT title, domestic_sales, international_sales
FROM movies INNER JOIN boxoffice ON movies.id=boxoffice.movie_id
WHERE international_sales>domestic_sales

-- 6.3 List all the movies by their ratings in descending order
SELECT title, rating FROM movies
INNER JOIN boxoffice ON movies.id=boxoffice.movie_id
ORDER BY rating DESC