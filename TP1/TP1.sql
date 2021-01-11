#create database
create database sailor;

#use the database
use sailor;

#create table sailors in database sailor.
create table sailors(
	sid int primary key,
    sname varchar(20),
    rating int,
    age int
);

#create table boats
create table boats(
	bid int primary key,
    bname varchar(20),
    color varchar(20)
);

#create table reserves
create table reserves(
	sid int,
    bid int,
    day date,
    constraint primary key (sid, bid, day),
    constraint foreign key (sid) references sailors (sid),
    constraint foreign key (bid) references boats (bid)
);

#modify the datatype of attribute age in table sailors
alter table sailors modify age decimal(3,1);

#add check constraint to attribute rating. MySQL doesn't support check constraint.
alter table sailors add constraint check (rating in (1,2,3,4,5,6,7,8,9,10));

#insert data into table sailors
insert into sailors values(22,"Dustin",7,45),
						(29,"Brustus",1,33),
                        (31,"Lubber",8,55.5),
                        (32,"Andy",8,25.5),
                        (58,"Rusty",10,35),
                        (64,"Horatio",7,35),
                        (71,"Zorba",10,16),
                        (74,"Horatio",9,35),
                        (85,"Art",3,25.5),
                        (95,"Bob",3,63.5);
                        
#insert data into table boats
insert into boats values (101, 'interlake', 'blue'),
						(102, 'interlake', 'red'),
                        (103, 'Clipper', 'green'),
                        (104, 'Marine', 'red');
       
#insert data into table reserves
insert into reserves values (22, 101, '1998-10-10'),
						(22, 102, '1998-10-10'),
                        (22, 103, '1998-08-10'),
                        (22, 104, '1998-07-10'),
                        (31, 102, '1998-10-11'),
                        (31, 103, '1998-06-11'),
                        (31, 104, '1998-12-11'),
                        (64, 101, '1998-05-09'),
                        (64, 102, '1998-08-09'),
                        (74, 103, '1998-08-09');
