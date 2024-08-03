--1
--Query A
SELECT SUM(invoice_total - payment_total - credit_total) balance_due
FROM invoices
WHERE vendor_id = 95;
--Query B
--CONNECT ap/ap; --don't need to connect since we are already connected to our database
--SET SERVEROUTPUT ON;
DECLARE
sum_balance_due_var NUMBER(9, 2);
BEGIN
SELECT SUM(invoice_total - payment_total - credit_total) balance_due
INTO sum_balance_due_var
FROM invoices
WHERE vendor_id = 95;
IF sum_balance_due_var > 0 THEN
DBMS_OUTPUT.PUT_LINE('Balance due: $' ||
ROUND(sum_balance_due_var, 2));
ELSE
DBMS_OUTPUT.PUT_LINE('Balance paid in full');
END IF;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/
--2
SET SERVEROUTPUT ON;
begin
dbms_output.put_line('Hello my name is Vineet');
end;
/
--3a
DECLARE
max_invoice_total invoices.invoice_total%TYPE;
min_invoice_total invoices.invoice_total%TYPE;
percent_difference NUMBER;
count_invoice_id NUMBER;
vendor_id_var NUMBER := 95;
BEGIN
SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
INTO max_invoice_total, min_invoice_total, count_invoice_id
FROM invoices WHERE vendor_id = vendor_id_var;
percent_difference :=
(max_invoice_total - min_invoice_total) / min_invoice_total * 100;
DBMS_OUTPUT.PUT_LINE('Maximum invoice: $' || max_invoice_total);
DBMS_OUTPUT.PUT_LINE('Minimum invoice: $' || min_invoice_total);
DBMS_OUTPUT.PUT_LINE('Percent difference: %' || ROUND(percent_difference, 2));
DBMS_OUTPUT.PUT_LINE('Number of invoices: ' || count_invoice_id);
END;
/
--3b
DECLARE
max_invoice_total invoices.invoice_total%TYPE;
min_invoice_total invoices.invoice_total%TYPE;
percent_difference NUMBER;
count_invoice_id NUMBER;
MyAge NUMBER;
vendor_id_var NUMBER := 95;
BEGIN
SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
INTO max_invoice_total, min_invoice_total, count_invoice_id
FROM invoices WHERE vendor_id = vendor_id_var;
percent_difference :=
(max_invoice_total - min_invoice_total) / min_invoice_total * 100;
DBMS_OUTPUT.PUT_LINE('I am ' || max_invoice_total || ' years old.');
DBMS_OUTPUT.PUT_LINE('Maximum invoice: $' || max_invoice_total);
DBMS_OUTPUT.PUT_LINE('Minimum invoice: $' || min_invoice_total);
DBMS_OUTPUT.PUT_LINE('Percent difference: %' || ROUND(percent_difference, 2));
DBMS_OUTPUT.PUT_LINE('Number of invoices: ' || count_invoice_id);
END;
/
--4
set define on;
DECLARE
max_invoice_total invoices.invoice_total%TYPE;
min_invoice_total invoices.invoice_total%TYPE;
percent_difference NUMBER;
count_invoice_id NUMBER;
MyAge NUMBER := &user_defined_age;
vendor_id_var NUMBER := 95;
BEGIN
SELECT MAX(invoice_total), MIN(invoice_total), COUNT(invoice_id)
INTO max_invoice_total, min_invoice_total, count_invoice_id
FROM invoices WHERE vendor_id = vendor_id_var;
percent_difference :=
(max_invoice_total - min_invoice_total) / min_invoice_total * 100;
DBMS_OUTPUT.PUT_LINE('I am ' || max_invoice_total || ' years old.');
DBMS_OUTPUT.PUT_LINE('Maximum invoice: $' || max_invoice_total);
DBMS_OUTPUT.PUT_LINE('Minimum invoice: $' || min_invoice_total);
DBMS_OUTPUT.PUT_LINE('Percent difference: %' || ROUND(percent_difference, 2));
DBMS_OUTPUT.PUT_LINE('Number of invoices: ' || count_invoice_id);
END;
/
--5



