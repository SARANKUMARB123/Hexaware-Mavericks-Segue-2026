-- Query 1

SELECT
    l.LoanID,
    c.CustomerName,
    b.BranchName,
    l.LoanAmount,
    l.OverdueInstallments
FROM Loans l
INNER JOIN Customers c
ON l.CustomerID = c.CustomerID
INNER JOIN Branches b
ON l.BranchID = b.BranchID
WHERE l.OverdueInstallments > 3;


-- Query 2

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT l.BranchID) AS TotalBranches
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT l.BranchID) > 1;


-- Query 3

SELECT
    g.GuarantorName,
    c.CustomerName AS Borrower
FROM Guarantors g
INNER JOIN Customers c
ON g.CustomerID = c.CustomerID;


-- Query 4

SELECT
    b.BranchID,
    b.BranchName
FROM Branches b
LEFT JOIN Loans l
ON b.BranchID = l.BranchID
WHERE l.LoanID IS NULL;


-- Query 5

SELECT
    b.BranchName,
    SUM(l.LoanAmount) AS TotalLoanAmount
FROM Branches b
INNER JOIN Loans l
ON b.BranchID = l.BranchID
GROUP BY b.BranchName;


-- Query 6

SELECT
    c.CustomerName,
    l.LoanID,
    l.LoanAmount,
    l.LoanDate
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID;


-- Query 7

SELECT
    l.LoanID,
    c.CustomerName,
    r.RepaymentID,
    r.PaymentDate,
    r.Amount
FROM Loans l
INNER JOIN Customers c
ON l.CustomerID = c.CustomerID
LEFT JOIN Repayments r
ON l.LoanID = r.LoanID;


-- Query 8

SELECT
    l.LoanID,
    g.GuarantorName
FROM LoanGuarantors lg
INNER JOIN Loans l
ON lg.LoanID = l.LoanID
INNER JOIN Guarantors g
ON lg.GuarantorID = g.GuarantorID;


-- Query 9

SELECT
    b.BranchName,
    AVG(l.LoanAmount) AS AverageLoanAmount
FROM Branches b
INNER JOIN Loans l
ON b.BranchID = l.BranchID
GROUP BY b.BranchName;


-- Query 10

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(l.LoanID) AS TotalLoans
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(l.LoanID) > 1;