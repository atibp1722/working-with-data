 USE DummyDB;

CREATE PROCEDURE get_workers()
BEGIN
	 SELECT * FROM Worker
END;

CREATE PROCEDURE get_bonusAmt()
BEGIN
	SELECT * FROM Bonus
	WHERE BonusAmt > 2500
END

DROP PROCEDURE IF EXISTS get_bonusAmt;

CREATE PROCEDURE get_workers_by_dept(wrk_id INT)
BEGIN
	 SELECT * FROM Worker wrk
	 WHERE wrk.WorkerID = wrk_id
END

CREATE PROCEDURE get_by_dept(dept varchar(2))
BEGIN
		SELECT * FROM Worker wrk
		WHERE wrk.Department = IFNULL (dept, wrk.Department);
END

CREATE PROCEDURE  get_payment( cl_id INT, pay_methodID INT )
BEGIN
	SELECT * FROM Invoices inv
	WHERE inv.clientID = IFNULL(cl_id, inv.clientID)
		AND
	inv.payment_method_ID = IFNULL(pay_methodID, inv.payment_method_ID)
END

CREATE PROCEDURE calc_salary
( 
	worker_ID INT,
	total_salary INT,
	department varchar(3)
)
BEGIN
	IF total_salary <= 0 THEN
		SIGNAL SQLSTATE '2203' 
			SET MESSAGE_TEXT = "Invalid amount.";
	END IF;
	UPDATE Worker wrk SET
		wrk.Salary = total_salary,
		wrk.Department = department
	WHERE
		wr.WorkerID = worker_ID
END

CREATE PROCEDURE get_worker_total_salary
(
	worker_ID INT, 
	OUT Salary_Count INT,
	OUT Salary_Total INT
)
BEGIN
	SELECT COUNT(*), SUM(Salary)
	INTO Salary_Count, Salary_Total
	FROM Worker wrk
	WHERE wrk.WorkerID = worker_ID AND Salary > 10000
END

CREATE PROCEDURE risk_factor()
BEGIN
	DECLARE risk_factor DECIMAL (5,2);
	DECLARE Sal_Count DECIMAL (5,2);
	DECLARE Sal_Total INT;

	SELECT COUNT(*), SUM(Salary) INTO Sal_Count, Sal_Total
	FROM Worker;

	SET risk_factor = (Sal_Total/Sal_Count)*100
	SELECT risk_factor;
END 

