

-- a
CREATE TABLE Articles
(
    aid INTEGER PRIMARY KEY,
    title VARCHAR(25),
    author VARCHAR(25),
    pubyear INTEGER
);


CREATE TABLE Students (
    sid INTEGER PRIMARY KEY,
    name VARCHAR(25),
    city VARCHAR(25),
    state VARCHAR(25),
    age REAL,
    gpa REAL CHECK (gpa >= 1 AND gpa <= 4)
);

CREATE TABLE Reads (
    sid INTEGER NOT NULL,
    aid INTEGER NOT NULL,
    rday DATE NOT NULL,
    PRIMARY KEY (sid, aid),
    FOREIGN KEY (sid) REFERENCES Students(sid),
    FOREIGN KEY (aid) REFERENCES Articles(aid)
);

--b  
CREATE INDEX idx_rday ON Reads (rday);
-- It is mainly used for frequently need to retrieve data from the reads table based on the rday value.
-- It will improve the performance of queries that involve filtering and others.

--c 
INSERT INTO Students VALUES (1, 'John Smith', 'New York', 'NY', 20, 3.5);
INSERT INTO Students VALUES (2, 'Emily Johnson', 'Los Angeles', 'CA', 22, 3.8);
INSERT INTO Students VALUES (3, 'Michael Brown', 'Massachusetts', 'MA', 21, 3.6);

INSERT INTO Articles VALUES (1, 'Introduction to SQL', 'Tom', 2022);
INSERT INTO Articles VALUES (2, 'Data Modelling Basics', 'Jerry',2023);

-- d
INSERT INTO Reads VALUES (1, 1, '2023-08-15'),  -- John Smith read Article 1
INSERT INTO Reads VALUES (1, 2, '2023-08-18'),  -- John Smith read Article 2
INSERT INTO Reads VALUES (2, 1, '2023-08-17'),  -- Emily Johnson read Article 1
INSERT INTO Reads VALUES (3, 2, '2023-08-16');  -- Michael Brown read Article 2


-- e
CREATE VIEW MAStudents AS
SELECT * FROM Students WHERE state = 'MA';


-- f 
CREATE VIEW StudentsReads AS
SELECT s.sid AS id, s.name, s.city, r.aid, a.title
FROM Students s
LEFT JOIN Reads r ON s.sid = r.sid
LEFT JOIN Articles a ON r.aid = a.aid;


-- g
SELECT id, name, city, COUNT(aid) AS num_articles_read
FROM StudentsReads
GROUP BY id, name, city
ORDER BY id;



--h 
DROP VIEW StudentsReads;
DROP VIEW MAStudents;

or
DROP VIEW IF EXISTS StudentsReads;
DROP VIEW IF EXISTS MAStudents;










