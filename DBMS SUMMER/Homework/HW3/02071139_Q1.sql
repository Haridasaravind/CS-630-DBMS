-- HW3_Q1 Given the following
-- CREATE TABLE songs

--a
CREATE TABLE Customers
(
     cid    INTEGER PRIMARY KEY,
     name   VARCHAR (20),
     city   VARCHAR(20),
     state  VARCHAR(20),
     age    INTEGER
);
CREATE TABLE Accounts
(
     aid  INTEGER PRIMARY KEY,
     atype  VARCHAR(20),
     amount REAL 
);
CREATE TABLE Has_account
(
  cid   INTEGER,
  aid   INTEGER,
  since DATE,
  PRIMARY KEY (cid,aid),
  FOREIGN KEY (cid) REFERENCES customers(cid),
  FOREIGN KEY (aid) REFERENCES accounts(aid)
);

--b   Inserting records into each table

INSERT INTO Customers (cid, name,city,state,age) VALUES (1, 'Tom','Boston','MA',30);
INSERT INTO Customers (cid, name,city,state,age) VALUES (2, 'Jerry','Boston','MA',29);
INSERT INTO Customers (cid, name,city,state,age) VALUES (3, 'Spike','Newyork','NY',32);
INSERT INTO Customers (cid, name,city,state,age) VALUES (4, 'Droopy','boston','MA',26);

INSERT INTO Accounts (aid,atype,amount) VALUES (1,'checking',4500);
INSERT INTO Accounts (aid,atype,amount) VALUES (2,'savings',3150);
INSERT INTO Accounts (aid,atype,amount) VALUES (3,'savings',2105);
INSERT INTO Accounts (aid,atype,amount) VALUES (4,'savings',1100);
INSERT INTO Accounts (aid,atype,amount) VALUES (5,'savings',5500);
INSERT INTO Accounts (aid,atype,amount) VALUES (6,'savings',2700);
INSERT INTO Accounts (aid,atype,amount) VALUES (7,'savings',2959);

INSERT INTO Has_account VALUES (1, 1, TO_DATE('2021-01-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (1, 2, TO_DATE('2021-02-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (1, 3, TO_DATE('2018-01-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (1, 4, TO_DATE('2020-02-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (2, 1, TO_DATE('2021-02-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (2, 5, TO_DATE('2019-01-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (4, 6, TO_DATE('2021-03-01','YYYY-MM-DD'));
INSERT INTO Has_account VALUES (4, 7, TO_DATE('2021-04-01','YYYY-MM-DD'));

--c 
SELECT DISTINCT C.cid, C.name
FROM Customers C
INNER JOIN Has_account HA ON C.cid = HA.cid
INNER JOIN Accounts A ON HA.aid = A.aid
WHERE C.city = 'Boston' AND A.amount < 5000
ORDER BY C.name DESC;

-- d
SELECT cid, name, age
FROM Customers
WHERE NOT EXISTS (
    SELECT 1
    FROM Has_account
    WHERE Customers.cid = Has_account.cid
    AND since BETWEEN TO_DATE('2020-01-01', 'YYYY-MM-DD') AND TO_DATE('2021-12-01', 'YYYY-MM-DD')
);

-- e                  
SELECT c.cid, c.name, c.age
FROM Customers c
JOIN Has_account ha1 ON c.cid = ha1.cid
JOIN Accounts a1 ON ha1.aid = a1.aid AND a1.atype = 'savings'
JOIN Has_account ha2 ON c.cid = ha2.cid
JOIN Accounts a2 ON ha2.aid = a2.aid AND a2.atype = 'checking'
ORDER BY c.name DESC;

--f
SELECT C.cid, C.name
FROM Customers C
JOIN Has_account HA ON C.cid = HA.cid
JOIN Accounts A ON HA.aid = A.aid
GROUP BY C.cid, C.name
HAVING SUM(A.amount) <= 10000;

--g    
SELECT HA.aid
FROM Has_account HA
JOIN Accounts A ON HA.aid = A.aid AND A.atype = 'checking'
GROUP BY HA.aid
HAVING COUNT(HA.cid) >= 2;

--h 
SELECT c.cid, c.name, c.age, COUNT(*) AS num_accounts
FROM Customers c
JOIN Has_account ha ON c.cid = ha.cid
JOIN Accounts a ON ha.aid = a.aid
WHERE c.age > 25 AND c.age < 35
GROUP BY c.cid, c.name, c.age
HAVING COUNT(*) >= 2;

-- i
SELECT c.cid, c.name, c.age
FROM Customers c
WHERE EXISTS (
  SELECT 1
  FROM Has_account ha
  WHERE c.cid = ha.cid AND EXTRACT(YEAR FROM ha.since) = 2018
) AND EXISTS (
  SELECT 1
  FROM Has_account ha
  WHERE c.cid = ha.cid AND EXTRACT(YEAR FROM ha.since) = 2020
);

--j 
SELECT c.cid, c.name
FROM Customers c
WHERE c.state = 'MA'
AND (
  SELECT COUNT(a.aid)
  FROM Has_account ha
  JOIN Accounts a ON ha.aid = a.aid
  WHERE c.cid = ha.cid AND a.atype = 'savings'
) >= 2;











