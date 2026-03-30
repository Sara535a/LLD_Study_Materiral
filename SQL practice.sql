# sql practice

-- create database company 
create database company;
-- uuse the database company 
use company;
-- create table employees and insert values
CREATE TABLE Employees (
emp_id INT,
name VARCHAR(50),
age INT,
department VARCHAR(50),
salary INT,
city VARCHAR(50)
);
INSERT INTO Employees (emp_id, name, age, department, salary, city) VALUES
(101, 'Arun', 25, 'HR', 30000, 'Chennai'),
(102, 'Priya', 28, 'IT', 45000, 'Coimbatore'),
(103, 'Karthik', 32, 'Finance', 50000, 'Madurai'),
(104, 'Divya', 24, 'Marketing', 35000, 'Trichy'),
(105, 'Vignesh', 29, 'IT', 48000, 'Salem'),
(106, 'Sneha', 31, 'HR', 40000, 'Erode'),
(107, 'Rahul', 27, 'Sales', 37000, 'Tirunelveli'),
(108, 'Anitha', 26, 'Finance', 42000, 'Vellore'),
(109, 'Suresh', 35, 'IT', 60000, 'Chennai'),
(110, 'Meena', 30, 'Marketing', 39000, 'Coimbatore');

-- show table values 
describe Employees;

-- return salary > 50000
SELECT * from Employees where salary > 50000;

-- return employees from IT department
SELECT * from Employees where department ="IT";

-- retuen employee age >30 
SELECT * from Employees where age>30;

-- return employee whose salary in range of 30000 to 60000
SELECT * from Employees where salary > 30000 AND salary<60000;

-- return employee whois not HR
SELECT * from Employees where department  != "HR";

-- count no of employees from same city
SELECT city,count(*) as total_employees from Employees group by city;

-- return employees name starts with a
SELECT * from Employees where name LIKE 'A%';

-- return employees age 20,32,35
SELECT * from Employees where age IN (20,32,35);
SELECT * from Employees where age = 20 OR age = 32 OR age =35;

-- return employee whose city is null
SELECT * from Employees where city = null;

-- return employees whose salaty is <=40000 in sales department
SELECT * from Employees where salary <=40000 AND department = "SALES";

-- return each department count 
SELECT department,count(*) as Employee_Count  from Employees Group By department;

-- return department with >2 employees
SELECT department,count(*) as Employee_Count  from Employees Group By department HAVING count(*)>2;

-- return employee with max salary 
SELECT * from Employees where salary=(
	select max(salary) from employees
    );
    
-- return duplicate salary 
SELECT salary ,count(*) as duplicate_salary from employees Group by salary HAVING count(*)=1 Order By salary asc;

-- return second max salary 
SELECT * from Employees where salary = (select max(salary) from Employees where salary< (select max(salary) from employees) );

-- return employees with salary > average salary of all 
SELECT * from Employees where salary > (
	select avg(salary) from Employees
    );
    
-- return the second largest of salary > average of all the employees  
select * from Employees where salary = (
	select max(salary) from Employees where salary<(
		select max(salary) from employees where salary > (
			select avg(salary) from Employees
            )
		)
	);
    
SELECT * from(
	SELECT * , DENSE_RANK() OVER (Order by salary desc)as rnk from Employees where salary >(
		SELECT avg(salary) from Employees)) 
			as ranked where rnk=2;
            
-- return the second largest of salary > average of all the employees whose department is IT
SELECT * from(
	SELECT * , DENSE_RANK() OVER (Order by salary desc)as rnk from Employees where department ="IT" and salary >(
		SELECT avg(salary) from Employees)) 
			as ranked where rnk=2;

-- return hignest salary of each department
SELECT * from ( 
	SELECT * ,DENSE_RANK() over (
		partition by department order by salary  DESC )as rnk from Employees) 
			as ranked where rnk=1 order by salary asc;
            
SELECT department,max(salary) as max_salary from Employees group by department order by max_salary ASC ;

-- return employee salary < average of all salary 
SELECT * from employees where salary < (select avg(salary)from employees);

-- return department with average salary >50000
SELECT department, avg(salary) as avg_salary 
	from Employees 
		group by department 
			Having avg_salary > 50000 
				order by avg_salary asc;
                
-- add new column to the table 
ALTER table Employees add column dept_id Int;

-- SQL Safe Update is a MySQL feature that prevents accidental UPDATE or DELETE operations on multiple rows unless the query uses a key column in the WHERE clause or uses LIMIT.
	set SQL_SAFE_updates =1;
    
-- update data into the table
Update Employees set dept_id=1 where department='HR';
Update Employees set dept_id=2 where department='IT';
Update Employees set dept_id=3 where department='Finance';
Update Employees set dept_id=4 where department='Marketing';
Update Employees set dept_id=5 where department='Sales';

# JOIN 

-- create table department
CREATE TABLE Departments (
dept_id INT,
dept_name VARCHAR(50)
);

-- insert values in department table
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

-- INNER JOIN of tables employees and departments  -INNER JOIN (Returns only matching records from both tables)
SELECT e.name, d.dept_name,d.dept_id 
	from employees e INNER JOIN departments d 
		ON e.dept_id=d.dept_id
			order by d.dept_id asc ,e.name asc;

-- LEFT JOIN (LEFT OUTER JOIN) of tables employees and departments  -LEFT JOIN(Returns all records from left table + matched from right)
SELECT e.name,d.dept_name,d.dept_id 
	from employees e LEFT JOIN departments d 
		ON e.dept_id=d.dept_id 
			order by d.dept_id asc,e.name asc;

-- RIGHT JOIN (RIGHT OUTER JOIN) of table employees and departments  -RIGHT JOIN(Returns all records from right table + matched from left)
SELECT e.name,d.dept_name,d.dept_id 
	from employees e RIGHT JOIN departments d 
		ON e.dept_id=d.dept_id 
			order by d.dept_id asc,e.name asc;

-- UNION of table employees and departments   -UNION(Returns all records from right table + matched from left column size should be equal)
SELECT name,dept_id 
	from employees  UNION SELECT dept_name,dept_id 
		from departments;

-- CROSS JOIN of table employees and departments  -CROSS JOIN(Return all possible combinations of rows from both tables)
SELECT * from employees
	CROSS JOIN departments;

-- self JOIN of table emoloyees  - self JOIN(Used when data in one row is related to another row in the same table)
SELECT e.name as Employee,m.name as HR 
	from employees e JOIN employees m 
		where e.department="HR";

-- using WHERE instead of JOIN 
SELECT d.*,e.name,e.salary 
	from employees e,departments d where e.department=d.dept_name 
		order by d.dept_id ASC;

-- create column manager_id in table employees
Alter table employees add column manager_id int ; 
insert into employees(emp_id,name,age,department,salary,city,dept_id) Values (111,"Pooja",29,"HR",38000,"Udumalpet",1);
UPDATE employees set manager_id=101 where dept_id=2;
UPDATE employees set manager_id=106 where dept_id=3;
UPDATE employees set manager_id=111 where dept_id=4;

-- group employee count under each HR        
Select m.name as hr_name,count(e.emp_id) as members 
	from employees m join employees e 
		on m.emp_id=e.manager_id 
			group by m.emp_id,m.name;

-- HR with more than 2 employees 
select m.name as HR_name,count(e.emp_id) as memmbers 
	from employees m join employees e 
		on m.emp_id= e.manager_id 
			group by m.emp_id,m.name 
				having count(e.emp_id) >2 ;