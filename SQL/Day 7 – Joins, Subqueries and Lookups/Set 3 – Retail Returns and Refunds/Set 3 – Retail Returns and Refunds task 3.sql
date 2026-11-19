-- Query 15
-- Stores whose average refund is greater than ANY other store in the same region

SELECT
    s.StoreID,
    s.StoreName,
    s.Region,
    AVG(rf.RefundAmount) AS AverageRefund
FROM Stores s
INNER JOIN Returns r
ON s.StoreID = r.StoreID
INNER JOIN Refunds rf
ON r.ReturnID = rf.ReturnID
GROUP BY s.StoreID, s.StoreName, s.Region
HAVING AVG(rf.RefundAmount) >
ANY
(
    SELECT AVG(rf2.RefundAmount)
    FROM Stores s2
    INNER JOIN Returns r2
    ON s2.StoreID = r2.StoreID
    INNER JOIN Refunds rf2
    ON r2.ReturnID = rf2.ReturnID
    WHERE s2.Region = s.Region
      AND s2.StoreID <> s.StoreID
    GROUP BY s2.StoreID
);

-- Query 16
-- Stores whose average refund is greater than ALL other stores in the same region

SELECT
    s.StoreID,
    s.StoreName,
    s.Region,
    AVG(rf.RefundAmount) AS AverageRefund
FROM Stores s
INNER JOIN Returns r
ON s.StoreID = r.StoreID
INNER JOIN Refunds rf
ON r.ReturnID = rf.ReturnID
GROUP BY s.StoreID, s.StoreName, s.Region
HAVING AVG(rf.RefundAmount) >
ALL
(
    SELECT AVG(rf2.RefundAmount)
    FROM Stores s2
    INNER JOIN Returns r2
    ON s2.StoreID = r2.StoreID
    INNER JOIN Refunds rf2
    ON r2.ReturnID = rf2.ReturnID
    WHERE s2.Region = s.Region
      AND s2.StoreID <> s.StoreID
    GROUP BY s2.StoreID
);