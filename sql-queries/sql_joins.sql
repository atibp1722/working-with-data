CREATE Table Orders (Numerodeorder int, IDCustomer int)
GO
CREATE Table Customers( name varchar(200), firstname varchar(200), IDCustomer int, address varchar(200), city varchar(200))

INSERT into Orders VALUES
('3712',1),
('4851',2),
('6712',3),
('3215',4),
('3218',5),
('3220',6),
('3221',7),
('3227',8),
('3238',9)

INSERT into Customers VALUES
('Bill','Gates',1,'7 street Bill','Chicago'),
('Sinatra','Franck',3,'78 street Sinatra','Paris'),
('Jordan','Mickael',5,'15 street Jordan','Asterdam'),
('Einstein','Albert',12,'7 street Einstein','Prague'),
('Noris','Chuck',13,'7 street Noris','Vienne')

SELECT *FROM Orders
go
SELECT* FROM Customers

--INNER JOIN
SELECT A.IDCustomer, B.firstname FROM Orders A
INNER JOIN Customers B
ON A.IDCustomer=B.IDCustomer;

--LEFT AND RIGHT JOIN
SELECT B.IDCustomer, B.firstname FROM Customers B
LEFT JOIN Orders A
ON B.IDCustomer=A.IDCustomer;

SELECT B.IDCustomer, B.name, B.firstname FROM Customers B
LEFT JOIN Orders A
ON B.IDCustomer=A.IDCustomer
WHERE A.IDCustomer IS NULL;

SELECT B.IDCustomer, B.firstname FROM Orders A
RIGHT JOIN Customers B
ON A.IDCustomer=B.IDCustomer;

SELECT B.IDCustomer, B.firstname FROM Orders A
RIGHT JOIN Customers B
ON A.IDCustomer=B.IDCustomer
WHERE A.IDCustomer IS NULL;

SELECT B.IDCustomer, B.firstname FROM Customers B
LEFT OUTER JOIN Orders A
ON B.IDCustomer=A.IDCustomer
WHERE A.IDCustomer IS NULL;

SELECT B.IDCustomer, B.firstname FROM Orders A
RIGHT OUTER JOIN Customers B
ON A.IDCustomer=B.IDCustomer
WHERE A.IDCustomer IS NULL;

--FULL OUTER JOIN
SELECT A.IDCustomer FROM Orders A
FULL OUTER JOIN Customers B
ON A.IDCustomer=B.IDCustomer

SELECT B.IDCustomer FROM Customers B
FULL OUTER JOIN Orders A
ON B.IDCustomer=A.IDCustomer;

SELECT B.IDCustomer FROM Orders A 
FULL OUTER JOIN Customers B
ON A.IDCustomer=B.IDCustomer
WHERE A.IDCustomer IS NULL;

--CROSS JOIN
SELECT * FROM Orders A
CROSS JOIN Customers B

SELECT B.IDCustomer, B.name, B.firstname FROM Customers B
INNER JOIN Orders A
ON A.IDCustomer=B.IDCustomer;

SELECT B.IDCustomer, B.name, B.firstname FROM Customers B
CROSS APPLY(SELECT * FROM Orders A WHERE B.IDCustomer=A.IDCustomer)A

Create table Loyalty_card  (Loyal char(5), IDCustomer int)
INSERT into Loyalty_card values 
('YES', 1),
('YES', 2),
('NO', 3),
('YES', 4),
('NO', 5),
('YES', 6),
('NO', 7),
('YES', 8),
('YES', 9),
('NO', 10),
('YES', 11),
('NO', 12)

SELECT A.IDCustomer, A.firstname FROM Customers A
INNER JOIN Orders B
ON A.IDCustomer=B.IDCustomer
INNER JOIN Loyalty_card C
ON B.IDCustomer = C.IDCustomer
WHERE Loyal='YES';

--LEFT JOIN WITH NOT IN & NOT EXIST
SELECT B.IDCustomer, B.firstname FROM Customers B
LEFT JOIN Orders A
ON A.IDCustomer=B.IDCustomer
WHERE A.IDCustomer IS NULL;

SELECT IDCustomer, firstname, name FROM Customers
WHERE IDCustomer NOT IN
(SELECT IDCustomer FROM Orders)

SELECT B.IDCustomer, B.name, B.firstname FROM Customers B
WHERE NOT EXISTS (SELECT * FROM Orders A WHERE A.IDCustomer=B.IDCustomer);

--EXCEPT AND INTERSECT
SELECT A.IDCustomer FROM Orders A
INNER JOIN Customers B
ON A.IDCustomer=B.IDCustomer;

SELECT IDCustomer FROM Customers
INTERSECT SELECT IDCustomer FROM Orders

SELECT IDCustomer FROM Customers
EXCEPT SELECT IDCustomer FROM Orders

create table salary_scale (job varchar (200),salary varchar(200))
go
create table employee ( IDclient int,[name] varchar (200),firstname varchar (200), age varchar(2000),gender varchar(200),date_birth varchar(200),[job] varchar (200))
go
create table Job_status (IDclient int,[Types] varchar (200))

insert into salary_scale values 
('Human resources','between 2000$ and 3000$'),
('Buisness developer','between 2500$ and 5000$'),
('Recruiter','between 2200$ and 6000$'),
('financial services','between 5000$ and 10000$')
go 
insert into employee values 
(1,'Jackson','Mickael',18,'F','1976-08-04','Human resources'),
(1,'Taylor','Liz',16,'F','1978-08-02','Buisness developer'),
(2,'Grace','Kelly',17,'F','1987-05-02','Recruiter'),
(1,'Eastwood','Clint',23,'M','1970-05-06','financial services'),
(1,'Willis','Bruce',22,'M','1983-08-02','Recruiter'),
(3,'Dicaprio','Leonardo',22,'M','1983-08-02','Buisness developer'),
(2,'Pitt','Brad',37,'M','1975-08-02','Buisness developer'),
(2,'Clooney','George',22,'M','1983-01-01','Human resources'),
(2,'Monroe','Marylin',48,'M','1960-06-12','Human resources'),
(2,'Roberts','Julia',47,'F','1968-06-12','Recruiter'),
(1,'Jolie','Angelina',28,'M','1972-07-24','Human resources'),
(1,'Thuillier','olivier',41,'M','12-08-1976','Buisness developer'),
(2,'Chuillier','olivier',43,'M','12-08-1978','financial services'),
(1,'Meilhac','ludivine',45,'F','08-05-1983','financial services'),
(2,'Stone','Sharon',34,'F','1983-05-08','financial services'),
(4,'Willis','Bruce',22,'M','1983-08-02','Human resources'),
(2,'Brando','Marlon',48,'M','12-06-1960','Human resources'),
(3,'Smith','Will',47,'F','22-01-1965','Recruiter'),
(1,'Watson','Emma',57,'M','24-09-1978','Human resources'),
(2,'Hanks','Tom',41,'M','12-08-1976','Recruiter'),
(2,'Gary','Grant',44,'M','12-08-1976','financial services'),
(1,'Clarke','Emilia',37,'F','08-05-1983','Buisness developer'),
(6,'Bardot','Brigitte',47,'F','22-01-1965','financial services'),
(5,'Cotillard','Marion',22,'M','01-01-1983','Human resources'),
(4,'Williams','Robin',48,'M','12-06-1960','Human resources'),
(2,'Stallone','Sylvester',47,'F','22-01-1965','Recruiter'),
(2,'Blanchett','Cate',28,'M','24-09-1988','Human resources'),
(3,'Redford','Robert',55,'M','12-08-1973','Buisness developer'),
(3,'Forster','Robert',58,'M','12-08-1970','financial services'),
(4,'Walters','Julie',47,'F','08-05-1978','Recruiter'),
(1,'Hall','Rebecca',52,'F','22-01-1963','Recruiter')
go 
insert into Job_status values
(1,'Full-Time contracts'),
(2,'Part-Time contracts'),
(3,'Temporary contracts'),
(4, 'Zero hours contracts')

SELECT * FROM salary_scale
SELECT * FROM employee
SELECT * FROM Job_status

SELECT E.IDclient, E.name, S.job FROM employee E
JOIN salary_scale S
ON E.job = S.job;

SELECT B.firstname, B.IDclient, B.job FROM employee B
CROSS APPLY (SELECT A.job FROM salary_scale A WHERE A.job=B.job)A

SELECT E.name, E.firstname, E.job FROM employee E
INNER JOIN salary_scale S
ON E.job=S.job
WHERE E.gender='F' AND S.job='Recruiter';

SELECT J.IDclient, E.name, E.firstname, E.job FROM employee E 
INNER JOIN Job_status J
ON E.IDclient = J.IDclient 
INNER JOIN salary_scale S
ON E.job=S.job
WHERE J.[Types]='Full-Time contracts' AND S.salary='between 2000$ and 3000$'

SELECT E.[name], E.firstname,
CASE WHEN J.[Types] IS NULL THEN 'No contract' END AS 'Contract Status'
FROM employee E
LEFT JOIN job_status J
ON J.IDclient=E.IDclient
WHERE J.IDclient IS NULL;

SELECT E.[name], E.firstname,
CASE WHEN J.[Types] IS NOT NULL THEN 'He/she has contract' END AS 'Contract Status'
FROM employee E
LEFT JOIN job_status J
ON J.IDclient=E.IDclient
WHERE J.IDclient IS NOT NULL;

SELECT TOP(5) A.name, A.firstname, Z.[Types] FROM employee A
RIGHT JOIN job_status Z
ON A.IDclient=Z.IDclient;