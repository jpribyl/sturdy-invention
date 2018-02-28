-- ----------------------------------------
-- ADDING COLUMNS
-- ----------------------------------------
select * from person;


alter 
	table person 
	add column(email varchar(100));

select * from person;


alter 
	table person 
	drop column email;

-- ----------------------------------------
-- ADDING FKs
-- ----------------------------------------

drop table if exists book;
drop table if exists library;

create table book (id int primary key auto_increment, name varchar(50), library int);
create table library(id int auto_increment primary key, name varchar(50));
insert into library (name) values ('Cardiff Church Road'), ('Nottingham Orchard Way');


alter
	table book
	add constraint fk_library foreign key (library) references library(id)
;
desc book;


insert 
	into book(name, library)
	values ('hamlet', 1)
;

select * from book;


-- ----------------------------------------
-- ADDING INDEXES
-- ----------------------------------------

-- here is the syntax
-- alter
	-- table music
	-- add index indx_band(band)
-- ;

-- alter
	-- table music
	-- drop index indx_band(band)
-- ;


-- indexes take up some space, but also speed up queries on a column

-- if you add multiple indexes at the same time
-- you will speed up queries on a, a and b, a and c, but not b or c only
-- alter
	-- table music
	-- add index indx_band(a, b, c)
-- ;



