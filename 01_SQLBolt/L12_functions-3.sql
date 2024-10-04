-- L12: https://sqlbolt.com/lesson/select_queries_order_of_execution

-- FROM, JOIN
-- WHERE (rows that do not satisfy the constraint are discarded)
-- GROUP BY (when you have aggregate functions in your query)
-- HAVING (discard the grouped rows that don't satisfy the constraint)
-- expressions in the SELECT
-- DISTINCT
-- ORDER BY
-- LIMIT, OFFSET

-- Exercises

-- 12.1 Find the number of movies each director has directed
SELECT director, COUNT(director)
FROM movies
GROUP BY director

-- 12.2 Find the total domestic and international sales that can be attributed to each director
SELECT director, SUM(domestic_sales)+SUM(international_sales) AS sales
FROM movies INNER JOIN boxoffice ON id=movie_id
GROUP BY director