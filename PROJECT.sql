CREATE DATABASE HealthCampDB;
USE HealthCampDB;
USE HealthCampDB;
CREATE TABLE Health_Camp (
    camp_id INT PRIMARY KEY AUTO_INCREMENT,
    camp_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    camp_date DATE NOT NULL,
    organizer VARCHAR(100) NOT NULL
);
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(200) NOT NULL
);
CREATE TABLE Registration (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    camp_id INT NOT NULL,
    registration_date DATE NOT NULL,
    
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (camp_id) REFERENCES Health_Camp(camp_id)
);
CREATE TABLE Diagnosis (
    diagnosis_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    camp_id INT NOT NULL,
    disease_details VARCHAR(200) NOT NULL,
    medicines_prescribed VARCHAR(200) NOT NULL,
    diagnosis_date DATE NOT NULL,
    
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (camp_id) REFERENCES Health_Camp(camp_id)
);
INSERT INTO Health_Camp (camp_name, location, camp_date, organizer)
VALUES 
('General Health Camp', 'Solapur', '2026-03-10', 'City Hospital'),
('Eye Checkup Camp', 'Pune', '2026-03-15', 'Vision Foundation'),
('Dental Camp', 'Mumbai', '2026-03-20', 'Smile Care NGO');
INSERT INTO Doctor (doctor_name, specialization, phone)
VALUES
('Dr. Sharma', 'General Physician', '9876543210'),
('Dr. Mehta', 'Ophthalmologist', '9876543211'),
('Dr. Rao', 'Dentist', '9876543212');
INSERT INTO Patient (patient_name, age, gender, phone, address)
VALUES
('Ravi Kumar', 25, 'Male', '9000000001', 'Solapur'),
('Anita Patil', 30, 'Female', '9000000002', 'Pune'),
('Suresh Deshmukh', 40, 'Male', '9000000003', 'Mumbai');
INSERT INTO Registration (patient_id, camp_id, registration_date)
VALUES
(1, 1, '2026-03-10'),
(2, 2, '2026-03-15'),
(3, 3, '2026-03-20');
INSERT INTO Diagnosis (patient_id, doctor_id, camp_id, disease_details, medicines_prescribed, diagnosis_date)
VALUES
(1, 1, 1, 'Fever and Cold', 'Paracetamol', '2026-03-10'),
(2, 2, 2, 'Weak Eyesight', 'Eye Drops', '2026-03-15'),
(3, 3, 3, 'Tooth Infection', 'Painkillers', '2026-03-20');
SELECT * FROM Patient;
SELECT * FROM Patient
WHERE age > 30;
SELECT 
    p.patient_name,
    d.doctor_name,
    h.camp_name,
    dg.disease_details,
    dg.medicines_prescribed
FROM Diagnosis dg
JOIN Patient p ON dg.patient_id = p.patient_id
JOIN Doctor d ON dg.doctor_id = d.doctor_id
JOIN Health_Camp h ON dg.camp_id = h.camp_id;
SELECT h.camp_name, COUNT(r.patient_id) AS total_patients
FROM Health_Camp h
JOIN Registration r ON h.camp_id = r.camp_id
GROUP BY h.camp_name;
SELECT h.camp_name, COUNT(r.patient_id) AS total_patients
FROM Health_Camp h
JOIN Registration r ON h.camp_id = r.camp_id
GROUP BY h.camp_name
HAVING COUNT(r.patient_id) > 1;
SELECT patient_name, age
FROM Patient
WHERE age > (SELECT AVG(age) FROM Patient);
CREATE VIEW Diagnosis_Report AS
SELECT 
    p.patient_name,
    d.doctor_name,
    h.camp_name,
    dg.disease_details,
    dg.medicines_prescribed,
    dg.diagnosis_date
FROM Diagnosis dg
JOIN Patient p ON dg.patient_id = p.patient_id
JOIN Doctor d ON dg.doctor_id = d.doctor_id
JOIN Health_Camp h ON dg.camp_id = h.camp_id;
SELECT * FROM Diagnosis_Report;