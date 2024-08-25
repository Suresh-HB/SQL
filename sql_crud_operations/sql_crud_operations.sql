/*

@Author: Suresh 
@Date: 2024-08-21
@Last Modified by: Suresh
@Last Modified: 2024-08-21
@Title : CRUD operations 

*/

---[DDL] Operations

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






----creating view

CREATE VIEW view_ename AS
select ename,sal from employee;

SELECT * FROM view_ename;
drop view view_ename;

CREATE VIEW view_ename_sal AS
SELECT ename, sal
FROM employee;

SELECT * FROM view_ename_sal;
drop view view_ename_sal;

select * from EMPLOYEE;

CREATE VIEW read_only_view AS
SELECT e.ename, d.deptno
FROM employee e
JOIN department d ON e.deptno = d.DEPTNO;

select * from read_only_view;

update read_only_view
set ENAME='suresh'
select * from EMPLOYEE;


UPDATE EMPLOYEE
SET ENaME='Vijay Kumar k'
where empno=8;





--FUNCTIONS

select ename,len(ENAME) from employee;

select 'Mr.'+ename as Employee_name from employee; 

select replace(ename,'L','s') from employee;

select ename as names from employee where len(ename)>=12;

SELECT CONCAT(ename, '', sal) AS name_sal
FROM employee;

select concat(ename,sal) from employee;

select concat(ename,' hb')
from EMPLOYEE;

select * from employee;

select LOWER(ename) from employee;
select Upper(ename) from employee;


-- it is used to replace part of the string from given string
select replace(ename,'s','H') from employee where ename like's%';

-- it is used to reverse given string
select REVERSE(ename) from employee;
select REPLACE(ename,'S','s') from EMPLOYEE;

-- it is used to extract the part of the substring from given string
select SUBSTRING(ename,4,6) from employee;


select replace(ename,'a','H') from employee where SUBSTRING(ename,2,1)='a';

select * from employee;


-- for getting starting half of the employee name
select SUBSTRING(ename,1,LEN(ename)/2)  AS SecondHalf from employee;


-- for getting second half of the employee name
SELECT SUBSTRING(ename, LEN(ename) / 2 + 1, LEN(ename) - LEN(ename) / 2) AS SecondHalf FROM employee;


--get last 3 characters of employee name
select SUBSTRING(ename,-3) from employee;


--to employee name from 3 rd position
SELECT SUBSTRING(ename, LEN(ename) - 2, 5) AS last_three_chars
FROM employee;


--to get last 2 character of the employee name
SELECT RIGHT(ename, 2) AS last_three_chars
FROM employee;


--to get frist 2 character of the employee name
SELECT left(ename, 2) AS last_three_chars
FROM employee;


--no of times the character preset in the word suresh
select LEN(ename)-LEN(replace(ename,'s','')) from EMPLOYEE where ename='Suresh';


-- find the character position of the string
SELECT CHARINDEX('s', ename) AS position
FROM employee;


-- return whose name as this character 
SELECT ename FROM employee WHERE CHARINDEX('s', ename) >2;


--left trim rtrim
select RTRIM(ename,'h') from EMPLOYEE;
select LTRIM(ename,'s') from EMPLOYEE;

--round
select round(1023362.3625,1);

--date and time
select SYSDATETIME() as t;