-- ---------------------------------
-- INTRODUCING TRIGGERS
-- ---------------------------------

/*
 *triggers are similar to stored procedures, except that they are run
 *automatically depeding upon some condition
 */

/*
 *for example, let's say that you have a table for sales and you want to know
 *        whenever someone wants to change the sales table
 */

drop table if exists sales;
drop table if exists sales_update;
create table sales(
	id int primary key,
	product varchar(30) not null,
	value numeric(10,2)
);

insert 
	into sales(id, product, value)
	values 
		(1, 'melon', 1.20),
		(2, 'cake', .80);


create table sales_update(
	id int primary key auto_increment,
	product_id int not null,
	changed_at timestamp,
	before_value numeric(10,2) not null,
	after_value numeric(10,2) not null
);


-- it will be useful to change the delimiter for triggers as well
delimiter $$

-- we need to choose an event and whether it will run before or after event
-- this is the naming convention
create trigger before_sales_update
	-- this tells the trigger what it's going to do and when
	before 
		update on sales 
	for 
		each row


begin
	insert 
		into sales_update(product_id, changed_at, before_value, after_value)
		-- old refers to the sales table id
		values 
			(old.id, now(), old.value, new.value);
end$$


delimiter ;

-- now let's see if it works!
select * from sales;
update sales
	set value = 1.23
	where id = 1;

update sales
	set value = 5.23
	where id = 2;

select * from sales;

-- magic!
select * from sales_update;


-- ---------------------------------
-- VALIDATING WITH TRIGGERS
-- ---------------------------------

-- note, if you drop a table the associated triggers are also dropped
drop table if exists trigger_products;
create table trigger_products(
	id int primary key auto_increment,
	value numeric(10,2) not null
);


select * from trigger_products;

-- let's say there's a cap of $100.00 on the value of products, we can prevent insertion
delimiter $$
create trigger before_products_insert
	before insert on trigger_products
	for each row

begin
	if new.value > 100.0 then
		set new.value := 100.0;
	end if;
end$$


-- and similarly prevent updates
create trigger before_products_update
	before update on trigger_products
	for each row

begin
	if new.value > 100.0 then
		set new.value := 100.0;
	end if;
end$$
delimiter ;


-- testing it, we find that it works
insert 
	into trigger_products(value)
	values 
		(99.9),
		(103),
		(65);

select * from trigger_products;

update trigger_products
	set value = 102
	where id = 1;

select * from trigger_products;


-- ---------------------------------
-- TRIGGERS AND TRANSACTIONS
-- ---------------------------------

/*
 *let's say that we want to create a trigger which will automatically total up
 *all the sales for a day
 */

drop table if exists sales, sales_total;
create table sales(
	id int primary key auto_increment,
	product varchar(45) not null,
	sold numeric(10,2) not null
);

create table sales_total(
	id int primary key auto_increment,
	total numeric(11,2) not null,
	sold_on date
);

-- prevent accidentally winding up with more than one entry for a day
alter table  sales_total add unique (sold_on);



delimiter $$
create trigger before_sales_insert
	before insert on sales
	for each row
begin
	declare count int default 0;

	-- if we run the trigger right before midnight, we don't want to break things!
	declare today date default date(now());
	select 
		count(*) 
		from sales_total 
		where sold_on = today 
		into count
		-- innodb runs triggers within a transaction by default!
		-- we won't lock the whole table because sold_on is unique (IE Index)
		for update;
	
	-- if today doesn't have a row yet, we need to create it
	if count = 0 then
		insert 
			into sales_total(total, sold_on)
			values (new.sold, today);

	-- if it does have a row, then we need to update it
	else
		update
			sales_total

			set total = total + new.sold
			where sold_on = today;
	end if;

-- innodb also commits at the end by default
/*commit;*/
end$$

insert 
	into sales(product, sold)
	values 
		('dog leash', 5.20),
		('dog leash deluxe', 10.20),
		('dog leash', 5.20);

select * from sales;
select * from sales_total;
