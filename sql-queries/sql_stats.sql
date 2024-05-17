SELECT *
FROM employees LIMIT 10

SELECT count(*), MIN(salary), MAX(salary)
FROM employees

SELECT SUM(salary) FROM employees

SELECT job_title, count(start_date) FROM employees GROUP BY job_title

SELECT department_id, SUM(salary) FROM 
employees GROUP BY department_id

SELECT department_id, round(AVG(salary),2) FROM 
employees GROUP BY department_id

SELECT department_id, round(AVG(salary),2), round(var_pop(salary),2),
round(stddev_pop(salary),2) FROM
employees GROUP BY department_id

SELECT job_title, salary FROM 
employees GROUP BY(job_title, salary)

SELECT last_name, department_id, salary FROM 
employees WHERE salary>100000 AND last_name LIKE 's%'

SELECT * FROM
employees em JOIN
company_departments cd
ON em.department_id = cd.id

SELECT em.last_name, em.salary, cr.region_name, cr.country_name FROM
employees em JOIN
company_regions cr
ON em.region_id = cr.id
WHERE cr.country_name='usa'

SELECT em.last_name, em.salary, cr.region_name, cr.country_name,
cd.department_name, cd.division_name FROM
employees em JOIN
company_regions cr
ON em.region_id = cr.id
JOIN company_departments cd
ON em.department_id = cd.id
WHERE cr.country_name='canada'

SELECT emp.last_name, emp.email, cdp.department_name FROM
employees emp JOIN
company_departments cdp
ON emp.department_id=cdp.id
WHERE emp.salary>120000

SELECT date_trunc('month',x.start_date) as MONTH_NAME,
x.job_title,y.department_name,round(SUM(salary),2) as MONTHLY_SALARY FROM 
employees x JOIN
company_departments y
ON x.department_id=y.id
WHERE x.start_date BETWEEN '2021-01-01' AND '2021-12-30'
GROUP BY date_trunc('month',x.start_date),x.job_title,y.department_name

with total_salary as
(
	SELECT job_title, round(SUM(salary),2) as SUM_SALARY 
	FROM employees GROUP BY job_title
)
SELECT * FROM total_salary
SELECT round(AVG(SUM_SALARY),2) FROM total_salary

with title_count as
(
	SELECT id, job_title, salary, COUNT(*) FROM employees GROUP BY id,job_title,salary
)
SELECT x.id, x.department_name,y.job_title,y.salary,
CASE WHEN y.salary<50000 THEN 'Low Paying Dept.'
	WHEN y.salary BETWEEN 50000 and 60000 THEN 'Avg. Paying Dept.'
	WHEN y.salary>60000 and y.salary<100000 THEN 'Mid Paying Dept.'
	WHEN y.salary>100000 THEN 'High Paying Dept.'
END AS test_case
FROM company_departments x JOIN title_count y
ON x.id=y.id
