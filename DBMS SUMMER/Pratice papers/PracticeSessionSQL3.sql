-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
drop table reserves;
drop table boats;
drop table sailors;
drop table sailors2;



-- create table sailors
create table sailors(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4)
);

-- create table boats
create table boats(
	bid 	number(9) primary key,
	name	varchar(20),
	color	varchar(20)
);

--create table reserves
create table reserves(
	sid 	number(9),
	bid 	number(9),
	day date,
	primary key(sid,bid),
	foreign key (sid) references sailors,
	foreign key (bid) references boats
);

create table sailors2(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4,2)
);



-- describe tables
desc reserves;
desc sailors;
desc boats;
desc sailors2;


-- insert data into sailors table
INSERT INTO SAILORS(sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO SAILORS
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO SAILORS
	VALUES (58, 'rusty', 10, 35.0);
INSERT INTO SAILORS
	VALUES (59, 'rusty', 10, 45.0);

-- insert data into boats table
insert into boats (name, bid, color)
	values ('interlake', 101, 'red');
insert into boats(bid,name,color)
	values (102, 'clipper', 'green');
insert into boats(bid,name,color)
	values (103, 'transatlantic', 'red');
insert into boats(bid,name,color)
	values (104, 'vacation', 'white');
insert into boats(bid,name,color)
	values (105, 'hawaii', 'green');
insert into boats(bid,name,color)
	values (106, 'sea', 'green');

-- insert data into reserves table
insert into reserves values (22,101,TO_DATE('10/10/2022', 'mm/dd/yyyy'));
insert into reserves values (58,101,TO_DATE('10/11/2022', 'mm/dd/yyyy'));
insert into reserves values (22,102,TO_DATE('10/20/2022', 'mm/dd/yyyy'));
insert into reserves values (59,103,TO_DATE('10/20/2022', 'mm/dd/yyyy'));

-- insert data into sailors2 table
INSERT INTO SAILORS2(sid, sname, rating, age)
	VALUES (20, 'joe', 9, 24.0);
INSERT INTO SAILORS2(sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO SAILORS2(sid, sname, rating, age)
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO SAILORS2(sid, sname, rating, age)
	VALUES (60, 'andy', 9, 60.0);


--- some operations

select sname, rating, (rating-1)/2 as newcol from sailors;
select sname, rating, (rating-1) from sailors;



--UNION, INTERSECT
select * from sailors
UNION
select * from sailors2;

select * from sailors
UNION ALL
select * from sailors2;

select * from sailors
INTERSECT
select * from sailors2;

(select * from sailors where rating >8)
UNION
(select * from sailors2 where rating <8);



--- operation with aggregates
select avg(rating) from sailors;
-- with where clause
select sum(rating) from sailors where age >40;

-- next commented out query will return an error if run
--select age,avg(rating) from sailors;

--GROUP BY
-- this query will give an ERROR, because we group by age, and we have rating in select
select rating,avg(age) from sailors group by age;
-- group by and order by
select age,avg(rating) from sailors group by age order by avg(rating);
-- group by with renaming aggregate
select age,avg(rating) as avgrating from sailors group by age order by avgrating;


-- GROUP BY AND HAVING
-- how many boats of each color I have ?
select count(*) from boats group by color;
-- how many boats of each color I have ? Include in the results boats with an id greater than 102
select count(*) from boats where bid>102 group by color;

-- MORE PRACTICE
select * from reserves;

-- Find how many reservations for each boat color we have.
select color,count(*)
from reserves r, boats b
where r.bid=b.bid
group by color;

-- Find how many reservation for each boat color we have. Count each unique boat only once.
select color,count(distinct r.bid)
from reserves r, boats b
where r.bid=b.bid
group by color;

