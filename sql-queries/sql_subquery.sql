SELECT NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
	(SELECT BusinessEntityID 
	FROM HumanResources.EmployeeDepartmentHistory)
ORDER BY JobTitle;

SELECT BusinessEntityID, NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
	(SELECT BusinessEntityID 
	FROM HumanResources.EmployeeDepartmentHistory
	WHERE BusinessEntityID <= 100)
ORDER BY JobTitle;

SELECT MIN(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
	(SELECT TOP 3 UnitPrice
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY UnitPrice
	ORDER BY UnitPrice DESC);

SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice <
	(SELECT AVG(ListPrice)
	FROM Production.Product);

--EXISTS() Operator
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee
WHERE EXISTS
	(SELECT DepartmentID 
	FROM HumanResources.Department
	WHERE Name='Sales');

--Nesting Sub Query
SELECT ProductSubCategoryID
FROM Production.Product
WHERE ProductSubCategoryID IN
	(SELECT ProductSubCategoryID 
	FROM Production.ProductSubcategory
	WHERE ProductSubCategoryID IN
		(SELECT ProductCategoryID 
		FROM Production.ProductCategory
		WHERE Name LIKE '%Bikes%')
	);

--Sub Query as an Expression
SELECT PurchaseOrderID, TaxAmt,
	(SELECT SUM(OrderQty)
		FROM Purchasing.PurchaseOrderDetail AS pod
		WHERE pod.PurchaseOrderID=poh.PurchaseOrderID
		GROUP BY pod.PurchaseOrderID
	)AS SumQty
FROM Purchasing.PurchaseOrderHeader AS poh
ORDER BY poh.PurchaseOrderID;

--Sub Query using FROM
SELECT AVG(minUnitPrice) AS AvgUnitPrice
FROM 
	(SELECT PurchaseOrderID, MIN(UnitPrice) AS MinUnitPrice
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY PurchaseOrderID) AS AvgUnitPrice;

--Any and All Operator
SELECT PurchaseOrderID, UnitPrice, DueDate
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate >=
	ANY(SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader);

SELECT PurchaseOrderID, UnitPrice, DueDate
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate !=
	ALL(SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader);