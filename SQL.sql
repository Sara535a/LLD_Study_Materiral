use employee;

create table employee_table (EMPLOYEE_ID int primary key auto_increment,
FIRST_NAME varchar(25),
LAST_NAME varchar(5),
SALARY int,
JOINING_DATE date,
DEPARTMENT varchar(20)
);
SELECT * FROM employee_table;
create table employee_incentive(EMPLOYEE_REF_ID int,
INCENTIVE_DATE date,
INCENTIVE_AMOUNT int,
foreign key(EMPLOYEE_REF_ID) references employee_table(EMPLOYEE_ID)
);
INSERT INTO employee_table (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
VALUES 
("Venkatesh", "S", 100000, '2015-08-28', "BANKING"),
("Ragavi", "P", 75000, '2015-03-02', "BUSINESS"),
("Gopinath", "C", 50000, '2016-02-03', "PHARMA"),
("Dinesh", "G", 50000, '2016-02-03', "INSURANCE"),
("Saibabu", "E", 40000, '2017-08-07', "SOFTWARE"),
("Hasan", "S", 29000, '2017-08-07', "MANUFACTURING"),
("Divya", "P", 33000, '2017-08-07', "HEALTHCARE"),
("Aravindan", "R", 40000, '2017-08-07', "HEALTHCARE"),
("Sathish", "MD", 45000, '2016-02-03', "AUTOMOBILE"),
("Prasanth", "PKP", 34000, '2016-02-03', "INSURANCE"),
("Vijay", "R", 25684, '2016-02-03', "BUSINESS"),
("Sivakumar", "K", 54789, '2016-02-03', "SOFTWARE");
INSERT INTO employee_incentive (EMPLOYEE_REF_ID, INCENTIVE_DATE, INCENTIVE_AMOUNT) VALUES
(1, '2016-02-01', 5000),
(2, '2016-02-01', 3000),
(3, '2017-02-01', 4000),
(1, '2017-01-01', 4500),
(2, '2017-01-01', 3500);
select * from employee_incentive;

-- 1. Get all employee details from the employee table
select * from employee_table;

-- 2. Get First_Name,Last_Name from employee table
select FIRST_NAME,LAST_NAME from employee_table;

-- 3. Get First_Name from employee table using alias name “Employee Name”
select FIRST_NAME employee_Name from employee_table;

-- 4. Get First_Name from employee table in upper case
select ucase(FIRST_NAME) from employee_table;

-- 5. Get First_Name from employee table in lower case
select lcase(FIRST_NAME) from employee_table;

-- 6. Get unique DEPARTMENT from employee table
select DEPARTMENT from employee_table group by DEPARTMENT ;

-- 7. Select first 3 characters of FIRST_NAME from EMPLOYEE
select SUBSTRING(FIRST_NAME,1,3) from employee_table;

-- 8. Get position of "a" in name "ragavi" from employee table
SELECT INSTR(FIRST_NAME, 'a') FROM employee_table WHERE FIRST_NAME = 'ragavi';

-- 9. Get FIRST_NAME from employee table after removing white spaces from right side
select rtrim(FIRST_NAME) from employee_table;

-- 10. Get FIRST_NAME from employee table after removing white spaces from left side
select ltrim(FIRST_NAME) from employee_table;

-- 11. Get length of FIRST_NAME from employee table
select length(FIRST_NAME) from employee_table;

-- 12. Get First_Name from employee table after replacing "a"; with "$";
select replace(FIRST_NAME,'a','$') from employee_table;

-- 13. Get First_Name and Last_Name as single column from employee table separated by a "_";
select concat(FIRST_NAME,"_",LAST_NAME) from employee_table;

-- 14. Get FIRST_NAME ,Joining year,Joining Month and Joining Date from employee table
select FIRST_NAME ,year(JOINING_DATE)as Joining_year,month(JOINING_DATE)as Joining_month,day(JOINING_DATE)as Joining_day from employee_table;

-- 15. Get all employee details from the employee table order by First_Name Ascending
select * from  employee_table order by FIRST_NAME;

-- 16. Get all employee details from the employee table order by First_Name descending
select * from  employee_table order by FIRST_NAME desc;

-- 17. Get all employee details from the employee table order by First_Name Ascending and Salary descending
select * from employee_table order by FIRST_NAME ,SALARY desc;

-- 18. Get employee details from employee table whose employee name is “Dinesh”
select * from employee_table where FIRST_NAME = "Dinesh";

-- 19. Get employee details from employee table whose employee name are “Dinesh” and “Roy”
select * from employee_table where FIRST_NAME = "Dinesh" OR FIRST_NAME = "Roy";

-- 20. Get employee details from employee table whose employee name are not “Dinesh” and “Roy”
select * from employee_table where FIRST_NAME not in("Dinesh","Roy");

-- 21. Get employee details from employee table whose first name starts with "s";
select * from employee_table where FIRST_NAME like "s%";

-- 22. Get employee details from employee table whose first name contains "v";
select * from employee_table where FIRST_NAME like "%v%";

-- 23. Get employee details from employee table whose first name ends with "n";
select * from employee_table where FIRST_NAME like "%n";

-- 24. Get employee details from employee table whose first name ends with "n" and name contains 4 letters
select * from employee_table where FIRST_NAME like "%n" AND length(FIRST_NAME)>=4;

-- 25. Get employee details from employee table whose first name starts with "J" and name contains 4 letters
select * from employee_table where FIRST_NAME like "j%" AND length(FIRST_NAME)>=4;

-- 26. Get employee details from employee table who’s Salary greater than 60000
select * from employee_table where SALARY >=60000;

-- 27. Get employee details from employee table who’s Salary less than 80000
select * from employee_table where SALARY <80000;

-- 28. Get employee details from employee table who’s Salary between 50000 and 80000
select * from employee_table where SALARY between 50000 and 80000;

-- 29. Get employee details from employee table whose name is venkatesh and ragavi
select * from employee_table where FIRST_NAME = "venkatesh" OR FIRST_NAME = "ragavi";

-- 30. Get employee details from employee table whose joining year is “2015”
select * from employee_table where year(JOINING_DATE) = 2015;

-- 31. Get employee details from employee table whose joining month is “January”
select * from employee_table where month(JOINING_DATE) = "01";

-- 32. Get employee details from employee table who joined before January 1st 2017
select * from employee_table where date(JOINING_DATE)<"2017-01-01";

-- 33. Get employee details from employee table who joined after January 31 st 2016
select * from employee_table where date(JOINING_DATE)>"2017-01-01";

-- 35. Get Joining Date and Time from employee table
select JOINING_DATE,JOINING_TIME from employee_table ;
use employee;
-- 36 Get Joining Date,Time including milliseconds from employee table
SELECT DATE_FORMAT(JOINING_DATE, '%Y-%m-%d %H:%i:%s.%f') 
FROM employee_table;

-- 37. Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table
SELECT e.EMPLOYEE_ID,
       e.FIRST_NAME,
       e.JOINING_DATE,
       i.INCENTIVE_DATE,
       DATEDIFF(i.INCENTIVE_DATE, e.JOINING_DATE) AS Date_Difference
FROM employee_table e
JOIN employee_incentive i
    ON e.EMPLOYEE_ID = i.EMPLOYEE_REF_ID;

-- 38. Get database date
SELECT NOW() AS CurrentDateTime;

-- 39.Get names of employees from employee table who has "%" in Last_Name. Tip : Escape character for special characters in a query.
select *from employee_table where FIRST_NAME like "%\%%";

-- 40.Get Last Name from employee table after replacing special character with white space
SELECT REPLACE(LAST_NAME, '%', ' ') FROM employee_table;

-- 41. Get department,total salary with respect to a department from employee table.
use employee;
SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY
FROM employee_table
GROUP BY DEPARTMENT;

-- 42. Get department,total salary with respect to a department from employee table order by total salary descending

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY
FROM employee_table
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY DESC;

-- 43. Get department,no of employees in a department,total salary with respect to a department from employee table order by total salary descending
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT, SUM(SALARY) AS TOTAL_SALARY
FROM employee_table
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY DESC;

-- 44. Get department wise average salary from employee table order by salary ascending
SELECT DEPARTMENT, AVG(SALARY) AS AVERAGE_SALARY
FROM employee_table
GROUP BY DEPARTMENT
ORDER BY AVERAGE_SALARY ASC;

-- 45. Get department wise maximum salary from employee table order by salary ascending
SELECT DEPARTMENT, MAX(SALARY) AS MAX_SALARY
FROM employee_table
GROUP BY DEPARTMENT
ORDER BY MAX_SALARY ASC;

-- 46. Get department wise minimum salary from employee table order by salary ascending
SELECT DEPARTMENT, MIN(SALARY) AS MIN_SALARY
FROM employee_table
GROUP BY DEPARTMENT
ORDER BY MIN_SALARY ASC;

-- 47. Select no of employees joined with respect to year and month from employee table
SELECT 
    YEAR(JOINING_DATE) AS JOIN_YEAR,
    MONTH(JOINING_DATE) AS JOIN_MONTH,
    COUNT(*) AS EMPLOYEE_COUNT
FROM employee_table
GROUP BY YEAR(JOINING_DATE), MONTH(JOINING_DATE)
ORDER BY JOIN_YEAR, JOIN_MONTH;



