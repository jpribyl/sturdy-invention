-------------------------
--LECTURE DATA TYPES
-------------------------

/*
boolean or bool: t,f,true,false,ull

char: fixed length characer string char(n) exactly n character

varchar: variable length varchar(n) is up to n characters

numbers: integers and floating points etc
	smallint, 
	int, 
	serial (populate value into column automatically)
	float(n) max 8-byte
	real / float8 (double precision)
	numeric(p, s) real number with p digits s of which are after the decimal point

temporal:
	date
	time
	timestamp
	interval (difference between two time stamps)
	timstamptz (timestamp with time zone)
*/


---------------------------------------
--LECTURE PRIMARY / FOREIGN KEYS
---------------------------------------

--foreign key constraint indicates that values in a 
-- col(s) of the child table match the values in 
-- col(s) of parent table

---------------------------------------
--LECTURE PRIMARY / FOREIGN KEYS
---------------------------------------
drop table account_role;
drop table account;
drop table role;
drop table leads;
drop table links;
drop table links_copy;
drop table new_table;

CREATE TABLE account(
user_id serial PRIMARY KEY,
username VARCHAR (50) UNIQUE NOT NULL,
password VARCHAR (50) NOT NULL,
email VARCHAR (355) UNIQUE NOT NULL,
created_on TIMESTAMP NOT NULL,
last_login TIMESTAMP
);

CREATE TABLE role(
role_id serial PRIMARY KEY,
role_name VARCHAR (255) UNIQUE NOT NULL
);

CREATE TABLE account_role (

  user_id integer NOT NULL,
  role_id integer NOT NULL,
  grant_date timestamp without time zone,
  PRIMARY KEY (user_id, role_id),
  CONSTRAINT account_role_role_id_fkey FOREIGN KEY (role_id)
      REFERENCES role (role_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT account_role_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES account (user_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


---------------------------------------
--CHALLENGE CREATE TABLE
---------------------------------------

--create a table to organize the potential leads
create table leads (

	lead_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(350) unique not null,
	sign_up_ts timestamp not null,
	min_on_site integer not null
);


---------------------------------------
--LECTURE INSERT
---------------------------------------

create table links(
	link_id serial primary key,
	url varchar(255) not null,
	name varchar(255) not null,
	description varchar(255),
	rel varchar(50)
);

--insert rows (and multiple rows at once)
insert into 
	links(url, name)

	values
		('www.google.com', 'Google');

insert into 
	links(url, name)

	values
		('www.yahoo.com', 'Yahoo');

insert into 
	links(url, name)

	values 
		('www.bing.com', 'Bing'),
		('www.amazon.com', 'Amazon');

--copy a table's structure to a new table
create table links_copy(like links);

--copy a table's rows into a new table (including the ID) using select statments!
insert into links_copy
	select * 
		from links
		where name = 'Bing';

---------------------------------------
--LECTURE UPDATE
---------------------------------------

-- we can update based upon conditions
update links
	set description = 'Empty Description'
	where description is null;

update links
	set description = 'Name starts with A'
	where name like 'A%';

--we can also update columns based on other columns
update links 
	-- assuming description and name are the same data type
	set description = name;

--we can use the word returning to show changes!
update links 
	set description = 'new descrip'
	where link_id = 1
	returning link_id, url, name, description;


---------------------------------------
--LECTURE DELETE
---------------------------------------

--delete statement returns the number of rows deleted
delete 
	from
		links
	where
		name like 'A%'

	--you can also have it return the rows deleted
	returning *;

select * from links;


---------------------------------------
--LECTURE ALTER TABLE
---------------------------------------

/*
add column
drop column
rename column
add constraing
rename to
*/

drop table links;

-- adding and dropping columns works exactly how you would expect!
create table links(
	link_id serial primary key,
	title varchar(512) not null,
	url varchar(1024) not null unique
);

alter table links
	add column active boolean;


alter table links
	drop column url;

-- we can also rename <xxx> to <yyy>
alter table links
	rename column title to new_title;

alter table links rename to new_table;
select * from new_table;


---------------------------------------
--LECTURE DROP TABLE
---------------------------------------

create table test_two(
	test_id serial primary key);

select * from test_two;

--dropping tables is pretty simple
drop table test_two;

--to avoid getting an error when dropping nonexistent tables
--you'll still get a notice, but the table will be skipped
drop table if exists test_two;

--you can put 'restrict' after the table to avoid dropping tables with dependencies
--restrict will be put in by default
--or, 'cascade' to drop a table and all it's dependencies

---------------------------------------
--LECTURE CHECK CONSTRAINT
---------------------------------------
--check if the value meets a boolean IE birthday after 1900
create table new_users(
	id serial primary key,
	first_name varchar(50),
	birth_date date check(birth_date > '1900-01-01'),
	join_date date check(join_date > birth_date),
	salary integer check(salary>0)
);

insert 
	into 
		new_users(
			first_name, 
			birth_date, 
			join_date, 
			salary
		)

	values(
		'bob',
		'1980-02-02',
		'1990-04-04',
		10
	);


select * from new_users;

--we can also name checks by using CONSTRAINT
create table checktest(
	sales integer CONSTRAINT positive_sales check(sales>0)
);

insert into checktest(sales)
	values (10);



drop table new_users;
drop table checktest;


---------------------------------------
--LECTURE NOT NULL CONSTRAINT
---------------------------------------

--null is the word for missing / unknown information
--different than empty string or zero

create table learn_null(
	first_name varchar(50),
	sales integer not null 
);

insert 
	into 
		learn_null(first_name, sales)
	values 
		('john', 12);


select * from learn_null;
drop table learn_null;


---------------------------------------
--LECTURE UNIQUE CONSTRAINT
---------------------------------------

create table people(
	id serial primary key,
	first_name varchar(50),
	email varchar(100) unique 
);

insert into people(id, first_name, email)
	values (1,'joe', 'joe@joe.com');

insert into people(id, first_name, email)
	values (2,'joseph', 'joe2@joe.com');

select * from people;

drop table if exists people;


