
SELECT
    h.HubName,
    s.HubID,
    s.ShipmentID,
    s.ShippingCost
FROM Shipments s
INNER JOIN Hubs h
ON s.HubID = h.HubID
WHERE s.ShippingCost =
(
    SELECT MAX(s2.ShippingCost)
    FROM Shipments s2
    WHERE s2.HubID = s.HubID
      AND s2.ShippingCost <
      (
          SELECT MAX(s3.ShippingCost)
          FROM Shipments s3
          WHERE s3.HubID = s.HubID
      )
)
ORDER BY s.HubID;