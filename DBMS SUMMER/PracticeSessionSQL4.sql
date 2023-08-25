-- SQL Practice 4
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT FOUR LINES TO DROP THE TABLES FIRST)
--drop table reserves;
--drop table boats;
--drop table sailors;
--drop table sailors3;


-- create table sailors
create table sailors(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4,2)
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

create table SAILORS3(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4,2),
        salary NUMBER(9)
);




-- describe tables
desc reserves;
desc sailors;
desc boats;
desc sailors3;


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

-- insert data into sailors3 table
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (22, 'dustin', 7, 45.0,20000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (31, 'lubber', 8, 55.5, 30000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (58, 'rusty', 10, 35.0, 15000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (59, 'rusty', 10, 45.0, 40000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (60, 'andy', 10, 60.0, 25000);
INSERT INTO SAILORS3(sid, sname, rating, age, salary)
	VALUES (61, 'mary', 8, 25.0, 30000);

-- QUERIES

select * from sailors3;

-- with aggregates

SELECT s.rating, MIN(s.age)
FROM SAILORS3 s
GROUP BY s.rating;

-- next commented query will fail when run
--SELECT s.sname,s.rating, MIN(s.age)
--FROM SAILORS3 s
--GROUP BY s.rating;

SELECT s.sname,s.rating, MIN(s.age)
FROM SAILORS3 s
GROUP BY s.rating, s.sname;

---- NESTED QUERIES

-- find the sailors with the highest rating
select *
from sailors s
where s.rating = (select max(s2.rating) from sailors s2);

-- NOTE: next commented query will fail.
--SELECT * from sailors s
--WHERE s.rating = (SELECT s2.rating
--                              FROM sailors s2);


-- find the sailors who reserved boat 101
SELECT *
FROM Sailors s
WHERE EXISTS (SELECT *
               FROM Reserves r
               WHERE r.bid=101 and s.sid=r.sid);

-- select all sailors who have at least one reservation
SELECT * from Sailors s
WHERE s.sid IN ( SELECT r.sid
                           FROM Reserves r);

-- select all sailors who have NO reservation
SELECT * from Sailors s
WHERE s.sid NOT IN ( SELECT r.sid
                           FROM Reserves r);
-- select all sailors whose rating is higher than any sailor who reserved boat 101
SELECT * from Sailors s
WHERE s.rating > ANY ( SELECT s2.rating
                           FROM Sailors s2,Reserves r
                           WHERE s2.sid=r.sid and r.bid=101);

-- select the name and rating for sailors who reserved boat 101
SELECT  s2.sname, s2.rating
FROM Sailors s2,Reserves r
WHERE s2.sid=r.sid and r.bid=101;

-- select all sailors with the maximum age
-- sol1:
SELECT * from Sailors s
WHERE s.age >= ALL ( SELECT s2.age
                           FROM Sailors s2);

-- select all sailors with the maximum age
-- sol2:
-- this query uses aggregates
SELECT * from Sailors s
WHERE s.age = ( SELECT max(s2.age)
                           FROM Sailors s2);

