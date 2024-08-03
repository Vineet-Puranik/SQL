--2
CREATE TABLE members_dw (
    member_id INT,
    data_source CHAR(4), 
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip VARCHAR(20),
    constraint pd_id_source primary key (member_id, data_source)
);

--3

CREATE OR REPLACE VIEW members_view
    AS
    SELECT 'ORIG' AS data_source, m.member_id AS member_id, first_name, last_name, phone_number, email_address, RTRIM(address, ';') AS address, city, state, zip_code
    FROM members m join member_phone p 
    ON m.member_id = p.member_id;
    
CREATE OR REPLACE VIEW members_acquired_view
    AS
    SELECT 'AQUI' AS data_source, acquired_member_id AS member_id, ma_first_name AS first_name, ma_last_name AS last_name, ma_email AS email,
    SUBSTR(ma_phone, 1, 3) || '-' ||  SUBSTR(ma_phone,4 ,3) || '-' ||
    SUBSTR(ma_phone, 7, 4) AS phone, SUBSTR(ma_address, 1 , INSTR(ma_address, 'Bend,OR') -2) AS address, 'Bend' AS city, 'OR' AS state, ma_zip_code AS zip
    FROM members_acquired;
    
--4
    insert into members_dw
    select m.member_id, m.data_source, m.first_name, m.last_name, m.email, m.address, m.city, m.state, m.zip, m.phone
    from members_view m left join members_dw dw
        on m.member_id = dw.member_id
        and m.data_source = dw.data_source
    where dw.member_id is null;
    
    
        insert into members_dw
    select ma.member_id, ma.data_source, ma.first_name, ma.last_name, ma.email, ma.address, ma.city, ma.state, ma.zip, ma.phone
    from members_acquired_view ma left join members_dw dw
        on ma.member_id = dw.member_id
        and ma.data_source = dw.data_source
    where dw.member_id is null;
    

--5

 MERGE INTO members_dw dw
        USING members_view m
        ON (m.member_id = dw.member_id and dw.data_source = 'ORIG')
      WHEN MATCHED THEN
        UPDATE SET  dw.first_name = m.first_name, 
                    dw.last_name = m.last_name,
                    dw.address = m.address,
                    dw.city = m.city,
                    dw.state = m.state,
                    dw.zip= m.zip,
                    dw.phone = m.phone,
                    dw.email =m.email;
                    
       
 MERGE INTO members_dw dw
        USING members_acquired_view ma
        ON (ma.member_id = dw.member_id and dw.data_source = 'ORIG')
      WHEN MATCHED THEN
        UPDATE SET  dw.first_name = ma.first_name, 
                    dw.last_name = ma.last_name,
                    dw.address = ma.address,
                    dw.city = ma.city,
                    dw.state = ma.state,
                    dw.zip= ma.zip,
                    dw.phone = ma.phone,
                    dw.email =ma.email;             
                
--6
   create or replace PROCEDURE members_etl_proc 
AS
BEGIN
 insert into members_dw
    select m.member_id, m.data_source, m.first_name, m.last_name, m.email, m.address, m.city, m.state, m.zip, m.phone
    from members_view m left join members_dw dw
        on m.member_id = dw.member_id
        and m.data_source = dw.data_source
    where dw.member_id is null;
    
    
        insert into members_dw
    select ma.member_id, ma.data_source, ma.first_name, ma.last_name, ma.email, ma.address, ma.city, ma.state, ma.zip, ma.phone
    from members_acquired_view ma left join members_dw dw
        on ma.member_id = dw.member_id
        and ma.data_source = dw.data_source
    where dw.member_id is null;

 MERGE INTO members_dw dw
        USING members_view m
        ON (m.member_id = dw.member_id and dw.data_source = 'ORIG')
      WHEN MATCHED THEN
        UPDATE SET  dw.first_name = m.first_name, 
                    dw.last_name = m.last_name,
                    dw.address = m.address,
                    dw.city = m.city,
                    dw.state = m.state,
                    dw.zip= m.zip,
                    dw.phone = m.phone,
                    dw.email =m.email;
                    
       
 MERGE INTO members_dw dw
        USING me    mbers_acquired_view ma
        ON (ma.member_id = dw.member_id and dw.data_source = 'ORIG')
      WHEN MATCHED THEN
        UPDATE SET  dw.first_name = ma.first_name, 
                    dw.last_name = ma.last_name,
                    dw.address = ma.address,
                    dw.city = ma.city,
                    dw.state = ma.state,
                    dw.zip= ma.zip,
                    dw.phone = ma.phone,
                    dw.email =ma.email;     
END;
/

 
    


