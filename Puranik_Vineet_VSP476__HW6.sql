SET SERVEROUTPUT ON;


--1

BEGIN
  DECLARE
    count_loans NUMBER;
  BEGIN
    SELECT COUNT(*) INTO count_loans
    FROM loans
    WHERE member_id = 1018;
        IF count_loans > 1 THEN
      DBMS_OUTPUT.PUT_LINE('The member has taken out more than 1 loan.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('The member has taken only 1 loan.');
    END IF;
  END;/


DELETE FROM transcation_history
WHERE loan_number = 'SNB000100112';

DELETE FROM loans
WHERE loan_number = 'SNB000100112' AND member_id = 1018;

rollback;


--2
SET DEFINE ON;
DECLARE
  v_member_id loans.member_id%TYPE;;
  count_loans NUMBER;
BEGIN
  SELECT COUNT(*), v_member_id
  INTO count_loans, v_member_id
  FROM loans
  WHERE member_id = &member_id;
  GROUP BY member_id;

  IF count_loans > 1 THEN
    DBMS_OUTPUT.PUT_LINE('The member with ID:' || v_member_id || ' has taken out more than 1 loan.');
 ELSE
    DBMS_OUTPUT.PUT_LINE('The member with ID:' || v_member_id || ' has taken out only 1 loan.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An invalid member id was entered');
END;
/

--3


BEGIN
    INSERT INTO branch (branch_id, branch_name, street, city, branch_state, zip_code)
  VALUES (branch_id_sq.nextval, 'Yay', '4619 Autumn Orchard Ln', 'Katy', 'TX', '77494');
    DBMS_OUTPUT.PUT_LINE('1 row was inserted into the branch table.');
    
  EXCEPTION
  WHEN OTHER THEN
    DBMS_OUTPUT.PUT_LINE('Row was not inserted. Unexpected exception occurred.');
END;
/   

--4

DECLARE
  TYPE loan_status_list_type  IS TABLE OF VARCHAR(40);
  v_loan_status_list status_table;
BEGIN
  SELECT DISTINCT loan_status
  BULK COLLECT INTO v_loan_status_list
  FROM loans
  ORDER BY loan_status;

  FOR i IN 1..v_loan_status_list.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Loan Status ' || i || ' is: ' || v_loan_status_list(i));
  END LOOP;
END;
/

--5
DECLARE
  CURSOR loan_cursor IS
    SELECT loan_number, loan_status, COUNT(transaction_id) AS payment_count
    FROM loans l
    JOIN transaction_history t ON l.loan_number = t.loan_number
    GROUP BY l.loan_number, t.loan_status
    ORDER BY loan_status, loan_number;
    
loans_row  loans%ROWTYPE;
BEGIN
FOR
loans_row IN loan_cursor LOOP
DBMS_OUTPUT.PUT_LINE('Loan Number: '  ||  loans_row.loan_number || ' of status '   ||  
TRIM(loans_row.loan_status)  ||  ' has ' || loans_row.payment_count ||  'payments.');
END LOOP;
END;
/
--6
CREATE OR REPLACE PROCEDURE insert_branch(
  street_param          branch.street%TYPE
  branch_name_param     branch.branch_nam%TYPE
  branch_state_param    branch.branch_state%TYPE
  city_param            branch.city%TYPE
  zip_code_param        branch.zip_code%TYPE
) AS
branchs_id_vars          branch.branch_id%TYPE;
BEGIN
  SELECT branch_id_seq.NEXTVAL INTO branchs_id_vars FROM dual;

  INSERT INTO branch (branch_id, branch_name, street, city, branch_state, zip_code)
  VALUES (branchs_id_vars , branch_name_param, street_param, city_param, branch_state_param, zip_code_param);

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Row was not inserted. Unexpected exception occurred');
    ROLLBACK;
END;
/

--7
CREATE OR REPLACE FUNCTION loan_count(
    member_id_param loans.member_id%TYPE
    RETURN NUMBER
AS
    loan_count_vars NUMBER;
    BEGIN
    SELECT COUNT(*)
    INTO loan_count_vars
    FROM Loans
    WHERE member_id = member_id_param;
RETURN
loan_count_vars;
EXCEPTION
WHEN OTHER THEN
DMBS_OUTPUT.PUT_LINE('A wrong member id was entered');
END;
/



