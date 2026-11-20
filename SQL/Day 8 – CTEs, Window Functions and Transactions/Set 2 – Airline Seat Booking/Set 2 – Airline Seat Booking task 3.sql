USE AirlineDB;
GO

INSERT INTO Booking
(PassengerName,FlightID,SeatID,Fare)
VALUES
('Arun',1,102,8000),
('Bala',1,103,6500),
('Charles',1,101,6500);

SELECT
FlightID,
PassengerName,
Fare,

RANK() OVER
(
PARTITION BY FlightID
ORDER BY Fare DESC
) AS FareRank,

DENSE_RANK() OVER
(
PARTITION BY FlightID
ORDER BY Fare DESC
) AS DenseFareRank

FROM Booking
ORDER BY Fare DESC;

Difference
RANK()
8000  Rank 1
6500  Rank 2
6500  Rank 2
Next Rank = 4

DENSE_RANK()
8000  Rank 1
6500  Rank 2
6500  Rank 2
Next Rank = 3