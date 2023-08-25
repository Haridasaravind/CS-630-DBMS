-- SQL Practice 6
-- NOTE: a comment line in SQL starts with --
-- DROP TABLES (IF YOU ALREADY HAVE THESE TABLES AND WANT TO RECREATE THEM WITH FRESH DATA FROM THIS FILE, PLEASE UNCOMMENT THE NEXT LINES
-- TO DROP THE TABLES FIRST)


--drop table PlaysIn;
--drop table Movies;
--drop table Actors;
--drop table reserves;
--drop table sailors;
--drop table boats;
--drop table sailors4;
--drop table sailors5;

-- create table Movies
create table Movies(
        movie_id 	number(9) primary key,
        title	varchar(40),
        year  int,
        studio   varchar(20)
);

-- create table Actors
create table Actors(
        actor_id 	number(9) primary key,
        name	varchar(40),
        age  number(4,2)
);

-- create table PlaysIn
create table PlaysIn(
        actor_id 	number(9),
        movie_id number(8),
        character varchar(40),
        primary key(actor_id, movie_id),
        foreign key (actor_id) references Actors,
	    foreign key (movie_id) references Movies
);


-- insert records into Actors table
INSERT INTO Actors(actor_id,name,age) VALUES(10,'Joe',35.0);
INSERT INTO Actors(actor_id,name,age) VALUES(20,'Mary',20.0);
INSERT INTO Actors(actor_id,name,age) VALUES(30,'Anne',55.0);
INSERT INTO Actors(actor_id,name,age) VALUES(40,'Jerry',45.0);
INSERT INTO Actors(actor_id,name,age) VALUES(500,'Joe',45.0);

-- insert records into movies table
INSERT INTO Movies(movie_id,title,year, studio) VALUES(100,'Movie A', 2010,'Universal');
INSERT INTO Movies(movie_id,title,year, studio) VALUES(200,'Movie B',2005,'Universal');
INSERT INTO Movies(movie_id,title,year, studio) VALUES(300,'Movie C',2015,'WB');

-- insert records into PlaysIn table
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,100,'cab driver');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,200,'waitress');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(10,300,'Billy');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(20,100,'musician');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(20,300,'waitress');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,100,'Laura');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,200,'teacher');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(30,300,'librarian');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(40,100,'teacher');
INSERT INTO PlaysIn(actor_id, movie_id,character) VALUES(40,200,'football player');


select *
from actors a, playsin p
where a.actor_id = p.actor_id ;

select *
from actors a JOIN playsin p
       on a.actor_id = p.actor_id ;

-- left join. Will include actors who do not play in any movie (e.g. actor with actor_id 500)
select *
from actors a LEFT JOIN playsin p
       on a.actor_id = p.actor_id ;


select * from actors a, playsin p, movies m
where a.actor_id = p.actor_id and p.movie_id=m.movie_id;

select *
from actors a join playsin p on a.actor_id=p.actor_id
     join movies m on m.movie_id=p.movie_id;

-- cross product
select *
from actors, playsin;

select *
from actors cross join playsin;

-- natural join
select * from actors a, playsin p, movies m
where a.actor_id = p.actor_id and p.movie_id=m.movie_id;

select *
from actors natural join playsin natural join movies;


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


-- some updates

UPDATE sailors
 SET rating=9
 WHERE sid=31;


UPDATE Sailors
SET rating=8;


-- some deletes

-- delete all record for sailors named rusty
-- this will give an error, because rusty has a reservation (FK  integrity constraint)
DELETE FROM Sailors
WHERE sname='rusty';

-- delete data from reserves
DELETE FROM Reserves;

-- now the delete from before would work
DELETE FROM Sailors
WHERE sname='rusty';


--delete all records from table Sailors
DELETE FROM Sailors;


-- INTEGRITY CONSTRAINTS

--Foreign key integrity constraint
-- this will return an error
insert into reserves values (20,101,TO_DATE('10/26/2022', 'mm/dd/yyyy'));

-- general constraints
-- For table Sailors, we can insert records with rating 11
INSERT INTO Sailors VALUES(100,'joe',11,33);

-- create table sailors4 with a constraing on rating, to only allow values >=1 and <=10.
create table Sailors4(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4,2),
        CONSTRAINT RatingRange
        CHECK (rating>=1 AND rating <=10)
);

-- this will return an error because of the RatingRange constraint
INSERT INTO Sailors4 VALUES(100,'joe',11,33);

-- same constraint without name
create table Sailors5(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2) CHECK (rating>=11 AND rating <=10),
        age   	number(4,2)
);

-- this will return an error because of the constraint on rating
INSERT INTO Sailors5 VALUES(100,'joe',11,33);

