--1
SELECT sysdate, 
TRIM(' ' FROM REPLACE(TO_CHAR(SYSDATE, 'DAY, MONTH'), '  ', ' ')) || TRIM(' ' FROM REPLACE(TO_CHAR(SYSDATE, ', YEAR'), '  ', ' '))   AS DAY_MONTH_YEAR,
TO_CHAR(SYSDATE, 'MM/DD/YY - "hours:"hh') AS DATE_WITH_HOURS, 
ROUND(TO_DATE('31-DEC-2023', 'DD-MON-YYYY') - SYSDATE) AS DAYS_TIL_END_OF_YEAR,
TO_CHAR(SYSDATE, 'mon dy yyyy') AS lowercase,
'$' || TO_CHAR(55*8*5*52,'999,999') AS INTIAL_SALARY
FROM dual;

--2
SELECT e.employee_id, e.first_name ||' '|| e.last_name || nvl2(9001, 'has processed a loan', 'has not processed a loan') AS Employee_Information,
'Loan Started: ' || TO_CHAR(l.origination_date, 'Mon-DD-YYYY') AS Loan_Origination_Date
FROM employees e join loans l 
ON e.employee_id = l.employee_id
ORDER BY e.employee_id, Loan_Origination_Date;



 The Employee_ID column
 The “Employee Information” column which uses concatenation of explicit values: the first_name, space,
last_name, nvl2 function with appropriate argument values (see sample output) based on the employee_id to
create a result as shown below.
 The “Loan Origination Date” column which uses concatenation of ‘Loan started:’ and origination_date field
formatted to create a result as shown below.
Sort the final output by employee_id and “Loan Origination Date” (please use the column alias)
