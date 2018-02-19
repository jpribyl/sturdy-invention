-- ------------------------------
-- COMPARISON OPERATORS
-- ------------------------------

-- easy to google mysql operators
select count(*) from users;

-- for example
select * from users where age < 36;

-- like workes the same as it does in psql
-- seems like basically all of them are the same

-- let's see if we can cast the ints to a string
select * from users where age like '%0';
select * from users where id like '%0';


-- ------------------------------
-- LOGICAL OPERATORS
-- ------------------------------
-- looks like || is a logical OR in mySQL and not a "combine strings"

-- mysql does ILIKE by default - thk god
select * from users where age > 30 and name like 'bob';

select * from users 
	where 
		age > 50 || 
		name like 'bob' or 
		age < 20;

-- mysql respects order of operations with parentheses


-- ------------------------------
-- XOR
-- ------------------------------

select *
	from users
	where age < 30 or age < 30;

-- an odd number of xor conditions will return things! sort of a !! situation
select *
	from users
	where age < 30 xor age < 30;

select *
	from users
	where age < 30 xor age < 30 xor age < 30;

-- xor will throw out null values IE
select * from users where age < 30 or name = 'Bob';
select * from users where age < 30 xor name = 'Bob';
