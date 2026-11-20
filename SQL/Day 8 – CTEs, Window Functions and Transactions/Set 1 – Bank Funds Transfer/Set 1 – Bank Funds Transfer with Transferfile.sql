Set 1 – Bank Funds Transfer

Task - 1

-- CREATE DATABASE

CREATE DATABASE BankDB;
GO

USE BankDB;
GO

-- ACCOUNT TABLE

CREATE TABLE Account
(
    AccountID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Balance DECIMAL(12,2),
    Status VARCHAR(20)
);

-- TRANSACTION HISTORY

CREATE TABLE TransactionHistory
(
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    FromAccount INT,
    ToAccount INT,
    Amount DECIMAL(12,2),
    TransactionDate DATETIME DEFAULT GETDATE()
);

-- INSERT DATA

INSERT INTO Account
VALUES
(101,'Arun',50000,'Active'),
(102,'Bala',25000,'Active'),
(103,'Charles',15000,'Inactive');

GO

BEGIN TRY

BEGIN TRAN;

DECLARE
    @FromAccount INT = 101,
    @ToAccount INT = 102,
    @Amount DECIMAL(12,2) = 5000;

IF NOT EXISTS
(
    SELECT *
    FROM Account
    WHERE AccountID=@FromAccount
    AND Status='Active'
)
THROW 50001,'Source account is inactive.',1;

IF NOT EXISTS
(
    SELECT *
    FROM Account
    WHERE AccountID=@ToAccount
    AND Status='Active'
)
THROW 50002,'Destination account is inactive.',1;

IF
(
    SELECT Balance
    FROM Account
    WHERE AccountID=@FromAccount
) < @Amount
THROW 50003,'Insufficient balance.',1;

UPDATE Account
SET Balance=Balance-@Amount
WHERE AccountID=@FromAccount;

UPDATE Account
SET Balance=Balance+@Amount
WHERE AccountID=@ToAccount;

INSERT INTO TransactionHistory
(
FromAccount,
ToAccount,
Amount
)
VALUES
(
@FromAccount,
@ToAccount,
@Amount
);

COMMIT TRAN;

PRINT 'Transfer Successful';

END TRY

BEGIN CATCH

ROLLBACK TRAN;

PRINT ERROR_MESSAGE();

THROW;

END CATCH;

SELECT * FROM Account;

SELECT * FROM TransactionHistory;

Task - 2

-- ROLLBACK DEMONSTRATION

BEGIN TRY

BEGIN TRAN;

DECLARE
    @FromAccount INT = 101,
    @ToAccount INT = 102,
    @Amount DECIMAL(12,2) = 2000;

UPDATE Account
SET Balance=Balance-@Amount
WHERE AccountID=@FromAccount;

THROW 51000,'Artificial Failure After Debit.',1;

UPDATE Account
SET Balance=Balance+@Amount
WHERE AccountID=@ToAccount;

COMMIT TRAN;

END TRY

BEGIN CATCH

ROLLBACK TRAN;

PRINT 'Rollback Executed';

PRINT ERROR_MESSAGE();

END CATCH;

SELECT * FROM Account;

Task - 3

-- SAVEPOINT DEMONSTRATION

BEGIN TRY

BEGIN TRAN;

DECLARE
    @Amount DECIMAL(12,2)=1000,
    @Fee DECIMAL(12,2)=100;

UPDATE Account
SET Balance=Balance-@Amount
WHERE AccountID=101;

UPDATE Account
SET Balance=Balance+@Amount
WHERE AccountID=102;

SAVE TRANSACTION FeeSavePoint;

UPDATE Account
SET Balance=Balance-@Fee
WHERE AccountID=101;

THROW 52000,'Fee Processing Failed.',1;

COMMIT TRAN;

END TRY

BEGIN CATCH

IF @@TRANCOUNT>0
BEGIN
    ROLLBACK TRANSACTION FeeSavePoint;
    COMMIT TRAN;
END

PRINT 'Transfer Completed. Fee Rolled Back.';
PRINT ERROR_MESSAGE();

END CATCH;

SELECT * FROM Account;

Task - 4

USE BankDB;
GO

WITH StatementCTE AS
(
    SELECT
        TransactionID,
        FromAccount,
        ToAccount,
        Amount,
        TransactionDate,

        ROW_NUMBER() OVER
        (
            ORDER BY TransactionDate
        ) AS RowNum,

        LAG(Amount,1,0) OVER
        (
            ORDER BY TransactionDate
        ) AS PreviousAmount

    FROM TransactionHistory
)

SELECT
TransactionID,
FromAccount,
ToAccount,
Amount,
PreviousAmount,
RowNum,
TransactionDate
FROM StatementCTE
ORDER BY TransactionDate;