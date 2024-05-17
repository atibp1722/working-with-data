SELECT * FROM employees LIMIT 5

SELECT cd.department_name,COUNT(*) FROM employees em
JOIN company_departments cd
ON em.department_id=cd.id
GROUP BY cd.department_name
HAVING COUNT(*)>40
ORDER BY cd.department_name DESC

SELECT
	em.last_name,em.start_date,em.job_title,
	(SELECT trunc(AVG(em1.salary),2) FROM employees em1 WHERE em.department_id=em1.department_id)
FROM employees em

SELECT trunc(AVG(salary),2) 
FROM (SELECT * FROM employees WHERE salary>100000)

SELECT department_id,job_title
FROM employees em
WHERE (SELECT MAX(salary) FROM employees em1)=em.salary

SELECT cr.country_name,cr.region_name,COUNT(em.*) 
FROM employees em
JOIN company_regions cr
ON em.region_id=cr.id
GROUP BY ROLLUP(cr.country_name,cr.region_name)
ORDER BY cr.country_name,cr.region_name

SELECT cr.country_name,cr.region_name,cd.department_name,COUNT(em.*)
FROM employees em
JOIN company_regions cr
ON em.region_id=cr.id
JOIN company_departments cd
ON em.department_id=cd.id
GROUP BY CUBE(cr.country_name,cr.region_name,cd.department_name)
ORDER BY cr.country_name,cd.department_name

SELECT job_title,start_date,salary FROM employees
ORDER BY salary DESC
FETCH FIRST 10 ROWS ONLY

SELECT SUM(em.salary),cd.department_name,COUNT(em.*)
FROM employees em
JOIN company_departments cd
ON em.department_id=cd.id
GROUP BY cd.department_name
HAVING SUM(salary)>5000000
ORDER BY SUM(salary) DESC
