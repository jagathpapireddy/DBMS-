create database if not exists bank;
use bank;

CREATE TABLE Branch (
    Branchname VARCHAR(50) PRIMARY KEY,
    Branchcity VARCHAR(50),
    Assets DECIMAL(10, 2));

CREATE TABLE BankCustomer (
    Customername VARCHAR(50) PRIMARY KEY,
    Customer_street VARCHAR(100),
    City VARCHAR(50));


CREATE TABLE BankAccount (
    Accno INT PRIMARY KEY,
    Branchname VARCHAR(50),
    Balance DECIMAL(10, 2),
    FOREIGN KEY (Branchname) REFERENCES Branch(Branchname));

CREATE TABLE Depositer (
    Customername VARCHAR(50),
    Accno INT ,
    PRIMARY KEY (Customername, Accno),
    FOREIGN KEY (Customername) REFERENCES BankCustomer(Customername),
    FOREIGN KEY (Accno) REFERENCES BankAccount(Accno));
 
CREATE TABLE LOAN (
    Loannumber INT PRIMARY KEY,
    Branchname VARCHAR(50),
    Amount DECIMAL(12, 2),
    FOREIGN KEY (Branchname) REFERENCES Branch(Branchname));
INSERT INTO Branch (Branchname, Branchcity, Assets) VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);
INSERT INTO BankAccount (Accno, Branchname, Balance) VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParlimentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

INSERT INTO BankCustomer (Customername, Customer_street, city) VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');
INSERT INTO Depositer (Customername, Accno) VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);
INSERT INTO Loan (Loannumber, Branchname, Amount) VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);
select branchname,
assets/100000 as 'assets in lakhs' from branch;
select customername,branchname,count(*) as 'number of accounts' from depositer d,bankaccount b
where d.accno=b.accno
group by branchname,customername
having count(*)>=2;
create view bank_loan as
select branchname,sum(amount) from loan
group by branchname;

