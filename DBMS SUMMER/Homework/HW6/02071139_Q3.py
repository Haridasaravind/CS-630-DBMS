import oracledb
import getpass

# read input arguments: username, pasword, db host, db name
username = input("aravind:")
userpwd = getpass.getpass("aravind657:")  
hostname = input("dbs3.cs.umb.edu:")
database = input("dbs3:")

#Establish the connection to DBMS
dsn = f"{username}/{userpwd}@{hostname}/{database}"
if hostname[-1] == '/':connection = oracledb.connect(user=username,password=userpwd,dsn=dsn)
else:connection = oracledb.connect(user=username, password=userpwd,dsn=f"{hostname}/{database}")

curs = connection.cursor() #creates a cursor that will be needed to access the databases

# Drop tables Students, Articles, Reads if they exist 	
tables_to_drop = ['Students', 'Articles', 'Reads']
for table in tables_to_drop:
    try:
        cursor.execute(f"DROP TABLE {table}")
        print(f"Table {table} dropped successfully.")
    except cx_Oracle.DatabaseError as e:
        print(f"Error dropping table {table}: {e}")


# Create tables using cursor
create_students_table = '''
CREATE TABLE Students(
    sid INTEGER PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    age INTEGER,
    gpa REAL
)
'''
cursor.execute(create_students_table)

create_articles_table = '''
CREATE TABLE Articles(
    aid INTEGER PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    pubyear INTEGER
)
'''
cursor.execute(create_articles_table)

create_reads_table = '''
CREATE TABLE Reads(
    aid INTEGER,
    sid INTEGER,
    rday DATE,
    PRIMARY KEY(aid, sid),
    FOREIGN KEY(aid) REFERENCES Articles(aid),
    FOREIGN KEY(sid) REFERENCES Students(sid)
)
'''
cursor.execute(create_reads_table)

# Insert two records into each table
insert_students = '''
INSERT INTO Students(sid, name, city, state, age, gpa)
VALUES (1, 'Tom', 'Boston', 'MA', 20, 3.5)
'''
insert_articles = '''
INSERT INTO Articles(aid, title, author, pubyear)
VALUES (1, 'Introduction to SQL', 'Alice', 2022)
'''
insert_reads = '''
INSERT INTO Reads(aid, sid, rday)
VALUES (1, 1, TO_DATE('2023-08-20', 'YYYY-MM-DD'))
'''
insert_queries = [insert_students, insert_articles, insert_reads]
for query in insert_queries:
    cursor.execute(query)





# Select all articles
cursor.execute("SELECT * FROM Articles")
articles = cursor.fetchall()
print("All records from Articles table:")
for article in articles:
    print(article)

# Select all students
cursor.execute("SELECT * FROM Students")
students = cursor.fetchall()
print("All records from Students table:")
for student in students:
    print(student)

# Select all records from Reads
cursor.execute("SELECT * FROM Reads")
reads = cursor.fetchall()
print("All records from Reads table:")
for read in reads:
    print(read)


#  commit the transaction 

print("Committing transaction.")
connection.commit()
print("Closing connection.")
connection.close()



