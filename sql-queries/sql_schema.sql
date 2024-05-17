CREATE SCHEMA [movies]
CREATE TABLE movies.movie (id int, title varchar(25));

CREATE VIEW movies.movie_View
AS
SELECT * FROM movies.movie

--Table Function
CREATE OR ALTER function table_function (@test varchar(5))
RETURNS Table 
AS RETURN (SELECT gender, count(*) AS Total FROM Contact
WHERE @test=gender
GROUP BY gender)
GO
SELECT* FROM table_function('F')

--Scalar FUnction
CREATE FUNCTION scalar_function
(@name varchar(20))
RETURNS varchar(20)
AS
BEGIN
	RETURN SUBSTRING(@name,1,3)
END
GO
SELECT dbo.scalar_function('Atib')

CREATE TABLE #Temporary (id int, info varchar(25))
ALTER TABLE #Temporary ALTER COLUMN id BIGINT

BEGIN TRAN 
	INSERT INTO #Temporary VALUES(1, 'Rollback for temp table') 
ROLLBACK TRAN

SELECT * FROM #Temporary

--Ranking Functions
USE AdventureWorks2019

SELECT CustomerID, SalesOrderID, OrderDate, ROW_NUMBER() OVER (ORDER BY CustomerID) FROM Sales.SalesOrderHeader

SELECT CustomerID, SalesOrderID, OrderDate, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) FROM Sales.SalesOrderHeader

SELECT ProductID, name, FinishedGoodsFlag FROM Production.Product

SELECT ProductID, name, ListPrice, 
COUNT(*) OVER() AS TotalProduct, AVG(ListPrice) AS AvgListPrice
FROM Production.Product
WHERE FinishedGoodsFlag=1 GROUP BY ProductID, name, ListPrice

SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS Quote,
	LEAD(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS Next_Quote
	FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID=275

SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS Quote,
	LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS Prev_Quote
	FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID=275

--Truncate VS Delete
USE Excercise

CREATE TABLE Parents (
    Name varchar (200) ,
    PRIMARY KEY (Name))
	
CREATE TABLE Child (
    Name varchar (200) FOREIGN KEY REFERENCES Parents(name))

INSERT into Parents values ('THuillier'),('John'),('olivier')
INSERT into Child values ('THuillier'),('John'),('olivier')

TRUNCATE TABLE Parents WHERE Name='THuillier'

BEGIN TRAN
	DELETE FROM Parents WHERE Name='THuillier'
ROLLBACK TRAN

TRUNCATE TABLE Parents

BEGIN TRAN
	TRUNCATE TABLE Child
	SELECT * FROM Child
ROLLBACK 

BEGIN TRAN
	DELETE FROM Child WHERE Name='THuillier'
COMMIT TRAN

