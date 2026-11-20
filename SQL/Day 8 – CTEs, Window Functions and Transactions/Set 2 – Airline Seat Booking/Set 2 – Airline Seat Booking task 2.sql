Session 1

USE AirlineDB;
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRAN;

SELECT *
FROM Seat
WHERE SeatID=102;

WAITFOR DELAY '00:00:15';

UPDATE Seat
SET SeatStatus='Booked'
WHERE SeatID=102;

COMMIT TRAN;

Session 2

USE AirlineDB;
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRAN;

SELECT *
FROM Seat
WHERE SeatID=102;

UPDATE Seat
SET SeatStatus='Booked'
WHERE SeatID=102;

COMMIT TRAN;

SERIALIZABLE Result
- Session 2 waits until Session 1 completes.
- Double booking is prevented.