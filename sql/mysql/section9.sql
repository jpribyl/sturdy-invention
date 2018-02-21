-- ----------------------------------------
-- UNION AND UNION ALL
-- ----------------------------------------

select * 
	from person a
	left join address b
	on b.id = a.address_id
;

-- it is generally more efficient to use a union all than a union
-- union has to remove all duplicates which is sloooooow




-- ----------------------------------------
-- USING IN
-- ----------------------------------------
-- this is also the same as in psql
-- you can use IN to create subqueries inside () as well


-- ----------------------------------------
-- INLINE VIEWS
-- ----------------------------------------

-- also the same as psql basically just select x from (select x)
