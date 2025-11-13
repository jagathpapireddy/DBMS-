create database supplier;
use supplier;
create table Supplier(
		sid int primary key,
        sname varchar(50),
        city varchar(50));
CREATE TABLE Parts (
		pid INT PRIMARY KEY,
		pname VARCHAR(50),
		color VARCHAR(20)
);
create table catalog(
		sid int,
        pid int,
        cost decimal(10,2),
        primary key(sid,pid),
        foreign key(sid) references supplier(sid),
        foreign key(pid) references parts(pid));

INSERT INTO Supplier VALUES (10001, 'Acme Widget', 'Bangalore'),
							(10002, 'Johns', 'Kolkata'),
                            (10003, 'Vimal', 'Mumbai'),
                            (10004,'reliance','delhi'),
                            (10005,'mahindra','mumbai');


insert into parts values(20001,'book','red'),
						(20002,'pen','red'),
                        (20003,'pencil','green'),
                        (20004, 'Mobile', 'Green'),
                        (20005, 'Charger', 'Black');

insert into catalog values(10001, 20001, 10),
						  (10001, 20002, 10),
                          (10001, 20003, 30),
                          (10001, 20004, 10),
                          (10001, 20005, 10),
                          (10002, 20001, 10),
                          (10002, 20002, 20),
                          (10003, 20003, 30),
                          (10004, 20003, 40);
select distinct pname from parts p
join catalog c on p.pid=c.pid;

select sname from supplier
where not exists (select pid from parts
where pid not in (select pid from catalog
where catalog.sid = supplier.sid));

select distinct sname from supplier s
join catalog c on s.sid=c.sid
where pid in (select pid from parts where color='red');

select pname from parts p 
join catalog c on p.pid=c.pid
join supplier s on c.sid=s.sid
where s.sname='acme widget' and p.pid not in
(select c1.pid from catalog c1
join supplier s1 on c1.sid=s1.sid
where s1.sname != 'acme widget');

select c1.sid from catalog c1 where c1.cost>
(select avg(c2.cost) from catalog c2 where c2.pid=c1.pid);

select p.pname,p.pid, s.sname from parts p
join catalog c on p.pid = c.pid
join supplier s on c.sid = s.sid
where (p.pid, c.cost) in (select pid, max(cost) from catalog group by pid);