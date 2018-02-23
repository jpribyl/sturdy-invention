-- -----------------------------
-- STRING FUNCTIONS
-- -----------------------------

-- concat is one of the most useful string functions 
-- it works like the || does in postgres
select 
	concat('Title: ', name) 
	from book;

-- concat is a function that takes in parameters and does a thing to them!
select concat('My', ' name ', 'is', ' john') as concatenation;

-- ucase and lcase do what you would want them to do
select ucase(concat('My', ' name ', 'is', ' john')) as upper_case_concat;
select lcase(concat('My', ' name ', 'is', ' john')) as lower_case_concat;


-- we can also select the left or rightmost characters
select left(concat('My', ' name ', 'is', ' john'), 4) as left_most_letter;

-- or we can strip spaces off with trim
select left(concat('    My', ' name ', 'is', ' john'), 4) as no_trim;
select left(trim(concat('    My', ' name ', 'is', ' john')), 4) as trim_off_space;

-- we can create substrings using substr this will hack off everything on
-- either side - in python substr(@greeting, 7,4) would be like
-- greeting[7:11]
set @greeting= 'hello there, hows it going?';
select substr(@greeting, 7,4);

-- -----------------------------
-- DATE AND TIME FUNCTIONS
-- -----------------------------
drop table if exists dates;

create table dates(
	id int primary key auto_increment,
	dates date not null
);

select curdate();

insert 
	into dates(dates)
	values (curdate());

-- -----------------------------
-- DATES INTERVALS AND QUERIES
-- -----------------------------
insert 
	into dates(dates)
	values (curdate());

select * from dates;


/*we can add or subtract from the current date*/
select curdate() - interval 16 day;
select curdate() - interval 16 year - interval 10 day as someday;

select 
	* 

	from dates 
	where dates > '2016-01-01';

-- -----------------------------
-- DATE DIFF AND DAYNAME
-- -----------------------------

/*we can also use the day, month, year, etc functions*/
select
	id,
	day(dates) as days

	from dates;

/*let's see what day of the week I was born on!*/
set @born = '1993-06-19';
select
	dayname(@born);

/*we can also select the number of days have passed since my birth and format
 * it using the from_days function*/
select 
	datediff(curdate(), @born) as days_since_birth,
	from_days(datediff(curdate(), @born)) as y_m_d;

 
-- -----------------------------
-- STR_TO_DATE AND DATE FORMAT
-- -----------------------------

/*str_to_date can examine a string and pull out the date from it. we need to
 * specify the format using the mysql standards found online*/
select 
	str_to_date('06/19/1993', '%m/%d/%Y');

/*the function won't ignore random characters.. but you can tell it to ignore
 * things specifically*/
/*once it's been converted, we get the full power of datetime formats*/

select 
	str_to_date('06zyx/19/1993', '%mzyx/%d/%Y');


/*we can easily reformat dates.. note that this is also an alternative to the
 * dayname() function*/
select 
	date_format('2015-02-27', '%a, %M %d \'%y');


-- -----------------------------
-- CONTROL FLOW FUNCTIONS
-- -----------------------------


