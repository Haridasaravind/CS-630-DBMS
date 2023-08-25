- HW3_Q2 Given the following
--a

CREATE TABLE Articles
(
     aid           INTEGER PRIMARY KEY,
     aname         VARCHAR (20),
     first_author  VARCHAR(20),
     pubyear       INTEGER,
     pubcompany    VARCHAR(20)
);
CREATE TABLE Students
(
     sid    INTEGER PRIMARY KEY,
     sname  VARCHAR(20),
     age    REAL,
     state  VARCHAR(20) 
);
CREATE TABLE Reads
(
  sid   INTEGER,
  aid   INTEGER,
  year  VARCHAR(20),
  PRIMARY KEY (aid,sid),
  FOREIGN KEY (aid) REFERENCES Articles(aid),
  FOREIGN KEY (sid) REFERENCES Students(sid)
);

-- b  Inserting th records

INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (1, 'Tom and Jerry','john Andrew',2020,'Company A');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (2, 'Bob leuko ','mark pamo',2019, 'Company B');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (3, 'New day to rome','nazi anderson',2022,'penguin');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (4, 'leuko lab','bob mayer',2019,'simon');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (5, 'Times ','Johnson johnson',2022,'marine');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (6, 'Amway ','colgate',2020,'classmate');

INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (10, 'Bobby smith','bush',2022, 'Company B');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany) VALUES (11, 'Bold simon','bard',2016, 'Company B');


INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany)  VALUES (12, 'Breth J', 'Wascom', 2017,'company D');
INSERT INTO Articles (aid, aname,first_author,pubyear,pubcompany)  VALUES (13, 'Black K', 'Title 4', 2021,'company D');

INSERT INTO Students (sid,sname,age,state) VALUES (1,'tom',20,'MA');
INSERT INTO Students (sid,sname,age,state) VALUES (2,'jerry',21,'CA');
INSERT INTO Students (sid,sname,age,state) VALUES (3,'spike',22,'NY');
INSERT INTO Students (sid,sname,age,state) VALUES (4,'butch',22,'TX');
INSERT INTO Students (sid,sname,age,state) VALUES (10,'droopy',22,'TX');
INSERT INTO Students (sid,sname,age,state) VALUES (11,'mike',22,'TX');


INSERT INTO Reads (sid, aid,year) VALUES (1,1,2020);
INSERT INTO Reads (sid, aid,year) VALUES (1,2,2019);
INSERT INTO Reads (sid, aid,year) VALUES (1,2,2019);
INSERT INTO Reads (sid, aid,year) VALUES (4,6,2020);
INSERT INTO Reads (sid, aid,year) VALUES (1,3,2022);
INSERT INTO Reads (sid, aid,year) VALUES (1,4,2019);
INSERT INTO Reads (sid, aid,year) VALUES (1,5,2020);
INSERT INTO Reads (sid, aid,year) VALUES (2,5,2020);
INSERT INTO Reads (sid, aid,year) VALUES (3,4,2019);
INSERT INTO Reads (sid, aid,year) VALUES (10,10,2022);
INSERT INTO Reads (sid, aid,year) VALUES (11,11,2016);




-- c 

SELECT COUNT(*)
FROM Articles
WHERE LOWER(first_author) LIKE '%an%';


-- d
     SELECT *
     FROM Articles
     ORDER BY pubyear DESC, aname ASC;


-- e  nw

SELECT DISTINCT S.sid, S.sname, S.age
FROM Students S
WHERE NOT EXISTS (
    SELECT A.aid
    FROM Articles A
    WHERE NOT EXISTS (
        SELECT R.sid
        FROM Reads R
        WHERE R.sid = S.sid AND R.aid = A.aid
    )
);


SELECT s.sid, s.sname, s.age
FROM Students s
WHERE NOT EXISTS (
  SELECT a.aid
  FROM Articles a
  WHERE NOT EXISTS (
    SELECT r.aid
    FROM Reads r
    WHERE r.sid = s.sid AND r.aid = a.aid
  )
);




-- f 
SELECT S.sid, S.sname
FROM Students S
WHERE S.sid IN (
    SELECT R.sid
    FROM Reads R
    JOIN Articles A ON R.aid = A.aid
    WHERE A.pubyear = 2020
)
AND S.sid NOT IN (
    SELECT R.sid
    FROM Reads R
    JOIN Articles A ON R.aid = A.aid
    WHERE A.pubyear = 2018
)
ORDER BY S.sname DESC;


-- g

SELECT DISTINCT S.sid, S.sname
FROM Students S
JOIN Reads R ON S.sid = R.sid
JOIN Articles A ON R.aid = A.aid
WHERE R.year = A.pubyear;


--h 
SELECT S.sid, S.sname, COUNT(R.aid) AS num_articles_read
FROM Students S
JOIN Reads R ON S.sid = R.sid
GROUP BY S.sid, S.sname
HAVING COUNT(R.aid) >= 3;


-- i 
SELECT state, MIN(age) AS min_age, MAX(age) AS max_age, AVG(age) AS avg_age
FROM Students
GROUP BY state
HAVING COUNT(sid) >= 2;


-- j nw  
SELECT *
FROM Articles
WHERE first_author LIKE 'B%' AND (pubyear < 2018 OR pubyear > 2020);


--k
SELECT DISTINCT S.sid, S.sname
FROM Students S
WHERE NOT EXISTS (
    SELECT A.aid
    FROM Articles A
    WHERE A.pubyear = 2022 AND A.pubcompany = 'penguin'
    AND NOT EXISTS (
        SELECT R.sid
        FROM Reads R
        WHERE R.sid = S.sid AND R.aid = A.aid
    )
);


-- i
SELECT DISTINCT S.sid, S.sname, S.age, S.state
FROM Students S
WHERE NOT EXISTS (
    SELECT 1
    FROM Articles A
    WHERE A.pubcompany = 'simon'
    AND NOT EXISTS (
        SELECT 1
        FROM Reads R
        WHERE R.aid = A.aid AND R.sid = S.sid
    )
)
ORDER BY S.sname;












