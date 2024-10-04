-- L11: https://sqlbolt.com/lesson/select_queries_with_aggregates_pt_2

-- Exercises

-- 11.1 Find the number of Artists in the studio (without a HAVING clause)
SELECT COUNT(*) AS n_artists FROM employees
WHERE role="Artist"

-- 11.2 Find the number of Employees of each role in the studio
SELECT role, count(*) FROM employees
GROUP BY role

-- 11.3 Find the total number of years employed by all Engineers
SELECT SUM(years_employed) AS sum FROM employees
WHERE role="Engineer"