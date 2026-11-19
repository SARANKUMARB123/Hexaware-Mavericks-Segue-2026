-- Query 11
-- Customers who have made returns (IN)

SELECT
    CustomerID,
    CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Returns
);

-- Query 12
-- Customers who have not made any returns (NOT IN)

SELECT
    CustomerID,
    CustomerName
FROM Customers
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM Returns
);

-- Query 13
-- Demonstrating the NULL pitfall with NOT IN

SELECT
    CustomerID,
    CustomerName
FROM Customers
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM Returns
    UNION
    SELECT NULL
);

-- Query 14
-- Correct approach using NOT EXISTS

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM Returns r
    WHERE r.CustomerID = c.CustomerID
);