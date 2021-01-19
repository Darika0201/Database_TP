use classicmodels;

#1	Show first name and last name of customer from France.
select contactFirstName, contactLastName
from customers
where country = 'France';

#2	Show the first name and last name of employee who is a sale manager.
select firstName, lastName
from employees
where jobTitle like '%sale manager%';

#3 Pair the name and number of employees along with the name of his/her advisor.
select em.employeeNumber, em.lastName, em.firstName,
		adv.employeeNumber as advisorNumber, adv.lastName as advisorLastName , adv.firstName as advisorFirstName
from employees as em join employees as adv
	on em.reportsTo = adv.employeeNumber;
    
#4  Pair the name and number of customers along with the name of sale representative that work with them. 
#If the sale representative is null, replace it with N/A.

select cus.customerNumber, cus.contactLastName, cus.contactFirstName,
	ifnull(SRE.lastName, 'N/A') as SaleRepresentativeLastName, ifnull(SRE.firstName,'N/A') as SaleRepresentativeFirstName
from customers as cus left join employees as SRE
	on cus.salesRepEmployeeNumber = SRE.employeeNumber
order by cus.customerNumber;

#5	Show information of customer, if the creditlimited is greater than 80 000, then the customer is vip. If not he is normal.
select *, if(cus.creditLimit > 80000, 'VIP', 'Normal') as Customer_status
from customers cus;

#6 Show all product which is in “classic car” product line.
select * from products
where productline like 'classic car%';

#7 Show all products containing “Toyota” in its name.
select * from products
where productName like '%Toyota%' ;

#8 Show all products with the scale smaller than 1:24.
select * from products
where productScale < "1:24" ;

#9 Show all products from the vendor “Autoart Studio Design”.
select * from products
where productVendor like 'Autoart Studio Design';

#10. Show all products with MSRP (the manufacturer’s suggested retail price) higher than twice the cost of buyPrice.
select * from products
where MSRP > buyPrice;

#11. Show information of sale representative of the customer “Land of toys Inc.”
select em.* 
from employees as em join customers as cus
	on em.employeeNumber = cus.salesrepEmployeeNumber
where cus.customerName like 'Land of toys Inc.';

#12. Show information about order that is shipped later than the required date.
select * from orders
where shippedDate > requiredDate;

#13. Show all orders made by “La Rochelle Gifts”.
select o.* 
from orders o join customers cus
	on o.customerNumber = cus.customerNumber
		and cus.customerName like 'La Rochelle Gifts';

#14. Show all products ordered by “La Rochelle Gifts”.
select p.* 
from products as p join orderdetails as ord join 
		orders as o join customers cus
	on p.productCode = ord.productCode
		and ord.orderNumber = o.orderNumber
		and o.customerNumber = cus.customerNumber
		and cus.customerName like 'La Rochelle Gifts';
#OR
select p.*
from products as p natural join orderdetails as ord natural join 
		orders as o natural join customers cus
where cus.customerName like 'La Rochelle Gifts';


#15. Show customer’s name who has ordered more than 15 products in once.
select customerName
	from customers cus join orders as o join orderdetails as ord
			on cus.customerNumber = o.customerNumber
				and o.orderNumber = ord.orderNumber
		group by o.orderNumber
		having count(ord.productCode) > 15 ;

select customername
from customers
where customernumber in 
	(select customernumber
	from orders o join orderdetails od
		on  o.orderNumber = od.orderNumber
	group by o.orderNumber
	having count(productcode) > 15);

select customerName
	from customers 
    where customerNumber in (select customerNumber
		from orders as o join orderdetails as ord
			on o.orderNumber = ord.orderNumber
		having count(ord.productCode) > 15);

select count(od.productCode)
from orderdetails as od; 
 
#16. Show the best-selling product in “2004-02”.
#17. Find the lowest sale price of each product.
#18. Find the biggest gape of sale price of each product.
#19. Find the product with the biggest gape of sale price.
#20. Find the total cost of all orders of each customer.
#21. Find the top customer (with the highest total sale cost) of each city.
#22. Show monthly income, purchase expense, and profit in a specific year. An order that is placed in which
#month would be considered as part of income of that month; the state of shipment and payment are taken into account.