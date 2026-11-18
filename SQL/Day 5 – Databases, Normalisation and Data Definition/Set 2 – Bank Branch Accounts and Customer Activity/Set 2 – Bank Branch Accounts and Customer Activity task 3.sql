
-- TASK 3: DELETE, TRUNCATE AND DROP DEMONSTRATION

CREATE TABLE TestAccount
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO TestAccount(CustomerName)
VALUES
('Arun'),
('Priya'),
('Rahul'),
('Sneha'),
('Vijay');

SELECT * FROM TestAccount;

BEGIN TRANSACTION;

DELETE FROM TestAccount
WHERE ID = 1;

SELECT * FROM TestAccount;

ROLLBACK;

SELECT * FROM TestAccount;

INSERT INTO TestAccount(CustomerName)
VALUES('Karthik');

SELECT * FROM TestAccount;

TRUNCATE TABLE TestAccount;

SELECT * FROM TestAccount;

INSERT INTO TestAccount(CustomerName)
VALUES('Deepa');

SELECT * FROM TestAccount;

DROP TABLE TestAccount;

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'TestAccount';