SELECT * FROM company_regions

SELECT UPPER(country_name) FROM company_regions
SELECT INITCAP(country_name) FROM company_regions
SELECT LOWER(INITCAP(country_name)) FROM company_regions

SELECT LTRIM('	Test')
SELECT RTRIM('Test	')
SELECT RTRIM(LTRIM(' Test '))='Test'

SELECT last_name||': '||job_title FROM employees
SELECT CONCAT(last_name,': ',NULL) FROM employees

SELECT substring('asdjadgqwnbasauy',1,3) text_string
SELECT substring('asdjadgqwnbasauy' from 1 for 5) text_string

SELECT COUNT(*), job_title from employees 
WHERE job_title LIKE '%engineer%' GROUP BY job_title

SELECT job_title, (job_title LIKE '%engineer%') is_engineer
FROM employees

SELECT DISTINCT job_title
FROM employees WHERE job_title SIMILAR TO 'vp_p%'

SELECT DISTINCT job_title
FROM employees WHERE job_title SIMILAR TO 'vp (p|s)%'

SELECT * FROM employees LIMIT 10

SELECT job_title, COUNT(job_title) as total_emp, SUM(salary) as total_sal,
CASE WHEN COUNT(job_title)=1
	 OR SUM(salary)<100000
	 THEN 1 ELSE 0
	 END AS title_check 
FROM employees GROUP BY job_title

SELECT x.id,x.last_name,
CASE WHEN x.job_title LIKE '%programmer%' THEN 1 ELSE 0 END AS helper_prog,
CASE WHEN x.job_title LIKE '%engineer%' THEN 1 ELSE 0 END AS helper_eng
FROM employees x
INNER JOIN company_regions y
ON x.region_id=y.id
WHERE country_name='usa'

CREATE EXTENSION fuzzystrmatch

SELECT SOUNDEX('job_title'),
	   SOUNDEX('job_titles'),
	   ('job_title'='job_titles'),
	   SOUNDEX('job_title')=SOUNDEX('job_titles')

SELECT DIFFERENCE('job_tilte','job_titles')

SELECT LEVENSHTEIN('job_tilte','job_titles')
