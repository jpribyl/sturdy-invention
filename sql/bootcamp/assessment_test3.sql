--create a new database 'school' 
create table students(
	student_id serial primary key unique not null,
	first_name varchar(50),
	last_name varchar(50),
	hr integer,
	phone varchar(20) unique not null,
	email varchar(255) unique,
	grad_year integer
);


create table teachers(
	teacher_id serial primary key unique not null,
	first_name varchar(50),
	last_name varchar(50),
	hr integer,
	department varchar(50),
	email varchar(255) unique not null,
	phone varchar(20) unique not null
);

--put some people into the database
insert 
	into students(first_name, last_name, phone, grad_year, hr)
	values ('Mark', 'Watney', '777-555-1234', 2035, 5);

insert 
	into teachers(first_name, last_name, phone, email, department, hr)
	values ('Jonas', 'Salk', '777-555-4321', 'jsalk@school.org', 'Biology', 5);

select * from students;
select * from teachers;

drop table teachers;
drop table students;
