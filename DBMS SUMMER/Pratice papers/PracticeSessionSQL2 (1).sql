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

select * from sailors,reserves where sailors.sid=reserves.sid;

--sort by queries
select * from sailors;
select * from sailors order by age;
select * from sailors order by age desc;
select * from sailors order by 4 desc;
select * from sailors order by 4,3 desc;
select * from sailors order by 4,rating desc;


--next commented out qyery will give an error if run
--select * from sailors,reserves where sailors.sid=reserves.sid order by sid;
select * from sailors,reserves where sailors.sid=reserves.sid order by 1;

--LIKE keyword
select * from sailors where sname='dustin';
select * from sailors where sname like'dustin';
select * from sailors where sname like '%stin';
select * from sailors where sname like '%st';
select * from sailors where sname like '%st%';

-- case insensitive text matches
select * from sailors where upper(sname)=upper('Dustin');
select * from sailors where lower(sname)=lower('Dustin');

--other queries
SELECT s.sid, s.sname, b.color, r.day FROM sailors s, reserves r, boats b
    WHERE s.sid = r.sid AND r.bid= b.bid AND r.day<TO_DATE('10/11/2022','mm/dd/yyyy');

SELECT s.sid, s.sname, b.color, r.day FROM sailors s, reserves r, boats b
    WHERE s.sid = r.sid AND r.bid= b.bid AND r.day<=TO_DATE('10/11/2022','mm/dd/yyyy');

SELECT upper(sname)
FROM sailors s, reserves r, boats b
WHERE s.sid=r.sid AND r.bid=b.bid AND s.age>30 and (b.color='red' or b.color='green');

SELECT sname
FROM sailors s, reserves r, boats b
WHERE s.sid=r.sid AND r.bid=b.bid AND s.age>30 and (b.color='red' or b.color='green');

SELECT count(distinct b.bid)
FROM reserves r, boats b
WHERE r.bid=b.bid and b.color='green';
