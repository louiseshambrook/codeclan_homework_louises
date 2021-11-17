/*Question 1.
Find all the employees who work in the ‘Human Resources’ department. */

SELECT *
FROM employees
WHERE department = 'Human Resources'

/*
Question 2.
Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department. */

SELECT *
FROM employees
WHERE department = 'Legal'

/* Question 3.
Count the number of employees based in Portugal. */
SELECT
	COUNT (*)
FROM employees
WHERE country = 'Portugal'

/* Question 4.
Count the number of employees based in either Portugal or Spain. */
SELECT 
	COUNT (*)
FROM employees
WHERE country = 'Portugal' OR country = 'Spain'

/* Question 5.
Count the number of pay_details records lacking a local_account_no. */

SELECT 
	COUNT(*)
FROM pay_details
WHERE local_account_no IS NULL

Hint
Run a query first to get some records in the table, just to see what the data looks like

/* Question 6.
Are there any pay_details records lacking both a local_account_no and iban number? */

SELECT *
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL

/* Question 7.
Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).
*/

SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC NULLS LAST

/* Question 8.
Get a table of employees first_name, last_name and country, ordered alphabetically first by country and then by last_name (put any NULLs last). */ 

SELECT first_name, last_name, country
FROM employees
ORDER BY COUNTRY ASC NULLS LAST,
		last_name ASC NULLS LAST;

/* Question 9.
Find the details of the top ten highest paid employees in the corporation. */ 
SELECT employees, salary
FROM employees
ORDER BY salary DESC
	LIMIT 10;

/* Question 10.
Find the first_name, last_name and salary of the lowest paid employee in Hungary. */

SELECT *
FROM employees
WHERE country = 'Hungary'
ORDER BY salary DESC
	LIMIT 1;

/* Question 11.
How many employees have a first_name beginning with ‘F’? */ 

SELECT 
	COUNT(*)
FROM employees
WHERE first_name LIKE 'F%';

/* Question 12.
Find all the details of any employees with a ‘yahoo’ email address? */ 

SELECT *
FROM employees
WHERE email LIKE '%@yahoo%';

/* Question 13. Count the number of pension enrolled employees not based in either France or Germany. */ 

SELECT 
	COUNT(*)
FROM employees
WHERE pension_enrol = TRUE AND (country != 'France' AND country != 'Germany')

/* Question 14.
What is the maximum salary among those employees in the ‘Engineering’ department who work 1.0 full-time equivalent hours (fte_hours)? */ 

SELECT
	MAX (salary)
FROM employees
WHERE department = 'Engineering' AND fte_hours = 1.0


/* Question 15.
Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours),
salary, and a new column effective_yearly_salary which should contain fte_hours multiplied by salary.
*/

-- ANSWER

SELECT 
  first_name,
  last_name,
  fte_hours,
  salary,
  fte_hours * salary AS effective_yearly_salary
FROM employees
