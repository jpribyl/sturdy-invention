-- Online shop

-- Use foreign keys
-- Keep it fairly simple (unless you really want to get stuck into it)

-- — List these things:
-- product
-- product categories
-- customers
-- record all sales including time of sale
-- Don't use enum for any potentially long lists, like products or categories

-- Write a join query that lists all the sales and all associated information
-- Create some join queries that retrieve other information; whatever you can think up (e.g a list of products by number of sales, top selling product first)
drop table if exists sales;
drop table if exists products;
drop table if exists categories;
drop table if exists customers;

create table customers(
	id int primary key auto_increment,
	firstname varchar(25) not null,
	lastname varchar(25) not null,
	email varchar(100) default null
);

create table categories(
	id int primary key auto_increment,
	catname varchar(50)
);

	
create table products(
	id int primary key auto_increment,
	prodname varchar(50) not null,
	category_id int not null,
	price decimal(7,2) not null,
	foreign key (category_id) references categories(id)
);

create table sales(
	id int primary key auto_increment,
	sold_at datetime default now(),
	sale_price decimal(7,2),
	product_id int not null,
	customer_id int not null,
	foreign key (product_id) references products(id),
	foreign key (customer_id) references customers(id)
);

insert 
	into customers(firstname, lastname, email)
	values ('Bob', 'Ross', 'bob@ross.com')
;

insert
	into categories(catname)
	values ('Food')
;

insert 
	into products(prodname, category_id, price)
	values ('Carrots', 1, 8)
;

insert 
	into sales(sale_price, product_id, customer_id)
	values (52, 1, 1)
;

select 
	b.prodname,
	a.sale_price,
	a.sold_at,
	c.firstname,
	c.lastname
	
	from sales a

	join products b
	on a.product_id = b.id

	join customers c
	on a.customer_id = c.id
;
