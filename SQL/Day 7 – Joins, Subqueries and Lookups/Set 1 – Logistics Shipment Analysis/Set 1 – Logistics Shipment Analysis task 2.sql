-- Query 11

SELECT
    CustomerID,
    CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT CustomerID
    FROM Shipments
);


-- Query 12

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


-- Query 13

SELECT
    CarrierID,
    CarrierName
FROM Carriers
WHERE CarrierID = ANY
(
    SELECT CarrierID
    FROM Shipments
    WHERE DelayDays > 5
);


-- Query 14

SELECT
    CarrierID,
    CarrierName
FROM Carriers
WHERE CarrierID = ALL
(
    SELECT CarrierID
    FROM Shipments
    WHERE CarrierID = 1
);


-- Query 15

SELECT
    c.CarrierName,
    AVG(s.DelayDays) AS AverageDelay
FROM Carriers c
INNER JOIN Shipments s
ON c.CarrierID = s.CarrierID
GROUP BY c.CarrierName
HAVING AVG(s.DelayDays) >
(
    SELECT AVG(DelayDays)
    FROM Shipments
);


-- Query 16

SELECT
    CustomerID,
    CustomerName
FROM Customers c
WHERE NOT EXISTS
(
    SELECT HubID
    FROM Hubs
    EXCEPT
    SELECT HubID
    FROM Shipments s
    WHERE s.CustomerID = c.CustomerID
);


-- Query 17

SELECT
    ShipmentID,
    ShippingCost
FROM Shipments
WHERE ShippingCost >
(
    SELECT AVG(ShippingCost)
    FROM Shipments
);


-- Query 18

SELECT
    ShipmentID,
    ShippingCost
FROM Shipments
WHERE ShippingCost >
ANY
(
    SELECT ShippingCost
    FROM Shipments
    WHERE HubID = 1
);


-- Query 19

SELECT
    ShipmentID,
    ShippingCost
FROM Shipments
WHERE ShippingCost >
ALL
(
    SELECT ShippingCost
    FROM Shipments
    WHERE HubID = 1
);


-- Query 20

SELECT
    HubID,
    HubName
FROM Hubs
WHERE HubID IN
(
    SELECT DISTINCT HubID
    FROM Shipments
    WHERE DelayDays > 2
);