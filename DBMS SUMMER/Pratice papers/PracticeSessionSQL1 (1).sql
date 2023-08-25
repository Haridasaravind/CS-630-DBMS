-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF THEY EXIST ALREADY, UNCOMMENT THE NEXT THREE LINES TO DROP THE TABLES FIRST)
--drop table reserves;
--drop table boats;
--drop table sailors;


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

-- describe tables
desc reserves;
desc sailors;
desc boats;

-- alter table reserves by adding a column
ALTER TABLE reserves
       ADD invoiceday DATE;

-- modify existing column by changing the data type
 ALTER TABLE reserves
       MODIFY invoiceday VARCHAR(30);

-- describe table
desc reserves;

-- alter table by renaming one column
ALTER TABLE reserves
      RENAME COLUMN invoiceday to invday;

-- describe table
desc reserves;

-- rename table
ALTER TABLE reserves
      RENAME TO otherreserves;


-- rename table
ALTER TABLE otherreserves
      RENAME TO reserves;

-- alter table reserves by dropping one column
ALTER TABLE reserves
      DROP COLUMN invday;

-- describe table
desc reserves;

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
insert into boats
	values (102, 'clipper', 'green');

-- insert data into reserves table
insert into reserves values (22,101,TO_DATE('10/10/2022', 'mm/dd/yyyy'));
insert into reserves values (58,101,TO_DATE('10/11/2022', 'mm/dd/yyyy'));
insert into reserves values (22,102,TO_DATE('10/20/2022', 'mm/dd/yyyy'));

-- SOME SELECT QUERIES USED TO EXTRACT DATA

select * from sailors;
select * from boats;
select * from reserves;

select rating,sname from sailors;
select distinct rating,sname from sailors;
select * from sailors where rating=10;

select * from sailors, reserves where sailors.sid=reserves.sid;

select * from sailors s1, reserves r1 where s1.sid=r1.sid;

select * from sailors, reserves where sailors.sid=reserves.sid and reserves.bid=101;

select sailors.sname, boats.name, boats.color from sailors, reserves, boats where sailors.sid=reserves.sid and boats.bid=reserves.bid;

select sname, name, color from sailors, reserves, boats where sailors.sid=reserves.sid and boats.bid=reserves.bid;


