-- 1. Using any table, write a query that produces the following output, querying the number of rows in the table.

-- 'Total: 5 records'

-- Modify the query so that it only adds the "s" to "records" if there is some number of records other than 1. For example:

-- 'Total: 0 records'
-- 'Total: 5 records'
-- 'Total: 1 record'
select 
	if(
		count(*) = 1, 
		concat('Total: ', cast(count(*) as char), ' record'),
		concat('Total: ', cast(count(*) as char), ' records')
		) as record_number

	from person
	where id=9;

-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------


-- 2. Using a table with a date column, format the dates in this format:

-- '31st of January, 2015 (Saturday)'
select
	date_format(dates, '\'%D of %M, %Y (%W)')
	as formatted_dates
	from dates;

-- Set a variable to the value of one of the dates retrieved from this table, in this format.
set @date = (select 
		date_format(dates, '\'%D of %M, %Y (%W)')
		from dates
		limit 1);
select @date;

-- Now format the date contained in the variable back into a date object.
select 
	str_to_date(
		@date, 
		'\'%D of %M, %Y (%W)'
	)
	as date_again;


-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------
-- ---------------------------------------------------------------------


-- 3. The mathematician Kurt Gödel was born on April 28, 1906  and died on January 14, 1978.

-- Set text variables to these dates, in exactly this format.
set @birth = 'April 28, 1906';
set @death = 'January 14, 1978';

-- Answer the following questions.

-- a) On what day of the week was Gödel born, and on what day did he die?

set @birth_date = 
	str_to_date(
		@birth, 
		'%M %d, %Y'
	);

set @death_date =
	str_to_date(
		@death, 
		'%M %d, %Y'
	);

select 
	dayname(
		@birth_date
	) as birth_day,

	dayname(
		@death_date
	) as death_day;


-- b) Exactly how old was Gödel when he died, in years, months and days?
select from_days(
		datediff(@death_date, @birth_date)
	) as y_m_d_format;

-- c) If Gödel had lived to be 99 years, six months and three days old, what
/*date would he have died on? What day of the week is this?*/

set @hypo_death = 
(select 
	@birth_date + 
	interval 99 year +
	interval 6 month + 
	interval 3 day);

select @hypo_death;
select dayname(@hypo_death) as hypo_day;


