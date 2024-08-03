--1
select *
from vendors inner join invoices;


--2
select *
from customers_om c inner join orders o 
on c.customer_id = o.customer_id;

--3
select  c.customer_id, customer_first_name || ' ' || customer_last_name as customer_name, order_id, order_date
from customers_om c inner join orders o 
on c.customer_id = o.customer_id;

--4

select  c.customer_id, o.order_id, o.order_date, od.item_id, od.order_qty
from customers_om c  inner join orders o  on c.customer_id = o.customer_id
inner join order_details od on o.order = od.order_id;


