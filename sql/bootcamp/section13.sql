-------------------------
-- LECTURE VIEWS
-------------------------

--a view is a virtual table (not actually a copy of data)
--it is a saved query that you can reference later on 
create view customer_info as
	select 
		first_name,
		last_name,
		email,
		address,
		phone 
		
		from customer as a
		join address as b
		on a.address_id = b.address_id

		limit 1;

alter view customer_info 
	rename to customer_master_list;

select email from customer_master_list;


--if you want to remove a view do it like a table
drop view if exists customer_master_list;
