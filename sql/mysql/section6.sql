-- ---------------------------------
-- MYSQL TYPES
-- ---------------------------------

-- don't be afraid to use the manual

-- ---------------------------------
-- TEXT TYPES
-- ---------------------------------
-- text is meant for a big block of text
drop table if exists test;

-- char means <= that many characters it also means it will take that much
-- space on your machine no matter how much info is in it
create table test(
	essay text, 
	zipcode char(7),
	value decimal(4,2)
);


-- ---------------------------------
-- FLOATS AND STUFF
-- ---------------------------------

-- (4 bits for float, 8 for double) floats and doubles aren't stored exactly -
-- so don't cmpare them with ='s

-- decimal(x,y) is stored exactly with a total of up to x digits and
-- y digits after the decimal

insert into test(value)
	values (1.2);

select * from test;


-- ---------------------------------
-- BIT TYPE
-- ---------------------------------

alter table test
	add column(bitfield bit(4));

insert into test(bitfield) values (b'0110');

select * from test;
select bitfield from test;

select bin(bitfield) from test;


-- ---------------------------------
-- BOOL TYPE
-- ---------------------------------

drop table if exists products;
create table products(
	id int primary key auto_increment,
	product varchar(100),
	available bool default false
);

desc products;

-- booleans are saved as a 0 or 1
insert into 
		products(product, available)
	values
		('electric dog groomer', true),
		('automatic fandangle', 0);

select * from products where available;

-- we can update the products to make them available
update products
	set 
		available=true
	where
		product = 'automatic fandangle';


select * from products where available;


-- ---------------------------------
-- BLOB TYPE
-- ---------------------------------

-- stands for binary large object
-- used for things like images
drop table if exists images;

create table images(
	name varchar(50),
	data blob
);

insert 
	into
		images(name, data)
	values
		('holiday1.jpg', 'lkjlj');

select * from images;


-- ---------------------------------
-- TIME DATE AND YEAR
-- ---------------------------------

-- we can use the now() function to pull the current datetime stamp and we can
-- extract its parts
select year(now()), time(now()), date(now());

drop table if exists moments;

create table moments(
	id int primary key auto_increment,
	theYear year,
	theDate date,
	theTime time
);

insert into moments(theYear, theDate, theTime)
	values
		('2015', '2014-06-15', '08:10:23'),
		(year(now()), date(now()), time(now()));

select * from moments;


-- ---------------------------------
-- TIMESTAMP AND DATETIME
-- ---------------------------------

drop table if exists products;

create table products(
	name varchar(50),
	sold_at timestamp default now(),
	received datetime
);

insert 
	into products(name, sold_at, received)
	values
		('dog groomer',now(),'2015-05-15 15:05:23');	
insert 
	into products(name, received)
	values
		('dog groomer','2015-05-15 15:05:23');	

select * from products;	


-- ---------------------------------
-- ENUMERATIONS
-- ---------------------------------

drop table if exists foods;

-- you can have a whole set of choices however, this is often better done with a
-- foreign key
create table foods(
	name varchar(50),
	temperature enum('cold', 'hot'),
	flavor enum('sweet', 'savory')
);

insert into foods(name, temperature, flavor)
	values
		('pizza', 'hot', 'savory'),
		('ice cream', 'cold', 'sweet'),
		('peanuts', 'cold', 'savory'),
		('hot cake', 'hot', 'sweet');

select * from foods;



-- ---------------------------------
-- BRACKETS
-- ---------------------------------

-- bring me something that is hot or something that is cold and sweet

select * 
	from 
		foods
	where
		temperature = 'hot' or
		temperature = 'cold' and flavor = 'sweet';

-- brackets can make things easier to read - by default and takes precidence over
-- or in sql
select * 
	from 
		foods
	where
		(temperature = 'hot') 
		or
		(temperature = 'cold' and flavor = 'sweet')
