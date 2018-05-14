
CREATE TABLE admin
( ID serial NOT NULL,
username varchar NOT NULL,
password varchar NOT NULL,
name varchar NOT NULL,
surname varchar NOT NULL,
PRIMARY KEY(username) 
);

DROP TABLE IF EXISTS drugs;
CREATE TABLE drugs
(
ID serial NOT NULL,
name varchar NOT NULL,
description varchar NOT NULL,
PRIMARY KEY (ID),
UNIQUE(ID)
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
ID serial NOT NULL,
name varchar NOT NULL,
PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS patient;
CREATE TABLE patient
(
patientAMKA bigint NOT NULL,
userid varchar NOT NULL,
password varchar NOT NULL,
name varchar NOT NULL,
surname varchar NOT NULL,
gender varchar NOT NULL,
PRIMARY KEY (patientAMKA)
);


DROP TABLE IF EXISTS medical_folder;
CREATE TABLE medical_folder(
ID serial NOT NULL,
patient bigint NOT NULL,
cure varchar NOT NULL,
drug_id serial NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (drug_id) references drugs(ID),
FOREIGN KEY (patient) references patient(patientAMKA)
);


CREATE TABLE doctor(
doctorAMKA bigint NOT NULL,
username varchar NOT NULL,
password varchar NOT NULL,
name varchar NOT NULL,
surname varchar NOT NULL,
specialty serial NOT NULL,
PRIMARY KEY (doctorAMKA),
FOREIGN KEY (specialty) references departments(ID),
UNIQUE (doctorAMKA)
);


CREATE TABLE appointments(
ID serial NOT NULL,
t timestamp NOT NULL,
patientAMKA bigint NOT NULL,
doctorAMKA bigint NOT NULL,
diagnosis varchar,
PRIMARY KEY (ID),
FOREIGN KEY (patientAMKA) references patient(patientAMKA),
FOREIGN KEY (doctorAMKA) references doctor(doctorAMKA)
);

DROP TABLE IF EXISTS pending_pat;
CREATE TABLE pending_pat
(
patientAMKA bigint NOT NULL,
userid varchar NOT NULL,
password varchar NOT NULL,
name varchar NOT NULL,
surname varchar NOT NULL,
gender varchar NOT NULL,
PRIMARY KEY (patientAMKA)
);

DROP TABLE IF EXISTS pending;
CREATE TABLE pending
(
doctorAMKA bigint NOT NULL,
username varchar NOT NULL,
password varchar NOT NULL,
name varchar NOT NULL,
surname varchar NOT NULL,
specialty integer NOT NULL,
PRIMARY KEY (doctorAMKA)
);



select * from patient;
select * from doctor;
select * from appointments;
select * from departments;
select * from drugs;
select * from medical_folder;
select * from admin;
select * from pending;