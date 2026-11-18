CREATE DATABASE HospitalManagementDB;
GO

USE HospitalManagementDB;
GO

-- DEPARTMENT TABLE

CREATE TABLE Department
(
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- DOCTOR TABLE

CREATE TABLE Doctor
(
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,

    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- PATIENT TABLE

CREATE TABLE Patient
(
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

-- VISIT TABLE

CREATE TABLE Visit
(
    VisitID INT IDENTITY(1,1) PRIMARY KEY,

    PatientID INT NOT NULL,

    DoctorID INT NOT NULL,

    VisitDate DATE NOT NULL,

    Diagnosis VARCHAR(200) NOT NULL,

    Prescription VARCHAR(200),

    BillAmount DECIMAL(10,2) NOT NULL
    CHECK (BillAmount >= 0),

    Notes VARCHAR(300),

    Status VARCHAR(20) NOT NULL
    DEFAULT 'Open',

    CHECK (VisitDate <= GETDATE()),

    FOREIGN KEY (PatientID)
    REFERENCES Patient(PatientID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (DoctorID)
    REFERENCES Doctor(DoctorID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- INSERT DEPARTMENTS

INSERT INTO Department(DepartmentName)
VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Dermatology'),
('Pediatrics'),
('ENT'),
('Oncology'),
('Gynecology'),
('Urology'),
('General Medicine');

-- INSERT DOCTORS

INSERT INTO Doctor(DoctorName,DepartmentID)
VALUES
('Dr. Arun',1),
('Dr. Priya',2),
('Dr. Rahul',3),
('Dr. Sneha',4),
('Dr. Vijay',5),
('Dr. Meena',6),
('Dr. Karthik',7),
('Dr. Anitha',8),
('Dr. Suresh',9),
('Dr. Deepa',10);

-- INSERT PATIENTS

INSERT INTO Patient(PatientName,Address)
VALUES
('Arun Kumar','Chennai'),
('Priya Sharma','Coimbatore'),
('Rahul Singh','Madurai'),
('Sneha Rao','Salem'),
('Vijay Kumar','Trichy'),
('Meena Devi','Vellore'),
('Karthik Raj','Erode'),
('Anitha Roy','Thanjavur'),
('Suresh Babu','Hosur'),
('Deepa Nair','Tirunelveli');

-- INSERT VISITS

INSERT INTO Visit
(PatientID,DoctorID,VisitDate,Diagnosis,Prescription,BillAmount,Notes)
VALUES
(1,1,'2026-10-01','Fever','Paracetamol',1200,'Normal Fever'),
(2,2,'2026-10-03','Migraine','Pain Killer',1800,'Frequent Headache'),
(3,3,'2026-10-05','Fracture','Calcium Tablets',4500,'Minor Fracture'),
(4,4,'2026-10-06','Skin Allergy','Ointment',900,'Rashes'),
(5,5,'2026-10-08','Cold','Syrup',700,'Seasonal Cold'),
(6,6,'2026-10-10','Ear Pain','Ear Drops',1500,'Infection'),
(7,7,'2026-10-12','Cancer Checkup','Medication',6000,'Routine Check'),
(8,8,'2026-10-15','Pregnancy','Vitamin Tablets',2500,'Monthly Check'),
(9,9,'2026-10-17','Kidney Stone','Pain Killer',3200,'Observation'),
(10,10,'2026-10-20','Diabetes','Insulin',4000,'Regular Checkup');

-- VIEW DEPARTMENT

SELECT * FROM Department;

-- VIEW DOCTOR

SELECT * FROM Doctor;

-- VIEW PATIENT

SELECT * FROM Patient;

-- VIEW VISIT

SELECT * FROM Visit;