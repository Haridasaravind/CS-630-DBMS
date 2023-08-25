
--Q1 
--a

CREATE TABLE Movies (
    mid INTEGER PRIMARY KEY,
    title VARCHAR(25),
    director VARCHAR(25),
    studio VARCHAR(25),
    releaseyear INTEGER
);

-- b 

CREATE TABLE Customers (
    cid INTEGER PRIMARY KEY,
    name VARCHAR(25),
    city VARCHAR(25),
    state VARCHAR(25),
    age REAL CHECK (age >= 18)
);

-- c 

CREATE TABLE Watch (
    cid INTEGER,
    mid INTEGER,
    watchedon DATE,
    PRIMARY KEY (cid, mid),
    FOREIGN KEY (cid) REFERENCES Customers(cid),
    FOREIGN KEY (mid) REFERENCES Movies(mid)
);

-- d 

Create INDEX indexwatchDate on Watch(Watchedon); 

-- e 
-- Insert a record into Movies

INSERT INTO Movies (mid, title, director, studio, releaseyear)
VALUES (1, 'Avatar', 'James', 'Sony', 2023);

-- Insert a record into Customers
INSERT INTO Customers (cid, name, city, state, age)
VALUES (1, 'Cameron', 'Boston', 'MA', 25);

-- Insert a record into Watch
INSERT INTO Watch (cid, mid, watchedon)
VALUES (1, 1, '2023-08-21');

--f
SELECT DISTINCT m.mid, m.title
FROM Movies m
INNER JOIN Watch w ON m.mid = w.mid
WHERE w.watchedon BETWEEN '2022-01-01' AND '2022-07-31';


--g
SELECT c.cid, c.name, m.mid, m.title, m.director, w.watchedon
FROM Customers c
INNER JOIN Watch w ON c.cid = w.cid
INNER JOIN Movies m ON w.mid = m.mid
ORDER BY w.watchedon DESC;




