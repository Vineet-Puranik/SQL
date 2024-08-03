--1
SELECT sysdate, 
TRIM(' ' FROM REPLACE(TO_CHAR(SYSDATE, 'DAY, MONTH'), '  ', ' ')) || TRIM(' ' FROM REPLACE(TO_CHAR(SYSDATE, ', YEAR'), '  ', ' '))   AS DAY_MONTH_YEAR,
TO_CHAR(SYSDATE, 'MM/DD/YY - "hours:"hh') AS DATE_WITH_HOURS, 
ROUND(TO_DATE('31-DEC-2023', 'DD-MON-YYYY') - SYSDATE) AS DAYS_TIL_END_OF_YEAR,
TO_CHAR(SYSDATE, 'mon dy yyyy') AS lowercase,
'$' || TO_CHAR(55*8*5*52,'999,999') AS INTIAL_SALARY
FROM dual;

--2
SELECT e.employee_id, (e.first_name ||' '|| e.last_name || nvl2(e.employee_id, 'has processed a loan' , 'has not processed a loan')) AS "Employee Information",
('Loan Started: ' || TO_CHAR(l.origination_date, 'DD-Mon-YYYY')) AS "Loan Origination Date"
FROM employee e left join loans l 
ON e.employee_id = l.employee_id
ORDER BY e.employee_id, "Loan Origination Date";

--3
SELECT UPPER(last_name) || ', ' || SUBSTR(first_name,1,1) AS employee_name,
mailing_state, TO_CHAR(birthdate, 'DD-Mon-YYYY') AS "Date of Birth", phone_number
FROM employee
WHERE birthdate>='01-Jan-2000' AND mailing_state IN ('NY', 'MD')
ORDER BY "Date of Birth";
    
--4
SELECT UPPER(first_name) ||' '|| UPPER(last_name) AS  NAME, emp_level, 
CASE
WHEN(emp_level =1)
THEN 
TO_CHAR(38000, '$99,999') ||' to '|| TO_CHAR(50000, '$99,999')
WHEN(emp_level =2)
THEN
TO_CHAR(38000, '$99,999') ||' to '|| to_char(50000, '$99,999')
WHEN(emp_level =3)
THEN 
TO_CHAR(80001, '$99,999') ||' to '|| to_char(105000, '$999,999') END AS salary
FROM Employee
ORDER BY name asc, emp_level desc;

--5
SELECT m.first_name || ' ' || nvl2(m.middle_name, SUBSTR(m.middle_name,1,1) || '. ', '') || ''|| last_name AS Full_Name,
email_address, LENGTH(email_address) AS email_length, loan_number, 
ROUND(SYSDATE - origination_date) AS days_since_loan_originated
FROM members m join loans l 
ON m.member_id = l.member_id
WHERE ROUND(SYSDATE - origination_date)>500
ORDER BY days_since_loan_originated;
 
--6
SELECT employee_id, last_name, first_name, substr(phone_number, 1, instr(phone_number,'-')-1) AS phone_area_code,
SUBSTR(email, 1, INSTR(email, '@')-1) AS email_id
FROM employee
ORDER BY phone_area_code;

--7
SELECT DISTINCT m.first_name || ' ' || m.last_name AS Member_Name,
  CASE
    WHEN m.Member_ID IN (SELECT DISTINCT Member_ID FROM Loans) THEN
      SUBSTR(t.tax_id, 1, 3) || '-***-*****'
    ELSE
      t.tax_id
  END AS redacted_tax_id
FROM members m
JOIN member_tax_id t ON m.member_id = t.member_id
JOIN loans l ON t.member_id = l.member_id
WHERE l.origination_date > TO_DATE('2023-01-01', 'YYYY-MM-DD')
ORDER BY Member_Name;


--8
SELECT interest_rate, loan_type, loan_number,
  CASE 
    WHEN interest_rate > 5.5 THEN 'High Interest Rate'
    WHEN interest_rate BETWEEN 3.5 AND 5.5 THEN 'Medium Interest Rate'
    WHEN interest_rate < 3.5 THEN 'Low Interest Rate'
  END AS interest_type
FROM loans
ORDER BY interest_rate DESC;

--9
SELECT
    e.first_name,
    e.last_name,
    e.emp_level,
    SUM(l.original_amount) AS total_original_amount,
    DENSE_RANK() OVER (ORDER BY SUM(l.original_amount) DESC) AS total_amount_rank
FROM
    employee e
JOIN
    loans l
ON
    e.employee_id = l.employee_id
GROUP BY
    e.first_name, e.last_name, e.emp_level;

--10
--Part A
WITH ranked_employees AS (
    SELECT
        e.first_name,
        e.last_name,
        e.emp_level,
        SUM(l.original_amount) AS total_original_amount,
        DENSE_RANK() OVER (ORDER BY SUM(l.original_amount) DESC) AS total_amount_rank
    FROM
        employee e
    JOIN
        loans l ON e.employee_id = l.employee_id
    GROUP BY
        e.first_name, e.last_name, e.emp_level
)
SELECT *
FROM ranked_employees
WHERE ROWNUM <= 6
ORDER BY first_name;

--Part B
WITH ranked_employees AS (
    SELECT
        e.first_name,
        e.last_name,
        e.emp_level,
        SUM(l.original_amount) AS total_original_amount,
        DENSE_RANK() OVER (ORDER BY SUM(l.original_amount) DESC) AS total_amount_rank
    FROM
        employee e
    JOIN
        loans l ON e.employee_id = l.employee_id
    GROUP BY
        e.first_name, e.last_name, e.emp_level
)
SELECT *
FROM ranked_employees
WHERE total_amount_rank <=4
ORDER BY first_name;
