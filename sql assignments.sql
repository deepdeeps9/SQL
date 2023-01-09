use deepdb1;
create table student(studentid int primary key ,studname varchar(20),marks decimal);
drop table student;
insert into student 
values (1,'roshin',87.5),(2,'chaitu',68.0),(3,'arshu',89.5),(4,'arman',75.6),(5,'rose',95.2),(6,'aruvi',58.0),(7,'seema',45.6),(8,'preksha',36.9),(9,'rahul',50.9);

select * from student;

delete from student where studentid=5;

insert into student 
values (5,'rose',95.2),(11,'priya',38.5),(12,'ruby',66.4),(13,'mokshi',53.5),(14,'deepu',77.5),(15,'tarun','90.1');

SELECT studentid, studname, marks FROM student
WHERE MARKS >80;

select max(marks), min(marks), sum(marks) , avg(marks) from student;

SELECT studname,marks FROM student 
WHERE marks>40 and  marks<60;

SELECT studentid, marks FROM student 
ORDER BY marks desc;
SELECT * FROM student 
ORDER BY marks desc;
SELECT ROUND(marks,2) AS marks FROM student;
SELECT MOD (marks, 3) FROM student;
select power(marks,2) from student;

select round(marks,0),mod(marks,3),pow(marks,2) from student;
select ucase(studname),lcase(studname),left(studname,3),right(studname,3),instr(studname,'a') from student;

select ltrim("Innomatics Research Lab	     ") as 'Left trim', 
rtrim("Innomatics Research Lab	     ") as 'Right trim', 
trim("Innomatics Research Lab	     ") as 'trim';

select concat(date(now()),concat("/",concat(month(now()),concat("/",year(now())))));

select concat(date(now()),concat("/",month(now()),concat("/",year(now()))));

select dayname(now()),monthname(now()),day(now()),dayname(now()),dayofmonth(now()),dayofyear(now()),date(now());


#Explain the difference between primary key and foreign key.

/* PRIMARY KEY: 
It is uniquely identify each row in a table.
–it cannot accept null values
--each table can have only one primary key
--it can be created on auto increment field (identity column).

FOREIGN KEY: 
It is a field in one table that refers to the primary key in another table.
-- It can contain duplicate values
-- A table can contain more than one foreign key						   
-- it can accept null values. */

#***********************************************************************************************************************************************************

create table employee(empid int primary key,empname varchar(100), department varchar(50),contactno bigint, emaildid varchar(100), empheadid int);
create table empdept(deptid varchar(50) primary key,deptname varchar(100), dept_off varchar(100), depthead int);
create table empsalary(empid int,salary bigint, ispermanent varchar(3), foreign key (empid) references employee(empid));
drop table employee;
drop table empsalary;
drop table empdept;
insert into employee (empid,empname,department,contactno,emaildid,empheadid)
values (101,'Parag','IT',1234567890,'abc@gmail.com',105),
(102,'Rahul','IT','1234567890','abc@gmail.com',103),
(103,'Rohit','CSE','9994567890','def@gmail.com',101),
(104,'Ram','DS','7774567890','123@yahoo.com',105),
(105,'Renuka','DS','6664567890','999@gmail.com',102),
(107,'Arush','CSE','987654210','123@yahoo.com',103),
(108,'Priya','IT','7894561230','456@yahoo.com',106),
(109,'roja','BA','6935824710','123@gmail.com',101),
(110,'rushika','DA','3692581470','123@yahoo.com',103),
(112,'Abhishek','IT','1234567890','123@yahoo.com',105);

select * from employee;

insert into empdept (deptid,deptname,dept_off,depthead)
values ('101','IT','Monday','105'),
('102','IT','Tuesday','101'),
('103','DS','Saturday','103'),
('104','DS','Sunday','104'),
('107','DS','Monday','104'),
('108','BA','Tuesday','105'),
('109','DA','Friday','101'),
('110','DS','Friday','103'),
('111','IT','Monday','106'),
('112','IT','Sunday','105');

insert into empsalary
value(101,2000,'yes'),
(102,4000,'no'),
(103,5000,'yes'),
(104,6000,'no'),
(105,7000,'yes'),
(107,5000,'yes'),
(108,10000,'yes'),
(109,6000,'no'),
(110,6000,'yes'),
(112,5000,'yes');



select * from employee;   #empid,empname,department,contactno,emaildid,empheadid)
select * from empdept;    #deptid,deptname,dept_off,depthead
select * from empsalary;  #empid,salary,ispermanent

#Select the detail of the employee whose name start with P.(hint use like)
SELECT * FROM employee WHERE empname LIKE 'P%';

#How many permanent candidates earn more than 5000.
select count(salary) as count from empsalary where ispermanent='yes' and salary>5000;

#Select the details of the employee whose emailId is in gmail.
select * from employee where emaildid like '%@gmail.com';

#What is the total salary that is paid to permanent employees?
select sum(salary) as totalsalary  from empsalary 
where ispermanent='yes';

#List name of all employees whose name ends with a.\
select empname from employee where empname like '%a';

#a.	Select the name of the employee who is working under Abhishek.
select empname from employee
where empheadid in (select empheadid from employee where empname='Abhishek');

#b.	Select the name of the employee head who is permanent.
select empname from employee 
where empid in(select empheadid from employee) and empid in(select empid from empsalary where ispermanent='yes');

select * from employee;   #empid,empname,department,contactno,emaildid,empheadid)
select * from empdept;    #deptid,deptname,dept_off,depthead
select * from empsalary;  #empid,salary,ispermanent

#left join on above any 2 tables
#Left join: Here, the sql command select empname,empid from the employee table and the deptname column from the empdept table. 
#And the result set will contain those rows where there is a match between empid of the employee table and deptid of the empdept table along with all remaining rows from the left table.
select employee.empid, employee.empname, empdept.deptname
from employee left join empdept on employee.empid=empdept.deptid;

#right join on above any 2 tables
#right join: Here, the sql command select empname,empid from the employee table and the deptname column from the empdept table. 
#And the result set will contain those rows where there is a match between empid of the employee table and deptid of the empdept table along with all remaining rows from the rght table.

select employee.empid, employee.empname, empdept.deptname
from employee right join empdept on employee.empid=empdept.deptid;

#inner join on above any 2 tables
#inner join: Here, the sql command select empname,empid from the employee table and the deptname column from the empdept table. 
#And the result set will contain those rows where there is a match between empid of the employee table and deptid of the empdept table along with all remaining rows from the both table.
select employee.empid, employee.empname, empdept.deptname
from employee inner join empdept on employee.empid=empdept.deptid;

#cross join on above any 2 tables
select *
from employee cross join empdept;

#The CROSS JOIN keyword returns all records from both tables (table1 and table2).
#cross join :we have two database tables: employee, empdept tables
# We need to get all possible combinations of employee and empdept table.
SELECT *
FROM employee
CROSS JOIN empdept ON employee.empid =empdept.deptid;

#6)	Update a value in the employee table.

#Hint(Set empname as Maria where empid is 10)

update employee set empname='Maria'
where empid='10'; 

#Delete the entire row in employee table where empid is  10
delete from  employee 
where empid='10';

select* from employee;
#altering table-adding additional column in employee table
alter table employee add(Address varchar(50));

#removing the newly added column from employee table
alter table employee
drop column Address;

#Find the count of common salaries given to the employees (hint use group by)
SELECT COUNT(*) 
FROM empsalary 
GROUP BY salary; 

#lists the number of employees and there common salary, sorted high to low (Only include common salary with more than 5 employees)
select distinct salary,empid from empsalary 
order by salary desc;

/*Explain about the JOINS.
        A JOIN clause is used to combine rows from two or more tables, based on a related column between them.
Here are the different types of the JOINs in SQL:
•	INNER JOIN: Returns records that have matching values in both tables
SYNTAX:SELECT column_name(s)
        FROM table1
        INNER JOIN table2
        ON table1.column_name = table2.column_name;
•	LEFT JOIN: Returns all records from the left table, and the matched records from the right table
SYNTAX:SELECT column_name(s)
        FROM table1
        LEFT JOIN table2
        ON table1.column_name = table2.column_name;
•	RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
SYNTAX:SELECT column_name(s)
        FROM table1
        RIGHT JOIN table2
        ON table1.column_name = table2.column_name;
•	FULL JOIN: Returns all records when there is a match in either left or right table
SYNTAX:SELECT column_name(s)
        FROM table1
        FULL JOIN table2
        ON table1.column_name = table2.column_name;
•   SELF JOIN:A self join is a regular join, but the table is joined with itself.
SYNTAX:SELECT column_name(s)
       FROM table1 T1, table1 T2
       WHERE condition;
• CROSS JOIN :The CROSS JOIN keyword returns all records from both tables (table1 and table2).
 CROSS JOIN can potentially return very large result-sets.
 SYNTAX:SELECT column_name(s)
        FROM table1
        CROSS JOIN table2;
        
12.	What are UNION, MINUS and INTERSECT commands?
UNION:UNION operator is used to combining the results of two tables,and it eliminates duplicate rows from the tables.
     
MINUS:Minus operation combines results of two SELECT statements and return only those in the final result,
 which belongs to the first set of the result.
     
INTERSECT:Intersect operation is used to combine two SELECT statements, 
but it only returns the records which are common from both SELECT statements.


13.	What are the differences between TRUNCATE, DELETE and DROP?

TRUNCATE command is a DDL command. It also deletes records from a table without removing table structure, 
but it doesn’t use the WHERE clause.

DELETE command is a DML command. This command removes records from a table. 
It is used only for deleting data from a table, not to remove the table from the database.

DROP command is another DDL operation. But it is not used for simply removing data from a table; 
it deletes the table structure from the database, along with any data stored in the table.*/






