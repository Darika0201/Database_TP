#SHOW TABLES;



SELECT * 
FROM customers 
WHERE city = 'lyon';



SELECT *#contactFirstname, contactLastname, country
FROM customers
WHERE country = 'France';
#2
SELECT firstname, lastname , CONCAT(firstname, ' ', lastname) AS fullname FROM employees
WHERE jobTitle LIKE '%sale%manager%';
#3
SELECT em.employeeNumber, em.firstName, em.Lastname, em.reportsto, adv.firstname, adv.lastname AS advisor
FROM employees em
	JOIN employees adv
	ON em.reportsTo = adv.employeeNumber;
#WHERE adv.lastName = 'Murphy';
#4
SELECT cus.customerNumber ,cus.contactfirstname, cus.contactlastname, COALESCE(sr.firstname, 'N/A')
, sr.employeeNumber,cus.salesrepemployeenumber, COALESCE(sr.lastname,'N/A')
FROM customers cus
	left JOIN employees sr
	ON cus.salesrepemployeenumber= sr.employeeNumber;
#5	
SELECT * , if(creditlimit > 80000, 'VIP', 'Normal' )
FROM customers;
#6
SELECT * 
FROM products
WHERE productline = 'classic cars';
#7
SELECT * FROM products
WHERE productname LIKE '%toyota%';

#8
SELECT * FROM products WHERE productscale > "1:24" ;
#9
SELECT * FROM PRODUCTS WHERE productvendor = 'autoart studio design'; 


#10
SELECT * FROM products WHERE MSRP > buyprice*2;

#11
SELECT emp.*
FROM employees emp JOIN customers c
	ON emp.employeeNumber = c.salesRepEmployeeNumber
WHERE customerName = 'land of toys inc.';

#12
SELECT * FROM orders WHERE shippeddate > requireddate;

#13
SELECT o.*, c.*
FROM orders o natural JOIN customers c 
#	ON o.customerNumber = c.customerNumber
WHERE c.customerName = 'La Rochelle Gifts';

#14
SELECT * #p.*
FROM orders o natural JOIN customers c NATURAL JOIN orderdetails od
	NATURAL JOIN products p

WHERE c.customerName = 'La Rochelle Gifts';

#15
SELECT COUNT(od.productCode)
FROM orderdetails od

;


SELECT city ,COUNT(customers.salesRepEmployeeNumber) FROM customers 
GROUP BY city;


SELECT od.orderNumber,  COUNT(od.productCode) AS num
FROM orderdetails od
GROUP by od.orderNumber
HAVING  num > 15;

#16


#show product num , total ordered quantity
SELECT productcode,SUM(quantityordered) as total FROM orderdetails
WHERE ordernumber 
	IN(SELECT o.orderNumber 
		FROM orders o  
		WHERE year(o.orderDate) = 2004 AND MONTH(o.orderDate) = 2)
	
GROUP BY productcode
HAVING total = 
		(SELECT MAX(total) # return the highest ordered quantity of product 77
		from
			(SELECT productcode,SUM(quantityordered) as total 
			FROM orderdetails
			WHERE ordernumber 
				IN(SELECT o.orderNumber 
					FROM orders o  
					WHERE year(o.orderDate) = 2004 AND MONTH(o.orderDate) = 2
					)
			GROUP BY productcode
			) temp 
		)
;

SELECT productcode,SUM(quantityordered) as total 
FROM orderdetails od natural JOIN orders o
WHERE year(o.orderDate) = 2004 AND MONTH(o.orderDate) = 2
GROUP BY productcode
HAVING total = 
		(SELECT max(total) 
		FROM (SELECT productcode,SUM(quantityordered) as total 
				FROM orderdetails od natural JOIN orders o
				WHERE year(o.orderDate) = 2004 AND MONTH(o.orderDate) = 2
				GROUP BY productcode
				) AS temp
				
		)
;

#17

SELECT *
FROM orders
WHERE YEAR(orderdate) = 2004
order BY YEAR(orderdate), MONTH (orderdate);



;


SELECT o.orderNumber FROM orders o  WHERE year(o.orderDate) = 2004 AND 
	MONTH(o.orderDate) = 2;


SELECT * FROM orderdetails;


USE classicmodels;

SELECT YEAR( o.orderDate ), MONTH(o.orderDate)
	, SUM(od.quantityOrdered* od.priceEach) AS incomes
	, SUM(od.quantityOrdered* p.buyPrice) AS purchase_expenses
	, SUM(od.quantityOrdered* od.priceEach) 
		- SUM(od.quantityOrdered* p.buyPrice) AS profit
FROM orders o NATURAL JOIN orderdetails od NATURAL JOIN products p
WHERE YEAR( o.orderDate ) = 2004
GROUP BY YEAR( o.orderDate ), MONTH(o.orderDate)
;



#2.1 lowest saleprice of each product

SELECT od.productCode, MAX(od.priceEach) MAXprice,min(od.priceEach)minprice
	, COUNT(od.productCode) numorder
	,  MAX(od.priceEach)-min(od.priceEach) pricegape
FROM orderdetails od
GROUP BY od.productCode 
HAVING pricegape =  (SELECT MAX(pricegape)
FROM (SELECT od.productCode, MAX(od.priceEach) MAXprice,min(od.priceEach)minprice
	, COUNT(od.productCode) numorder
	,  MAX(od.priceEach)-min(od.priceEach) pricegape
FROM orderdetails od
GROUP BY od.productCode ) temp
);


SELECT MAX(pricegape)
FROM (SELECT od.productCode, MAX(od.priceEach) MAXprice,min(od.priceEach)minprice
	, COUNT(od.productCode) numorder
	,  MAX(od.priceEach)-min(od.priceEach) pricegape
FROM orderdetails od
GROUP BY od.productCode ) temp


;


SELECT c.*,sum(od.quantityOrdered* od.priceEach) totalcost
FROM customers c natural join orders o NATURAL JOIN orderdetails od 
WHERE (city, )
GROUP BY c.customerNumber
									(
									SELECT city, MAX(totalcost)
									FROM (
											SELECT c.*,sum(od.quantityOrdered* od.priceEach) totalcost
											FROM customers c natural join orders o NATURAL JOIN orderdetails od 
											GROUP BY c.customerNumber
											) temp
									GROUP BY city
									
									)
									
									;
		
		
		;





SELECT priceeach
FROM ORDERdetails
WHERE productcode = 's18_4933';