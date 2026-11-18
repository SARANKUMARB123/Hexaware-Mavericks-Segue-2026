-- ==========================================
-- CREATE ACCOUNT TABLE
-- ==========================================

USE BankManagementDB;
GO

CREATE TABLE Account
(
    AccountID INT IDENTITY(1,1) PRIMARY KEY,

    AccountNumber VARCHAR(20) NOT NULL UNIQUE,

    CustomerID INT NOT NULL,

    BranchID INT NOT NULL,

    ManagerID INT NOT NULL,

    AccountType VARCHAR(20) NOT NULL,

    Balance DECIMAL(12,2) NOT NULL,

    OpenDate DATE NOT NULL,

    LastTransactionText VARCHAR(200),

    CONSTRAINT CK_Account_Balance
    CHECK
    (
        AccountType <> 'Savings'
        OR Balance >= 0
    ),

    CONSTRAINT FK_Account_Customer
    FOREIGN KEY(CustomerID)
    REFERENCES Customer(CustomerID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT FK_Account_Branch
    FOREIGN KEY(BranchID)
    REFERENCES Branch(BranchID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,

    CONSTRAINT FK_Account_Manager
    FOREIGN KEY(ManagerID)
    REFERENCES RelationshipManager(ManagerID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- ==========================================
-- INSERT ACCOUNT RECORDS
-- ==========================================

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

SELECT * FROM Account;

-- ==========================================
-- TASK 4: INSERT
-- ==========================================

INSERT INTO Account
(AccountNumber,CustomerID,BranchID,ManagerID,AccountType,Balance,OpenDate,LastTransactionText)
VALUES
('ACC1011',1,1,1,'Savings',45000,'2026-10-20','Cash Deposit');

SELECT * FROM Account;

-- ==========================================
-- TASK 4: UPDATE
-- ==========================================

SELECT * FROM Account
WHERE AccountNumber='ACC1003';

UPDATE Account
SET Balance=25000,
    LastTransactionText='Balance Updated'
WHERE AccountNumber='ACC1003';

SELECT * FROM Account
WHERE AccountNumber='ACC1003';

-- ==========================================
-- TASK 4: DELETE
-- ==========================================

SELECT * FROM Account
WHERE AccountNumber='ACC1011';

DELETE FROM Account
WHERE AccountNumber='ACC1011';

SELECT * FROM Account
WHERE AccountNumber='ACC1011';

-- ==========================================
-- WHERE
-- ==========================================

SELECT *
FROM Account
WHERE Balance > 50000;

-- ==========================================
-- WHERE WITH AND
-- ==========================================

SELECT *
FROM Account
WHERE AccountType='Savings'
AND Balance>20000;

-- ==========================================
-- WHERE WITH OR
-- ==========================================

SELECT *
FROM Account
WHERE AccountType='Current'
OR Balance>100000;

-- ==========================================
-- WHERE WITH IN
-- ==========================================

SELECT *
FROM Account
WHERE BranchID IN (1,3,5);

-- ==========================================
-- WHERE WITH BETWEEN
-- ==========================================

SELECT *
FROM Account
WHERE Balance BETWEEN 20000 AND 80000;

-- ==========================================
-- LAST QUARTER ACCOUNTS WITH BALANCE ABOVE 30000
-- ==========================================

SELECT *
FROM Account
WHERE OpenDate BETWEEN '2026-08-01' AND '2026-10-31'
AND Balance>30000;