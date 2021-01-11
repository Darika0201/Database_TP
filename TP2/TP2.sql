use sailor;

#2. a.	List the name of sailors who are rated higher than 7.
select sname
from sailors
where rating > 7;

#b.	List the name and rate of sailors who have rate higher than 7 and are younger than 50.
select sname, rating
from sailors
where rating > 7 and age < 50;

#c.	List information of the sailor named “Horatio”.
select *
from sailors
where sname = "Horatio";

#d.	List information of sailors whose name starts with “A”.
select *
from sailors
where sname like "a%";

	#or read mysql manual for better understanding of regexp.

select *
from sailors
where sname regexp "^a.*";

#e.	List information of sailors whose name start with “A” and end with “Y”.
select *
from sailors
where sname like "a%y";
	#or
select *
from sailors
where sname regexp "^a.*y$";

#f.	List information of all red boat.
select *
from boats
where color = "red";

#g.	List information about boats reservation in October 1998.
select *
from reserves
where day like "1998-10-%";

	#OR
select *
from reserves
where day >= "1998-10-01" and day <= "1998-10-31";

	#OR
select *
from reserves
where day between "1998-10-01" and "1998-10-31";

	#OR
select *
from reserves
where day regexp "^(1998-10-)[0-9]{2}$";

#h.	Find the names of sailors who have reserved boat 103.
select sname
from sailors natural join reserves
where bid = 103;

	#OR
select sname
from sailors join reserves
	on sailors.sid = reserves.sid
where bid = 103;

	#OR
select sname
from sailors, reserves
where sailors.sid = reserves.sid and bid = 103;

#i. Find the names of sailors who have reserved a red boat.
select distinct sname
from sailors natural join reserves natural join boats
where color = "red";

	#OR
select distinct sname
from sailors s, reserves r, boats b
where s.sid = r.sid and r.bid = b.bid and color = "red";

#j.	Find the names of sailors who have reserved at least one boat.
select distinct sailors.sid, sname
from sailors natural join reserves;

#k.	Find the names of sailors who have reserved a red or a green boat.
select distinct sailors.sid, sname
from sailors natural join reserves natural join boats
where color = "red" or color = "green";

	#OR
select sailors.sid, sname
from sailors natural join reserves natural join boats
where color = "red"
union
select sailors.sid, sname
from sailors natural join reserves natural join boats
where color = "green";

#l.	Find the names of sailors who have reserved a red and a green boat.
select distinct sailors.sid, sname
from sailors natural join reserves natural join boats
where color = "red" and sailors.sid in
	(select sailors.sid
    from sailors natural join reserves natural join boats
    where color = "green");
    
#m.	Find pairs of boats that have the same name.
select*
from boats as b1, boats as b2
where b1.bname = b2.bname and b1.bid < b2.bid;
