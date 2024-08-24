/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : CRUD operations 

*/


--Creating the database
CREATE DATABASE EMPLOYEE_AND_DEPARTMENT;

USE EMPLOYEE_AND_DEPARTMENT;

-- Creating the Department table 
CREATE TABLE DEPARTMENT(
    DEPTNO INT PRIMARY KEY,             
    DeptName VARCHAR(100) NOT NULL,
	LOC VARCHAR(20) NOT NULL
);


--inserting the values into department table 
INSERT INTO DEPARTMENT(DEPTNO,DEPTNAME,LOC)
VALUES(10,'DATA-ENGINEER','BANGALORE'),
(20,'MICRO-SERVICE','HYDRABAD'),
(30,'GO-LANG','BANGALORE'),
(40,'JAVA-BOAT','BANGALORE'),
(50,'R-LANG','CHENNAI');


--Creating the employee table 
CREATE TABLE EMPLOYEE(
EMPNO INT PRIMARY KEY,
ENAME VARCHAR(30) NOT NULL,
SAL INT NOT NULL,
DEPTNO INT,                          
FOREIGN KEY (DEPTNO) REFERENCES DEPARTMENT(DEPTNO) 
);


--inserting the values into employaa table
INSERT INTO EMPLOYEE(EMPNO,ENAME,SAL,DEPTNO)
VALUES(1,'SURESH','50000',10),
(2,'RAMESH','26000',20),
(3,'JEEVAN','50200',10),
(4,'APPU','9600',30),
(5,'NITHIN','93000',20);


--displaying the employee and department table 
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;


--fetching the enames and department names
select ename from employee;
select deptname from department;


--fetching the department name based on empno
SELECT DeptName
FROM Department
WHERE DeptNo = (
    SELECT DeptNo
    FROM Employee
    WHERE EMPNO = 3
);


SELECT DeptName
FROM Department
WHERE DeptNo = (
    SELECT DeptNo
    FROM Employee
    WHERE EMPNO = 2
);


--  [DML]  updating the employee sal 
UPDATE EMPLOYEE 
SET SAL =70000
WHERE EMPNO=1;

SELECT * FROM EMPLOYEE;

--updating the employee name
UPDATE EMPLOYEE
SET ENAME = 'JEEVAN GB'
WHERE EMPNO=3;

SELECT * FROM EMPLOYEE;

--deleting the record based on empno
DELETE FROM EMPLOYEE 
WHERE EMPNO=5;

SELECT * FROM EMPLOYEE;


--TCL statements 
BEGIN TRANSACTION;

INSERT INTO EMPLOYEE(EMPNO,ENAME,SAL,DEPTNO)
VALUES(6,'JAGA',56500,50);

COMMIT;
SELECT * FROM EMPLOYEE;



ROLLBACK;
SELECT * FROM EMPLOYEE;



SELECT @@ServerName


--creating and deleting  the indexs
CREATE INDEX MYINDEX1
ON EMPLOYEE(EMPNO);

CREATE INDEX MYINDEX2
ON EMPLOYEE (EMPNO,ENAME)
DROP INDEX EMPLOYEE.MYIDEX1;