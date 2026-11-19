-- Query 11
-- Uncorrelated Subquery

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(l.LoanAmount) AS TotalLoanExposure
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(l.LoanAmount) >
(
    SELECT AVG(LoanAmount)
    FROM Loans
);

-- Query 12
-- Correlated Subquery

SELECT DISTINCT
    c.CustomerID,
    c.CustomerName
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID
WHERE
(
    SELECT SUM(l2.LoanAmount)
    FROM Loans l2
    WHERE l2.CustomerID = c.CustomerID
)
>
(
    SELECT AVG(l3.LoanAmount)
    FROM Loans l3
    WHERE l3.BranchID = l.BranchID
);