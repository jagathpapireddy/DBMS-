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
    (2,'bhargav',1,'2019-03-15',60000,20),
    (3,'chandra',2,'2021-06-20',60000,30),
    (4,'divya',2,'2022-08-10',48000,30),
    (5,'eshan',3,'2018-11-01',70000,40),
    (6,'finch',2,'2023-04-05',62000,20);

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
	(1,'2019-01-15',2000),
    (3,'2019-01-10',1000),
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

select e.ename as manager_name from employee e
join employee m on e.empno=m.mgr_no
group by e.ename,e.empno
having count(m.empno)= (select max(cnt) from 
                     (select count(*) as cnt from employee 
                                group by mgr_no)as t);
								

select m.empno,m.ename,m.sal from  employee m 
join employee e on e.mgr_no=m.empno
group by m.empno, m.ename, m.sal 
having m.sal> avg(e.sal);


select d.deptno,e.empno,e.ename from dept d
join employee e1 on d.deptno=e1.deptno and e1.mgr_no is null
join employee e on e.mgr_no=e1.empno;

select e.* from employee e
join incentives i on e.empno=i.empno
where i.incentive_amount=
(select distinct incentive_amount from incentives 
where year(incentive_date)=2019 and month(incentive_date)=1
order by incentive_amount desc
limit 1 offset 1);


select e.empno, e.ename, d.dname
from employee e
join employee m on e.mgr_no = m.empno
join dept d on e.deptno = d.deptno
where e.deptno = m.deptno;



    
        