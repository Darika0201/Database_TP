use estate_agency;

#1	List type and address of all properties.
select type, address
from property;

#2	List information about all flats.
select *
from property
where type = 'flat' ;

#3	List information about property located in Bell ville
select *
from property
where address like "%Bell ville%" ;

#4	List information of rent that costs between 500 and 1000.
select *
from rent
where price between 500 and 1000 ;

#5	List information of rent that started before 2012.
select *
from rent
where year(rent_date) < 2012 ;

#6	List ID of client who has rented property number 2.
select clientID
from rent as r
where r.propertyID = 2 ;

#7	List phone number of client who has rented property number 2.
select tel
from client c join rent r
	on c.clientID = r.clientID
where r.propertyID = 2 ;

#8	List information about properties rent by John.
select p.*
from property p join rent r join client c
	on p.propertyID = r.propertyID
    and r.clientID = c.clientID
where c.name = 'John' ;

#9	List information of client who has rent an apartment.
select c.*
from client c join rent r join property p
	on c.clientID = r.clientID
    and r.propertyID = p.propertyID
where p.type = "apartment";

#10	List information of client who has never rented a property.

select c.*
from client as c
where c.clientID not in (select c1.clientID
							from client c1 join rent r
								on c1.clientID = r.clientID);

#11	List the property with the highest rental price.

select p.*
from property p join rent r
	on p.propertyID = r.propertyID
where r.price = (select max(price) from rent) ;

/*12	For client who has rented the same property multiple times, list client’s id, client’s name,
property id, rent_date and price order by client id and rent date.	*/

select c.clientID, c.name, r.propertyID, r.rent_date, r.price
from client c join rent r
	on c.clientID = r.clientID
group by c.clientID, r.propertyID
having count(*) > 1
order by c.clientID, rent_date ;

#13. Show the maximum, minimum and average rental price of each property.
select propertyID, max(price), min(price), avg(price)
from rent natural join property
group by propertyID;

#14. Show house in Cow City that is available for rent between January 2018 and December 2020.
select p.*
from property p join rent r
	on p.propertyID = r.propertyID
where p.address like '%Cow City%' 
	and r.rent_date like '2018%' 
    and r.end_date like '2020%' ;
