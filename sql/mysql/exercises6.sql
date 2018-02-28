
-- Tips:

-- Order by rand().
-- Will need to use two cursors at one point in these exercise!
-- Build up step by step.
-- Test sql outside of procedure (don't forget to remove @ from variable names)

-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------


-- 1. Manually create a table containing two columns and a primary key, one column
-- a list of nouns and one column a list of adjectives
-- e.g.
-- 1 hot dog
-- 2 fast banana
-- 3 orange cloud
-- 4 charming curtain
-- .....
drop table if exists adj_noun;
create table adj_noun(
	id int primary key auto_increment,
	adj longtext,
	noun longtext
);

insert
	into adj_noun(adj, noun)
	values
		('hot', 'dog'),
		('cold', 'cat'),
		('orange', 'ant'),
		('charming', 'school'),
		('smiling', 'box'),
		('jumping', 'bean'),
		('fast', 'fox'),
		('mild', 'elephant'),
		('frisky', 'bottle'),
		('yellow', 'house'),
		('quick', 'job'),
		('peaceful', 'spoon');


-- Write a procedure that returns data in two "out" variables. One will contain
-- all the nouns joined with commas, the other will contain all the adjectives
-- joined by commas.
drop procedure if exists commavariables;


delimiter $$
create procedure commavariables(
	out outadj longtext,
	out outnoun longtext
)


	begin
		declare finished bool default false;
		declare cur_adj varchar(50);
		declare cur_noun varchar(50);
		declare cur cursor for
			select
				adj,
				noun
				from adj_noun;
		declare continue handler for not found
			set finished := true;


		set outadj := '';
		set outnoun := '';


		open cur;
			comma_loop: loop

				fetch cur into
					cur_adj,
					cur_noun;


				if finished then
					-- pop the trailing commas
					set outadj := substring(outadj, 1, char_length(outadj) - 1);
					set outnoun := substring(outnoun, 1, char_length(outnoun) - 1);
					leave comma_loop;
				end if;


				set outadj := concat(outadj, cur_adj, ',');
				set outnoun := concat(outnoun, cur_noun, ',');
			end loop;
		close cur;

	end$$
delimiter ;
call commavariables(@a, @b);
select @a;
select @b;

-- Optional: modify the procedure so that there is no stray extra comma before or after
-- the start of the lists.

-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------

-- 2. Write a stored procedure that creates a table called "stars" containing a column of type text.
-- Make the procedure populate the table by selecting an adjective at random and
-- a noun at random and joining them together with a space between them.

-- Hot Cloud
-- Charming Dog
-- etc.

-- Optional: upper case the first letters of the two words.
drop procedure if exists star_pop;
drop procedure if exists capitalize;
delimiter $$


-- for readability, it makes sense to use two procedures
-- the first one capitalizes the first letter of any word
create procedure capitalize(
	in inword varchar(50),
	out outword varchar(50)
)


begin
	declare first_letter char(1);
	declare rest_of_word varchar(50);


	set first_letter := upper(left(inword,1));
	set rest_of_word := substring(inword, 2, char_length(inword));
	set outword := concat(first_letter, rest_of_word);
end$$



-- and this one populates the stars table randomly
create procedure star_pop()
begin
	declare finished bool default false;
	declare cur_adj varchar(50);
	declare cur_noun varchar(50);


	-- we need two cursors to walk through each column separately
	declare cur1 cursor for
		select adj 
			from adj_noun
			order by rand();
	declare cur2 cursor for
		select noun
			from adj_noun
			order by rand();
	declare continue handler for not found
		set finished := true;


	-- avoid creating a table that already exists
	drop table if exists stars;
	create table stars(
		id int primary key auto_increment,
		adj_noun text
	);


	open cur1;
	open cur2;
	cur_loop: loop
		fetch cur1 into cur_adj;
		fetch cur2 into cur_noun;


		-- this capitalizes the first letter of each word
		-- and saves it back into the same variable
		call capitalize(cur_adj, cur_adj);
		call capitalize(cur_noun, cur_noun);

		-- exit condition
		if finished then
			leave cur_loop;
		end if;

		-- populate the table
		insert 
			into stars(adj_noun)
			values (concat(cur_adj, ' ', cur_noun));
	end loop;
	close cur2;
	close cur1;

end$$
delimiter ;

call star_pop();
select * from stars;



-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------

-- 3. Modify this procedure so that it create the table with a birth date and death date
-- column. Make the procedure fill in the birth and death dates in the following way.

-- The birth date should be random between 20 and 80 years ago.
-- The death date should be random between 19 years after the birth date and today.

-- 4. Modify this procedure so that the death date is only filled in 40% of the time, at random.
drop procedure if exists birth_death_pop;
delimiter $$
create procedure birth_death_pop(
	in num_people int
)


begin
	declare counter int default 0;
	declare cur_birth date;
	declare cur_death date;
	declare alive bool;


	-- avoid creating a table that already exists
	drop table if exists birth_death;
	create table birth_death(
		id int primary key auto_increment,
		birth date,
		death date
	);


	while counter < num_people do
		set counter := counter + 1;


		/*rand() is between 0 and 1, this will shift it to be between .1
		 *and 1.1. When it is < .5 then alive will be false this will be
		 *true  with a probability of (.5 - .1) / (1.1 - .1) = .4 or, in
		 *other words, the subject is dead 40% of the time*/
		set alive := round(rand() + .1);


		set cur_birth := 
			-- this could also be done with one interval (as in cur_death)
			-- but here, I think it is more clear to use two intervals
			date(now() 
				- interval 20 year
				- interval (365 * 60 * rand()) day
			);


		if alive then
			set cur_death = null;
		else
			set cur_death := 
				cur_birth 
				+ interval 19 year
				+ interval (
					rand() * 
					datediff(date(now()), (cur_birth + interval 19 year))
				) day;
		end if;


		insert 
			into birth_death(birth, death)
			values (cur_birth, cur_death);
	end while;
end$$


delimiter ;
-- let's put some people into the birth_death table
call birth_death_pop(2000);

-- and see what it looks like!
select * from birth_death limit 10;

-- if we put enough people in the table, then we find that there are ~60% of the people with null deaths
set @numalive = (
	select 
		count(*) 
		from birth_death 
		where death is null
	);
select 
	(@numalive / count(*)) * 100 as percent_alive
	from birth_death;


-- we can also verify that no one dies under the age of 19 or after today
select 
	datediff(death, birth) / 365
	from birth_death 
	where (death - birth) / 365 < 19 
	or death > date(now());
