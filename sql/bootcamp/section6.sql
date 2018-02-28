-------------------------
--LECTURE MIN MAX AVG SUM Aggregate
-------------------------

-- combines many rows of data into a single value
select round(avg(amount), 2)
	from payment;


select round(min(amount), 2)
	from payment;


select count(amount)
	from payment
	where amount = 0;

select round(sum(amount), 2)
	from payment;

-------------------------
--LECTURE GROUP BY
-------------------------

select customer_id
	from payment 
	group by customer_id
	limit 10;

select customer_id, sum(amount) as total
	from payment 
	group by customer_id
	order by total desc
	limit 10;

select staff_id, count(*)
	from payment 
	group by staff_id;

select rating, count(rating)
	from film
	group by rating;

select rental_duration, count(rental_duration)
	from film 
	group by rental_duration;

select rating, avg(rental_rate)
	from film 
	group by rating;


-------------------------
--CHALLENGE GROUP BY
-------------------------

--2 staff members, want to give a bonus to the staff who handled the most payments

select table_name
	from information_schema.columns
	where column_name = 'staff_id';

select staff_id, sum(amount), count(payment_id)
	from payment
	group by staff_id
	order by count desc,
	sum;


--corporate wants to know the average replacement cost of movies by rating
select table_name
	from information_schema.columns
	where column_name = 'replacement_cost';

select rating, round(avg(replacement_cost), 2)
	from film 
	group by rating;


-- send coupons to the top 5 spenders at the store
select customer_id, sum(amount) as total
	from payment
	group by customer_id
	order by total desc
       	limit 5;


-------------------------
--LECTURE HAVING
-------------------------

--like where, except after a group by instead of before it
select customer_id, sum(amount)
	from payment 
	group by customer_id
	having sum(amount) > 200
	limit 5;

select store_id, count(customer_id)
	from customer 
	group by store_id 
	having count(customer_id) > 300;

-- you can use both where and having in one query
select rating, round(avg(rental_rate), 2) from film 
	where rating in('R','G','PG')
	group by rating
	having avg(rental_rate) < 3;

-------------------------
--CHALLENGE HAVING
-------------------------
--which customers are eligible for platinum credit cards?
--reqs: 40+ transaction payments

select customer_id, count(payment_id)
	from payment
	group by customer_id
	having count(payment_id) >= 40;

--what movie ratings are rented for longer than 5 days?
-- select table_name 
	-- from information_schema.columns 
	-- where column_name = 'rental_duration'

select rating, round(avg(rental_duration),1)
	from film
	group by rating
	having avg(rental_duration) > 5;

