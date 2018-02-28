-------------------------
--CHALLENGES
-------------------------

-- challenge: find all distinct ratings from the films

-- search schema tables for those that contain a column named 'rating'
select table_name
	from information_schema.columns
       	where column_name LIKE 'rating';

-- then, grab the rating of the films
select distinct rating
	from film;

-------------------------
--LECTURE WHERE
-------------------------
select last_name, first_name
	from customer
	where first_name ='Jamie'
	and last_name = 'Rice';

-- select customer_id, amount, payment_date
	-- from payment
	-- where amount <= 1
	-- or amount >= 8;

-- you don't need to include the column you're selecting in the where
select email from customer
	where first_name = 'Jared';

select email from customer 
	where store_id = 1
	and address_id = 5;



-------------------------
--CHALLENGES
-------------------------

-- Oh no! nancy thomas lost her wallet!
select email from customer 
	where first_name = 'Nancy'
	and last_name = 'Thomas';

-- But wait, what about Outlaw Hanky?! What is it about?
select description from film 
	where title = 'Outlaw Hanky';


-- We need to call somebody who lives at 259 Ipoh! Quick! hAlp!
-- first, figure out where the phone number lives
-- select table_name
	-- from information_schema.columns
               -- where column_name LIKE 'phone';

select phone from customer_list 
	where address = '259 Ipoh Drive';

-------------------------
--LECTURE COUNT
-------------------------
select count(*) 
	from payment;

select count(distinct(amount))
	from payment;

-------------------------
--LECTURE LIMIT
-------------------------

--limit goes at the very end of a query
-- select * from customer 
	-- limit 5;


-------------------------
--LECTURE ORDER BY
-------------------------

--psql is FIFO on its sorting, use order by if you don't like this
--it's possible to sort on multiple columns 
--it's possible to order by columns that are not selected in postgreS
	--this won't be possible in other engines
	--best practice to always select columns that you will order by

-- select first_name, last_name
	-- from customer 
	-- order by first_name asc,
	-- last_name desc;


-------------------------
--CHALLENGE
-------------------------

-- Who are the highest payers? just their ID's
 -- select table_name
	-- from information_schema.columns
	-- where column_name LIKE 'amount';

select customer_id, amount from payment 
	order by amount desc
	limit 10;


-- titles of movies with film ID's 1 through 5
select distinct film_id, title from film 
	where film_id <= 5
	order by film_id asc;

--official solution
-- select film_id, title, release_year
	-- from film
	-- order by film_id 
	-- limit 5;



-------------------------
--LECTURE BETWEEN
-------------------------

select customer_id, amount from payment 
	where amount between 8 and 9
	limit 5;


select customer_id, amount from payment 
	where amount not between 8 and 9
	limit 5;

select amount, payment_date from payment 
	where payment_date
        between '2007-02-07' and '2007-02-15';


-------------------------
--LECTURE IN
-------------------------

--they function like linked OR statements
select customer_id, rental_id, return_date
	from rental
	where customer_id in (2,1)
	order by return_date desc;

select * from payment
	where amount in (7.99, 8.99)
	limit 5;


-------------------------
--LECTURE LIKE
-------------------------

--what if you don't remember the exact name of something you want to find?
--a string that contains a % char is a pattern
--the % means any characters
--an _ is a wildcard character and matches any single character

--multicharacter matching with %
select first_name, last_name
	from customer 
	where first_name like 'Jen%'
	limit 3;

select first_name, last_name
	from customer 
	where first_name like '%er%'
	limit 9;

--single character matching with _
select first_name, last_name 
	from customer 
	where first_name like'_her%';

--supports NOT
select first_name, last_name 
	from customer 
	where first_name not like'_her%'
	limit 5;

--use ILIKE for case insensitivity
select first_name, last_name 
	from customer 
	where first_name ilike'je%';


-------------------------
--CHALLENGE (GENERAL)
-------------------------

--How many payment transactions were greater than $5?

select count(amount)
	from payment
	where amount > 5.00;

--How many actors have a first name that begins with P?
select count(*)
	from actor 
	where first_name like ('P%');

--How many unique districts are customers from?
select table_name 
	from information_schema.columns 
	where column_name = 'district';

select count(distinct(district))
	from address;

--Now, what are the districts names?
-- select distinct district
	-- from address;

--how many films have an R rating and replacement cost between $5-15
select count(*)
	from film
	where rating = 'R'
        and replacement_cost between 5 and 15;


--how many films have the word 'Truman' in the title?
select count(*)
	from film
	where title like '%Truman%';


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
--LECTURE LIKE
-------------------------


