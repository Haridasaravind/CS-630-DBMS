-- Q1 Given the following
--   Books , Author , Write tables 

-- Books(bid:integer, bname:string, author:string, pubyear:integer,pubcompany:string) 
-- a

Create table Books
(
 bid      integer primary key,
 bname    varchar(20),
 author   varchar(20),
 pubyear  integer,
 pubcompany varchar(20)
);
-- Authors(aid:integer, name:string, rating:int, city:string, state:string) 
create table Authors
(
	aid     integer primary key,
	name    varchar(20),
	rating  integer,
	city    VARCHAR(20),
	state   VARCHAR(20)
);
-- Write(aid:integer,bid:integer) 
create table Write
(
	bid integer,
	aid integer,
	PRIMARY KEY (bid,aid),
    FOREIGN KEY (bid) REFERENCES Books(bid),
    FOREIGN KEY (aid) REFERENCES Authors(aid)
);

--   Inserting data into the tables:
--  Data into Books
-- INSERT INTO Books (bid, bname,author,pubyear,pubcompany) VALUES (1, 'maths','Tom',2020,'Company A');
-- INSERT INTO Books (bid, bname,author,pubyear,pubcompany) VALUES (2, 'science ','Jerry',2019, 'Company B');

INSERT INTO Books VALUES (101, 'physics', 'Butch', 2022, 'Company X');
INSERT INTO Books (bid, bname,author,pubyear,pubcompany) VALUES (5, 'physics','Butch',null ,'marine');
INSERT INTO Books (bid, bname,author,pubyear,pubcompany) VALUES (4, 'english','Bob',2019,'simon');
INSERT INTO Books (bid, bname,author,pubyear,pubcompany) VALUES (3, 'social','Spike',2020,'penguin');

--  Inserting data into Authors
-- INSERT INTO Authors (aid,name,rating,city,state) VALUES (10, 7, 'Boston', 'MA');
--INSERT INTO Authors (aid,name,rating,city,state) VALUES (20, 9, 'los Angles' ,'CA');
--INSERT INTO Authors (aid,name,rating,city,state) VALUES (30, 6,'newyork','NY');
--INSERT INTO Authors (aid,name,rating,city,state) VALUES (40, 8,'austin','TX');

INSERT INTO Authors VALUES (1, 'Tom', 7, 'newyork', 'NY');
INSERT INTO Authors VALUES (6, 'Jerry', 5, 'Boston', 'MA');
INSERT INTO Authors (aid, name, rating, city, state) VALUES (6, 'Jerry', 5, 'Boston', 'MA');

--  Inserting data into write

INSERT INTO Write (aid, bid)
VALUES (1, 101);

INSERT INTO Write (bid, aid) VALUES (5,50);
INSERT INTO Write (bid, aid) VALUES (6,60);

--b 
--Use INNER JOIN to write the SQL query to extract the id and name of the authors and the id, name, and pubyear of books they wrote.

 SELECT Authors.aid, Authors.name, Books.bid, Books.bname, Books.pubyear
  FROM Authors
  INNER JOIN Write ON Authors.aid = Write.aid
  INNER JOIN Books ON Write.bid = Books.bid;

-- c  Write the SQL query to extract the id and name of all the Books that do not have a  pubyear. Sort the result by name in descending order.

select books.bid, books.bname
 From Books
 where pubyear is null
 order by bname desc;

-- d  Write the SQL query to find the number of books for each pubcompany and pubyear.

select books.pubcompany, books.pubyear, count(*) as numberofbooks
  from books
  group by books.pubcompany,books.pubyear;

-- e  Write the SQL statement to join Authors with Write. In the result also include the authors that did not write any books.
SELECT Authors.aid, Authors.name, Write.bid
FROM Authors
LEFT JOIN Write ON Authors.aid = Write.aid;



-- f Write the SQL statement to update all Authors ratings to use rating 8.
update authors set rating =8;

-- g Write the SQL statement to update all books published in year 2020 to use pubcompany 'simon'.

update  books
  set pubcompany ='simon'
where pubyear = 2020; 

-- h) write the SQL statement to delete all authors that did not write any book. 
DELETE FROM Authors
WHERE aid NOT IN (SELECT aid FROM Write);


-- i) Write the SQL statement to delete all Books that do not have a pubyear.
delete from books where pubyear is null;

-- j Write the SQL table to insert a record into each of these three tables.Statements need to be written in an order such that if executed in that that will not cause an error.
insert into Books(bid,bname,author,pubyear,pubcompany) values (10,'tom','warnerbros',1998,'WB');
 insert into Authors (aid, name ,rating,city, state) values(10,'warnerbros',5,'BOSTON','MA');
 insert into Write (aid,bid) values (10,10);

-- k Write the SQL statement to update the record you inserted in Authors table at point (j). Update the name of the author and the rating to use different values.
update authors
	set name ='HP',rating =10
	where aid =10;

-- l Write the SQL statement to alter table Authors to add an additional column phone of type string.
ALTER TABLE Authors ADD phone VARCHAR(20);


--m Inside a comment line describe under what conditions query SELECT COUNT(name)
--  SELECT COUNT(name) FROM Authors; and SELECT COUNT(*) FROM Authors; will give different values 
 
-- If there are NULL values in the name column of the Authors table,
-- the COUNT(name) query will count only the non-NULL values, 
-- while the COUNT(*) query will count all rows, including the ones with NULL values


-- N Drop all tables 

drop table write;
drop table Authors;
drop table books;

Create table Authors
(
    aid     integer primary key,
	name    varchar(20),
	rating  integer check (rating >= 1 and rating <=10),
	city    VARCHAR(20),
	state   VARCHAR(20)	
);










