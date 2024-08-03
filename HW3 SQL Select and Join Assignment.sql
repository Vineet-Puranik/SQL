--1
SELECT employee_id, first_name, last_name, phone_number
FROM employee
ORDER BY last_name;

--2
SELECT first_name || ' ' || SUBSTR(middle_name,1,1) || '. ' || last_name AS member_full
FROM members
WHERE (last_name LIKE 'A%' or last_name LIKE 'B%' or last_name LIKE 'C%') and middle_name is NOT NULL
ORDER BY first_name, SUBSTR(last_name,1,1);

SELECT first_name || ' ' || SUBSTR(middle_name,1,1) || '. ' || last_name AS member_full
FROM members
WHERE SUBSTR(last_name,1,1) IN ('A','B','C') and middle_name is NOT NULL
ORDER BY first_name, SUBSTR(last_name,1,1);

--3
SELECT loan_type, member_id, original_amount, origination_date
FROM loans
WHERE original_amount >30000 and original_amount<=40000
ORDER BY loan_type, original_amount desc;

--4 

--Part A
SELECT loan_type, member_id, original_amount, origination_date
FROM loans
WHERE original_amount BETWEEN 30001 and 40000
ORDER BY loan_type, original_amount desc;

--Part B
SELECT loan_type, member_id, original_amount, origination_date
FROM loans
WHERE original_amount >30000 and original_amount<=40000
MINUS
SELECT loan_type, member_id, original_amount, origination_date
FROM loans
WHERE original_amount BETWEEN 30001 and 40000;

--5
SELECT loan_type, origination_date, original_amount, number_of_payments,payment_amount, 
    number_of_payments * payment_amount AS total_payment, 
    number_of_payments * payment_amount-original_amount AS total_interest
FROM Loans
WHERE rownum<=4
ORDER BY total_payment desc;

--6
SELECT loan_number,transaction_date,amount,updated_balance, 
    ROUND(updated_balance/amount,2) AS average_number_payment_to_date
FROM transaction_history
WHERE ROUND(updated_balance/amount,2)>250
ORDER BY average_number_payment_to_date;

--7
SELECT loan_number, member_id, origination_date, loan_notes
FROM loans
WHERE loan_notes is NOT NULL
ORDER BY 1;

--8 -- 
SELECT Sysdate AS today_unformatted, 
    To_CHAR(Sysdate, 'MM/DD/YYYY') AS today_formatted,
    250000 AS loan,
    .075 AS mortgage_rate,
    250000*.075 AS annual_interest_amount, 
    250000*.075 * 15 AS total_interest_15_years
FROM Dual;

--9
SELECT loan_type, loan_number, original_amount, origination_date
FROM loans
WHERE loan_type != 'MO'
ORDER BY original_amount desc
FETCH FIRST 5 ROWS ONLY;

--10
SELECT branch_state, branch_name, first_name, last_name, emp_level
FROM employee e inner join branch b
ON e.branch_id = b.branch_id
ORDER BY branch_state, branch_name, emp_level desc;

--11
SELECT first_name || ' ' || last_name AS "Member Name", member_address_link.address_status,address_line_1, address_line_2, city, member_state, zip_code,email_address
FROM Members inner join member_address_link 
ON members.member_id = member_address_link.member_id
join member_address
ON member_address.address_id = member_address_link.address_id
WHERE email_address = 'aheapez@naver.com';

--12
SELECT first_name, last_name, phone_number, phone_type
FROM member_phone p inner join members m
ON p.member_id = m.member_id
WHERE m.member_id IN (1001, 1002) 
AND p.phone_type = 'P';

--13
SELECT m.first_name,m.last_name,b.branch_id,e.first_name, e.last_name, l.loan_number, original_amount, origination_date, updated_balance
FROM employee e inner join branch b
ON e.branch_id = b.branch_id
JOIN loans l
ON e.employee_id = l.employee_id
JOIN members m 
ON m.member_id = l.member_id
JOIN transaction_history t
ON t.loan_number = l.loan_number
ORDER BY b.branch_ID, l.loan_number, updated_balance desc;

--14
SELECT m.member_ID, phone_ID
FROM members m left outer join Member_Phone p
ON m.member_id = p.member_id
WHERE phone_ID IS NULL;

--15
SELECT 'High Interest Rate' AS interest_type, interest_rate, loan_type, loan_number
FROM loans
WHERE interest_rate>5.5
UNION
SELECT 'Medium Interest Rate' AS interest_type, interest_rate, loan_type, loan_number
FROM loans
WHERE interest_rate BETWEEN 3.5 and 5.5
UNION
SELECT 'Low Interest Rate' AS interest_type, interest_rate, loan_type, loan_number
FROM loans
WHERE interest_rate < 3.5
ORDER BY interest_rate desc;



 


