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
  TYPE loan_status_list_type IS TABLE OF loans.loan_status%TYPE INDEX BY PLS_INTEGER;
  v_loan_status_list loan_status_list_type;
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
    SELECT loan_number, loan_status, COUNT(payment_id) AS payment_count
    FROM loans
    LEFT JOIN loan_payments ON loans.loan_number = loan_payments.loan_number
    WHERE loan_status = :user_loan_status  -- Prompt user for loan status
    GROUP BY loan_number, loan_status
    ORDER BY loan_status, loan_number;
BEGIN
  DBMS_OUTPUT.PUT('Enter loan status: ');
  DBMS_OUTPUT.GET_LINE(:user_loan_status, 20);

  -- Open the cursor
  OPEN loan_cursor;

  DBMS_OUTPUT.PUT_LINE('Loan Number | Loan Status | Payment Count');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------');
  FOR loan_rec IN loan_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(
      RPAD(loan_rec.loan_number, 12) || ' | ' ||
      RPAD(loan_rec.loan_status, 11) || ' | ' ||
      TO_CHAR(loan_rec.payment_count)
    );
  END LOOP;

  -- Close the cursor
  CLOSE loan_cursor;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/

--6
CREATE OR REPLACE PROCEDURE insert_branch(
  p_branch_id OUT NUMBER,
  p_branch_name IN VARCHAR2,
  p_branch_location IN VARCHAR2
) AS
BEGIN
  SELECT branch_id_seq.NEXTVAL INTO p_branch_id FROM dual;

  INSERT INTO branch (branch_id, branch_name, branch_location)
  VALUES (p_branch_id, p_branch_name, p_branch_location);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('1 row was inserted into the branch table.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Row was not inserted. Unexpected exception occurred');
END insert_branch;
/

--7
DECLARE
  v_count NUMBER;
BEGIN
  v_count := loan_count(1018); -- Replace with the desired member_id.
  DBMS_OUTPUT.PUT_LINE('Total number of loans: ' || v_count);
END;
/

