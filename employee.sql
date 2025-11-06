create database employee_database;
use employee_database;
create table dept(
	deptno int primary key,
    dname varchar(50),
    dloc varchar(50));
create table employee(
	empno int primary key,
    ename varchar(50),
    mgr_no int,
    hiredate date,
    sal decimal(10,2),
    deptno int,
    foreign key (deptno) references dept(deptno)
		on delete set null
		on update cascade);
    
create table project(
	pno int primary key,
    pname varchar(50),
    ploc varchar(50));

create table assignedto(
	empno int ,
    pno int,
    job_role varchar(55),
    primary key(empno,pno),
    foreign key (empno) references employee(empno),
    foreign key (pno) references project(pno));

create table incentives(
		empno int,
        incentive_date date,
        incentive_amount decimal(10,2),
        foreign key (empno) references employee(empno));

insert into dept values
	(10,'hr','bengaluru'),
    (20,'finance','hyderabad'),
    (30,'it','mysuru'),
    (40, 'admin', 'chennai'),
    (50, 'marketing', 'delhi');

insert into employee values
	(1, 'arun',null,'2020-01-01',50000,10),
    (2,'bhargav',1,'2019-03-15',55000,20),
    (3,'chandra',2,'2021-06-20',60000,30),
    (4,'divya',2,'2022-08-10',48000,30),
    (5,'eshan',3,'2018-11-01',70000,40),
    (6,'finch',2,'2023-04-05',62000,50);

insert into project values
	(101, 'payroll system','bengaluru'),
	(102, 'Rfid','hyderabad'),
    (103, 'AI','mysuru'),
    (104, 'website','delhi'),
    (105, 'data migration','chennai');

insert into assignedto values
	(1,101,'analyst'),
    (2,102,'developer'),
    (3,103,'tester'),
    (4,101,'developer'),
    (5,104,'manager'),
    (6,105,'chennai');

insert into incentives values
	(1,'2024-01-15',2000),
    (3,'2024-03-10',2000),
    (5,'2024-02-20',2500);

select e.empno from employee e
join assignedto a on e.empno=a.empno
join project p on a.pno=p.pno
where p.ploc in ('bengaluru','hyderabad','mysuru'); 

select * from employee
where empno not in (select empno from incentives);

select e.empno,e.ename,d.dname as department,a.job_role,d.dloc as department_location,p.ploc as project_location from employee e
join dept d on e.deptno = d.deptno
join assignedto a on e.empno=a.empno
join project p on a.pno=p.pno
where d.dloc =p.ploc; 


SELECT e.ename AS manager_name
FROM employee e
JOIN employee m ON e.empno = m.mgr_no
GROUP BY e.empno, e.ename
HAVING COUNT(m.empno) =
(
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM employee
        WHERE mgr_no IS NOT NULL
        GROUP BY mgr_no
    ) AS t
);

SELECT m.empno, m.ename, m.sal
FROM employee m
JOIN employee e ON e.mgr_no = m.empno
GROUP BY m.empno, m.ename, m.sal
HAVING m.sal > AVG(e.sal);

SELECT d.deptno, e2.empno, e2.ename
FROM dept d
JOIN employee e1 ON d.deptno = e1.deptno AND e1.mgr_no IS NULL
JOIN employee e2 ON e2.mgr_no = e1.empno;

SELECT e.*
FROM employee e
JOIN incentives i ON e.empno = i.empno
WHERE i.incentive_amount =
(
    SELECT DISTINCT incentive_amount
    FROM incentives
    WHERE MONTH(incentive_date)=1 AND YEAR(incentive_date)=2019
    ORDER BY incentive_amount DESC
    LIMIT 1 OFFSET 1
);

SELECT e.empno, e.ename, d.dname
FROM employee e
JOIN employee m ON e.mgr_no = m.empno
JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = m.deptno;




    
	  
    
        
