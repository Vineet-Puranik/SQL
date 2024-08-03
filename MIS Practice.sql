--1
Select *
FROM Vendors;
--2
SELECT Vendor_ID, Vendor_name, Vendor_Address1, Vendor_Address2, Vendor_city, Vendor_State, Vendor_Zip_Code
FROM Vendors;
--3
SELECT Vendor_ID, Vendor_name, Vendor_Address1 || '; ' || Vendor_City || ', ' || Vendor_State || Vendor_Zip_Code
FROM VENDORS;
--4
SELECT Vendor_ID, Vendor_name, Vendor_Address1 || '; ' || Vendor_City || ', ' || Vendor_State || Vendor_Zip_Code AS Vendor_Address 
FROM VENDORS; 
--5
SELECT vendor_id, invoice_total, payment_total, invoice_total - payment_total 
FROM INVOICES;
--6
SELECT vendor_id, invoice_total, payment_total, invoice_total - payment_total AS Amount_Owed
FROM INVOICES;
--7
SELECT vendor_id, invoice_total, payment_total, invoice_total - payment_total AS Amount_Owed
FROM INVOICES
WHERE ROWNUM <=5;
--8
SELECT *
FROM dual;
--9
SELECT 'Hello, my name is Vineet'
FROM dual;
SELECT 18*36
FROM dual;
--10
SELECT SYSDATE
FROM dual;

SELECT MOD (3942,17)
FROM dual;

SELECT 
TO_CHAR(SYSDATE, 'MM/DD/YYYY')
FROM dual;

SELECT 
TO_CHAR(SYSDATE, 'DD/MM/YYYY')
FROM dual;

--11
SELECT invoice_id, invoice_number, invoice_total, invoice_date, ROUND(invoice_date - SYSDATE,0) AS "Days til Due"
FROM INVOICES

--12
SELECT ROUND(AVG(invoice_total),2)
FROM INVOICES;

--13
SELECT SUBSTR(Customer_First_Name, 1,1) || SUBSTR(Customer_Last_Name, 1,1)  AS Intials
FROM Customers_OM

--14
SELECT DISTINCT VENDOR_ID
FROM VENDORS;

--15
SELECT count(DISTINCT VENDOR_ID)
FROM INVOICES;
--16
