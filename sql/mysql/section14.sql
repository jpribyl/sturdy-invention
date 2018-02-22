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
