--1
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
ORDER BY Vendor_State 

--2
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
ORDER BY Vendor_State desc
--3
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
ORDER BY Vendor_State, Vendor_City, Vendor_Name
--4
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
ORDER BY 5,3,2
--5
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code AS Zip
FROM Vendors
ORDER BY Zip
--26
SELECT *
FROM invoices
WHERE ROWNUM <=5
ORDER BY invoice_id DESC;

SELECT *
FROM invoices
ORDER BY invoice_id DESC
FETCH FIRST 5 ROWS ONLY;

SELECT *
FROM invoices
ORDER BY invoice_id DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

--7
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
WHERE VENDOR_State = 'NY' or Vendor_State = 'NJ'

--8
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
WHERE VENDOR_State IN ('NY','NJ')

--9
SELECT VENDOR_ID,VENDOR_Name,VENDOR_Address1,VENDOR_State,VENDOR_ZIP_Code
FROM Vendors
WHERE VENDOR_State NOT IN ('NY','NJ')

--10
SELECT *
FROM invoices
WHERE ROWNUM <=7
ORDER BY invoice_total DESC;
--11
SELECT Invoice_id, Invoice_total-payment_total - credit_total AS "Balance Due"
FROM invoices
WHERE Invoice_total-payment_total - credit_total=0;
--12
SELECT Customer_First_Name,Customer_Last_Name
FROM Customers_OM
WHERE Customer_First_name || ' ' || Customer_Last_Name = 'Korah Blanca';
--13
SELECT Customer_Last_Name
FROM Customers_OM
WHERE SUBSTR(Customer_Last_Name, 1,3)='Dam';
--Like
--14
SELECT Invoice_Date
FROM Invoices
WHERE Invoice_Date