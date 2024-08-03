--DROP TABLE customers_dw;

----------------------------------------------------------------
--create DW table
create table customers_dw
(  data_source           VARCHAR(5),
   customer_id           number,
   customer_first_name   varchar(50),
   customer_last_name    varchar(50),
   customer_address      varchar(50), 
   customer_city         varchar(50), 
   customer_state        varchar(2), 
   customer_zip_code     varchar(10), 
   customer_phone        varchar(12),
   constraint   pk_id_source   primary key (data_source,customer_id)
);
 



--Create EX view
Create or replace view customers_ex_view
as
select 'EX' as data_source, customer_id, customer_firstname as customer_first_name, 
customer_lastname as customer_last_name, customer_address , customer_city , customer_state , customer_zipcode, 
substr(customer_phonenum,2,3) || '-'|| substr(customer_phonenum,7,3) || substr(customer_phonenum,10,5)as customer_phone
from customers_ex;


--Create MGS view
Create or replace view customers_mgs_view
as
select 'MGS' as data_source, mgs.customer_id, mgs.first_name as customer_first_name, mgs.last_name as customer_last_name,
nvl2(a.line2, a.line1 || ', ' || a.line2 ,a.line1) as customer_address, a.city as customer_city, a.state as customer_state,
a.zip_code as customer_zip, a.phone as customer_phone
from customers_mgs mgs inner join addresses a on mgs.shipping_address_id = a.address_id ;

 
--Create OM view
Create or replace view customers_om_view
as
select 'OM' as data_source, customer_id, customer_first_name, 
customer_last_name, customer_address , customer_city , customer_state , customer_zip, 
substr(customer_phone,1,3) || '-' || substr(customer_phone,4,3) || '-' || substr(customer_phone,7,4) as customer_phone
from customers_om; 



--Code to create stored proc.  runs with no inputs
create or replace PROCEDURE customer_etl_proc 
AS
BEGIN

    --Insert new EX records
    insert into customers_dw
    select exv.data_source, exv.customer_id,  exv.customer_first_name as first_name, exv.customer_last_name as last_name, exv.customer_address as address, 
        exv.customer_city as city, exv.customer_state as state, exv.customer_zipcode as zip_code, 
        exv.customer_phone as phone
    from customers_ex_view exv left join customers_dw dw
        on exv.customer_id = dw.customer_id
        and exv.data_source = dw.data_source
    where dw.customer_id is null;

    --Insert new MGS records
    insert into customers_dw
    select mgs.data_source, mgs.customer_id, mgs.customer_first_name as first_name, 
        mgs.customer_last_name as last_name, mgs.customer_address as address, 
        mgs.customer_city as city, mgs.customer_state as state, mgs.customer_zip as zip_code, 
        mgs.customer_phone as phone
    from customers_mgs_view mgs left join customers_dw dw
        on mgs.customer_id = dw.customer_id
        and mgs.data_source = dw.data_source
    where dw.customer_id is null;


    --Insert new OM records
    insert into customers_dw
    select om.data_source, om.customer_id, om.customer_first_name as first_name, 
        om.customer_last_name as last_name, om.customer_address as address, 
        om.customer_city as city, om.customer_state as state, om.customer_zip as zip_code, 
        om.customer_phone as phone
    from customers_om_view om left join customers_dw dw
        on om.customer_id = dw.customer_id
        and om.data_source = dw.data_source
    where dw.customer_id is null;


    --update EX records
    MERGE INTO customers_dw dw
        USING customers_ex_view ex
        ON (dw.customer_id = ex.customer_id and dw.data_source = 'EX')
      WHEN MATCHED THEN
        UPDATE SET  dw.customer_first_name = ex.customer_first_name, 
                    dw.customer_last_name = ex.customer_last_name,
                    dw.customer_address = ex.customer_address,
                    dw.customer_city = ex.customer_city,
                    dw.customer_state = ex.customer_state,
                    dw.customer_zip_code = ex.customer_zipcode,
                    dw.customer_phone = ex.customer_phone ;
                
    --update MGS records
    MERGE INTO customers_dw dw
        USING customers_mgs_view mgs
        ON (dw.customer_id = mgs.customer_id and dw.data_source = 'MGS')
      WHEN MATCHED THEN
        UPDATE SET  dw.customer_first_name = mgs.customer_first_name, 
                    dw.customer_last_name = mgs.customer_last_name,
                    dw.customer_address = mgs.customer_address,
                    dw.customer_city = mgs.customer_city,
                    dw.customer_state = mgs.customer_state,
                    dw.customer_zip_code = mgs.customer_zip,
                    dw.customer_phone = mgs.customer_phone ; 
 
    --update OM records
    MERGE INTO customers_dw dw
        USING customers_om_view om
        ON (dw.customer_id = om.customer_id and dw.data_source = 'OM')
      WHEN MATCHED THEN
        UPDATE SET  dw.customer_first_name = om.customer_first_name, 
                    dw.customer_last_name = om.customer_last_name,
                    dw.customer_address = om.customer_address,
                    dw.customer_city = om.customer_city,
                    dw.customer_state = om.customer_state,
                    dw.customer_zip_code = om.customer_zip,
                    dw.customer_phone = om.customer_phone ;

END;
/



-- Look at tables
select * from customers_ex;
select * from customers_mgs inner join addresses on customers_mgs.customer_id = addresses.customer_id;
select * from customers_om;

select * from customers_ex_view;
select * from customers_mgs_view;
select * from customers_om_view;

----Checks to see what's in data warehoues table
select * from customers_dw;

----Code to call ETL procedure
call customer_etl_proc();

----Checks to see what's in data warehouse table
select * 
from customers_dw
where customer_id in (1,99);



----Run these to update some records and insert new records
INSERT INTO CUSTOMERS_OM VALUES (99, 'New', 'OM_Customer', '1826 OM Street', 'Tyler', 'TX', '75703', '9035613009', 'NULL');
Insert into customers_ex values (99, 'Another New', 'EX_Customer', '1600 EX Ave', 'Washington', 'DC', '93823', '(987) 139-9283');
INSERT INTO CUSTOMERS_mgs VALUES (99, 'MGS@mac.com', 'lk2j34s9fsdfbc4638a2b4f3f68bf23', 'New', 'MGS_Customer', 13, 13);
INSERT INTO addresses VALUES (13, 99, '1800 MGS Ave', 'Suite B', 'Boston', 'MA', '38729', '586-231-3468', 0);
commit;

UPDATE CUSTOMERS_EX 
SET CUSTOMER_LASTNAME = 'EX_Last', CUSTOMER_FIRSTNAME = 'EX-first', CUSTOMER_ADDRESS = 'EX-address', 
CUSTOMER_CITY = 'EX-city', CUSTOMER_STATE = 'EX', CUSTOMER_ZIPCODE = '12345', CUSTOMER_PHONENUM = '(111) 111-1111' 
WHERE Customer_id = 1; 

UPDATE CUSTOMERS_OM 
SET CUSTOMER_FIRST_NAME = 'OM_first', CUSTOMER_LAST_NAME = 'om_last', CUSTOMER_ADDRESS = 'om_address1', 
CUSTOMER_CITY = 'om_city', CUSTOMER_STATE = 'OM', CUSTOMER_ZIP = '23456', CUSTOMER_PHONE = '2222222222', CUSTOMER_FAX = '9999999999' 
WHERE customer_id = 1; 
    
UPDATE ADDRESSES 
SET LINE1 = 'mgs_line_1', LINE2 = 'mgs_line_2', CITY = 'mgs_city', STATE = 'MG', ZIP_CODE = '98765', 
PHONE = '333-333-3333' 
WHERE address_id = 1;

UPDATE CUSTOMERS_MGS 
SET EMAIL_ADDRESS = 'update_mgs_email', PASSWORD = 'update_mgs_password', FIRST_NAME = 'MGS_first', LAST_NAME = 'MGS_Last' 
WHERE customer_id = 1;
commit;


call customer_etl_proc();

----Checks to see what's in data warehouse table
select * from customers_dw
where customer_id in (1,99);


----Drops to be used for student work
--drop table customers_dw;
--drop view customers_ex_view;
--drop view customers_mgs_view;
--drop view customers_om_view;
--drop procedure customer_etl_proc;

 
