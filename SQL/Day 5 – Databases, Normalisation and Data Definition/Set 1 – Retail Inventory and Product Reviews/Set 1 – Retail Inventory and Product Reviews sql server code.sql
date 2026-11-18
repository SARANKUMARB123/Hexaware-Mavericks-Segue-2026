-- TASK 2: CREATE DATABASE AND TABLES

CREATE DATABASE RetailInventoryDB;
GO

USE RetailInventoryDB;
GO

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Supplier
(
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(100) UNIQUE NOT NULL,
    SupplierPhone VARCHAR(15) NOT NULL
);

CREATE TABLE Warehouse
(
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Product
(
    SKU VARCHAR(10) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    WarehouseID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    ReorderLevel INT DEFAULT 10,

    FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,

    FOREIGN KEY (SupplierID)
        REFERENCES Supplier(SupplierID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,

    FOREIGN KEY (WarehouseID)
        REFERENCES Warehouse(WarehouseID)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);


-- TASK 3: INSERT 10 ROWS INTO EACH TABLE

INSERT INTO Category (CategoryName)
VALUES
('Electronics'),
('Furniture'),
('Groceries'),
('Books'),
('Clothing'),
('Toys'),
('Sports'),
('Kitchen'),
('Beauty'),
('Stationery');


INSERT INTO Supplier (SupplierName, SupplierPhone)
VALUES
('Tech World','9876543210'),
('Home Mart','9876500001'),
('Fresh Foods','9876500002'),
('Book House','9876500003'),
('Fashion Hub','9876500004'),
('Toy Planet','9876500005'),
('Sport Zone','9876500006'),
('Kitchen King','9876500007'),
('Beauty Care','9876500008'),
('Office Point','9876500009');


INSERT INTO Warehouse (WarehouseName)
VALUES
('Warehouse A'),
('Warehouse B'),
('Warehouse C'),
('Warehouse D'),
('Warehouse E'),
('Warehouse F'),
('Warehouse G'),
('Warehouse H'),
('Warehouse I'),
('Warehouse J');


INSERT INTO Product
VALUES
('P101','Laptop',1,1,1,30,5),
('P102','Office Chair',2,2,2,20,5),
('P103','Rice Bag',3,3,3,60,15),
('P104','Java Book',4,4,4,15,5),
('P105','T-Shirt',5,5,5,45,10),
('P106','Football',7,7,6,25,8),
('P107','Toy Car',6,6,7,40,10),
('P108','Mixer Grinder',8,8,8,18,5),
('P109','Shampoo',9,9,9,50,15),
('P110','Notebook',10,10,10,100,20);


-- TASK 3: FOUR DELIBERATELY FAILING INSERTS

-- Duplicate Primary Key
INSERT INTO Product
VALUES
('P101','Gaming Laptop',1,1,1,20,5);

-- Missing Parent (Invalid CategoryID)
INSERT INTO Product
VALUES
('P111','Camera',99,1,1,20,5);

-- Negative Quantity
INSERT INTO Product
VALUES
('P112','Printer',1,1,1,-5,5);

-- NULL in Mandatory Column
INSERT INTO Product
VALUES
('P113',NULL,1,1,1,15,5);


-- TASK 4: UPDATE SUPPLIER PHONE

SELECT *
FROM Supplier
WHERE SupplierID = 1;

UPDATE Supplier
SET SupplierPhone = '9998887776'
WHERE SupplierID = 1;

SELECT *
FROM Supplier
WHERE SupplierID = 1;


-- TASK 4: DELETE DISCONTINUED PRODUCTS

SELECT *
FROM Product;

DELETE FROM Product
WHERE SKU IN ('P109','P110');

SELECT *
FROM Product;


-- DISPLAY FINAL DATA

SELECT
P.SKU,
P.ProductName,
C.CategoryName,
S.SupplierName,
S.SupplierPhone,
W.WarehouseName,
P.Quantity,
P.ReorderLevel
FROM Product P
JOIN Category C
ON P.CategoryID = C.CategoryID
JOIN Supplier S
ON P.SupplierID = S.SupplierID
JOIN Warehouse W
ON P.WarehouseID = W.WarehouseID;


SELECT *
FROM Product
WHERE Quantity < ReorderLevel;