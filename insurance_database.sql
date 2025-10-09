create database carinsurance;
use carinsurance;
create table person(driver_id varchar(10),
	name varchar(10),
    address varchar(30),
    primary key(driver_id));
create table car(reg_num varchar(10),
		model varchar(10),
        year int,
        primary key(reg_num));
create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
create table owns(driver_id varchar(10), reg_num varchar(10),primary key(driver_id,reg_num),foreign key(driver_id) references person(driver_id), foreign key(reg_num) references car(reg_num));
create table participated(driver_id varchar(10),reg_num varchar(10), report_num int, damage_amount int, primary key(driver_id,reg_num, report_num),foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num),foreign key(report_num) references accident(report_num));
insert into person(driver_id,name,address)
	values('A01','Richard','srinivas nagar'),
    ('A02','Pradeep ','Rajajinagar'),
    ('A03','Smith','Ashoknagar'),
	('A04','Venu','N.R.Colony'),
    ('A05','John','Hanumanth Nagar');
insert into car(reg_num,model, year)
	values('KA052250','Indica', 1990),
	('KA031181','Lancer', 1957),
    ('KA095477','toyota', 1988),
    ('KA053408','honda', 2008),
    ('KA041702','Audi', 2005);
insert into accident (report_num,accident_date,location)
	values(11,'2003-01-01','Mysore Road'),
    (12,'2004-02-03','Mysore Road'),
    (13,'2005-03-20','Southend Circle'),
    (14,'2006-05-15','Bulltemple Road'),
    (15,'2004-06-12','Kanakpura Road');
insert into owns(driver_id,reg_num)
	values('A01','KA052250'),
    ('A02','KA053408'),
    ('A03','KA095477'),
    ('A04','KA031181'),
    ('A05','KA041702');
insert into participated (driver_id,reg_num,report_num,damage_amount)
	values('A01','KA052250',11,10000),
    ('A02','KA053408',12,50000),
    ('A03','KA095477',13,25000),
    ('A04','KA031181',14,3000),
    ('A05','KA041702',15,5000);
update participated set damage_amount=25000 where participated.reg_num='KA053408' and report_num=12;	
update accident set accident_date='2008-05-12' where report_num='14';
select count(*) CNT from participated,accident where participated.report_num=accident.report_num and accident.accident_date like '2008%';
insert into accident values(16,'2008-04-13','domlur');
select accident_date,location from accident;		
select driver_id from participated where damage_amount>=25000;
select * from car order by year asc;
select count(*) from participated,car where participated.reg_num=car.reg_num and car.model='lancer';
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated;
select name from person,participated where person.driver_id = participated.driver_id and participated.damage_amount>(select avg(damage_amount) from participated);
select max(damage_amount) from participated;