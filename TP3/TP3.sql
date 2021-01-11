use producttest;

#1	List all customers‟ name and city.
select name, city
from customer_t;

#2	List the information of customer from „CA‟ (state).
select *
from customer_t
where state = "CA";

#3	List ID, description and standard price of products made from “ash”.
select ID, description, standard_price
from product_t
where finish like "%ash%";

#4	List the information of product that is made from “ash” and costs between 15 and 80.
select *
from product_t
where finish like "%ash%" and standard_price >= 15 and standard_price <= 80;

#OR
select *
from product_t
where finish like "%ash" and standard_price between 15 and 80;

#5	Show all products and sort the result by stand price (from the cheapest to the most expensive).
select *
from product_t
order by standard_price;

#6	Show the cross product between customer and order.
select *
from product_t join order_t;

#7	Show the information of customer who has made order on “2004-04-01”.
select c.*
from customer_t c join order_t o
	on c.ID = o.customer_ID
where order_date = "2004-04-01";

#OR
select c.*
from customer_t c join order_t o
	on c.ID = o.customer_ID
where date(order_date) = "2004-04-01";

#8	Show information of products in the order number 106.
select p.*
from order_line_t ol join product_t p
	on ol.product_ID = p.ID
where ol.order_ID = 106;

#OR
select p.*
from product_t p join order_line_t ol
	on p.ID = ol.product_ID
where ol.order_ID = 106;

#9	Show the information of customer who has made order number 106.
select c.*
from customer_t c join order_t o
	on c.ID = o.customer_ID
where o.ID = 106;

#10	Show the order which contains book shelf.
select o.*
from order_t o join order_line_t ol join product_t p
	on o.ID = ol.order_ID and ol.product_ID = p.ID
where p.description like "%book shelf%";

#11	 Show the order which contains table lamp.
select o.*
from order_t o join order_line_t ol join product_t p
	on o.ID = ol.order_ID and ol.product_ID = p.ID
where p.description like "%table lamp%";

#12	Show the order which contain book shelf or table lamp.
select o.*
from order_t o join order_line_t ol join product_t p
	on o.ID = ol.order_ID and ol.product_ID = p.ID
where p.description like "%book shelf%" or p.description like "%table lamp%";

#13	Show the order which contain book shelf and table lamp
select o.*
from order_t o join order_line_t ol join product_t p
	on o.ID = ol.order_ID and ol.product_ID = p.ID
where p.description like "%book shelf%" and o.ID in
	(select ol.order_ID
    from order_line_t ol join product_t p
		on ol.product_ID = p.ID
	where p.description like "%table lamp%");
    
#14	Show the order which contain book shelf but not table lamp.
select o.*
from order_t o join order_line_t ol join product_t p
	on o.ID = ol.order_ID and ol.product_ID = p.ID
where p.description like "%book shelf%" and o.ID not in
	(select ol.order_ID
	from order_line_t ol join product_t p
		on ol.product_ID = p.ID
	where p.description like "%table lamp%");