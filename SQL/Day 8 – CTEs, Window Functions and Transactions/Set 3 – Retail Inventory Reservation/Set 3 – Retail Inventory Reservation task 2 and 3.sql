--Task 2

SELECT
P.ProductID,
P.ProductName,
P.Stock,
C.CategoryName
FROM Product P
JOIN Category C
ON P.CategoryID=C.CategoryID
WHERE P.Stock<
(
SELECT AVG(P2.Stock)
FROM Product P2
WHERE P2.CategoryID=P.CategoryID
);

--Task 3

USE RetailDB;
GO

WITH SalesCTE AS
(
SELECT

P.ProductID,
P.ProductName,
C.CategoryName,

SUM(OL.Quantity*OL.Price) AS TotalSales,

ROW_NUMBER() OVER
(
PARTITION BY C.CategoryName
ORDER BY SUM(OL.Quantity*OL.Price) DESC
)
AS ProductRank

FROM Product P

JOIN Category C
ON P.CategoryID=C.CategoryID

JOIN OrderLine OL
ON P.ProductID=OL.ProductID

GROUP BY
P.ProductID,
P.ProductName,
C.CategoryName
)

SELECT *
FROM SalesCTE
WHERE ProductRank<=3;

--Task 4

WITH MonthlySales AS
(
SELECT

ProductID,

YEAR(O.OrderDate) AS SalesYear,

MONTH(O.OrderDate) AS SalesMonth,

SUM(Quantity*Price) AS Sales

FROM OrderLine OL

JOIN Orders O
ON OL.OrderID=O.OrderID

GROUP BY
ProductID,
YEAR(O.OrderDate),
MONTH(O.OrderDate)
)

SELECT

ProductID,

SalesYear,

SalesMonth,

Sales,

LAG(Sales)
OVER
(
PARTITION BY ProductID
ORDER BY SalesYear,SalesMonth
)
AS PreviousMonth,

LEAD(Sales)
OVER
(
PARTITION BY ProductID
ORDER BY SalesYear,SalesMonth
)
AS NextMonth

FROM MonthlySales;