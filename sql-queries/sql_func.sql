SELECT department_id,salary,
FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY salary DESC)
FROM employees

SELECT department_id,salary,trunc(AVG(salary) OVER (PARTITION BY department_id),2)
FROM employees

SELECT department_id,salary,NTILE(4) OVER (PARTITION BY department_id ORDER BY salary)
FROM employees

SELECT department_id,salary,NTH_VALUE(salary,3) OVER (PARTITION BY department_id ORDER BY salary DESC)
FROM employees

SELECT department_id,salary,RANK() OVER (ORDER BY salary DESC) 
FROM employees

SELECT last_name,start_date,ROW_NUMBER() OVER (PARTITION BY id ORDER BY start_date)
FROM employees

SELECT department_id,salary,LEAD(salary,3) OVER (PARTITION BY department_id ORDER BY salary DESC) 
FROM employees

SELECT department_id,salary,LAG(salary,3) OVER (PARTITION BY department_id ORDER BY salary DESC) 
FROM employees

SELECT department_id,job_title,salary,
WIDTH_BUCKET(salary,0,150000,20)
FROM employees

SELECT department_id,job_title,salary,
CUME_DIST() OVER (ORDER BY salary DESC)*100
FROM employees

SELECT department_id,last_name,salary,SUM(salary) OVER (PARTITION BY department_id)
FROM employees

SELECT em.salary,cr.region_name,SUM(salary) OVER (PARTITION BY cr.id ORDER BY start_date)
FROM employees em
JOIN company_regions cr
ON em.region_id=cr.id
ORDER BY em.salary
