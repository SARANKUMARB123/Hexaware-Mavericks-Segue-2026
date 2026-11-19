-- Query 15

SELECT
    b.BranchID,
    b.BranchName,
    MAX(l.LoanAmount) AS HighestLoan
FROM Branches b
INNER JOIN Loans l
ON b.BranchID = l.BranchID
GROUP BY b.BranchID, b.BranchName
HAVING MAX(l.LoanAmount) >
(
    SELECT AVG(BranchMaximum)
    FROM
    (
        SELECT
            MAX(LoanAmount) AS BranchMaximum
        FROM Loans
        GROUP BY BranchID
    ) AS BranchMaxLoans
);