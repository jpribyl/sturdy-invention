----------------------------------
--LECTURE TIMESTAMPS AND EXTRACTS
----------------------------------

--to get documentation on units just google psql datetime
--we can do things like extract the day
select extract(day from payment_date)
	from payment
	limit 5;

--exctract customer's and the payment dates
select customer_id, extract(day from payment_date) as day
	from payment
	limit 5;

--extracting the most profitable months
select sum(amount) as total, extract(month from payment_date) as month
	from payment
	group by month
	order by total desc
	limit 5;


----------------------------------
--LECTURE MATH FUNCTIONS
----------------------------------

--you can add things! yay
select customer_id + rental_id as sums
	from payment
	limit 5;

select round(avg(amount), 2)
	from payment; 


----------------------------------
--LECTURE STRING FUNCTIONS AND OPERATORS
----------------------------------

--don't be afraid to check the docs on this, there are tons of examples
--it also supports regex searching and replacing
select first_name || ' ' || last_name as full_name
	from customer
	limit 5;


select lower(first_name), char_length(first_name)
	from customer
	limit 5;



----------------------------------
--LECTURE SUBQUERY
----------------------------------

-- this is a query within a query 
-- query-ception

--let's say we want all the movies that rent above the avg rental rate
--first, let's do it the long way
select avg(rental_rate)
	from film;


select 	title, rental_rate
	from film 
	where rental_rate > 2.98
	limit 5;

--now let's do it with a subquery
--you can make subqueries by putting them in brackets
select film_id,
	title,
       	rental_rate 
	from film 
	where rental_rate > (select avg(rental_rate) from film)
	limit 5;


--let's find the titles of movies that were returned on a given date!
select title 
	from film
	where film_id in

		(select b.film_id 
		from rental as a
		inner join inventory as b
		on b.inventory_id = a.rental_id 
		where a.return_date between '2005-05-29' and '2005-05-30')

	limit 5;


----------------------------------
--LECTURE SELF JOIN
----------------------------------

--always use aliases when you're doing a self join!
select 
	a.customer_id,
	a.first_name, 
	a.last_name,
	b.first_name,
	b.last_name 

	from
		customer as a,
		customer as b

	where 
		a.first_name = b.last_name

	order by 
		a.first_name;


--or, you can do a self join as a join!
select 
	a.customer_id,
	a.first_name, 
	a.last_name,
	b.first_name,
	b.last_name 

	from
		customer as a
	join
		customer as b

	on 
		a.first_name = b.last_name

	order by 
		a.first_name;


--what if you wanted a left self join? that's fine!
select 
	a.customer_id,
	a.first_name, 
	a.last_name,
	b.first_name,
	b.last_name 

	from
		customer as a
	left join
		customer as b

	on 
		a.first_name = b.last_name

	order by 
		a.first_name 
	
	limit 5;

--check out manager employee self join interview question!

--lil bobby tables :(
drop table employee;
create table employee(
	id INT PRIMARY KEY, 
	name TEXT,
	manager_id INT
);

INSERT INTO employee VALUES(101,'Mary',102);
INSERT INTO employee VALUES(102,'Ravi',NULL);
INSERT INTO employee VALUES(103,'Raj',102);
INSERT INTO employee VALUES(104,'Pete',103);
INSERT INTO employee VALUES(105,'Prasad',103);
INSERT INTO employee VALUES(106,'Ben',103);

select 
	a.name as employee,
	b.name as manager 

	from 
		employee as a

	--left join ensures that we include anyone without a manager in the table
	left join 
		employee as b

	on 
		a.manager_id = b.id;
