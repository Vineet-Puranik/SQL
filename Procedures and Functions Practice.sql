--1
SELECT*
from vendor_contacts
order by vendor_id;

CREATE OR REPLACE PROCEDURE insert_vendor_contacts_proc
(
    vendor_id_param   number,
    last_name_param  varchar,
    first_name_param  number default 0
    
)
AS
BEGIN
    insert into vendor_contacts
    values(vendor_id_param,last_name_param,first_name_param );
END;
/

BEGIN
insert_vendor_contacts_proc(
vendor_id_param =>47,last_name_param=> 200);
END;
/

CALL insert_vendor_contacts_proc(vendor_id_param = 47,last_name_param= 200,first_name_param  = 0);

--2
--Call 1
CALL insert_vendor_contacts_proc(1,'Thorton','Bob');
--Call 2
BEGIN
insert_vendor_contacts_proc(2,'Williams','Selma');
END;
/

--3
CALL insert_vendor_contacts_proc(1,'Bhai','Arsalan');

--4
CREATE OR REPLACE FUNCTION invoice_count
(
  vendor_id_param NUMBER
)
RETURN NUMBER
AS
  invoice_count_result NUMBER;
BEGIN
  SELECT COUNT(invoice_id)
  INTO invoice_count_result
  FROM invoices
  WHERE vendor_id = vendor_id_param;
  
  RETURN invoice_count_result;  
END;
/

--5
SELECT vendor_id, vendor_name, invoice_count(vendor_id)
FROM vendors
WHERE invoice_count(vendor_id) > 0;