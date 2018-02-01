-------------------------
--LECTURE AS
-------------------------

--as adds an alias
select payment_id as my_payments
	from payment
	limit 5;

select customer_id, sum(amount) as total_spent
	from payment 
	group by customer_id
	limit 5;


-------------------------
--LECTURE INNER JOIN
-------------------------

--inner, outer, and self joins are a thing
--for each row in main table, psql scans second table
--and checks if there is a match on the condition
--it is the overlapping section on a vinn diagram

select a.customer_id,
	a.first_name,
	a.last_name,
	a.email,

	b.amount,
	b.payment_date
	from customer as a
	inner join payment as b
	on a.customer_id = b.customer_id
	order by a.customer_id
	limit 10;


-------------------------
--LECTURE EXAMPLES OF INNER JOINS
-------------------------

--you don't have to specify table if it only shows up in one
--but, doing so loses readibility
select title, count(title)
	from inventory
	inner join film 
	on inventory.film_id = film.film_id
	where store_id = 1
	group by title
	limit 10;

select a.title,
	b.name
	from film as a
	inner join language as b
	on b.language_id = a.language_id
	limit 10;

--inner join and join are actually the same type of join!
--also, you don't actually need the 'as' - a ' ' also works
select a.title,
	b.name
	from film a
	join language b
	on b.language_id = a.language_id
	limit 10;


-------------------------
--LECTURE OUTER JOIN EXAMPLES
-------------------------


--find all the films that we do not have in inventory
--IE all the film id's that correspond to a null inventory id
--OR all the film id's that do not show up in the inventory table
select  a.film_id,
	a.title,
	b.inventory_id
	from film as a
	left outer join inventory as b
	on b.film_id = a.film_id
	where b.film_id is null;

select a.film_id,
	a.title,
	b.inventory_id 
	from film as a
	left outer join inventory as b
	on b.film_id = a.film_id 
	where b.inventory_id is null
	order by title;


-------------------------
--LECTURE UNION
-------------------------
-- unions require the same number of columns and the same data type
-- they basically tack one query underneath another!
