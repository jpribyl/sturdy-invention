-- Create a table of animals that includes a text-type column (e.g. varchar or
	-- text) called "animal_name".
-- Animals
-- primary key
-- animal name
-- (anything else)
drop table if exists animals;
drop table if exists violations;
create table animals(
	id int primary key auto_increment,
	animal_name varchar(50)
);


-- Violations
-- primary key
-- animal name
-- date and time
create table violations(
	id int primary key auto_increment,
	animal_name varchar(50),
	violation_time timestamp
);


-- Create a trigger that prevents you from inserting any animal name containing
-- the word "cat". E.g. "Wildcat", "Housecat", etc.

-- If someone tries to insert any kind of cat, the trigger should insert "xxx"
	-- instead and should log the attempted entry, including the animal name,
	-- in a "violations" table, along with the date and time it occurred.

delimiter $$
create trigger before_animals_insert
	before insert on animals
	for each row


begin
	if new.animal_name like '%cat%' then
		-- this one should come before you set the animal name
		insert
			into violations(animal_name, violation_time)
			values (new.animal_name, now());
		set new.animal_name = 'xxx';
	end if;

end$$
delimiter ;



insert 
	into animals(animal_name)
	values 
		('dog'),
		('wildebeast'),
		('cat'),
		('wildkittycAtthing');


select * from animals;
select * from violations;
