-- Q2  Given the follwing db schema

-- a Cars(carid:integer, make:string, model:string, myear:integer, dailyfee:real)
Create table Cars
(
   carid integer primary key,
   make varchar(20),
   model varchar(20),
   myear integer not null CHECK (myear >= 2015 AND myear <= 2020),
   dailyfee real
);

-- Inserting values 
 INSERT INTO Cars VALUES (1, 'Honda', 'Civic', 2016, 25.00);
   INSERT INTO Cars VALUES (2, 'Toyota', 'Corolla', 2017, 30.00);
   INSERT INTO Cars VALUES (3, 'Toyota', 'Camry', 2018, 35.00);
   INSERT INTO Cars VALUES (4, 'Ford', 'Mustang', 2019, 40.00);

   INSERT INTO Cars VALUES(11, 'Honda', 'Civic', 2019, 25.00);
   INSERT INTO Cars VALUES (12, 'Toyota', 'Corolla', 2020, 30.00);
   INSERT INTO Cars VALUES(13, 'Toyota', 'Camry', 2020, 35.00);
    INSERT INTO Cars VALUES(14, 'Ford', 'Mustang', 2020, 40.00);


-- b  Customers(custid:integer, name:string, city: string, state:string, dob: date) 
Create table Customers
(
  custid integer primary key not null,
  name varchar(20) not null,
  city varchar(20) not null,
  state varchar(20) not null,
  dob date not null
);

INSERT INTO Customers VALUES (1, 'ram', 'New York', 'NY', TO_DATE('1990-05-15', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (2, 'laxman', 'Los Angeles', 'CA', TO_DATE('1985-09-22', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (3, 'John', 'New York', 'NY', TO_DATE('1990-05-15', 'YYYY-MM-DD'));

-- c Rents(carid:integer, custid:integer, rday:date) 
create table Rents
(
	carid integer,
	custid integer,
	rday date not null,
	PRIMARY KEY (carid,custid),
  FOREIGN KEY (carid) REFERENCES Cars(carid),
  FOREIGN KEY (custid) REFERENCES Customers(custid)
);

INSERT INTO Rents VALUES (2, 1, TO_DATE('2020-08-01', 'YYYY-MM-DD'));
INSERT INTO Rents VALUES (3, 1, TO_DATE('2020-08-02', 'YYYY-MM-DD'));

INSERT INTO Rents VALUES  (12, 3, TO_DATE('2020-08-01', 'YYYY-MM-DD'));
INSERT INTO Rents VALUES  (13, 3 , TO_DATE('2020-08-02', 'YYYY-MM-DD'));
INSERT INTO Rents VALUES  (14, 3, TO_DATE('2020-08-03', 'YYYY-MM-DD'));


-- d) Write the SQL statement to find the id and name of customers who rented both Honda and Toyota cars 
-- (i.e. both make Honda and make Toyota). 
SELECT c.custid, c.name FROM Customers c
  inner JOIN Rents r ON c.custid = r.custid
	inner JOIN Cars ca ON r.carid = ca.carid
	WHERE ca.make IN ('Honda', 'Toyota')
	GROUP BY c.custid, c.name
	HAVING COUNT(DISTINCT ca.make) = 2;

-- e) Write the SQL query to extract the carid, make and model for cars that were rented for 
--    some day in 2020 , but they were not rented for any day in 2022.
-- we also have a constraint on myear  2015 to 2020

SELECT c.carid, c.make, c.model
FROM Cars c
LEFT JOIN Rents r2020 ON c.carid = r2020.carid AND EXTRACT(YEAR FROM r2020.rday) = 2020
LEFT JOIN Rents r2022 ON c.carid = r2022.carid AND EXTRACT(YEAR FROM r2022.rday) = 2022
WHERE r2020.rday IS NOT NULL AND r2022.rday IS NULL;


-- f  
-- Example of a valid INSERT statement
INSERT INTO Cars (carid, make, model, myear, dailyfee) VALUES (1, 'Toyota', 'Corolla', 2018, 50.00);

-- This INSERT will fail due to the constraint
INSERT INTO Cars (carid, make, model, myear, dailyfee)  VALUES (2, 'Ford', 'Mustang', 2012, 60.00







