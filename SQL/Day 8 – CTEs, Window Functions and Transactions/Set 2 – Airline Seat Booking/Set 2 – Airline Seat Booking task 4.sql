USE AirlineDB;
GO

WITH BookingCTE AS
(
SELECT
FlightID,
PassengerName,
Fare,
BookingDate
FROM Booking
)

SELECT

FlightID,
PassengerName,
Fare,

SUM(Fare) OVER
(
PARTITION BY FlightID
ORDER BY BookingDate
ROWS UNBOUNDED PRECEDING
)
AS RunningRevenue

FROM BookingCTE
ORDER BY FlightID,BookingDate;