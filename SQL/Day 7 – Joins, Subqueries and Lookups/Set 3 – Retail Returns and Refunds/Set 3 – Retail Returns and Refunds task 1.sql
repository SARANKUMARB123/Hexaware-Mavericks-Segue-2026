-- Query 1

SELECT
    p.ProductID,
    p.ProductName,
    COUNT(r.ReturnID) AS TotalReturns,
    COUNT(r.ReturnID) * 100.0 /
    (
        SELECT COUNT(*)
        FROM Returns
    ) AS ReturnRate
FROM Products p
INNER JOIN Returns r
ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(r.ReturnID) * 100.0 /
(
    SELECT COUNT(*)
    FROM Returns
) > 10;


-- Query 2

SELECT
    c.CustomerID,
    c.CustomerName,
    r.ReturnID
FROM Customers c
INNER JOIN Returns r
ON c.CustomerID = r.CustomerID
LEFT JOIN Refunds rf
ON r.ReturnID = rf.ReturnID
WHERE rf.RefundID IS NULL;


-- Query 3

SELECT TOP 1
    s.StoreID,
    s.StoreName,
    SUM(rf.RefundAmount) AS TotalRefund
FROM Stores s
INNER JOIN Returns r
ON s.StoreID = r.StoreID
INNER JOIN Refunds rf
ON r.ReturnID = rf.ReturnID
GROUP BY s.StoreID, s.StoreName
ORDER BY TotalRefund DESC;


-- Query 4

SELECT
    e.EmployeeName AS Employee,
    m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m
ON e.ManagerID = m.EmployeeID;


-- Query 5

SELECT
    p.ProductName,
    COUNT(r.ReturnID) AS TotalReturns
FROM Products p
INNER JOIN Returns r
ON p.ProductID = r.ProductID
GROUP BY p.ProductName
ORDER BY TotalReturns DESC;


-- Query 6

SELECT
    c.CustomerName,
    p.ProductName,
    r.ReturnDate,
    r.Quantity
FROM Returns r
INNER JOIN Customers c
ON r.CustomerID = c.CustomerID
INNER JOIN Products p
ON r.ProductID = p.ProductID;


-- Query 7

SELECT
    r.ReturnID,
    p.ProductName,
    rf.RefundAmount,
    rf.RefundDate
FROM Returns r
INNER JOIN Products p
ON r.ProductID = p.ProductID
LEFT JOIN Refunds rf
ON r.ReturnID = rf.ReturnID;


-- Query 8

SELECT
    s.StoreName,
    COUNT(r.ReturnID) AS TotalReturns
FROM Stores s
LEFT JOIN Returns r
ON s.StoreID = r.StoreID
GROUP BY s.StoreName;


-- Query 9

SELECT
    s.StoreName,
    AVG(rf.RefundAmount) AS AverageRefund
FROM Stores s
INNER JOIN Returns r
ON s.StoreID = r.StoreID
INNER JOIN Refunds rf
ON r.ReturnID = rf.ReturnID
GROUP BY s.StoreName;


-- Query 10

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(r.ReturnID) AS TotalReturns
FROM Customers c
INNER JOIN Returns r
ON c.CustomerID = r.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(r.ReturnID) > 1;