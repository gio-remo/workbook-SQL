-- L19: https://sqlbolt.com/topic/subqueries

-- You now want to find out which of your Associates are costing the company more than the average revenue brought per Associate
-- First:
SELECT AVG(revenue_generated)
FROM sales_associates;
-- Together:
SELECT *
FROM sales_associates
WHERE salary > 
   (SELECT AVG(revenue_generated)
    FROM sales_associates);

-- You are now looking across the company to find the employees who perform worse than average in their department
SELECT *
FROM employees
WHERE revenue < 
   (SELECT AVG(revenue_generated)
    FROM employees AS dept_employees
    WHERE dept_employees.department = employees.department);

-- Employees employed for a longer time than the average in their department
select *
from employees AS a
where years_employed >
    (SELECT AVG(years_employed)
    FROM employees AS b
    WHERE b.building=a.building);