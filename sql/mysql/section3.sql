-- --------------------------------
-- EXPORT AND IMPORT
-- --------------------------------
-- NOTE THAT YOU NEED TO SPECIFY THE DEFAULT TARGET SCHEMA FOR AN IMPORT
-- it's super easy with mysql workbench

-- or, using the command line with this command!
-- ./mysqldump -uroot -p -hlocalhost DBname > ~/path/to/command_line_export.sql


-- and then to import do:
	-- mysql -u root -hlocalhost DBNAME < ~/path/to/command_line_export.sql
-- if you get an error, you may need to create the database DBNAME before trying to import

-- now let's use some sample data!
-- drop table if exists users;

-- this is the structure
-- create table users(
	-- id int primary key auto_increment,
	-- name text,
	-- age int
-- );

-- use this file
-- mysql -uroot -p tutorial1 < /home/jp/kod/udemy/sql/mysql/015-Some-Test-Data.sql.txt

-- and make sure it worked
select * from users;
