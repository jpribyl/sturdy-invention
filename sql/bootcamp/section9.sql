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
	from payment 


----------------------------------
--LECTURE STRING FUNCTIONS AND OPERATORS
----------------------------------
