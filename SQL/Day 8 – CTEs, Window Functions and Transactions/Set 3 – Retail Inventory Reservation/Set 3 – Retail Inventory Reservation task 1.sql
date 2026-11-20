-- CREATE DATABASE

CREATE DATABASE RetailDB;
GO

USE RetailDB;
GO

-- CATEGORY TABLE

CREATE TABLE Category
(
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100)
);

-- PRODUCT TABLE

CREATE TABLE Product
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Stock INT,
    Price DECIMAL(10,2),
    FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID)
);

-- ORDERS TABLE

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATETIME DEFAULT GETDATE()
);

-- ORDERLINE TABLE

CREATE TABLE OrderLine
(
    OrderLineID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Product(ProductID)
);

-- INSERT DATA

INSERT INTO Category
VALUES
(1,'Electronics'),
(2,'Books');

INSERT INTO Product
VALUES
(101,'Laptop',1,20,60000),
(102,'Mouse',1,50,700),
(103,'SQL Book',2,30,900);

GO

BEGIN TRY

BEGIN TRAN;

DECLARE
    @ProductID INT=101,
    @Qty INT=2,
    @Customer VARCHAR(100)='Rahul',
    @OrderID INT;

IF
(
SELECT Stock
FROM Product
WHERE ProductID=@ProductID
) < @Qty
THROW 50001,'Insufficient Stock',1;

UPDATE Product
SET Stock=Stock-@Qty
WHERE ProductID=@ProductID;

INSERT INTO Orders(CustomerName)
VALUES(@Customer);

SET @OrderID=SCOPE_IDENTITY();

INSERT INTO OrderLine
(
OrderID,
ProductID,
Quantity,
Price
)
SELECT
@OrderID,
ProductID,
@Qty,
Price
FROM Product
WHERE ProductID=@ProductID;

COMMIT;

PRINT 'Order Placed Successfully';

END TRY

BEGIN CATCH

ROLLBACK;

PRINT ERROR_MESSAGE();

END CATCH;

SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderLine;

Rollback Demonstration
BEGIN TRY

BEGIN TRAN;

DECLARE
    @ProductID INT=101,
    @Qty INT=500;

IF
(
SELECT Stock
FROM Product
WHERE ProductID=@ProductID
)<@Qty
THROW 50002,'Stock Not Available',1;

UPDATE Product
SET Stock=Stock-@Qty
WHERE ProductID=@ProductID;

COMMIT;