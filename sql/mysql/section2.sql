-- --------------------------------
-- CREATING TABLES
-- --------------------------------

create table users(username text);

show databases;
show tables;
-- describing the table
desc users;


insert into 
		users(username) 
	values 
		('Bob');


insert into 
		users(username) 
	values 
		('Vicky');


select * from users;

-- you can alter the table you just made
alter table users 
	add column(id int);
desc users;

-- or delete it and then make a new one
drop table users;

create table users(
	username text,
	id int
);


insert into 
		users(id, username)
	values
		(1, 'Bob'),
		(2, 'Vicky');
select * from users;

-- --------------------------------
-- NULL VALUES
-- --------------------------------

-- If we want to prevent null values from existing in data we can do that!
insert into
		users(id)
	values
		(3);

select * from users;
drop table users;
create table users(
	username text not null,
	id int not null
);


/*
-- your version of mysql may have a default value (IE a blank string)
-- mine throws an error, uncomment this to see it
insert into
		users(id)
	values
		(3);

select * from users;
*/

insert into
		users(id, username)
	values
		(3, 'rick');

select * from users;


-- --------------------------------
-- STORAGE ENGINES AND CONFIGURATION
-- --------------------------------
-- there are a few different engines.. typically we use innoDB
show engines;
show table status;


-- --------------------------------
-- SQL MODES
-- --------------------------------

select @@global.sql_mode;

-- set @@session.sql_mode = ''
-- strict all tables will prevent you from inserting not null with a null
-- ie there will be no default values
set sql_mode = "STRICT_ALL_TABLES";
select @@session.sql_mode;



-- --------------------------------
-- DELETING ALL DATA
-- --------------------------------

-- before we can delete things, we need to make sure it won't yell at us
set sql_safe_updates = 0;
delete from users;
select * from users;


-- --------------------------------
-- PRIMARY KEYS
-- --------------------------------
drop table users;
create table users(
	id int primary key,
	name text,
	email text
);
desc users;


insert into
	users(id,name,email)
	values
		(0,'bob','bob@bob.bob'),
		(1,'bob','zbob@bob.bob');


select * from users;


-- --------------------------------
-- AUTO INCREMENT
-- --------------------------------

-- you can get sql to invent a key for you weeeeee
drop table users;
create table users(
	id int primary key auto_increment,
	name text,
	email text
);
desc users;


insert into
	users(name,email)
	values
		('bob','bob@bob.bob'),
		('bob','zbob@bob.bob');

select * from users;

-- this doesn't preclude you from inserting ID's manually
insert into
	users(id, name,email)
	values
		(3,'vicky','zvicky@bob.bob');

select * from users;


-- --------------------------------
-- NARROW DOWN SELECTS
-- --------------------------------
-- this is where which is the same as in psql and sqlite
-- but it also works with delete (if you have done set sql_safe_updates=0
-- delete from users where id=3;
delete from users where name='bob';

select * from users;
