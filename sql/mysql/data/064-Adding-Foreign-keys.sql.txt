create table book (id int primary key auto_increment, name varchar(50), library int)
create table library(id int auto_increment primary key, name varchar(50))
insert into library (name) values ('Cardiff Church Road'), ('Nottingham Orchard Way')

insert into book (name, library) values ('The 39 Steps', 10)

alter table book add constraint fk_book_library foreign key (library) references library(id)

alter table book drop foreign key fk_book_library



