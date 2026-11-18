USE HospitalManagementDB;
GO

-- INSERT A NEW PATIENT

INSERT INTO Patient(PatientName, Address, Insurance_ID)
VALUES
('Rohan Kumar', 'Chennai', 'INS101');

SELECT * FROM Patient;

-- INSERT A NEW PATIENT VISIT

INSERT INTO PatientVisit
(PatientID, DoctorID, VisitDate, Diagnosis, Prescription, BillAmount, Notes, Status)
VALUES
(1, 1, '2026-10-25', 'Viral Fever', 'Paracetamol', 1500, 'Follow-up after 3 days', 'Open');

SELECT * FROM PatientVisit;

-- UPDATE PATIENT ADDRESS

SELECT * FROM Patient
WHERE PatientID = 1;

UPDATE Patient
SET Address = 'Tambaram, Chennai'
WHERE PatientID = 1;

SELECT * FROM Patient
WHERE PatientID = 1;

-- UPDATE VISIT STATUS

SELECT * FROM PatientVisit
WHERE VisitID = 1;

UPDATE PatientVisit
SET Status = 'Closed'
WHERE VisitID = 1;

SELECT * FROM PatientVisit
WHERE VisitID = 1;

-- DELETE A PATIENT VISIT

SELECT * FROM PatientVisit
WHERE VisitID = 11;

DELETE FROM PatientVisit
WHERE VisitID = 11;

SELECT * FROM PatientVisit
WHERE VisitID = 11;

-- PATIENTS VISITED IN OCTOBER 2026

SELECT P.PatientName,
       PV.VisitDate,
       PV.Diagnosis
FROM Patient P
JOIN PatientVisit PV
ON P.PatientID = PV.PatientID
WHERE MONTH(PV.VisitDate) = 10
AND YEAR(PV.VisitDate) = 2026;

-- DOCTORS OF CARDIOLOGY DEPARTMENT

SELECT D.DoctorName,
       DP.DepartmentName
FROM Doctor D
JOIN Department DP
ON D.DepartmentID = DP.DepartmentID
WHERE DP.DepartmentName = 'Cardiology';

-- WHERE WITH LIKE (PATIENT NAME)

SELECT *
FROM Patient
WHERE PatientName LIKE 'A%';

-- WHERE WITH LIKE (DOCTOR NAME)

SELECT *
FROM Doctor
WHERE DoctorName LIKE 'Dr.%';