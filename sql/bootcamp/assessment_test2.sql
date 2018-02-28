--picking out the tables that contain a given column
--this is useful any time you're working with a new DB

/*
select 
	table_name

	from 
		information_schema.columns
	where 
		column_name = 'bookid';
*/


-------------------------------
--ASSESSMENT TEST 2
-------------------------------

--first, you need the exercises_assessment_test_2.tar file
--it has a new DB to load into pgadmin!

--1. retrieve all information from cd.facilities table:
select 
	*
	from cd.facilities;

--2. print a list of the facilities and their costs to members
select 
	name,
	membercost

	from 
		cd.facilities;

--3. make a list of facilities that charge members (IE have a non-zero cost)
select 
	name,
	membercost 

	from 
		cd.facilities 
	
	where
		membercost > 0;

--4 make a list of facilities that charge a member fee which is less than 1/50th maintenance costs
select 
	facid,
	name,
	membercost,
	monthlymaintenance

	from 
		cd.facilities 
	
	where 
		membercost > 0 
	and
		membercost < (1.0 / 50.0) * monthlymaintenance;
		
--5. make a list of facilities with 'Tennis' in their name
select 
	facid,
	name 

	from 
		cd.facilities 

	where
		name ilike '%tennis%';

--6. get the facilities with ID 1 or 5 without using OR
select 
	* 

	from 
		cd.facilities 

	where 
		facid in (1,5);

--7. get a list of members who joined after the beginning of september 2012
select 
	memid,
	surname,
	firstname,
	joindate

	from 
		cd.members

	where 
		joindate > '2012-09-01';

--8. get an ordered list of the first 10 unique surnames in the members table
select distinct
	surname 

	from 
		cd.members 
	
	order by 
		surname

	limit 10;

--9. get the most recent signup date
select 
	joindate  as latest_joindate

	from 
		cd.members 

	order by 
		joindate
	
	limit 1;

--10. get a count of the number of facilities with costs to guests of $10 or more
select 
	count(facid) 

	from 
		cd.facilities
	
	where 
		guestcost > 10;

--11. apparently there is no question 11?

--12. get a list of the total number of slots booked per facility in september 2012
--include facid and slots - sort by the number slots
select 
	facid,	
	sum(slots) as total_slots
	
	from 
		cd.bookings

	where 
		extract(month from starttime) = 9
	
	group by 
		facid

	order by 
		total_slots desc;

--13. make a list of facilities with more than 1000 slots booked
--include facid, total slots, and sort by facid

select 
	facid,
	sum(slots) as total_slots

	from 
		cd.bookings 

	group by 
		facid 

	having 
		sum(slots) > 1000 
	
	order by facid;

--14. make a list of start times for tennis court bookings on '2012-09-21'
--include start time, fac name pairings, and order by time
select 
	--cast timestamp to a time!
	a.starttime :: time,
	b.name

	from 
		cd.bookings as a
	
	join 
		cd.facilities as b
	
	on 
		a.facid = b.facid

	where 
		--cast the timestamp to a date!
		a.starttime :: date = '2012-09-21'
	and 
		b.name like 'Tennis C%'
		
	order by 
		a.starttime;

--15. get a list for all start times made by 'David Farrell'
select 
	a.starttime as david_farrell_start_times
	-- a.memid,
	-- b.firstname,
	-- b.surname
	
	from 
		cd.bookings as a	

	join 
		cd.members as b 

	on 
		a.memid = b.memid
	
	where 
		b.firstname || b.surname = 'DavidFarrell';

