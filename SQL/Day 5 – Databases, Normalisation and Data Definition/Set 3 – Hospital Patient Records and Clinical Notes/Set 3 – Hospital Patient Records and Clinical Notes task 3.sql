USE HospitalManagementDB;
GO

-- ADD INSURANCE_ID COLUMN

ALTER TABLE Patient
ADD Insurance_ID VARCHAR(30);

SELECT * FROM Patient;

-- RENAME VISIT TABLE TO PATIENTVISIT

EXEC sp_rename 'Visit', 'PatientVisit';

SELECT * FROM PatientVisit;

-- DROP DEFAULT CONSTRAINT ON STATUS

DECLARE @ConstraintName NVARCHAR(200);

SELECT @ConstraintName = dc.name
FROM sys.default_constraints dc
JOIN sys.columns c
ON dc.parent_object_id = c.object_id
AND dc.parent_column_id = c.column_id
WHERE OBJECT_NAME(dc.parent_object_id) = 'PatientVisit'
AND c.name = 'Status';

EXEC('ALTER TABLE PatientVisit DROP CONSTRAINT ' + @ConstraintName);

-- VERIFY TABLE STRUCTURE

EXEC sp_help Patient;

EXEC sp_help PatientVisit;