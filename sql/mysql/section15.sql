-- ---------------------------------
-- INTRODUCING STORED PROCEDURES!
-- ---------------------------------

-- collections of mysql statements that can be run all at once
-- you can give users permission to run stored procedures

-- loved by academics and hated by everyone else :P


-- ---------------------------------
-- CHANGING THE DELIMITER
-- ---------------------------------

-- we can change the ; delimiter to anything we want!
delimiter :
select * from book:

select * from dates:

-- this is important so that we can separate statements within a stored
-- procedure without ending the entire thing



-- ---------------------------------
-- HELLO WORLD
-- ---------------------------------
drop procedure if exists helloworld:

-- first, we need to set a delimiter that will end the whole procedure
delimiter $$

-- then we can create the procedure
create procedure helloworld()
-- our proc lives between begin/end
begin
	select
	-- inside the proc, we use the normal ; delimiter
		'hello world!';
end$$


-- then, we can reset the delimiter and call the proc
delimiter :
call helloworld():


-- ---------------------------------
-- EDITING STORED PROCEDURES
-- ---------------------------------
show databases:
-- select * from mysql.proc:
-- select
	-- cast(body as char)
	-- from mysql.proc:

-- we can right click and choose create / send to sql editor in order to put a
-- SP in our current sql window



-- ---------------------------------
-- SETTING THE DEFINER
-- ---------------------------------

use online_shop:
drop procedure if exists showcustomers:
drop procedure if exists showproducts:

show tables:
select
	*
	from products:




-- a stored proc will run with the definer permissions
-- by default those permissions are root
-- we can change that in a few ways:

-- let's make a new proc that shows all the customers
create 
	procedure showcustomers()

	-- we can set the permissions to be those of the person running the procedure like this:
	sql security invoker
	-- or, we can set 
	-- sql security definer
	-- that's the default and gives the procedure the same permissions as the person
	-- who creates it

	begin select
			*
			from customers;

	end:



-- we can change the definer to be something like this, which will give the
-- procedure the same permission set as shopuser@localhost has. (currently nothing)
create
	user shopuser@localhost
	identified by 'letmein':

create 
	definer=shopuser@localhost
	procedure showproducts()

	-- this is the default so you don't actually have to include this line
	sql security definer

	begin select
		*
		from products;

	end:

call showcustomers():

-- this will throw a denied error if you run it 
call showproducts():


-- ---------------------------------
-- PROCEDURE PERMISSION
-- ---------------------------------

-- let's grant execute permissions for the stored procedure in the last lecture
grant execute 
	on procedure online_shop.showproducts 
	to shopuser@localhost:


-- but that's not quite enough, because shopuser can't select from the table yet
grant select
	on online_shop.products
	to shopuser@localhost:

-- and now it will work!
call showproducts():




-- here is something interesting, let's make a new person
create
	user procuser@localhost
	identified by 'letmein':

-- and we'll give him view permission on customers but not products
grant select
	on online_shop.customers
	to procuser@localhost:

-- then we grant execute permissions on the procedure
grant execute
	on procedure online_shop.showproducts
	to procuser@localhost:

-- we find that procuser can actually run the procedure as procuser. this is
-- because we set the procedure's permissions to be those of the definer
-- (shopuser) who IS allowed to view the products table



-- ---------------------------------
-- PASSING PARAMETERS
-- ---------------------------------

use tutorial1:

select * from book:

drop procedure if exists showbooks:

-- we can pass parameters through the procedure, just like a function
-- 'in' means that we are putting data into the procedure.
create
	procedure showbooks(in maxid int)

	begin
		select *
			from book
			where id < maxid;
	end:

call showbooks(69):



-- ---------------------------------
-- MULTIPLE PARAMETERS
-- ---------------------------------


drop procedure if exists showbooks:

-- we can pass parameters through the procedure, just like a function
-- 'in' means that we are putting data into the procedure.
create
	procedure showbooks(
		in maxid int,
		in title varchar(50)
	)

	begin
		select *
			from book
			where id < maxid

			-- if we want to do a search by similar titles,
			-- something like this will work
			and name like concat('%', title, '%');

	end:


-- notice that mysql can't do default values for stored procedures....... but
-- you could pass null and run an if loop at the beginning to set null values
-- to your desired default

call showbooks(60, ''):
call showbooks(60, 'cloud'):


-- ---------------------------------
-- SELECT INTO VARIABLES
-- ---------------------------------

-- say we have some select query
select 
	id, 
	name 

	from book
	where id=11:

-- and we realize that we actually want to store the results as variables, we
-- can do that with the into command
select
	id,
	name

	into
		@bookid,
		@bookname
	
	from
		book
	
	where
		id = 11:

-- this could be super useful when we are doing a search from a stored procedure!
select 
	@bookid
	@bookname:


-- ---------------------------------
-- OUT PARAMETERS
-- ---------------------------------

drop procedure if exists showbooks:

-- we can save the results of a stored procedure into variables
create
	procedure showbooks(
		in maxid int,
		in title varchar(50)
	)

	begin
		select
			id,
			name

			into
				@procid,
				@procname

			from book
			where id < maxid

			-- if we want to do a search by similar titles,
			-- something like this will work
			and name like concat('%', title, '%');

	end:

call showbooks(60, 'cloud'):
select @procid, @procname:


drop procedure if exists showbooks:
-- or, we can let the user specify what the out-parameters should be
create
	procedure showbooks(
		in maxid int,
		in title varchar(50),
		out outid int,
		out outtitle varchar(50)
	)

	begin
		select
			id,
			name

			into
				outid,
				outtitle

			from book
			where id < maxid

			-- if we want to do a search by similar titles,
			-- something like this will work
			and name like concat('%', title, '%');

	end:

call showbooks(69, 'cloud', @outid1, @outtitle1):
select @outid1, @outtitle1:


-- ---------------------------------
-- INOUT PARAMETERS
-- ---------------------------------

select count(*) from book:

drop procedure if exists inandout:
create 
	procedure inandout(
		in bookid int
	)

	begin
		select bookid;


		select count(*)
		-- with an out procedure, this would be the syntax
		-- but it doesn't really work with an in parameter
		into bookid
		from book;
	end:


set @value = 11:
call inandout(@value):
-- we see that the parameter is not correctly set!
select @value:


/*let's try an out parameter*/
drop procedure if exists inandout:
create 
	procedure inandout(
		-- changing the parameter to an out param
		out bookid int
	)

	begin
		select bookid;


		select count(*)
		-- we CAN do this with an out param as we have seen before
		into bookid
		from book;
	end:


set @value = 11:

-- however, we can no longer call it as an in parameter
-- IE we see that it becomes null when we try to select it
call inandout(@value):
select @value:


/*what we really need to do is define it to be an inout parameter!*/
drop procedure if exists inandout:
create 
	procedure inandout(
		-- changing the parameter to an inout param
		inout bookid int
	)

	begin
		-- this is not null
		select bookid;


		select count(*)
		-- and this sets correctly!
		into bookid
		from book;
	end:


set @value = 11:

/*to verify that it works correctly - it is able to use the parameter within the*/
/*procedure and also works outside the procedure*/
call inandout(@value):
select @value:

/*we don't make every parameter an inout parameter because it makes the code*/
/*harder to read! Also probably a bit of an efficiency sacrifice*/


-- ---------------------------------
-- IF STATEMENT
-- ---------------------------------

show tables:
select * from accounts:

drop procedure if exists withdraw:
create 
	procedure withdraw(
		in flag bool -- flags are typically bools
	)

	begin

		-- we can take different actions based on flag
		if flag = true 
			then select 'hello';

		else
			select 'goodbye';

		end if;
	end:

call withdraw(true):
call withdraw(false):


-- ---------------------------------
-- LOCAL VARIABLES
-- ---------------------------------

-- let's verify a balance automatically before doing a withdrawal
-- we need to declare a local variable in the proc
drop procedure if exists withdraw:

create
	procedure withdraw(in flag bool)

	begin
		declare balance numeric(7,2) default 0;

		/*if we don't set the variable, it is initialized to null*/
		declare nullbalance int;
		set balance = 7;
		select nullbalance, balance;
	end:

call withdraw(true):


-- ---------------------------------
-- IMPLEMENT ACCOUNT WITHDRAWAL
-- ---------------------------------

/*building on the last lecture*/
drop procedure if exists withdraw:
create
	procedure withdraw(
		in account_id int,
		in amount numeric(10,2),
		out success bool
	)

	begin
		-- first declare the local variable
		declare current_balance numeric(10, 2) default 0;

		select a.balance
			-- then, select the balance into the variable
			into current_balance

			from tutorial1.accounts a
			where account_id = a.id;
		

		-- next, verify the withdrawal amount
		if current_balance >= amount then
			update tutorial1.accounts
				set balance = balance - amount
				where id = account_id;
			select 
				concat('ok, balance is now: ', balance) as success
				from accounts
				where account_id = accounts.id;

			set success = true;

		else
			set success = false;
			select 'not ok';
		end if;
		
	end:

call withdraw(2, 10000020, @success):
select @success:

-- there is also an interesting possibility of casting the bool as a number and
-- multiplying to do the withdrawal
select convert(@success, signed) * 10 as novelty:


-- ---------------------------------
-- TRANSACTION WITHDRAWAL
-- ---------------------------------

-- now, let's combine what we learned earlier in the course about transactions!
drop procedure if exists withdraw:
create
	procedure withdraw(
		in account_id int,
		in amount numeric(10,2),
		out success bool
	)

	begin
		-- declare the variable
		declare current_balance numeric(10, 2) default 0;

		-- so building, we start the transaction
		-- THIS MUST BE AFTER VARIABLE DECLARATION
		start transaction;

		select a.balance
			into current_balance

			from tutorial1.accounts a
			where account_id = a.id

			-- same 'for update' row lock used in section 13 -- as
			-- before, if you don't include an index (IE a unique
			-- column), the whole table will be locked
			for update;

		-- note that using a transaction, we can also set the amount
		update tutorial1.accounts
			set balance = balance - amount
			where id = account_id;
		

		if current_balance >= amount then
			select 
				concat('ok, balance is now: ', balance) as success
				from accounts
				where account_id = accounts.id;

			set success = true;
			-- and then commit
			commit;

		else
			set success = false;
			select 'not ok';
			-- or rollback depending on the state of the account
			rollback;

		-- this might not be the best solution though, because the
		-- amount in the account will temporarily be negative!
		end if;
		
	end:

call withdraw(1, 2000, @success):
select * from accounts:


-- ---------------------------------
-- ERRORS AND WARNINGS
-- ---------------------------------

/*an error totally prevents something from working*/
select * from plants:

/*if you encounter an error or warning during a procedure.. you might want to
 * exit the whole thing!*/
show errors:

/*you get a warning for doing something like setting a variable taht doesn't
 * exist. it won't prevent the sql from running, but it might be noteworthy*/
select * from book:
select
	name
	into @the_title
	from book
	where id = 1:

show warnings:
select @the_title:


-- ---------------------------------
-- HANDLING ERRORS
-- ---------------------------------

/*easy to google declare handler syntax - you can tell sql to continue, exit,
 * or undo the actions when it encounters a particular error*/
drop procedure if exists withdraw:
create
	procedure withdraw(
		in account_id int,
		in amount numeric(10,2),
		out success bool
	)

	begin
		declare current_balance numeric(10, 2) default 0;

		-- we declare handlers before the transaction as well
		declare exit handler for sqlexception
		begin
			show errors;
		end;

		declare exit handler for sqlwarning
		begin
			show warnings;
		end;


		start transaction;
		select a.balance
			into current_balance
			from tutorial1.accounts a
			where account_id = a.id
			for update;

		

		if current_balance >= amount then

			-- we can get it to throw the error by updating a nonexistent table
			update tutorial1.acc
				set balance = balance - amount
				where id = account_id;

			select 
				concat('ok, balance is now: ', balance) as success
				from accounts
				where account_id = accounts.id;
			set success = true;
			commit;

		else
			set success = false;
			select 'not ok';
			rollback;
		end if;
		
	end:

call withdraw(1, -20, @success):


-- ---------------------------------
-- WHILE LOOPS
-- ---------------------------------

drop procedure if exists whiledemo:
create 
	procedure whiledemo()

	begin
		declare count int default 0;
		declare numbers varchar(10) default '';

		-- these work just like you would expect.. remember to 'do'
		while count < 5 do

			-- this will through numbers 0-9
			set numbers = concat(numbers, count, ',');
			set count = count + 1;
		end while;

		select numbers;
	end:

call whiledemo():


-- ---------------------------------
-- LABELLED LOOPS
-- ---------------------------------

/*this is a better loop when you don't know how many times you need to iterate
 * the loop before hand IE stepping through every row of a table*/
delimiter $$
drop procedure if exists loopdemo$$
create procedure loopdemo()
begin
	declare count int default 0;
	declare numlist varchar(30) default '';

	-- we label the loop like this 
	-- for this reason, : may not be the best delimiter... oops!
	the_loop_label: loop

		-- exit condition
		if count = 10 then
			leave the_loop_label;
		end if;

		-- we can do this to ensure that the loop works
		set numlist = concat(numlist, count);
		set count := count + 1;

	end loop;
	
	select numlist, count;
end$$
delimiter ;


call loopdemo();


-- ---------------------------------
-- GENERATING RANDOM DATA
-- ---------------------------------

drop table if exists random_users;
create table random_users(
	id int primary key auto_increment,
	email varchar(50) not null,
	register_date date not null,
	active boolean default false
);

-- we can use the rand() function to generate a random number between 0 and 1
-- then, we can also use a while loop, and the round and floor functions to 
-- produce a table of users in the format:
	-- id -> as usual
	-- email -> user#@cave.com (where the # increases with ID)
	-- register_date -> random date 
	-- active -> random boolean

delimiter $$
drop procedure if exists populate_users $$
create
	procedure populate_users(
		in count int
	)

	begin
		declare user_num int default 1;

		while user_num <= count do

			insert 
				into random_users(
					email, 
					register_date,
					active
				)


				values (
					concat('user', user_num, '@cave.com'), 
					date(now()) - interval floor(rand() * 10000) day,
					round(rand())
				);

			set user_num := user_num + 1;

		end while;
	end$$
delimiter ;

call populate_users(200);


-- ---------------------------------
-- CURSORS
-- ---------------------------------

/*
 *a cursor is a way of fetching results from a table we could use a counter to
 *iterate through the row and select each row... but this would be like writing a
 *list, looking at item 1, then putting the list down, picking it up, looking
 *past item 1 to item 2 then putting it down, picking it up... etc
 */

delimiter $$
drop procedure if exists cursortest$$
create procedure cursortest()
begin
	-- variable to store the results
	declare the_email varchar(40) default null;


	-- first, delcare the cursor and what query it will be used for
	declare cursor1 cursor for 
		-- this is the cursor's query
		select email 
			from random_users
			order by id desc;


	-- then open the cursor
	open cursor1;
		-- fetch the data into the variable that we declared
		fetch cursor1 
		into the_email;

	-- and close the cursor - notice that it's not a begin end; - it's
	-- open; close;
	close cursor1;


	-- select the results to see that they work
	select the_email;

end$$
delimiter ;

/*select * from random_users limit 10;*/
call cursortest();


-- ---------------------------------
-- FETCHING CURSOR DATA IN A LOOP
-- ---------------------------------

/*
 *mysql cursors are 
 *
 *        asensitive - they don't store a copy of the data, they look at it in
 *        real time 
 *
 *        unidirectional - you can't rewind them, you can only step
 *        through one row at a time
 */


/*
 *say we want all the users who are active and have been around more than a year,
 *the query will look like this
 */
select email 
	from random_users 
	where active = true 
	and register_date > date(now() - interval 1 year);

/*
 *so, we can put this in a procedure and populate the resulting 'leads' into a
 *new table - first, let's create the leads table
 */

drop table if exists leads;
create table leads(
	id int primary key auto_increment,
	email varchar(50) unique not null
);


delimiter $$
drop procedure if exists cursortest$$

create procedure cursortest()
begin
	-- ---------------------------------------------
	-- FIRST DECLARE VARIABLES CURSORS AND HANDLERS
	-- ---------------------------------------------

	declare the_email varchar(50);

	-- this will provide the loop's exit condition
	declare finished boolean default false;

	-- and here is the query
	declare cursor1 cursor for
		select email
			from random_users
			where active = true
			and register_date > date(now() - interval 1 year);

	-- when we don't find any more matching emails, we are finished
	declare continue handler for not found 
		set finished := true;


	-- ---------------------------------------------
	-- NEXT OPEN THE CURSOR AND RUN THROUGH THE LOOP
	-- ---------------------------------------------
	delete from leads;

	open cursor1;
	-- so, this is the labelled loop
	the_loop: loop


		-- the handler will set finshed = true here
		fetch cursor1 into the_email;

		-- exit condition must be after fetching the email
		if finished then
			leave the_loop;
		end if;

		-- so, if we fetch the next email, and it isn't null then insert it
		insert into leads(email)
			values (the_email);
	
	end loop the_loop;

	close cursor1;
end$$
delimiter ;

call cursortest();
select * from leads;


-- ---------------------------------
-- THE CASE EXPRESSION
-- ---------------------------------



/*
 *so, the problem is to take all the entries in the products table and filter
 *them into their respective tables based on their categories

 *we can do this the old way with something like this that runs through if
 *statements
 */

-- first build the tables
drop table if exists products, fruits, vegetables, bakery;
create table products(id int primary key auto_increment, product varchar(40) not null, category enum('bakery', 'fruit', 'vegetable'));
insert into products (product, category) 
	values 
	('cat treats', null), 
	('carrots', 'vegetable'),
	('orange', 'fruit'),
	('banana', 'fruit'),
	('maple bread', 'bakery'),
	('potatoes', 'vegetable');

create table fruits(id int primary key, product varchar(40) not null);
create table vegetables(id int primary key, product varchar(40) not null);
create table bakery(id int primary key, product varchar(40) not null);

-- and here is the procedure using the old syntax
drop procedure if exists sortproducts;
delimiter $$
create procedure sortproducts()
begin
	declare finished boolean default false;
	declare current_product varchar(50);
	declare current_category varchar(50);
	declare current_id int;

	-- we want to sort products and id's based on categories (we need all three)
	declare cursor1 cursor for
		select 
			product, 
			id,
			category
		from products;
	
	-- this will give the exit condition for the labelled loop
	-- we could also use count(*) and a while loop
	declare continue handler for not found
		set finished := true;

	open cursor1;

	-- open the loop
	sort_loop: loop

		fetch cursor1 
			into 
				-- save the current info into local variables
				current_product,
				current_id,
				current_category;

		-- after fetching the data, let's see if we're done yet
		if finished then
			leave sort_loop;
		end if;
		
		-- then filter vegetables into vegetable
		if current_category = 'vegetable' then
			insert 
				into vegetables(id, product)
				values (current_id, current_product);
		end if;

		if current_category = 'bakery' then
			insert 
				into bakery(id, product)
				values (current_id, current_product);
		end if;

		if current_category = 'fruit' then
			insert 
				into fruits(id, product)
				values (current_id, current_product);
		end if;

		
	end loop sort_loop;
	close cursor1;


end$$
delimiter ;

select * from products;
call sortproducts();
select * from vegetables;
select * from fruits;
select * from bakery;



/*
 *but, there is a better way to do this using the case expression!
 */

drop table if exists fruits, vegetables, bakery;
create table fruits(id int primary key, product varchar(40) not null);
create table vegetables(id int primary key, product varchar(40) not null);
create table bakery(id int primary key, product varchar(40) not null);

drop procedure if exists filltables;
delimiter $$
create procedure filltables(out unassigned longtext)
begin
	declare finished boolean default false;

	declare current_id int;
	declare current_product varchar(50);
	declare current_category varchar(50);

	-- we want to sort products and id's based on categories (we need all three)
	declare cur cursor for
		select 
			id,
			product, 
			category
		from products;
	
	-- this will give the exit condition for the labelled loop
	-- we could also use count(*) and a while loop
	declare continue handler for not found
		set finished := true;


	-- we need to initialize the out param so that it's not null
	set unassigned := '';

	open cur;

	-- open the loop
	sort_loop: loop

		fetch cur into 
				-- save the current info into local variables
				current_id,
				current_product,
				current_category;


		-- after fetching the data, let's see if we're done yet
		if finished then
			leave sort_loop;
		end if;


		case current_category
			when 'fruit' then
				insert into fruits(id, product)
				values (current_id, current_product);
			when 'vegetable' then
				insert into vegetables(id, product)
				values (current_id, current_product);
			when 'bakery' then
				insert into bakery(id, product)
				values (current_id, current_product);
			else
				set unassigned := concat(unassigned, current_product, ', ');
		end case;
		

	end loop sort_loop;


	close cur;
end$$
delimiter ;

call filltables(@unassigned);
select * from fruits;
select @unassigned;


-- ---------------------------------
-- VARIABLE SCOPE AND MULTIPLE CURSORS
-- ---------------------------------

-- local variables are available within their begin / end block
-- it is best practice to only have variables available when they're needed

/*
 *delimiter $$
 *create procedure cursortest()
 *-- we can declare as many begin / end blocks in the procedure as we want!
 *begin
 *        -- variables here available until end of proc
 *
 *        begin
 *                -- variables here available here only
 *        end;
 *
 *        begin
 *                -- variables here available here only
 *        end;
 *
 *
 *
 *
 *end$$
 *delimiter ;
 */


update accounts
	set balance =
	case id
		when 1 
			then balance +1
		else balance + 3
	end;


select * from accounts;


delimiter $$
drop procedure if exists trailingcomma$$



-- let's write a procedure to remove that pesky trailing comma!
create procedure trailingcomma()
	begin
		-- variables and stuff
		declare commadelimited varchar(50);
		declare cur_id varchar(50);
		declare finished bool default false;
		declare cur cursor for
			-- it is really hard to dynamically define a table in mysql
			select id from accounts;
		declare continue handler for not found
			set finished := true;


		set commadelimited := '';


		-- using the cursor to add and then pop the comma
		open cur;
		cur_loop: loop
			-- fetch and store location, we could cast cur as char to be safe
			fetch cur into cur_id;
			-- exit condition will pop last comma
			if finished then
				set commadelimited := left(commadelimited, char_length(commadelimited) - 1);
				leave cur_loop;
			end if;
			-- add commas in until you finish
			set commadelimited := concat(commadelimited, cur_id, ',');
		end loop cur_loop;
		close cur;


		-- check the results
		select commadelimited;

	end$$


delimiter ;

-- and making sure it works
call trailingcomma();


-- here is a procedure to transpose text
drop procedure if exists texttranspose;
delimiter $$


create 
	procedure texttranspose(
		in word varchar(50),
		out transposed_word varchar(50)
	)


	begin
		declare word_length int;
		declare counter int;


		-- initializing to a newline makes display prettier in my pager
		set transposed_word := '\n';
		-- the char_length function is super userful!
		set word_length := char_length(word);
		set counter := 0;


		while counter < word_length do
			set counter := counter + 1;

			set transposed_word := concat(
				transposed_word,
				substring(word, counter, 1),
				'\n'
			);
		end while;
	end$$


delimiter ;

call texttranspose('capone', @transpose);
select @transpose;
