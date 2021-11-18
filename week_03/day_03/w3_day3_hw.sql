/* Question 1. */

SELECT 
	COUNT (id)
FROM employees
WHERE grade IS NULL AND salary IS NULL


/* Question 2.*/

SELECT
	department,
	CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY department, last_name

/* Question 3. .*/ 

SELECT *
FROM employees
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10

/* Question 4. */

SELECT 
	COUNT(*),
	department
FROM employees
WHERE start_date BETWEEN '01-01-2003' AND '12-31-2003'
GROUP BY department

/* Question 5. */ 

SELECT
	department,
	fte_hours,
	COUNT (*) AS num_employees
FROM employees
GROUP BY department, fte_hours
ORDER BY fte_hours

/* Question 6.
Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown enrollment status in the
corporation pension scheme. */

SELECT 
	pension_enrol,
	COUNT (*)
FROM employees
GROUP BY pension_enrol;


/* Question 7.
Obtain the details for the employee with the highest salary in the ‘Accounting’ department who is not enrolled in the pension
scheme? */ 

SELECT 
	*
FROM employees
WHERE department = 'Accounting' AND pension_enrol IS FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1;

/* Question 8.
Get a table of country
number of employees in that country
and the average salary of employees in that country for any
countries in which more than 30 employees are based. Order the table by average salary descending.

Hints
A clause is needed to filter using an aggregate function. You can pass a column alias to . */

SELECT
	country,
	COUNT(id) AS number_employees,
	AVG(salary) AS avg_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY AVG(salary) DESC;

/* Question 9.
11. Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary,
and a new column effective_yearly_salary which should contain fte_hours multiplied by salary. Return only rows where
effective_yearly_salary is more than 30000. */

SELECT
	first_name,
	last_name,
	fte_hours,
	fte_hours * salary AS effective_yearly_salary,
	salary
FROM employees
WHERE fte_hours * salary > 30000


/* Question 10 */

SELECT
	e.*,
	t.name
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
WHERE t.name = 'Data Team 1' OR t.name = 'Data Team 2'

/* Question 11 */

SELECT
	e.first_name,
	e.last_name,
	p.local_tax_code
FROM
	(employees AS e LEFT JOIN teams AS t ON t.id = e.team_id)
	LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id
WHERE local_tax_code IS NULL;


/* Question 12. */ 

SELECT
	e.id,
	e.first_name,
	e.last_name,
	t.charge_cost,
	(48 * 35 * CAST((t.charge_cost) AS INT) - e.salary) * e.fte_hours AS expected_profit 
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id  
ORDER BY (48 * 35 * CAST((t.charge_cost) AS INT) - e.salary) * e.fte_hours DESC NULLS LAST


/* Question 13. [Tough]
Find the first_name, last_name and salary of the lowest paid employee in Japan who works the least common full-time equivalent
hours across the corporation.”
Hint
You will need to use a subquery to calculate the mode */ 

SELECT
	first_name,
	last_name,
	salary,
	fte_hours
FROM employees
WHERE country = 'Japan' AND fte_hours IN (
  SELECT fte_hours
  FROM employees
  GROUP BY fte_hours
  HAVING COUNT(*) = (
    SELECT MIN(count)
    FROM
   (SELECT COUNT(*) AS count
    FROM employees
    GROUP BY fte_hours)
    AS temp
  )
);

/*
Question 14. */

SELECT
	COUNT (id),
	department
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) > 1
ORDER BY count(id) DESC, department

/* Q15 */ 

SELECT
	first_name,
	COUNT (id)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(id) > 1
ORDER BY COUNT (id) DESC, first_name

/* Q16 */

SELECT
	department,
	CAST(SUM(CAST(grade = '1' AS INT)) / CAST(COUNT(id) AS REAL)AS DECIMAL(10, 2)) AS prop_grade_1
FROM employees
GROUP BY department
ORDER BY prop_grade_1 DESC
