INSERT INTO emp_copy 
(SELECT e.name,e.salary,e.address,e.age,e.dept_name FROM emp e
JOIN dept d
ON d.dept_name=e.dept_name)
WHERE NOT EXISTS (SELECT * FROM 
                 emp_copy ec WHERE ec.emp_id=e.emp_id);

UPDATE emp e 
SET salary = (SELECT MAX(salary) + (MAX(salary)*0.25) FROM emp_copy ec 
             WHERE eh.dept_name=e.dept_name)
WHERE e.dept_name IN (SELECT dept_name FROM dept
                      WHERE dept_location='NYC')
AND e.emp_id IN (SELECT emp_id FROM emp_copy)

SELECT * FROM emp
WHERE salary > (SELECT avg(salary) FROM emp);

DELETE FROM dept
WHERE dept_name IN (SELECT dept_name FROM dept d
                   WHERE NOT EXISTS (SELECT * FROM emp e 
                   WHERE e.dept_name=d.dept_name)
                   );

SELECT * FROM emp 
WHERE dept_name IN (SELECT dept_name FROM dept 
                    WHERE dept_name='IT'
                    );

SELECT e.name,e.salary FROM emp e
WHERE salary > (SELECT salary FROM emp e1 
                WHERE e.manager=e1.emp_id
                );

SELECT * FROM emp 
WHERE (dept_name,salary) IN (SELECT dept_name,max(salary) 
      FROM emp GROUP BY dept_name
      );

SELECT MAX(salary) FROM emp 
WHERE salary < (SELECT MAX(salary) from emp 
                WHERE salary < (SELECT MAX(salary) FROM emp)
                );

SELECT * FROM dept 
WHERE dept_name NOT IN (
    SELECT DISTINCT dept_name FROM emp
    );

SELECT * FROM emp e
WHERE salary > (SELECT avg(salary) FROM emp e1 
                WHERE e1.dept_name=e.dept_name
                );

SELECT * FROM dept d
WHERE NOT EXISTS (SELECT * FROM emp e 
                 WHERE d.dept_name=e.dept_name
                 );

SELECT * FROM 
    (SELECT store_name, sum(sales) AS total_sales FROM sales 
    GROUP BY store_name) SALES
JOIN
SELECT avg(sales) AS sales FROM
    (SELECT store_name, sum(sales) AS total_sales FROM sales 
    GROUP BY store_name) avg_sales
ON SALES.total_sales>avg_sales.SALES;

SELECT * 
(CASE WHEN salary > (SELECT avg(salary) FROM emp)
         THEN 'Higher than average'
         ELSE ''
END) AS remark
FROM emp 
WHERE salary > avg(salary);

SELECT store_name,sum(quantity) AS ttl_qnt_sold
FROM sales GROUP BY(store_name)
HAVING sum(quantity) > (SELECT avg(quantity) FROM sales);

SELECT salary FROM emp (
    SELECT salary,DENSE_RANK() OVER (ORDER BY salary DESC) dr FROM emp
    WHERE dr=3
    );
