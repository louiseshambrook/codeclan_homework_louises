-- MVP
-- Q1.a

SELECT
	e.first_name AS first_name,
	e.last_name AS last_name,
	t.name AS team_name
FROM employees AS e INNER JOIN teams as t
ON t.id = e.team_id

-- MVP
-- Q1.b

SELECT
	e.first_name AS first_name,
	e.last_name AS last_name,
	t.name AS team_name,
	e.pension_enrol AS pension_enrolled
FROM employees as e INNER JOIN teams as t
ON t.id = e.team_id
WHERE e.pension_enrol = TRUE

-- MVP
-- Q1.c

SELECT
	CAST (t.charge_cost AS INT4),
	e.first_name AS first_name,
	e.last_name AS last_name,
	t.name AS team_name
FROM employees as e INNER JOIN teams as t
ON t.id = e.team_id
WHERE CAST (t.charge_cost AS INT4) > 80

-- MVP
-- Q2.a

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code 
FROM employees AS e LEFT JOIN pay_details AS p
ON p.id = e.pay_detail_id

-- MVP
-- Q2.b

SELECT
	e.*,
	p.local_account_no,
	p.local_sort_code,
	t.name AS team_name
FROM
	(employees AS e LEFT JOIN teams AS t ON t.id = e.team_id)
	LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id;

-- MVP
-- Q3.a

SELECT
	e.id AS employee_id,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id;

-- MVP
-- Q3.b

SELECT
	COUNT (e.id) AS employee_sum,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.name

-- MVP
-- Q3.c

SELECT
	COUNT (e.id) AS employee_sum,
	t.name AS team_name
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.name
ORDER BY employee_sum ASC

-- MVP
-- Q4.a

SELECT
	COUNT (e.id),
	t.name AS team_name,
	t.id
FROM employees AS e LEFT JOIN teams AS t ON e.team_id = t.id
GROUP BY t.id

SELECT 
  t.id,  
  t.name,
  COUNT(e.id)
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id

-- MVP
-- Q4.b

SELECT
	COUNT (t.id) AS employee_sum,
	t.name AS team_name,
	CAST (t.charge_cost AS INT4) * COUNT(t.id) AS total_day_charge
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id;

-- MVP
-- Q4.c

SELECT
	COUNT (t.id) AS employee_sum,
	t.name AS team_name,
	CAST (t.charge_cost AS INT4) * COUNT(t.id) AS total_day_charge
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id
ORDER BY total_day_charge DESC 
LIMIT 5

-- Ext.
-- Q5.

SELECT
	COUNT (committee_id) AS total_committees,
	employee_id
FROM employees_committees
GROUP BY employee_id 


    