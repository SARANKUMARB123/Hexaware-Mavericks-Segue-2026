-- Query 17

SELECT
    p.ProductID,
    p.ProductName
FROM Products p
WHERE p.ProductID IN
(
    SELECT r.ProductID
    FROM Returns r
    WHERE r.ReturnID IN
    (
        SELECT rf.ReturnID
        FROM Refunds rf
        WHERE rf.RefundAmount >
        (
            SELECT AVG(RefundAmount)
            FROM Refunds
        )
    )
);

-- Query 18

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
WHERE c.CustomerID IN
(
    SELECT r.CustomerID
    FROM Returns r
    WHERE r.ProductID IN
    (
        SELECT ProductID
        FROM Returns
        GROUP BY ProductID
        HAVING COUNT(ReturnID) =
        (
            SELECT MAX(ProductReturnCount)
            FROM
            (
                SELECT COUNT(ReturnID) AS ProductReturnCount
                FROM Returns
                GROUP BY ProductID
            ) AS ProductCounts
        )
    )
);