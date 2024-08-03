--2
CREATE ROLE member_user;
CREATE ROLE admin_user;
CREATE ROLE Loan_Analyst;
CREATE ROLE Customer_Service_Rep;

--3
--member_user
GRANT SELECT, UPDATE ON Members TO member_user;
GRANT SELECT, UPDATE ON Member_Phone TO member_user;
GRANT SELECT ON Loans to member_user;
GRANT SELECT ON transaction_history TO member_user;
--loan_analyst
GRANT SELECT ON Members TO loan_analyst;
GRANT SELECT ON Member_Phone TO loan_analyst;
GRANT SELECT, INSERT, UPDATE ON Loans to loan_analyst;
GRANT SELECT, INSERT ON transaction_history TO loan_analyst;
GRANT SELECT, UPDATE ON employees TO loan_analyst;
--customer_service_rep
GRANT SELECT, INSERT, UPDATE ON Members TO customer_service_rep;
GRANT SELECT, INSERT, UPDATE, DELETE ON Member_Phone TO customer_service_rep;
GRANT SELECT ON Loans to  customer_service_rep;
GRANT SELECT, UPDATE ON employees TO  customer_service_rep;
--admin_user
GRANT SELECT,INSERT,UPDATE ON Members to admin_user;
GRANT SELECT,INSERT,UPDATE ON Member_Phone to admin_user;
GRANT SELECT,INSERT,UPDATE ON Loans to admin_user;
GRANT SELECT,INSERT,UPDATE ON Transcation_History to admin_user;
GRANT SELECT,INSERT,UPDATE ON Employees to admin_user;

--4
-- member_user
REVOKE SELECT, UPDATE ON Members FROM member_user;
REVOKE SELECT, UPDATE ON Member_Phone FROM member_user;
REVOKE SELECT ON Loans FROM member_user;
REVOKE SELECT ON transaction_history FROM member_user;

-- loan_analyst
REVOKE SELECT ON Members FROM loan_analyst;
REVOKE SELECT ON Member_Phone FROM loan_analyst;
REVOKE SELECT, INSERT, UPDATE ON Loans FROM loan_analyst;
REVOKE SELECT, INSERT ON transaction_history FROM loan_analyst;
REVOKE SELECT, UPDATE ON employees FROM loan_analyst;

-- customer_service_rep
REVOKE SELECT, INSERT, UPDATE ON Members FROM customer_service_rep;
REVOKE SELECT, INSERT, UPDATE, DELETE ON Member_Phone FROM customer_service_rep;
REVOKE SELECT ON Loans FROM customer_service_rep;
REVOKE SELECT, UPDATE ON employees FROM customer_service_rep;

-- admin_user
REVOKE SELECT, INSERT, UPDATE ON Members FROM admin_user;
REVOKE SELECT, INSERT, UPDATE ON Member_Phone FROM admin_user;
REVOKE SELECT, INSERT, UPDATE ON Loans FROM admin_user;
REVOKE SELECT, INSERT, UPDATE ON Transcation_History FROM admin_user;
REVOKE SELECT, INSERT, UPDATE ON Employees FROM admin_user;

--5
CREATE USER vani;
CREATE USER satish;
CREATE USER vineet;
CREATE USER siddhant;

GRANT member_user TO vani;
GRANT loan_analyst TO satish;
GRANT customer_service_rep TO vineet;
GRANT admin_user TO siddhant;

