-- ---------------------------
-- SELECT DISTINCT
-- ---------------------------

-- works the same as psql

-- remember that distinct goes inside the count function
-- select distinct name from users;
-- select count(distinct name) from users;


-- ---------------------------
-- AGGREGATE FUNCTIONS
-- ---------------------------
-- these are also essentially identical to psql
-- min, max, avg, etc


-- ---------------------------
-- ARITHMETIC
-- ---------------------------

-- we can do simple arithmetic with myslq 
-- select 8/9, 8+9;

-- not useful on its own, but could be nice to... say add 10 to the age of all
-- users

-- say we want to find the average without using avg()
-- select sum(age) / count(*) from users;
-- select avg(age) from users;


-- ---------------------------
-- HEALTH SURVEY DATASET
-- ---------------------------

select 
	gender, 
	avg(weight) 

	from survey 
	group by gender
;

select
	country,
	count(*) as survey_responders,
	avg(smoke) as average_smoke

	from survey
	group by country

	order by average_smoke desc, survey_responders asc
;

select
	country,
	count(*),
	avg(smoke)

	from survey
	where weight > 80

	group by country
	order by avg(smoke)
;

select
	country,
	round(avg(weight), 0)

	from survey
	group by country
	order by avg(weight) desc
;


-- ---------------------------
-- HAVING ETC
-- ---------------------------

-- this is also extremely similar to psql

select 
	country,
	count(*) num_responses,
	round(avg(age),0) as avg_age

	from survey
	group by country

	having avg(age) > 40
;


