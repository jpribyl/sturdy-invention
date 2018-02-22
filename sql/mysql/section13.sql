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

-- we can use an aggregate function (or whatever) to set the value of a variable
-- there are a couple of ways to set varaibles
set @transaction_sum = (select sum(transaction_value) from sales);

select 
	@transaction_sum := sum(transaction_value),
	@transaction_minimum := min(transaction_value)
	from sales;

select @transaction_sum;
select @transaction_minimum;


-- -----------------------------
-- SELECT-UPDATE EXAMPLE
-- -----------------------------

drop table if exists sales_history;
create table sales_history(
	id int primary key auto_increment,
	month datetime default now(),
	monthly_sum float
);


-- we can save a variable and insert it directly into another table
select @monthly_sum := sum(transaction_value) from sales;
-- we should be careful to ensure that first line runs first (IE if we are
-- selecting from one table and putting it in another, that could be
-- problematic)
insert 
	into sales_history(monthly_sum)
	values (@monthly_sum);

-- or we can insert one query into another table
insert 
	into sales_history(monthly_sum)
	(select sum(transaction_value) from sales)
;

select * from sales_history;


-- -----------------------------
-- FIX SELECT UPDATE WITH LOCK
-- -----------------------------

lock tables sales read, sales_history write;
select @monthly_sum := sum(transaction_value) from sales;
insert 
	into sales_history(monthly_sum)
	values (@monthly_sum)
;
unlock tables;

select * from sales_history;

-- in innodb, you can do row locking, you don't have to lock the entire table!


-- -----------------------------
-- ACID
-- -----------------------------

-- atomicity - you can execute lots of statements and the will either all occur
-- - or none of them will

-- consistency - make sure that you can't have an inconsistent state IE remove
-- from one account without putting it in a new account

-- isolation - users can't conflict with each other

-- durability - even if there's a crash, you should be left consistent

-- innodb is acid compliant, myisam is not but it IS very fast.


-- -----------------------------
-- A SIMPLE TRANSACTION
-- -----------------------------

use tutorial1;

-- this will prevent a commit from happening without being told to happen
set autocommit=0;

delete 
	from book 
	where name = 'Journey to the Center of the Earth'
	or name = 'Cloud Atlas'
;

insert
	into book(name, library)
	values 
		('Journey to the Center of the Earth',1),
		('Cloud Atlas',1)
;


delete 
	from book 
	where name = 'Journey to the Center of the Earth'
	or name = 'Cloud Atlas'
;

select * from book;
rollback;
select * from book;

-- we have to commit things before they're visible to other users
-- if they do appear, isolation has been set differently
commit;
select * from book;


-- -----------------------------
-- START TRANSACTIONS
-- -----------------------------

-- we can also leave autocommit on but retain rollbacks with a transaction
set autocommit=1
select * from books;


start transaction;

update book 
	set name = 'The Raisins of Wrath' 
	where id = 2
;

select * from book;
rollback;
select * from book;
commit;
select * from book;



-- -----------------------------
-- INNODB ROW LEVEL LOCKING
-- -----------------------------

-- we can check the present isolation level with 
select @@session.tx_isolation;

-- row level locking: applies to indexes - without indexes, mysql will default
-- to locking the entire table
-- read locks (shared) vs write locks (exclusive)
-- TRANSACTIONS ENSURE ATOMICITY (all or nothing)


-- -----------------------------
-- ACID ISOLATION LEVELS
-- -----------------------------

-- we can set isolation levels with syntax like this
set session transaction isolation level repeatable read;

-- highest level is serializable -> no one can update any rows if you even just
-- select the row. This is generally overkill

-- default level is repeatable-read -> if you begin a select transaction you
-- will see the same results even if someone else changes the DB while you're
-- doing things. sometimes you might notice phantom rows mysql seems pretty good
-- about it but sometimes if you have a where clause and someone else changes
-- the table you might see rows you shouldn't see. Ideally, you will see the
-- same select over and over again until you commit


-- lower than this is read committed -> if another user commits changes, they
-- will appear to your subsequent selects

-- lowest level is read uncommitted -> essentially a lack of isolation, it will
-- show you changes even if another use has not comitted their changes.



-- -----------------------------
-- SERIALIZABLE AND ROW VS TABLE LOCKS
-- -----------------------------

select * from person;
set session transaction isolation level serializable;

start transaction;
select * from person where id=1;
commit;


-- -----------------------------
-- DEMONSTRATING OTHER ISOLATION LEVELS
-- -----------------------------

-- the exercises for this section are best done in mysql workbench so that you
-- can see in each tab the differences that occur. Open several tabs with the
-- connection default and use them to play around with various isolation levels
-- until they become intuitive this is worth doing, many devs skip over
-- isolation levels and don't really understand them


-- -----------------------------
-- ROLLING BACK TO SAVE POINTS
-- -----------------------------


-- we can create a save point partway through the transaction and roll back to
-- that point without ending the transaction.
start transaction;
insert into book(id,name, library) values(2,'Grapes of Wrath', 1);
select * from book;
delete from book where id=2;
savepoint testbook;
delete from book where id<100;
select * from book;
rollback to testbook;
select * from book;




-- -----------------------------
-- ACCOUNT TRANSFER PROBLEM
-- -----------------------------

drop table if exists accounts;
create table accounts(
	id int primary key auto_increment,
	balance numeric(10,2) default 0
);

insert 
	into accounts(balance) 
	values
		(1000),
		(20040)
;

-- what if we want to transfer from one account to another?
-- we could do it with a variable, but make sure to think about what would
-- happen if something goes wrong and only one of the transactions executes
start transaction;
set @transfer = 200.00;

update
	accounts

	set balance = balance - @transfer
	where id=1
;

update
	accounts

	set balance = balance + @transfer
	where id=2
;

commit;

-- the transaction prevents the money from going down into a black hole!
select * from accounts;



-- -----------------------------
-- SELECT FOR UPDATE
-- -----------------------------

-- sometimes it's not enough to just wrap statments as  transactions
-- what if we want to prevent overdraws?
start transaction;

set @withdraw = 500;
set @account = 1;
select balance from accounts where id=@account;

-- manually check the balance for now (can be automated later)
update accounts
	set balance = balance - @withdraw
	where id = @account;

commit;

-- if we run this from 2 sessions at the same time, we could wind up
-- withdrawing twice and overdrawing the account in a situation like this, we
-- need to prevent the second transaction from occuring

-- even in a transaction, we could wind up reading one before the second one
-- commits. So, we could lock the table for writing... but that's not super
-- ideal because it prevents anyone from doing anything. We could also up the
-- isolation level to serializable.. but that's also nasty

-- a better solution is to lock the row by using FOR UPDATE at the end of the
-- select query. This puts a write lock on the row.
start transaction;

set @withdraw = 100;
set @account = 1;
select 
	balance 
	from accounts 
	-- for update acts like a write lock on the row
	where id=@account for update;

update accounts
	set balance = balance - @withdraw
	where id = @account;

commit;
select balance from accounts where id=@account;



-- -----------------------------
-- LOCK IN SHARE MODES
-- -----------------------------

select * from book;
select * from library;

start transaction;
select 
	name 
	from library 
	where name like 'nottingham%'
	-- this lock in share mode functions as a read lock on the row(s)
	-- it will let people read the rows, but not change them (delete, etc)
	lock in share mode;


-- using for update is a write lock and isn't necessary here!
-- we just need a read lock.
delete from book where name = 'painting for beginners';
insert 
	into book(name, library) 
	values 
		('painting for beginners', 2);

commit;


select * from book;
