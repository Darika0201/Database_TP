use classicmodels;

#1. Show first name and last name of customer from France.
select contactFirstName, contactLastName
from customers
where country = "France";

#2. Show the first name and last name of employee who is a sale manager.
select firstName, lastName
from employees
where jobTitle regexp "sales? manager.*";
	#OR
select firstName, lastName
from employees
where jobTitle like "sale% manager%" ;

#3. Show all product which is in “classic car” product line.
select *
from products
where productline = "classic cars";

#4. Show all products containing “Toyota” in its name.
select *
from products
where  productName like "%Toyota%";
	#OR
select *
from products
where productName regexp "(Toyota)+";

#5. Show all products with the scale smaller than 1:24.
select *
from products
where substring_index(productScale, ":",-1) < 24;
	#OR
select *
from products
where productScale < '1:24' ;

#6. Show all products from the vendor “Autoart Studio Design”.
select *
from products
where productVendor = "Autoart Studio Design" ;

#7. Show all products with MSRP (the manufacturer’s suggested retail price) higher than twice the cost of buyPrice.
select * 
from products
where MSRP > buyPrice*2 ;

#8. Show information of sale representative of the customer “Land of toys Inc.”
select e.*
from customers c join employees e
	on c.salesRepEmployeeNumber = e.employeeNumber
where customerName = "Land of toys Inc." ;

#9. Show information about order that is shipped later than the required date.
select *
from orders
where requiredDate < shippedDate ;

#10. Show all orders made by “La Rochelle Gifts”.
select o.*
from customers c join orders o
	on c.customerNumber = o.customerNumber
where customerName = "La Rochelle Gifts" ;

#11. Show all products ordered by “La Rochelle Gifts”.
select p.*
from customers c join orders o join orderdetails od join products p
	on c.customerNumber = o.customerNumber
    and o.orderNumber = od.orderNumber
    and od.productCode = p.productCode
where customerName = "La Rochelle Gifts" ;

#12. Show customer’s name who has ordered more than 15 products in once.
select customerName
from customers
where customerNumber in
	(select customerNumber
		from orders o join orderdetails od
			on o.orderNumber = od.orderNumber
		group by o.orderNumber
        having count(productCode) > 15 ) ; 
	
    #OR
select customerName
from customers c join orders o join orderdetails od
	on c.customerNumber = o.customerNumber
    and o.orderNumber = od.orderNumber
group by o.orderNumber
having count(productCode) > 15 ;

#13.Show the best-selling product in “2004-02”.
create view saledetail200402 as
	select od.productCode, sum(od.quantityOrdered) as totalquantity
    from orders o join orderdetails od
		on o.orderNumber = od.orderNumber
	where year(o.orderDate) = 2004 and month(o.orderDate) = 2
    group by od.productCode ;

select p.*
from products as p join saledetail200402
	on p.productCode = saledetail200402.productCode
where totalquantity = (select max(totalquantity) from saledetail200402) ;