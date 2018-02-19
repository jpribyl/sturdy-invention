-- ---------------------------------
-- UPDATE
-- ---------------------------------
-- CRUD is Create Retrieve Update Delete

-- you'll need to set sql_safe_updates=0; to do more than 1 row at a time
-- careful with these.. this will change everyone's name to jim!
-- update users set name = 'Jim';

update users set name = 'Jim' where name = 'Bob';
select * from users;


-- ---------------------------------
-- ORDER BY
-- ---------------------------------
-- just like in psql


-- ---------------------------------
-- LIMIT
-- ---------------------------------
-- also just like in psql
