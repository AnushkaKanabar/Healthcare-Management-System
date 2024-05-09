-- Drop the database if it already exists
DROP DATABASE IF EXISTS healthcare_management_system;

-- Create the database
CREATE DATABASE healthcare_management_system;

 -- Use the database 
USE healthcare_management_system;

-- Create Insurance table
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    PolicyNumber VARCHAR(50),
    CoverageType VARCHAR(50),
    CoverageStartDate DATE,
    CoverageEndDate DATE,
    PremiumAmount DECIMAL(10 , 2 ),
    UNIQUE (Full_Name)
);

-- Create Patient table
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    InsuranceID INT,
    EmergencyContact VARCHAR(100),
    UNIQUE (FirstName, LastName),
    FOREIGN KEY (InsuranceID) REFERENCES Insurance (InsuranceID)
);

-- Create Doctor table
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Specialty VARCHAR(100),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    LicenseNumber VARCHAR(50),
    DateOfEmployment DATE,
    UNIQUE (FullName)
);

-- Create Hospital/Clinic table
CREATE TABLE HospitalClinic (
    HospitalClinicID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(100),
    NumberOfBeds INT,
    AccreditationStatus VARCHAR(50),
    SpecialFacilities VARCHAR(255),
    DirectorAdministrator VARCHAR(100),
    UNIQUE (Name)
);

-- Create Appointment table
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDateTime DATETIME,
    Duration INT,
    ReasonForVisit VARCHAR(255),
    Status VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
);

-- Create MedicalRecord table
CREATE TABLE MedicalRecord (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    DateOfVisit DATE,
    Diagnosis TEXT,
    TreatmentPlan TEXT,
    MedicationsPrescribed TEXT,
    LabTestResults TEXT,
    ImagingReports TEXT,
    SurgeryDetails TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
);

-- Create Billing table
CREATE TABLE Billing (
    BillingID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    HospitalClinicID INT,
    DateOfService DATE,
    ServiceProvided TEXT,
    ProcedureCodes VARCHAR(100),
    DiagnosisCodes VARCHAR(100),
    Cost DECIMAL(10 , 2 ),
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID),
    FOREIGN KEY (HospitalClinicID) REFERENCES HospitalClinic (HospitalClinicID)
);

-- Create Prescription table
CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    DatePrescribed DATE,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration INT,
    Instructions TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
);

-- Create LabTest table
CREATE TABLE LabTest (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    TestDate DATE,
    TestName VARCHAR(100),
    TestResult TEXT,
    NormalRange VARCHAR(100),
    TestMethod VARCHAR(100),
    LabTechnician VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
);

-- Create ImagingStudy table
CREATE TABLE ImagingStudy (
    StudyID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    StudyDate DATE,
    StudyType VARCHAR(100),
    Findings TEXT,
    Conclusion TEXT,
    Radiologist VARCHAR(100),
    ImageURLsReferences TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient (PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor (DoctorID)
);

-- Insert data into Insurance table
INSERT INTO Insurance (Full_Name, Address, PhoneNumber, Email, PolicyNumber, CoverageType, CoverageStartDate, CoverageEndDate, PremiumAmount) 
VALUES 
('ABC Insurance Company', '123 Main St, Cityville', '555-1234', 'info@abcinsurance.com', 'POL123456', 'Health', '2024-01-01', '2025-01-01', 200.00),
('XYZ Insurance Co.', '456 Elm St, Townsville', '555-5678', 'info@xyzinsurance.com', 'POL789012', 'Life', '2024-03-15', '2025-03-15', 150.00),
('Insurance Ltd.', '789 Oak St, Villageton', '555-9012', 'info@insuranceltd.com', 'POL345678', 'Auto', '2024-02-10', '2025-02-10', 300.00),
('Global Insurance Inc.', '321 Pine St, Hamletown', '555-3456', 'info@globalinsurance.com', 'POL901234', 'Health', '2024-04-20', '2025-04-20', 250.00),
('Secure Insurance', '567 Maple St, Countryside', '555-7890', 'info@secureinsurance.com', 'POL567890', 'Life', '2024-01-15', '2025-01-15', 180.00),
('Citywide Insurance', '890 Birch St, Metropolis', '555-2345', 'info@citywideinsurance.com', 'POL123789', 'Auto', '2024-03-01', '2025-03-01', 280.00),
('Metro Insurance Group', '234 Cedar St, Capital City', '555-6789', 'info@metroinsurancegroup.com', 'POL456789', 'Health', '2024-02-05', '2025-02-05', 220.00),
('Regional Insurance', '678 Walnut St, Midtown', '555-0123', 'info@regionalinsurance.com', 'POL890123', 'Life', '2024-04-10', '2025-04-10', 190.00),
('United Insurance Agency', '901 Spruce St, Downtown', '555-4567', 'info@unitedinsuranceagency.com', 'POL234567', 'Auto', '2024-01-20', '2025-01-20', 320.00),
('National Insurance Corporation', '345 Oak St, Uptown', '555-7891', 'info@nationalinsurancecorp.com', 'POL678901', 'Health', '2024-03-25', '2025-03-25', 270.00);

-- Insert data into Patient table
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Address, PhoneNumber, Email, InsuranceID, EmergencyContact)
VALUES 
('John', 'Doe', '1985-05-10', 'M', '123 Apple St, Anytown', '555-1111', 'john.doe@example.com', 1, 'Jane Doe'),
('Jane', 'Smith', '1990-08-15', 'F', '456 Banana St, Othertown', '555-2222', 'jane.smith@example.com', 2, 'John Smith'),
('David', 'Johnson', '1978-03-20', 'M', '789 Cherry St, Anycity', '555-3333', 'david.johnson@example.com', 3, 'Emily Johnson'),
('Emily', 'Brown', '1982-11-25', 'F', '012 Grape St, Newville', '555-4444', 'emily.brown@example.com', 4, 'Michael Brown'),
('Michael', 'Wilson', '1995-09-30', 'M', '234 Peach St, Smalltown', '555-5555', 'michael.wilson@example.com', 5, 'Sarah Wilson'),
('Sarah', 'Martinez', '2000-02-05', 'F', '567 Lemon St, Largetown', '555-6666', 'sarah.martinez@example.com', 6, 'Daniel Martinez'),
('Daniel', 'Lee', '1993-07-12', 'M', '890 Lime St, Minicity', '555-7777', 'daniel.lee@example.com', 7, 'Amanda Lee'),
('Amanda', 'Garcia', '1989-12-28', 'F', '901 Orange St, Maxville', '555-8888', 'amanda.garcia@example.com', 8, 'James Garcia'),
('James', 'Taylor', '1975-06-15', 'M', '234 Pineapple St, Bigcity', '555-9999', 'james.taylor@example.com', 9, 'Jessica Taylor'),
('Jessica', 'Clark', '1980-04-01', 'F', '678 Watermelon St, Grandtown', '555-0000', 'jessica.clark@example.com', 10, 'David Clark');

-- Insert data into Doctor table
INSERT INTO Doctor (FullName, Specialty, Address, PhoneNumber, Email, LicenseNumber, DateOfEmployment)
VALUES 
('Dr. John Smith', 'Cardiology', '123 Main St, Cityville', '555-1111', 'john.smith@example.com', 'DOC123456', '2010-05-10'),
('Dr. Emily Johnson', 'Pediatrics', '456 Elm St, Townsville', '555-2222', 'emily.johnson@example.com', 'DOC789012', '2012-08-15'),
('Dr. Michael Brown', 'Orthopedics', '789 Oak St, Villageton', '555-3333', 'michael.brown@example.com', 'DOC345678', '2015-03-20'),
('Dr. Sarah Martinez', 'Dermatology', '012 Pine St, Hamletown', '555-4444', 'sarah.martinez@example.com', 'DOC901234', '2018-11-25'),
('Dr. Daniel Lee', 'Neurology', '234 Cedar St, Capital City', '555-5555', 'daniel.lee@example.com', 'DOC567890', '2020-09-30'),
('Dr. Amanda Garcia', 'Ophthalmology', '567 Walnut St, Midtown', '555-6666', 'amanda.garcia@example.com', 'DOC123789', '2017-07-12'),
('Dr. James Taylor', 'ENT (Ear, Nose, Throat)', '890 Spruce St, Downtown', '555-7777', 'james.taylor@example.com', 'DOC234567', '2014-12-28'),
('Dr. Jessica Clark', 'Psychiatry', '901 Birch St, Uptown', '555-8888', 'jessica.clark@example.com', 'DOC345678', '2013-06-15'),
('Dr. David Wilson', 'Internal Medicine', '234 Oak St, Riverside', '555-9999', 'david.wilson@example.com', 'DOC456789', '2016-04-01'),
('Dr. Jennifer Adams', 'Obstetrics and Gynecology', '345 Maple St, Lakeside', '555-0000', 'jennifer.adams@example.com', 'DOC567890', '2019-02-20');

-- Insert data into HospitalClinic table
INSERT INTO HospitalClinic (Name, Address, PhoneNumber, Email, NumberOfBeds, AccreditationStatus, SpecialFacilities, DirectorAdministrator)
VALUES 
('City General Hospital', '123 Hospital Rd, Cityville', '555-1111', 'info@citygeneralhospital.com', 300, 'Accredited', 'MRI, CT Scan', 'Dr. William Johnson'),
('Townsville Medical Center', '456 Medical Blvd, Townsville', '555-2222', 'info@townsvillemedicalcenter.com', 250, 'Accredited', 'Laboratory, X-ray', 'Dr. Emma Wilson'),
('Villageton Clinic', '789 Clinic Ave, Villageton', '555-3333', 'info@villagetonclinic.com', 100, 'Not Accredited', 'Physical Therapy', 'Dr. Daniel Brown'),
('Hamletown Community Hospital', '012 Community Dr, Hamletown', '555-4444', 'info@hamletownhospital.com', 150, 'Accredited', 'Emergency Department', 'Dr. Sophia Garcia'),
('Capital City Medical Center', '234 Medical St, Capital City', '555-5555', 'info@capitalcitymedicalcenter.com', 200, 'Accredited', 'Surgery Department', 'Dr. Noah Martinez'),
('Midtown Specialty Clinic', '567 Specialty Ln, Midtown', '555-6666', 'info@midtownspecialtyclinic.com', 75, 'Accredited', 'Endoscopy Suite', 'Dr. Olivia Clark'),
('Downtown Surgical Hospital', '890 Surgical Ave, Downtown', '555-7777', 'info@downtownsurgicalhospital.com', 175, 'Accredited', 'Intensive Care Unit', 'Dr. Ethan Adams'),
('Uptown Medical Center', '901 Medical Park, Uptown', '555-8888', 'info@uptownmedicalcenter.com', 225, 'Accredited', 'Cardiac Catheterization Lab', 'Dr. Ava Taylor'),
('Riverside Family Clinic', '234 Family Dr, Riverside', '555-9999', 'info@riversidefamilyclinic.com', 50, 'Not Accredited', 'Pediatrics Department', 'Dr. Liam Clark'),
('Lakeside Women''s Hospital', '345 Women''s Ave, Lakeside', '555-0000', 'info@lakesidewomenshospital.com', 100, 'Accredited', 'Maternity Ward', 'Dr. Mia Adams');

-- Insert data into Appointment table
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDateTime, Duration, ReasonForVisit, Status, Notes)
VALUES 
(1, 1, '2024-03-01 09:00:00', 60, 'Routine checkup', 'Confirmed', 'No special notes'),
(2, 2, '2024-03-02 10:30:00', 30, 'Follow-up appointment', 'Confirmed', 'Patient improving well'),
(3, 3, '2024-03-03 14:00:00', 45, 'Orthopedic consultation', 'Confirmed', 'X-rays to be taken'),
(4, 4, '2024-03-04 11:15:00', 60, 'Skin rash examination', 'Confirmed', 'Prescribed topical ointment'),
(5, 5, '2024-03-05 08:45:00', 30, 'Neurology follow-up', 'Confirmed', 'Discuss MRI results'),
(6, 6, '2024-03-06 13:30:00', 45, 'Eye examination', 'Confirmed', 'Patient reports improved vision'),
(7, 7, '2024-03-07 09:30:00', 60, 'ENT consultation', 'Confirmed', 'Ear irrigation needed'),
(8, 8, '2024-03-08 12:00:00', 30, 'Psychiatry session', 'Confirmed', 'Discussing treatment progress'),
(9, 9, '2024-03-09 15:00:00', 45, 'Internal medicine checkup', 'Confirmed', 'Blood pressure slightly high'),
(10, 10, '2024-03-10 11:45:00', 60, 'Obstetrics follow-up', 'Confirmed', 'Patient feeling discomfort');

-- Insert data into MedicalRecord table
INSERT INTO MedicalRecord (PatientID, DoctorID, DateOfVisit, Diagnosis, TreatmentPlan, MedicationsPrescribed, LabTestResults, ImagingReports, SurgeryDetails)
VALUES 
(1, 1, '2024-03-01', 'Routine checkup', 'No treatment needed', 'None', 'Normal', 'None', 'None'),
(2, 2, '2024-03-02', 'Follow-up visit', 'Continue previous treatment', 'Antibiotics', 'Normal', 'None', 'None'),
(3, 3, '2024-03-03', 'Fractured arm', 'Apply cast, follow up in 6 weeks', 'Pain relievers', 'X-ray shows fracture', 'None', 'None'),
(4, 4, '2024-03-04', 'Skin rash', 'Prescribed topical ointment', 'Topical cream', 'None', 'None', 'None'),
(5, 5, '2024-03-05', 'Neurological condition', 'Further investigation required', 'None', 'MRI indicates nerve compression', 'None', 'None'),
(6, 6, '2024-03-06', 'Vision checkup', 'Prescription updated', 'Eyeglasses', 'None', 'None', 'None'),
(7, 7, '2024-03-07', 'Ear blockage', 'Irrigation procedure', 'None', 'Normal', 'None', 'None'),
(8, 8, '2024-03-08', 'Depression', 'Cognitive behavioral therapy', 'Antidepressants', 'None', 'None', 'None'),
(9, 9, '2024-03-09', 'Hypertension', 'Diet and exercise regimen', 'Blood pressure medication', 'Slightly elevated', 'None', 'None'),
(10, 10, '2024-03-10', 'Prenatal checkup', 'Monitoring pregnancy progress', 'Prenatal vitamins', 'None', 'None', 'None');

-- Insert data into Billing table
INSERT INTO Billing (PatientID, DoctorID, HospitalClinicID, DateOfService, ServiceProvided, ProcedureCodes, DiagnosisCodes, Cost, PaymentStatus)
VALUES 
(1, 1, 1, '2024-03-01', 'Routine checkup', 'P001', 'D001', 100.00, 'Paid'),
(2, 2, 2, '2024-03-02', 'Follow-up appointment', 'P002', 'D002', 75.00, 'Pending'),
(3, 3, 3, '2024-03-03', 'Orthopedic consultation', 'P003', 'D003', 150.00, 'Unpaid'),
(4, 4, 4, '2024-03-04', 'Skin rash examination', 'P004', 'D004', 80.00, 'Paid'),
(5, 5, 5, '2024-03-05', 'Neurology follow-up', 'P005', 'D005', 90.00, 'Paid'),
(6, 6, 6, '2024-03-06', 'Eye examination', 'P006', 'D006', 120.00, 'Pending'),
(7, 7, 7, '2024-03-07', 'ENT consultation', 'P007', 'D007', 110.00, 'Unpaid'),
(8, 8, 8, '2024-03-08', 'Psychiatry session', 'P008', 'D008', 130.00, 'Paid'),
(9, 9, 9, '2024-03-09', 'Internal medicine checkup', 'P009', 'D009', 95.00, 'Paid'),
(10, 10, 10, '2024-03-10', 'Obstetrics follow-up', 'P010', 'D010', 140.00, 'Pending');

-- Insert data into Prescription table
INSERT INTO Prescription (PatientID, DoctorID, DatePrescribed, MedicationName, Dosage, Frequency, Duration, Instructions)
VALUES 
(1, 1, '2024-03-01', 'Aspirin', '100 mg', 'Once daily', 30, 'Take with food'),
(2, 2, '2024-03-02', 'Amoxicillin', '500 mg', 'Twice daily', 10, 'Complete the course'),
(3, 3, '2024-03-03', 'Ibuprofen', '200 mg', 'As needed', 15, 'Take with plenty of water'),
(4, 4, '2024-03-04', 'Hydrocortisone cream', 'Apply thinly', 'Twice daily', 7, 'Avoid contact with eyes'),
(5, 5, '2024-03-05', 'Gabapentin', '300 mg', 'Three times daily', 30, 'Do not stop abruptly'),
(6, 6, '2024-03-06', 'Latanoprost', '1 drop', 'Once daily', 30, 'Administer in the evening'),
(7, 7, '2024-03-07', 'Debrox', '5 drops', 'Twice daily', 10, 'Warm the drops before use'),
(8, 8, '2024-03-08', 'Sertraline', '50 mg', 'Once daily', 60, 'May cause drowsiness'),
(9, 9, '2024-03-09', 'Lisinopril', '10 mg', 'Once daily', 30, 'Monitor blood pressure regularly'),
(10, 10, '2024-03-10', 'Prenatal vitamins', '1 tablet', 'Once daily', 90, 'Take with meals');

-- Insert data into LabTest table
INSERT INTO LabTest (PatientID, DoctorID, TestDate, TestName, TestResult, NormalRange, TestMethod, LabTechnician)
VALUES 
(1, 1, '2024-03-01', 'Blood Count', 'Normal', 'See lab report', 'Automated hematology analyzer', 'Jane Smith'),
(2, 2, '2024-03-02', 'Urinalysis', 'Abnormal', 'See lab report', 'Microscopic examination', 'John Doe'),
(3, 3, '2024-03-03', 'X-ray - Arm', 'Fracture detected', 'None', 'X-ray imaging', 'Emily Johnson'),
(4, 4, '2024-03-04', 'Skin Culture', 'Positive for bacteria', 'None', 'Culture and sensitivity testing', 'Michael Brown'),
(5, 5, '2024-03-05', 'MRI Brain', 'Normal', 'See radiologist report', 'MRI scanning', 'Sarah Martinez'),
(6, 6, '2024-03-06', 'Eye Pressure Measurement', 'Normal', '10 - 21 mmHg', 'Tonometry', 'Daniel Lee'),
(7, 7, '2024-03-07', 'Ear Microscopy', 'Impacted cerumen', 'None', 'Microscopic examination', 'Amanda Garcia'),
(8, 8, '2024-03-08', 'Psychological Assessment', 'Mild depression', 'None', 'Psychometric testing', 'James Taylor'),
(9, 9, '2024-03-09', 'Blood Pressure Measurement', 'Slightly elevated', 'Normal: < 120/80 mmHg', 'Sphygmomanometer', 'Jessica Clark'),
(10, 10, '2024-03-10', 'Ultrasound - Obstetrics', 'Normal', 'See radiologist report', 'Ultrasound imaging', 'David Wilson');

-- Insert data into ImagingStudy table
INSERT INTO ImagingStudy (PatientID, DoctorID, StudyDate, StudyType, Findings, Conclusion, Radiologist, ImageURLsReferences)
VALUES 
(1, 1, '2024-03-01', 'X-ray - Chest', 'Normal lung fields', 'No acute abnormalities detected', 'Jane Smith', 'N/A'),
(2, 2, '2024-03-02', 'CT Scan - Abdomen', 'Suspected renal calculus', 'Further evaluation recommended', 'John Doe', 'N/A'),
(3, 3, '2024-03-03', 'MRI - Spine', 'Lumbar disc herniation', 'Consider referral to neurosurgeon', 'Emily Johnson', 'N/A'),
(4, 4, '2024-03-04', 'Ultrasound - Skin Lesion', 'Benign cyst detected', 'No intervention necessary', 'Michael Brown', 'N/A'),
(5, 5, '2024-03-05', 'X-ray - Knee', 'Degenerative changes', 'Conservative management advised', 'Sarah Martinez', 'N/A'),
(6, 6, '2024-03-06', 'CT Scan - Head', 'Normal intracranial anatomy', 'No acute findings', 'Daniel Lee', 'N/A'),
(7, 7, '2024-03-07', 'MRI - Ear', 'Normal auditory structures', 'No significant abnormalities', 'Amanda Garcia', 'N/A'),
(8, 8, '2024-03-08', 'X-ray - Spine', 'Mild degenerative changes', 'Conservative treatment recommended', 'James Taylor', 'N/A'),
(9, 9, '2024-03-09', 'Ultrasound - Abdomen', 'Normal liver and spleen', 'No focal abnormalities detected', 'Jessica Clark', 'N/A'),
(10, 10, '2024-03-10', 'CT Scan - Pelvis', 'Normal pelvic structures', 'No acute findings', 'David Wilson', 'N/A');
