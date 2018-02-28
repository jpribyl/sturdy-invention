-------------------------
-- Assignment 1
-------------------------

/*
Return the customer IDs of customers who have spent at
least $110 with the staff member who has an ID of 2
*/

select customer_id, staff_id, sum(amount)
	from payment
	where staff_id = 2
	group by staff_id, customer_id
	having sum(amount) >= 110;


--How many films begin with the letter J?

select count(distinct(title))
	from film 
	where title like 'J%';

/*
What customer has the highest customer ID number whose name
starts with an 'E' and has an address ID lower than 500?
*/

select customer_id, first_name, last_name
	from customer 
	where first_name like 'E%'
	and address_id < 500
	order by customer_id desc
	limit 1;
