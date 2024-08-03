-- Drop tables if they exist (optional, use with caution)
DROP TABLE IF EXISTS member_committees;
DROP TABLE IF EXISTS members_info;
DROP TABLE IF EXISTS committees;

CREATE TABLE new_members_info 
(
    uteid       VARCHAR(20)     PRIMARY KEY,
    first_name  VARCHAR(30),
    last_name   VARCHAR(40),
    email       VARCHAR(40),
    phone       VARCHAR(12),
    grade       NUMBER(1),
    birthdate   DATE
);

ALTER TABLE new_members_info
ADD CONSTRAINT check_grade_positive CHECK (grade>0);

INSERT INTO new_members_info (uteid, first_name, last_name, email, phone, grade, birthdate)
VALUES ('example123', 'John', 'Doe', 'john@example.com', '555-1234', 0, TO_DATE('1990-01-01', 'YYYY-MM-DD'));

ALTER TABLE members_info
DROP CONSTRAINT check_grade_positive;

ALTER TABLE new_members_info
ADD CONSTRAINT check_grade_in_range CHECK (grade IN(1,2,3,4));

ALTER TABLE new_members_info
RENAME COLUMN phone TO phone_num;

ALTER TABLE new_members_info
ADD CONSTRAINT unique_email UNIQUE (email);

ALTER TABLE new_members_info
MODIFY uteid VARCHAR(10)

CREATE TABLE new_committees
(
    committee_id    NUMBER(5)   PRIMARY KEY,
    committee_name  VARCHAR(30),
    semester_year   VARCHAR(4)
);

CREATE TABLE new_member_committees
(
    uteid         VARCHAR(20),
    committee_id  NUMBER(5),
    PRIMARY KEY (uteid, committee_id),
    FOREIGN KEY (uteid) REFERENCES new_members_info(uteid),
    FOREIGN KEY (committee_id) REFERENCES new_committees(committee_id)
);

