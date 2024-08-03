--1
CREATE TABLE vendor_only_ca AS

select vendor_name, vendor_address1, vendor_address2, vendor_city, vendor_phone
from vendors
where vendor_state = 'CA'
order by vendor_city;

--2
select * from vendor_only_ca;

--3
UPDATE vendor_only_ca
SET vendor_name = 'Who Cares!?!'

select * from vendor_only_ca;

--4

rollback;
select * from vendor_only_ca;

--5
UPDATE vendor_only_ca
SET vendor_name = 'Who Cares!?!'

commit;
rollback;
select * from vendor_only_ca;

--6
DROP TABLE vendor_only_ca

--Practce basic INSERT, UPDATE< and DELETE

--1

insert into ubc_members (UTEID,FIRST_NAME, LAST_NAME, EMAIL, PHONE, YEAR_OC, BIRTHDATE)
values ('vsp476', 'Vineet', 'Puranik', 'vineetpuranik@gmail.com', '832-774-7395', DEFAULT, '15-Jun-2004');
commit;

--2

insert into ubc_member_committees
values ('vsp476', 1);
commit;

--3

update ubc_members
set first_name = 'iggy'
where uteid = 'ieo328';
commit;
--4

update ubc_members
set phone = NULL
where year_oc >1;
commit;
--5

update ubc_members
set year_oc = year_oc+1;
commit;

--6

delete
from ubc_member_committees
where uteid = 'vsp476';

delete
from ubc_members
where uteid = 'vsp476';

--7

delete 
from ubc_member_committees
where uteid in (
select uteid from ubc_members where year_oc =4);

commit;
