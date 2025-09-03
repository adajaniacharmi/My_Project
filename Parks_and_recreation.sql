CREATE DATABASE Parks_and_Recreation;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

CREATE TABLE parks_departments (
  department_id serial,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments(department_name) VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');

select * from employee_demographics;

select first_name from employee_demographics where age>=50;

-- Group by
select gender 
from employee_demographics
group by gender;


select gender,max(age),min(age),avg(age),count(age)
from employee_demographics
group by gender;

select occupation ,salary
from employee_salary
group by occupation,salary ;

--Order by
select * 
from employee_demographics
order by gender,age;

select gender,avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

select occupation,avg(salary)
from employee_salary
group by occupation;

--LIKE (Case-sensitive)
select * from employee_salary 
where first_name LIKE 'A%';

select * from employee_salary
where last_name LIKE '%te';

select * from employee_demographics
where last_name Like 'Dw___';

select * from employee_demographics
where first_name like 'J_r__';

--ILIKE (Case-insensitive)
select * from employee_salary
where occupation ilike 'd%';

select * from employee_demographics
where gender ilike 'Male';

--IN
select * from employee_salary
where occupation in ('Office Manager','City Manager','Nurse');
 
select * from employee_demographics
where first_name in (select first_name from employee_salary where salary >75000);

select first_name,age from employee_demographics
where first_name in (select first_name from employee_salary where salary > 50000)
and age > 30;

select first_name,salary,occupation from employee_salary
where first_name in(select first_name from employee_demographics where age > 40)
and salary > 50000;

select first_name,last_name,salary from employee_salary
where first_name not in(select first_name from employee_demographics)

--between
select * from employee_salary
where salary between 10000 and 50000;

--is null
select * from employee_salary
where dept_id is null;

--not
select * from employee_salary
where occupation not like '%Manager';

select * from employee_salary
where occupation not ilike '%recreation';

select * from employee_salary 
where occupation not in ('Entrepreneur','Nurse','State Auditor','Office Manager');

select * from employee_salary
where salary not between 10000 and 70000;

select * from employee_salary
where dept_id is not null;

--
select * from employee_demographics
order by age desc limit 5;
select * from employee_salary
limit 5 offset 3;

select distinct occupation from employee_salary;
select count(distinct occupation) from employee_salary; 
select sum(salary) from employee_salary;

select count(department_name) from parks_departments
select count(distinct department_name) from parks_departments

--between 17/2
select * from employee_salary
where salary between 20000 and 50000;

select * from employee_salary
where first_name between 'Andy' and 'Chris'
order by first_name;

--Alias
select occupation as occ from employee_salary;
select occupation occ from employee_salary;

select first_name ||' '|| last_name as Name from employee_salary;

select birth_date as "DOB" from employee_demographics

/* JOIN
INNER JOIN: Returns records that have matching values in both tables
LEFT JOIN: Returns all records from the left table, and the matched records from the right table
RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
FULL JOIN: Returns all records when there is a match in either left or right table
*/

select * from employee_salary;
select * from employee_demographics;

--INNER JOIN(3 tables)
select sal.employee_id, sal.first_name, sal.last_name,age,department_name, occupation, salary 
from ((employee_salary as sal
inner join employee_demographics as dem on sal.employee_id = dem.employee_id)
inner join parks_departments as par on sal.dept_id = par.department_id);

--LEFT JOIN
select sal.employee_id,dem.first_name,dem.last_name,salary
from employee_salary as sal
left join employee_demographics as dem on dem.employee_id = 
sal.employee_id;

select * from parks_departments
SELECT * FROM employee_salary
select * from employee_demographics

--RIGHT JOIN
select sal.employee_id, sal.first_name, dem.last_name, salary, birth_date, gender
from employee_demographics dem
right join employee_salary sal on dem.employee_id = 
sal.employee_id

--FULL JOIN
select dem.employee_id,dem.first_name,dem.last_name
from employee_demographics as dem
full join employee_salary as sal on dem.employee_id = 
sal.employee_id

--SELF JOIN
select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

-->add column in employee_demographics table named manager_id for self join

select 
	e.first_name || ' ' || e.last_name employee,
	m.first_name || ' ' || m.last_name manager
from
	employee_demographics e
inner join employee_demographics m on m.employee_id =
e.manager_id
order by 
	manager;
----PRACTICE----
select 
	e1.first_name as employeer,
	e2.first_name as manager
from
	employee_demographics e1
left join
	employee_demographics e2 on e1.manager_id = e2.employee_id
order by
	manager
	
--CROSS JOIN
select first_name,department_name
from employee_salary
cross join parks_departments

----practice----
create table month_values(
	MM int
)
create table year_values(
	YYYY int
)

insert into month_values values
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)
select * from month_values

insert into year_values values
(2011),(2012),(2013),(2014),(2015),(2016),(2017),(2018),(2019),(2020),(2021),(2022)
select * from year_values

select month_values.MM,year_values.yyyy
from month_values,year_values
order by year_values.yyyy,month_values.mm

--UNION 17/2
select first_name from employee_demographics
union
select first_name from employee_salary
order by first_name

select last_name from employee_demographics
union all
select last_name from employee_salary
order by last_name

--INTERSECT
select employee_id from employee_demographics
intersect
select employee_id from employee_salary
order by employee_id 

--EXCEPT
select employee_id,first_name from employee_salary
except
select employee_id,first_name from employee_demographics

--GROUP BY
select * from employee_demographics;
select * from employee_salary;
select * from parks_departments;

select count(occupation) , first_name
from employee_salary
group by first_name

--CASE
select first_name,
case 
	when age < 20 then 'teenage'
	when age > 50 then 'old'
else
	'adult'
end
from employee_demographics;
---
select first_name,salary,
case
	when salary > 60000 then 'High-end job'
	when salary < 25000 then 'low-end job'
else
	'mid-range job'
end
from employee_salary;

--
alter table employee_demographics
add manager_id INT

update employee_demographics
set manager_id = 2
where employee_id = 3

update employee_demographics
set manager_id = 3
where employee_id = 4

update employee_demographics
set manager_id = 4
where employee_id = 5

update employee_demographics
set manager_id = 5
where employee_id = 6

update employee_demographics
set manager_id = 6
where employee_id = 7

update employee_demographics
set manager_id = 7
where employee_id = 8

update employee_demographics
set manager_id = 8
where employee_id = 9

update employee_demographics
set manager_id = 9
where employee_id = 10

update employee_demographics
set manager_id = 10
where employee_id = 11

update employee_demographics
set manager_id = 1
where employee_id = 12

update employee_demographics
set manager_id = NULL
where employee_id = 1

select * from employee_demographics
order by employee_id

---
select employee_id,first_name,manager_id
from employee_demographics;

	
--WITH 
with AvgSalaryByDept as (
	select dept_id, avg(salary) as AvgSalary
	from employee_salary
	group by dept_id
)
select *
from AvgSalaryByDept

--VIEW
create view employee_details as
select first_name,age,gender
from employee_demographics

select * from employee_details

drop view employee_details

--INDEX
create index mnth_indx
on month_values(mm)

drop index mnth_indx
select * from month_values

--subquery
--(where)
select *
from employee_salary
where employee_id in
	(select employee_id 
	 from employee_demographics
	 where age>40)

--(join) not possible with this 
select * from employee_demographics
select * from employee_salary
select * from parks_departments

select 
	first_name,
	occupation,
	salary,
	department_name
from parks_departments dep
right join employee_salary sal 
on sal.dept_id=dep.department_id

--STRING FUN
select * from employee_demographics
select * from employee_salary
select * from parks_departments

--1.length
select 
	last_name,
	length(last_name),
	age
from employee_demographics 
where age between 30 and 40

--2.UPPER/lower
select 
	upper(first_name),
	lower(last_name)
from employee_salary

--3.REPLACE
select first_name,
	replace(first_name,'Leslie','Jiya')
from employee_salary

--4.TRIM/RTRIM/LTRIM (only with spacebar space,not with tab)
select trim('       this is trim           ')
select rtrim('           this is right trim              ')
select ltrim('               this is left trim                ')

--5.CONCATENATE
select 
	first_name||' '||last_name||', '||occupation as details
from employee_salary 

--6.SUBSTRING
select
	first_name,
	substring(gender for 1)
from employee_demographics

--MATHEMETICAL
--1.RANDOM
select random()

--2.CEIL/FLOOR
select 20.22* (100-20)+30.342,
	ceil(20.22* (100-20)+30.342),
	floor(20.22* (100-20)+30.342)
	
--3.SETSEED
select setseed(0.2),
	random(),
	random()
	
--4.ROUND
select round(4.873),
	round(4.222)
	
--5.POWER
select power(4,3)

--DATE/TIME
select current_date,
	current_time,
	current_time(10),
	current_timestamp,
	
--AGE
select age(current_date,'1999-09-25') as charmi,
	   age(current_date,'1999-03-11') as bhavik
	   
--EXTRACT
select extract(epoch from current_date) ,
		extract(hour from current_time) as hour

select current_timestamp,
	extract(epoch from current_timestamp)

-->PATTERN MATCHING
--1.like 
select * from employee_salary where first_name like 'A%'
select * from employee_salary where last_name like 'K__p_'
select * from employee_salary where first_name not like 'A%'

--2.similar to 
--3.regex
/*  ~* - start of string
	^  - starting of the string
	$  - end of string
	\s - any white space
*/

select * from employee_salary where first_name  ~*'^Do'
select * from employee_salary where first_name ~*'ie$'
select * from employee_salary where first_name ~*'^a+[a-z\s]+$'
select * from employee_salary where first_name ~*'^(a|b|c|d)+[a-z\s]+$'
select * from employee_salary where first_name ~*'^(a|b|c|d)[a-z]{2}$'


--DATA TYPE CONVERSION FUNCTION
--1.to_char
alter table employee_salary
add Bonus float

update employee_salary
set bonus=100.1299
where employee_id=1

update employee_salary
set bonus=120.7584
where employee_id=2

update employee_salary
set bonus=50.1211
where employee_id=3

update employee_salary
set bonus=150.3305
where employee_id=4

update employee_salary
set bonus=300.1299
where employee_id=5

update employee_salary
set bonus=10.99
where employee_id=6

update employee_salary
set bonus=450.8999
where employee_id=7

update employee_salary
set bonus=0
where employee_id=8

update employee_salary
set bonus=145.199
where employee_id=9

update employee_salary
set bonus=100
where employee_id=10

update employee_salary
set bonus=890.90
where employee_id=11

update employee_salary
set bonus=0.9986
where employee_id=12

select * from employee_salary

select 
	salary,
	bonus,
	to_char(salary,'₹ 99,999/-'),
	to_char(bonus,'999.99')
from employee_salary

select 
	birth_date,
	to_char(birth_date,'dd/mm/yyyy'),
	to_char(birth_date,'ddth month,yyyy'),
	to_char(birth_date,'ddth month,day')
from employee_demographics

--2.to_date(string to date)
select * from employee_demographics

select to_date('25-09-1999','dd/mm/yy'),
	to_date('1999/09/25','YYYY/MM/DD'),
	to_date('250999','ddmmyy')
	
--3.to_number(string to number)
select to_number('12.99928','99999.99')

