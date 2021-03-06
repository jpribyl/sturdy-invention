-- -----------------------------------
-- NAMING COLS AND TABLES
-- -----------------------------------
-- using the health survey DB
-- use health;

-- select 
	-- s.id as survery_id,
	-- s.weight as weight_kg,
	-- s.sugar as sugar_intake_score,
	-- s.health as health_score

	-- from survey as s
	-- limit 5
-- ;


-- -----------------------------------
-- FOREIGN KEYS
-- -----------------------------------

-- use tutorial1;


drop table if exists person_product;
drop table if exists person;
drop table if exists address;

create table address(
	id int primary key auto_increment,
	street varchar(50)
);


insert 
	into address(street)
	values
		('apple lane'),
		('borad street'),
		('church lane')
;

drop table if exists person;
create table person(
	id int primary key auto_increment,
	name varchar(50),
	address_id int, foreign key (address_id) references address(id)
);
desc person;


insert 
	into person(name, address_id)

	values 
		('Claire', 3),
		('Bob', 1),
		('Arnold', 3),
		('Anna', 2),
		('Anna_null', null)

		-- this one will throw an error b/c address '5' doesn't exist
		-- ('David', 5)
;

select * from address;
select * from person;


-- -----------------------------------
-- ER DIAGRAMS
-- -----------------------------------

-- this uses mysql workbench to reverse engineer schema diagrams


-- -----------------------------------
-- JOINS AND CARTESIAN PRODUCTS
-- -----------------------------------

-- if we just do something like this:
select
	name,
	street

	from person, address
;
-- then we get something called a cartesian product where everything matches up
-- with everything and it's godawful... we really want a join!


select a.name, b.street 
	from person as a
	join address as b
 
	on a.address_id = b.id
;

select a.name, b.street 
	from person as a
	left join address as b
 
	on a.address_id = b.id
;


-- -----------------------------------
-- MULTIPLE TABLE JOINS
-- -----------------------------------
use health;

select 
	a.id, 
	a.country, 
	a.age,
	b.question as smoke_q,
	e.question as exercise_q

	from survey a

	join smoke b
	on a.smoke=b.id


	join exercise e
	on e.id=a.exercise

	order by age desc
	limit 10;


-- -----------------------------------
-- ADDING ANOTHER TABLE WITH A FOREIGN KEY
-- -----------------------------------
use tutorial1;

drop table if exists region;
create table region(
	id int primary key auto_increment,
	name varchar(100)
);

-- select * from address;
desc address;

-- you can add this table into the DB
-- and reverse engineer the structure!
alter table address
	add column(
		region_id int,
		foreign key (region_id) references region(id)
	)
;
desc address;



-- if we don't put any regions in the region table, then this will return an
-- empty set
insert into region(name)
	values
		('derby'),
		('stafford'),
		('york')
;

update address set region_id = 4 - id;
select 
	a.name as name,
	b.street as street,
	c.name as region

	from person a

	join address b
	on a.address_id = b.id

	join region c
	on b.region_id = c.id
;


-- -----------------------------------
-- ONE TO MANY AND MANY TO ONE
-- -----------------------------------

-- if you have a mother and kids - you want the children table to have the
-- foriegn key. The relationship is many -> one where the table with the key is
-- many and the table without is one. In order to get a many to many
-- relationship then you'll need to add another table



select * from product;

-- -----------------------------------
-- MANY TO MANY
-- -----------------------------------
create table person_product(

	person_id int not null,
	product_id int not null,

	foreign key (person_id) references person(id),
	foreign key (product_id) references product(id)
);

insert 
	into 
		person_product(person_id, product_id)
	values
		(1,3),
		(1,2),
		(2,3),
		(3,2),
		(1,3),
		(5,2),
		(4,3),
		(1,3)
;

select * from person_product;
select * from person;


-- now that we've built the tables, let's pull out the purchases that each
-- person has made and give a count of how many of each item was bought
select
	a.name,
	c.name as product_name,
	count(*) as number_bought

	from person a

	join person_product b
	on a.id = b.person_id

	join product c
	on b.product_id = c.id

	group by a.name, c.name

	order by a.name, number_bought desc
;


-- -----------------------------------
-- SELF JOINS
-- -----------------------------------

-- here is an interview question with self joins!
drop table if exists seats;
create table seats(
	id int primary key auto_increment,
	free bool not null default true
);

-- the challenge is to pick out all empty pairs of seats
-- because people in the cinema like to sit next to each other
insert 
	into seats(free)

	values
		(true),
		(false),
		(true),
		(true),
		(false),
		(false),
		(true),
		(true),
		(false),
		(true)
;


select  
	a.id as free_seat_1,
	b.id as free_seat_2

	from seats a

	join seats b
	on a.id = (b.id - 1)

	where a.free = 1
	and b.free = 1
;


-- -----------------------------------
-- RESTRICT FKS
-- -----------------------------------

-- By default, mysql won't let you delete a foreign key (this is called restrict)
-- but, you can specify it to do something else

-- another option is to cascade which you can do syntactically by:

/*
create table(
	stuff here....
	on delete cascade
	on update cascade
);
*/

-- cascading will delete everything that is referenced by the key for example,
-- if you have animal > dog > fido and you delete animal, then dog and fido
-- will also be deleted

-- cascading makes more sense on update than it does on delete
