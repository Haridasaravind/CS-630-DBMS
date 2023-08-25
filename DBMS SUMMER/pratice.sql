



Singers(sid:int, name:string,city:string,state:string, age:real, rating:int)
Rents(sid:int, mid:int, rentdate:date)
Instruments(mid:int, category:string, myear:int, brand:string, model:string, dailyfee:real)



create table Singers(
sid integer primary key
name varchar(20)
city varchar(20)
state varchar(20)
age integer
rating real
);

create table Instruments(
mid integer primary key
category varchar
myear integer
brand varchar
model varchar
dailyfee real
);

create table Rents(
sid integer, 
mid integer,
primary key (sid , mid),
FOREIGN KEY (sid) refernce singers(sid),
FOREIGN key (mid) refernce Instruments(mid)
);
