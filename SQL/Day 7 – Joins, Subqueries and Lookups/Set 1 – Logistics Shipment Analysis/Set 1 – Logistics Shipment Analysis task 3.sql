
-- Subquery using IN

SELECT
    CustomerID,
    CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Shipments
);

--Rewritten using JOIN

SELECT DISTINCT
    c.CustomerID,
    c.CustomerName
FROM Customers c
INNER JOIN Shipments s
ON c.CustomerID = s.CustomerID;

-- Subquery using EXISTS

SELECT
    CustomerID,
    CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Shipments s
    WHERE s.CustomerID = c.CustomerID
);

--Rewritten using JOIN

SELECT DISTINCT
    c.CustomerID,
    c.CustomerName
FROM Customers c
INNER JOIN Shipments s
ON c.CustomerID = s.CustomerID;