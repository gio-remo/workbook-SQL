-- L10: https://sqlbolt.com/lesson/select_queries_with_aggregates

-- COUNT()
-- MIN()
-- MAX()
-- AVG()
-- SUM()

-- Exercises

-- 10.1 Find the longest time that an employee has been at the studio
SELECT name, MAX(years_employed) AS years FROM employees

-- 10.2 For each role, find the average number of years employed by employees in that role
SELECT role, AVG(years_employed) AS years
FROM employees
GROUP BY role

-- 10.3 Find the total number of employee years worked in each building
SELECT building, SUM(years_employed) AS years
FROM employees
GROUP BY building