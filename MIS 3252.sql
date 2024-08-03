--Homework 1 DDL Script Assignment | Vineet Puranik - vsp476

--Drop section where all tables and sequences are dropped

DROP TABLE Member_phone;
DROP TABLE Member_Tax_ID;
DROP TABLE Member_Address_Link;
DROP TABLE Transaction_History;
DROP TABLE Loans;
DROP TABLE Members;
DROP TABLE Member_Address;
DROP TABLE Employees;
DROP TABLE Branch;




DROP SEQUENCE Member_ID_seq;
DROP SEQUENCE Transaction_ID_seq;
DROP SEQUENCE Employee_ID_seq;


CREATE SEQUENCE Member_ID_seq;
CREATE SEQUENCE Transaction_ID_seq;
CREATE SEQUENCE Employee_ID_seq
START WITH 90000;
--Section where all tables are created and adds constraints either via CREATE or ALTER TABLE statements
CREATE TABLE Members
(
    Member_ID   NUMBER  DEFAULT Member_ID_seq.NEXTVAL    Primary Key,
    First_Name  VARCHAR (30) NOT NULL,
    Middle_Name VARCHAR(30)  NULL,
    Last_Name   VARCHAR(30)  NOT NULL,
    Email       VARCHAR(50)  UNIQUE     NOT NULL,
    CONSTRAINT email_length_check CHECK (Email>=7)
);

CREATE TABLE Member_Phone
(
    Phone_ID     NUMBER  PRIMARY KEY,
    Member_ID    NUMBER NOT NULL,
    Phone_Number CHAR(12) NOT NULL,
    Phone_Type   VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Member_Member_Phone FOREIGN KEY (Member_ID) REFERENCES Members (Member_ID)
);

CREATE TABLE Member_Tax_ID
(
    Member_ID NUMBER   Primary Key,
    Tax_ID    CHAR(9)  UNIQUE        NOT NULL,
    CONSTRAINT FK_Member_Tax_ID_Member_ID FOREIGN KEY (Member_ID) REFERENCES Members (Member_ID)
);

CREATE TABLE Member_Address
(
    Address_ID   NUMBER  Primary Key,
    Address_1    VARCHAR(40) NOT NULL,
    Address_2    VARCHAR(40) NULL,
    City         VARCHAR(30) NOT NULL,
    Member_State CHAR(2) NOT NULL,
    Zip_Code     CHAR(5) NOT NULL
);

CREATE TABLE Member_Address_Link
(
    Member_ID      NUMBER  REFERENCES Members(Member_ID),
    Address_ID     NUMBER  REFERENCES Member_Address(Address_ID),
    Address_Status CHAR(1) NOT NULL,
    CONSTRAINT FK_Member_AddressLink_ PRIMARY KEY (Member_ID, Address_ID)

);

CREATE TABLE Branch
(
    Branch_ID    NUMBER  Primary Key,
    Branch_Name  VARCHAR(40) UNIQUE     NOT NULL,
    Address      VARCHAR(40) NOT NULL,
    City         VARCHAR(30) NOT NULL,
    Branch_State CHAR(2) NOT NULL,
    Zip_Code     CHAR(5) NOT NULL
);

CREATE TABLE Employees
(
    Employee_ID      NUMBER      DEFAULT Employee_ID_seq.NEXTVAL   Primary Key,
    Branch_ID       NUMBER      NOT NULL,
    First_Name      VARCHAR (30)NOT NULL,
    Last_Name       VARCHAR(30) NOT NULL,
    Tax_ID_Number   NUMBER      NOT NULL,
    Birthday        VARCHAR(20) NOT NULL,
    Mailing_Address VARCHAR(40) NOT NULL,
    Mailing_City    VARCHAR(40) NOT NULL,
    Mailing_State   CHAR(2)     NOT NULL,
    Mailing_Zip     CHAR(5)     NOT NULL,
    Phone_Number    CHAR(12)    NOT NULL,
    Email           VARCHAR(60) NOT NULL,
    Emp_Level       CHAR(1)     NOT NULL CHECK (Emp_Level IN (1, 2, 3, 4, 5)),
    CONSTRAINT FK_Employees_Branch_ID FOREIGN KEY (Branch_ID) REFERENCES Branch (Branch_ID)
);

CREATE TABLE Loans
(
    Loan_Number        CHAR(12)      Primary Key,
    Member_ID          NUMBER        NOT NULL,
    Loan_Type          CHAR (2)      NOT NULL,
    Original_Amount    NUMBER        NOT NULL,
    Origination_Date   DATE          NOT NULL,
    Num_Of_Payments    NUMBER        NOT NULL,
    Interest_Rate      NUMBER(5,3)   NOT NULL,
    Payment_Amount     NUMBER        NOT NULL,
    Maturity_Date      DATE          NOT NULL,
    Loan_Notes         VARCHAR(250)  NULL,
    Employee_ID        NUMBER        NOT NULL,
    Loan_Status        CHAR(1)       NOT NULL,
    CONSTRAINT CHK_Loan_Status CHECK (Loan_Status IN ('A', 'R', 'P', 'D', 'C')),
    CONSTRAINT FK_Loan_Employee_ID   FOREIGN KEY (Employee_ID) REFERENCES Employees (Employee_ID),
    CONSTRAINT FK_Loans_Member_ID    FOREIGN KEY (Member_ID)   REFERENCES Members (Member_ID)
);

CREATE TABLE Transaction_History
(
    Transaction_ID              NUMBER            DEFAULT Transaction_ID_seq.NEXTVAL   Primary Key,
    Loan_Number                 CHAR(12)          NOT NULL,
    Transaction_Date            VARCHAR(30)       DEFAULT SYSDATE NOT NULL,
    Amount                      NUMBER            NOT NULL,
    Transaction_Description     VARCHAR(100)      NOT NULL, 
    Updated_Balance             NUMBER            NOT NULL CHECK (Updated_Balance>=0),
    CONSTRAINT FK_Transaction_History_Loan_Number FOREIGN KEY (Loan_Number) REFERENCES Loans (Loan_Number)
);

--Insert Data Section where we test the tables that we have created and the constraint to ensure they work
INSERT INTO members
VALUES (1,'Vineet','Satish','Puranik','vsp476@utexas.edu');
INSERT INTO members
VALUES (2,'Rishi','Naidu','Karanam','rishikaranam@utexas.edu');
Commit;
INSERT INTO Member_Tax_ID
VALUES(1,'VIN152004');
INSERT INTO Member_Tax_ID
VALUES(2,'RNK272004');
Commit;
INSERT INTO Member_Address
VALUES(1,'4619 Autumn Orchard Ln',NULL, 'Katy','TX','77494');
INSERT INTO Member_Address
VALUES(2,'2205 Shady Valley Road',NULL, 'Austin','TX','78705');
INSERT INTO Member_Address
VALUES(3,'3057 Oak Tree Bend',NULL, 'Kyle','TX','76578');
Commit;
INSERT INTO Member_Address_Link
VALUES(1,1,'P');
INSERT INTO Member_Address_Link
VALUES(2,2,'P');
INSERT INTO Member_Address_Link
VALUES(1,3,'I');
INSERT INTO Member_Address_Link
VALUES(2,3,'I');
Commit;
INSERT INTO Member_Phone
VALUES(1,1,'832-774-7395','home');
INSERT INTO Member_Phone
VALUES(2,1,'713-367-2028','cell');
INSERT INTO Member_Phone
VALUES(3,2,'832-506-6971','home');
INSERT INTO Member_Phone
VALUES(4,2,'832-566-6565','cell');
Commit;
INSERT INTO Loans
VALUES(1,1,'AB',10,'09/28/2023',3,20.111,50,'09/29/2023',100,1,'A');
INSERT INTO Loans
VALUES(2,1,'AB',10,'09/29/2023',3,20.111,60,'09/30/2023',100,1,'C');
INSERT INTO Loans
VALUES(3,2,'AB',10,'09/30/2023',3,20.111,70,'09/31/2023',100,1,'D');
INSERT INTO Loans
VALUES(4,2,'AB',10,'09/25/2023',3,20.111,80,'09/26/2023',100,1,'R');
Commit;
INSERT INTO Transaction_History
VALUES(1,'SCT00010019', '09/28/2023',50,'Paid 50 Dollars',0);
INSERT INTO Transaction_History
VALUES(2,'ABC00010019', '09/29/2023',60,'Paid 60 Dollars',0);
Commit;
INSERT INTO Employees
VALUES (90001, 1, 'John', 'Doe', 123456789, '01/15/1980', '123 Main St', 'Springfield', 'IL', '62701', '555-123-4567', 'john.doe@email.com', '3');
INSERT INTO Employees
VALUES (90002, 2, 'Jane', 'Smith', 987654321, '02/20/1985', '456 Elm St', 'Lexington', 'KY', '40502', '555-987-6543', 'jane.smith@email.com', '2');
INSERT INTO Employees
VALUES (90003, 1, 'Robert', 'Johnson', 555555555, '03/10/1975', '789 Oak St', 'Springfield', 'IL', '62701', '555-555-5555', 'robert.johnson@email.com', '4');
INSERT INTO Employees
VALUES (90004, 2, 'Lisa', 'Wilson', 111111111, '04/05/1990', '101 Pine St', 'Lexington', 'KY', '40502', '555-111-1111', 'lisa.wilson@email.com', '5');
Commit;
INSERT INTO Branch 
VALUES (1, 'Main Branch', '123 Main St', 'Springfield', 'IL', '62701');
INSERT INTO Branch
VALUES (2, 'Lexington Branch', '456 Elm St', 'Lexington', 'KY', '40502');
Commit;
--Section where all Indexes for Foreign Keys and 3 other fields are created
CREATE INDEX idx_Phone_Member_ID ON Member_Phone(Member_ID);
CREATE INDEX idx_Member_Address_Link_Member_ID ON Member_Address_Link(Member_ID);
CREATE INDEX idx_Member_Address_Link_Address_ID ON Member_Address_Link(Address_ID);
CREATE INDEX idx_Employees_Branch_ID ON Employees(Branch_ID);
CREATE INDEX idx_Employees_Emp_Level ON Loans(Member_ID);

CREATE INDEX idx_Member_Phone_Phone_Number ON Member_Phone(Phone_Number);
CREATE INDEX idx_Employees_FirstName ON Employees(First_Name);
CREATE INDEX idx_Employees_LastName ON Employees(Last_Name);









