CREATE VIEW SampleView
AS
SELECT Count(*) AS Total, gender, date_of_birth 
FROM Contact WHERE gender='F' AND year(date_of_birth)>1975
GROUP BY gender, date_of_birth

SELECT * FROM SampleView;

ALTER VIEW SampleView
AS
SELECT Count(*) AS Total, gender, date_of_birth 
FROM Contact WHERE gender='F' AND year(date_of_birth)=1983
GROUP BY gender, date_of_birth

sp_rename 'SampleView','NewView'
SELECT * FROM NewView;
DROP VIEW NewView

--STORED PROCEDURES
CREATE PROCEDURE InsertName
AS 
INSERT into Contact VALUES
('Darth','Vader',25,'M','1983-05-06');

EXEC InsertName;

SELECT * FROM Contact

CREATE PROCEDURE Updates
AS 
UPDATE Contact SET [name]='Anakin',firstname='Skywalker' WHERE [name]='Darth'

EXEC Updates;

CREATE PROCEDURE Deletes
AS 
DELETE FROM Contact WHERE [name]='Anakin'

EXEC Deletes

sp_rename 'Deletes','ProcDelete'

DROP PROCEDURE ProcDelete;

--VARIABLES IN STORED PROCEDURES
DECLARE @Avenger varchar(10)
SET @Avenger='Hulk'
PRINT @Avenger

CREATE PROCEDURE NewEntry
AS
DECLARE @NewActor varchar(10)
SET @NewActor='Stiller'
PRINT @NewActor

EXEC NewEntry

CREATE PROCEDURE FirstName @FirstName varchar(200)
AS SELECT * FROM Contact WHERE firstname=@FirstName

EXEC FirstName 'Leonardo'

SELECT * FROM Contact

CREATE PROCEDURE Insertion
AS 
INSERT into Contact VALUES
('Shirley','Temple',28,'F','1984-08-12'),
('Hanks','Tom',21,'M','1969-06-09')
GO
EXEC Insertion 

CREATE PROCEDURE Update_Monroe 
AS 
UPDATE Contact SET [Name]='Superman' WHERE [Name]='Monroe'
GO
EXEC Update_Monroe

ALTER PROCEDURE PSLeonardo @leo varchar(200)
AS 
SELECT * FROM Contact WHERE firstname=@leo
GO
EXEC PSLeonardo 'Leonardo'

ALTER PROCEDURE PSMarvel 
AS 
DECLARE @Hulk varchar(50)
DECLARE @Wolverine varchar(50)
SET @Hulk='Hulk ' 
SET @Wolverine='and Wolverine are best friend'
PRINT @Hulk+@Wolverine
GO
EXEC PSMarvel

ALTER VIEW View_Age
AS 
SELECT firstname, date_of_birth FROM Contact WHERE gender='F' AND YEAR(date_of_birth) BETWEEN 1976 AND 1985 
GO
SELECT * FROM View_Age

ALTER VIEW ConView
AS
SELECT CONVERT(varchar, date_of_birth,110) AS AmericanFormat FROM [dbo].[Contact]
GO
SELECT * FROM ConView