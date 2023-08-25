
drop table reserves;
drop table boats;
drop table sailors;
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

-- create view SailorsAndBoats
CREATE VIEW SailorsAndBoats(sid,sname,bid,bname,color,day)
AS SELECT s.sid,s.sname,b.bid,b.name,b.color,r.day
FROM sailors s, reserves r, boats b
WHERE s.sid=r.sid AND r.bid=b.bid;

desc SailorsAndBoats;

select * from SailorsAndBoats;

-- insert data into Sailors
INSERT INTO SAILORS(sid, sname, rating, age)
	VALUES (22, 'dustin', 7, 45.0);
INSERT INTO SAILORS(sid, sname, rating, age)
	VALUES (31, 'lubber', 8, 55.5);
INSERT INTO SAILORS(sid, sname, rating, age)
	VALUES (58, 'rusty', 10, 35.0);
INSERT INTO SAILORS(sid, sname, rating, age)
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

select * from SailorsAndBoats;

select * from SailorsAndBoats where sname like 'd%';

-- create view SailorsAndBoats3
CREATE VIEW SailorsAndBoats3
AS SELECT s.sid,s.sname,b.bid,b.name,b.color,r.day
FROM sailors s, reserves r, boats b
WHERE s.sid=r.sid AND r.bid=b.bid;

desc SailorsAndBoats3
desc SailorsAndBoats

-- create view SailorsHighRating
CREATE VIEW SailorsHighRating
AS SELECT *
FROM sailors s
WHERE s.rating>8;

desc SailorsHighRating;

select * from Sailors;
select * from SailorsHighRating;

update Sailors
set rating=7 where sid=58;

select * from Sailors;
select * from SailorsHighRating;
