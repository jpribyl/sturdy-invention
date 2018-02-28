-- -----------------------------
-- CREATING VIEWS
-- -----------------------------

-- less efficient than using the db itself! so use them sparingly creating a
-- view will make a sort of fake table that you can query on!  if the query
-- used to create a view contains a join, often you can't update the view.

-- also, you may not be able to do an insert on a view! IE if there is a not
-- null column not included on the view

drop view if exists bookview;
create view bookview as
	select 
		id, 
		name 
		from book
;


select * from bookview;
select * from book;



-- -----------------------------
-- VIEW ALGORITHMS
-- -----------------------------

-- views are most useful for shortening long queries
use online_shop;
show tables;

drop view if exists customer_sales1;
drop view if exists customer_sales2;
drop view if exists customer_sales3;

-- there are two ways to implement a view in mysql
create view customer_sales1 as 
	select
		b.id as customer_id,
		a.sold_at

		from sales a

		join customers b
		on b.id = a.customer_id
;	


-- this will combine your query when you select X from customer_sales2 with the
-- query used to create customer_sales2 whenever they're executed. this is the
-- most efficient way to create a view!
create algorithm=merge
view customer_sales2 as 
	select
		b.id as customer_id,
		a.sold_at

		from sales a

		join customers b
		on b.id = a.customer_id
;	

-- we can also create a temporary table that holds the results in a 'minitable'
-- this is less efficient and guarantees that you can't update the tables. the
-- temp table must be recreated every time you run the query. However, this
-- type of view can handle some things that the previous one can't - IE
-- aggregate / group by type of functions.

create algorithm=temptable
view customer_sales3 as 
	select
		b.id as customer_id,
		a.sold_at

		from sales a

		join customers b
		on b.id = a.customer_id
;	

-- or you can let mysql do it all by itself! generally this is fine, but if you
-- are very concerned with efficiency then you can specify the merge algorithm
create algorithm=undefined
view customer_sales3 as 
	select
		b.id as customer_id,
		a.sold_at

		from sales a

		join customers b
		on b.id = a.customer_id
;	

-- we can see that all 3 views return the same thing!
select * from customer_sales1;
select * from customer_sales2;
select * from customer_sales3;


-- -----------------------------
-- WITH CHECK OPTION
-- -----------------------------

-- let's make an option that only shows some of the books in the library!
use tutorial1;

drop view if exists bookview;

-- we are allowed to insert books which will not actually appear to the view
create algorithm=merge view bookview as
	select 
		id, 
		name 

	from book 
	where id < 10
;

select * from bookview;
delete from bookview where id = 11;
insert into bookview(id, name) values(11, 'old man and the sea');
select * from bookview;
select * from book;


-- if we specify with check option, then the view will not allow insertion of
-- items which would not appear to the view
create algorithm=merge view bookview1 as
	select 
		id, 
		name 

	from book 
	where id < 10
	with check option
;


select * from bookview1;
delete from bookview1 where id = 11;
insert into bookview1(id, name) values(15, 'Wuthering Heights');
select * from bookview1;
select * from book;
