-- ----------------------------------
-- CREATING USERS
-- ----------------------------------

-- we can create a user with something like this
create user 'john'@'localhost' identified by 'letmein'

-- and then grant all permissions except for grant privileges (IE cant give
-- permissions to other people) by grant 'all' on *.* <-- IE on all tables / DBs
grant all privileges on *.* to 'john'@'localhost'

-- to refresh privilege list
flush privileges


-- more often, we will want to make a user with limited number of privileges
-- instead of just giving all of them. we can see users and privileges with
select * from mysql.user

-- and drop the user with
drop user john@localhost




-- ----------------------------------
-- GRANTING PRIVILEGES
-- ----------------------------------

-- you can grant all sorts of privileges! to get a list, just google mysql
-- privileges here is an example of the syntax:
grant select on online_shop.* to 'john'@'localhost'


