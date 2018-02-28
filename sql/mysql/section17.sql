-- ---------------------------------
-- FUNCTIONS VS PROCEDURES
-- ---------------------------------

-- we know that we can define a procedure that is called with a call procedure()
-- type of syntac we can also use functions like max(1,2,3) functions have one
-- single output while procedures could have many, one, or none

-- in order to define an aggregate function in sql.. you need to use c we can
-- write functions that look at tables and translate rows into a single value so,
-- we can't write something like sum() but we can write something like date()


-- ---------------------------------
-- USER DEFINED FUNCTIONS
-- ---------------------------------

select * from sales;
set @tax = 19;
select sum(sold) * ((100 - @tax) / 100) from sales where id < 4;

delimiter $$
create function sales_after_tax(
	tax float, 
	min_sales_id int, 
	max_sales_id int
) returns numeric(10,2)


begin
	declare result numeric(10,2);

	select sum(sold) * ((100 - @tax) / 100) 
		from sales 
		where id < max_sales_id
		and id > min_sales_id
		into result;

	return result;
end$$

delimiter ;

-- let's test it out!
select sales_after_tax(19, 1, 4); 

-- funcitons are used less than stored procedures, but still useful to know about
