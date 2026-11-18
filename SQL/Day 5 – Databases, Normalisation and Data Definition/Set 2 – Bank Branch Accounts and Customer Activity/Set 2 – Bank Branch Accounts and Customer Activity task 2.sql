CREATE DATABASE BankManagementDB;
GO

USE BankManagementDB;
GO

CREATE TABLE Customer
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Branch
(
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE RelationshipManager
(
    ManagerID INT IDENTITY(1,1) PRIMARY KEY,
    ManagerName VARCHAR(100) NOT NULL,
    BranchID INT NOT NULL,

    FOREIGN KEY (BranchID)
    REFERENCES Branch(BranchID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

CREATE TABLE Account
(
    AccountID INT IDENTITY(1,1) PRIMARY KEY,

    AccountNumber VARCHAR(20) UNIQUE NOT NULL,

    CustomerID INT NOT NULL,

    BranchID INT NOT NULL,

    ManagerID INT NOT NULL,

    AccountType VARCHAR(20) NOT NULL,

    Balance DECIMAL(12,2) NOT NULL,

    OpenDate DATE NOT NULL,

    LastTransactionText VARCHAR(200),

    CHECK
    (
        AccountType <> 'Savings'
        OR Balance >=0
    ),

    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY(BranchID)
    REFERENCES Branch(BranchID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,

    FOREIGN KEY(ManagerID)
    REFERENCES RelationshipManager(ManagerID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO Customer(CustomerName,Address)
VALUES
('Arun','Chennai'),
('Priya','Coimbatore'),
('Rahul','Madurai'),
('Sneha','Salem'),
('Vijay','Trichy'),
('Meena','Vellore'),
('Karthik','Erode'),
('Anitha','Thanjavur'),
('Suresh','Hosur'),
('Deepa','Tirunelveli');

INSERT INTO Branch(BranchName)
VALUES
('Chennai'),
('Coimbatore'),
('Madurai'),
('Salem'),
('Trichy'),
('Vellore'),
('Erode'),
('Thanjavur'),
('Hosur'),
('Tirunelveli');

INSERT INTO RelationshipManager(ManagerName,BranchID)
VALUES
('Manager A',1),
('Manager B',2),
('Manager C',3),
('Manager D',4),
('Manager E',5),
('Manager F',6),
('Manager G',7),
('Manager H',8),
('Manager I',9),
('Manager J',10);

INSERT INTO Account
(AccountNumber,CustomerID,BranchID,ManagerID,AccountType,Balance,OpenDate,LastTransactionText)
VALUES
('ACC1001',1,1,1,'Savings',25000,'2026-09-15','ATM Withdrawal'),
('ACC1002',2,2,2,'Current',80000,'2026-10-01','Cash Deposit'),
('ACC1003',3,3,3,'Savings',15000,'2026-08-12','UPI'),
('ACC1004',4,4,4,'Current',90000,'2026-09-30','Cheque Deposit'),
('ACC1005',5,5,5,'Savings',35000,'2026-07-15','NEFT'),
('ACC1006',6,6,6,'Current',50000,'2026-10-10','Cash Withdrawal'),
('ACC1007',7,7,7,'Savings',18000,'2026-08-21','UPI'),
('ACC1008',8,8,8,'Current',76000,'2026-09-08','ATM Deposit'),
('ACC1009',9,9,9,'Savings',29000,'2026-10-14','Interest Credit'),
('ACC1010',10,10,10,'Current',110000,'2026-11-01','RTGS');