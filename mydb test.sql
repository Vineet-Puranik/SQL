use mydb;

DROP Table employees;

CREATE TABLE employees (
    id 			INT 			NOT NULL 	PRIMARY KEY 	AUTO_INCREMENT,
    name 		VARCHAR(100) 	NOT NULL,
    address		VARCHAR(255) 	NOT NULL,
    salary 		INT(10) 		NOT NULL
);

insert into employees 
values (1, 'John Candy', '1800 Gumdrop Lane', 68000);

insert into employees 
values (2, 'Selma Nguyen', '1826 Easy St', 120000);

select*
from employees
where id = 3;