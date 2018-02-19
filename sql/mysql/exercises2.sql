-- Create the following tables in MySQL

-- Products

-- primary key
-- name
-- category
-- sell by date
-- sold or not
-- moment of sale
-- quantity
-- weight Kg

drop table if exists products;
create table products(
	id int primary key auto_increment,
	name varchar(50),
	category enum('a', 'b', 'c'),
	sellby date,
	sold bool default false,
	saletime datetime default now(),
	quantity int,
	weight numeric(6,3)
);
desc products;

-- ---------------------------------------
-- Personnel

-- primary key
-- given name
-- family name
-- gender
-- telephone number
-- marital status
-- age
-- salary
-- position
-- date started

drop table if exists personnel;
create table personnel(
	id int primary key auto_increment,
	given_name varchar(50),
	family_name varchar(50),
	gender enum('male', 'female', 'neither'),

	-- phone numbers are tricky! sometimes they have +
	phone varchar(100),
	married bool,
	age tinyint,
	salary int,

	-- this should be in another table!
	position enum('pos1', 'pos2', 'pos3'),
	start_date date
);
-- ---------------------------------------

-- Address

-- First line
-- Second line
-- City
-- Region
-- zip/postal code
-- Two letter country code

drop table if exists address;
create table address(
	first_line varchar(100),
	second_line varchar(75),
	city varchar(50),
	region varchar(50),
	zip char(10),
	country_code char(2)
);


