import oracledb
import getpass
import pandas.io.sql as pdsql

# READ USERNAME, PASSWORD, DB HOST, DB NAME from command line
username = input("Enter your username:")
userpwd = getpass.getpass("Enter password: ") #Enter the pass set for you to access 
hostname = input("Enter the hostname:")
database = input("Enter the database:")

'''
if hostname does not have / at the end, then add it.

Establish the connection to DBMS
'''
if (hostname[-1]=='/'):
    connection = oracledb.connect(user=username,
                password=userpwd,dsn=hostname+database)
elif (hostname[-1]!='/'):
    connection = oracledb.connect(user=username,
                password=userpwd,dsn=hostname+'/'+database) #username to access 
                                                             #Oracle databses (in quotes)


#Establish the connection to DBMS
dsn = f"{username}/{userpwd}@{hostname}/{database}"
if hostname[-1] == '/':connection = oracledb.connect(user=username,password=userpwd,dsn=dsn)
else:connection = oracledb.connect(user=username, password=userpwd,dsn=f"{hostname}/{database}")



#run query against DB
df = pdsql.read_sql('SELECT * FROM sailors', con=connection)
#print the names of columns from the dataframe
print(df.columns)
print('Dataframe data')
print(df)
# prints the first 5 rows
print("df head")
print(df.head())
print("df shape")
print(df.shape)
print("df with only name and age")
df2=df[['SNAME','AGE']]
print(df2)
print("df2 shape")
print(df2.shape)

print("Calculate min and mean for all columns")
print(df.agg(['min','mean']))

print("Average only for rating column")
print(df.RATING.agg(['mean']))

print("Another ay to get the average only for rating column")
print(df[['RATING']].agg(['mean']))

#close the connection
connection.close()
