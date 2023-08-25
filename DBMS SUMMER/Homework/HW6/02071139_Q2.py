import oracledb
import getpass
import pandas.io.sql as pdsql

# read input arguments: username, pasword, db host, db name
username = input("aravind:")
userpwd  = getpass.getpass("aravind657:")  
hostname = input("dbs3.cs.umb.edu:")
database = input("dbs3:")


#Establish the connection to DBMS
dsn = f"{username}/{userpwd}@{hostname}/{database}"
if hostname[-1] == '/':connection = oracledb.connect(user=username,password=userpwd,dsn=dsn)
else:connection = oracledb.connect(user=username, password=userpwd,dsn=f"{hostname}/{database}")


# Query to extract information about all Students

query_students = "SELECT * FROM Students"
df_students = pdsql.read_sql(query_students, con=connection)

# Print out the information about the Students dataframe
print("Columns of the Students dataframe:")
print(df_students.columns)

print("Shape of the Students dataframe:")
print(df_students.shape)

print("First 3 records from the Students dataframe:")
print(df_students.head(3))

# Aggregate operations on Students dataframe
average_age = df_students['age'].mean()
min_age = df_students['age'].min()
print("Average Age of Students:", average_age)
print("Minimum Age of Students:", min_age)

min_gpa = df_students['gpa'].min()
max_gpa = df_students['gpa'].max()
print("Minimum GPA of Students:", min_gpa)
print("Maximum GPA of Students:", max_gpa)

sum_gpa = df_students['gpa'].sum()
print("Sum of GPA values of Students:", sum_gpa)


# Query to extract information about Students and Articles they read
query_students_reads = """
SELECT s.sid, s.name, s.state, r.aid, a.title
FROM Students s
JOIN Reads r ON s.sid = r.sid
JOIN Articles a ON r.aid = a.aid

"""
df_students_reads = pdsql.read_sql(query_students_reads, con=connection)

# Print out the information about the StudentsReads dataframe
print("Columns of the StudentsReads dataframe:")
print(df_students_reads.columns)

print("Records in the StudentsReads dataframe:", len(df_students_reads))
print("Number of columns in the StudentsReads dataframe:", len(df_students_reads.columns))

print("Name of the columns in the StudentsReads dataframe:")
print(df_students_reads.columns)


# Filter Students from state MA
df_ma_students = df_students_reads[df_students_reads['state'] == 'MA']

# Group by to count articles read by MA students
articles_read_by_ma = df_ma_students.groupby('name')['aid'].count()
print("Number of articles read by each MA student:")
print(articles_read_by_ma)

# Close the connection
connection.close()


