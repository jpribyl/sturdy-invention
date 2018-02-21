-- -----------------------------
-- EXCLUSIVE TABLE LOCKS
-- -----------------------------

-- when you insert data to a table, esp a lot of data - then it's totally
-- possible for a web app or user to attempt to alter a database while the
-- first connection is still underway. Locking the table is a way to handle
-- these types of conflicts. We really don't want someone to alter table
-- structure while we're doing a massive data dump into the table

use online_shop;
show tables;


lock tables categories write;

-- we can't now use a table other than the one that we locked
-- select * from sales;

-- because we locked it with write - nobody else can read or write to the table
-- nobody else can do a select! it will just hang and never complete

desc categories;
select * from categories;


delete from categories where catname = 'Toys';
insert into categories(catname) values('Toys');
select * from categories;

-- we can unlock any tables that we had locked with:
-- notice that you can lock / unlock more than one table at a time
unlock tables;


-- -----------------------------
-- READ LOCKS
-- -----------------------------

lock tables categories read;
select * from categories;

-- we can't write to the table or read any other tables neither us nor anyone
-- else can write to the table - however, more than one person at a time can
-- get a read lock
/*
select * from sales;
insert into categories(catname) values('newvalue');
*/

unlock tables;


-- -----------------------------
-- USING VARIABLES
-- -----------------------------

-- recall that you can do things like
select 3;
select now();

-- we can also create and assign values to variables.
set @user1 = 'john';
select @user1;


set @minvalue = 1;
select @minvalue;

-- then we can use the variables in whatever we want!
select * from sales where transaction_value > @minvalue;



-- -----------------------------
-- SETTING VARIABLES WITH SELECT
-- -----------------------------
set @transaction_sum = (select sum(transaction_value) from sales);
select @transaction_sum;
