-- Query 13
-- Customers with at least one loan

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Loans l
    WHERE l.CustomerID = c.CustomerID
);

-- Query 14
-- Customers with a loan but no repayment in the last 60 days

SELECT
    c.CustomerID,
    c.CustomerName
FROM Customers c
WHERE EXISTS
(
    SELECT 1
    FROM Loans l
    WHERE l.CustomerID = c.CustomerID
)
AND NOT EXISTS
(
    SELECT 1
    FROM Loans l
    INNER JOIN Repayments r
        ON l.LoanID = r.LoanID
    WHERE l.CustomerID = c.CustomerID
      AND r.PaymentDate >= DATEADD(DAY, -60, GETDATE())
);