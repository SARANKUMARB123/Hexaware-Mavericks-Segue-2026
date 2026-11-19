-- Query 1

SELECT
    s.ShipmentID,
    c.CarrierName,
    s.DelayDays
FROM Shipments s
INNER JOIN Carriers c
ON s.CarrierID = c.CarrierID
WHERE s.DelayDays > 2;


-- Query 2

SELECT
    s.ShipmentID,
    cu.CustomerName,
    h.HubName,
    c.CarrierName,
    s.ShipDate,
    s.DeliveryDate
FROM Shipments s
INNER JOIN Customers cu
ON s.CustomerID = cu.CustomerID
INNER JOIN Hubs h
ON s.HubID = h.HubID
INNER JOIN Carriers c
ON s.CarrierID = c.CarrierID;


-- Query 3

SELECT
    h.HubID,
    h.HubName
FROM Hubs h
LEFT JOIN Shipments s
ON h.HubID = s.HubID
WHERE s.ShipmentID IS NULL;


-- Query 4

SELECT
    cu.CustomerID,
    cu.CustomerName
FROM Customers cu
LEFT JOIN Shipments s
ON cu.CustomerID = s.CustomerID
WHERE s.ShipmentID IS NULL;


-- Query 5

SELECT
    c.CarrierName,
    s.ShipmentID,
    s.ShipDate
FROM Carriers c
FULL OUTER JOIN Shipments s
ON c.CarrierID = s.CarrierID;


-- Query 6

SELECT
    e.EmployeeName AS Employee,
    s.EmployeeName AS Supervisor
FROM Employees e
LEFT JOIN Employees s
ON e.SupervisorID = s.EmployeeID;


-- Query 7

SELECT
    c.CarrierName,
    COUNT(s.ShipmentID) AS TotalShipments
FROM Carriers c
INNER JOIN Shipments s
ON c.CarrierID = s.CarrierID
GROUP BY c.CarrierName;


-- Query 8

SELECT
    h.HubName,
    COUNT(s.ShipmentID) AS ShipmentCount
FROM Hubs h
LEFT JOIN Shipments s
ON h.HubID = s.HubID
GROUP BY h.HubName;


-- Query 9

SELECT
    cu.CustomerName,
    d.EventStatus,
    d.EventTime
FROM Customers cu
FULL OUTER JOIN Shipments s
ON cu.CustomerID = s.CustomerID
FULL OUTER JOIN DeliveryEvents d
ON s.ShipmentID = d.ShipmentID;


-- Query 10

SELECT
    c.CarrierName,
    AVG(s.DelayDays) AS AverageDelay
FROM Carriers c
INNER JOIN Shipments s
ON c.CarrierID = s.CarrierID
GROUP BY c.CarrierName
ORDER BY AverageDelay DESC;