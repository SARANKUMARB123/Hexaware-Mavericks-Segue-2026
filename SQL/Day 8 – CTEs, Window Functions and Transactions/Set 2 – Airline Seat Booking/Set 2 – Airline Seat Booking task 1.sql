-- CREATE DATABASE

CREATE DATABASE AirlineDB;
GO

USE AirlineDB;
GO

-- FLIGHT TABLE

CREATE TABLE Flight
(
    FlightID INT PRIMARY KEY,
    FlightName VARCHAR(100),
    SourceCity VARCHAR(50),
    DestinationCity VARCHAR(50)
);

-- SEAT TABLE

CREATE TABLE Seat
(
    SeatID INT PRIMARY KEY,
    FlightID INT,
    SeatNumber VARCHAR(10),
    SeatStatus VARCHAR(20),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

-- BOOKING TABLE

CREATE TABLE Booking
(
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerName VARCHAR(100),
    FlightID INT,
    SeatID INT,
    Fare DECIMAL(10,2),
    BookingDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (SeatID) REFERENCES Seat(SeatID)
);

-- INSERT DATA

INSERT INTO Flight
VALUES
(1,'AI101','Chennai','Delhi');

INSERT INTO Seat
VALUES
(101,1,'A1','Available'),
(102,1,'A2','Available'),
(103,1,'A3','Available');

GO

BEGIN TRY

BEGIN TRAN;

DECLARE
    @SeatID INT = 101,
    @FlightID INT = 1,
    @PassengerName VARCHAR(100)='Rahul',
    @Fare DECIMAL(10,2)=6500;

IF NOT EXISTS
(
    SELECT *
    FROM Seat
    WHERE SeatID=@SeatID
    AND SeatStatus='Available'
)
THROW 50001,'Seat is already booked.',1;

INSERT INTO Booking
(
PassengerName,
FlightID,
SeatID,
Fare
)
VALUES
(
@PassengerName,
@FlightID,
@SeatID,
@Fare
);

UPDATE Seat
SET SeatStatus='Booked'
WHERE SeatID=@SeatID;

COMMIT TRAN;

PRINT 'Booking Successful';

END TRY

BEGIN CATCH

ROLLBACK TRAN;

PRINT ERROR_MESSAGE();

THROW;

END CATCH;

SELECT * FROM Seat;

SELECT * FROM Booking;