use producttest;

#1	Show id and name of customer along with order id and oder_date of the order they have made.
select c.ID, c.name,  o.ID, o.order_date
from customer_t c join order_t o
	on c.ID = o.customer_ID;

#2	Show id and description of product and its quantity in each order.
select ol.order_ID, p.ID, p.description, ol.quantity
from product_t p join order_line_t ol
	on p.ID = ol.product_ID
order by ol.order_ID;

#3	Show id and name of customer along with id and description of product they have ordered.
select c.ID, c.name, p.ID, p.description 
from customer_t c join order_t o join order_line_t ol join product_t p 
	on c.ID = o.customer_ID and o.ID = ol.order_ID and p.ID = ol.product_ID
order by c.ID;

#OR
select c.ID, c.name, p.ID, p.description 
from customer_t c 
	join order_t o
    join order_line_t ol
	join product_t p 
		on c.ID = o.customer_ID 
        and o.ID = ol.order_ID
        and ol.product_ID = p.ID
order by c.ID;

#OR
select c.id, c.name, p.id, p.description
from customer_t c, product_t p
where (c.id, p.id) in
		(select customer_id, product_id
        from order_t o join order_line_t ol on o.id = ol.order_ID)
order by c.id;

#4	Repeat 1. and include the customers who has never made any order to the result (by using outer join).
select c.ID, c.name, o.ID, o.order_date
from customer_t c left join order_t o
	on c.ID = o.customer_ID;
    
#5	Show product with the lowest standard price.
select *
from product_t
where standard_price = (select min(standard_price) from product_t);

#OR
select *
from product_t p
where standard_price <= all
		(select standard_price from product_t p1 where p1.id <> p.id and not isnull(standard_price));

#OR
select *
from product_t p
where not standard_price > any
	(select standard_price from product_t p1 where p1.id <> p.id and not isnull(standard_price));

#OR
select *
from product_t p 
where not exists
			(select *
				from product_t p1
                where p1.id <> p.id and p.standard_price > p1.standard_price) 
                and not isnull(standard_price);

#6	Show product with the same name.
select *
from product_t p
where exists (select *
				from product_t p1
                where p1.id <> p.id and p1.description = p.description);

#OR
select p.*
from product_t p join product_t p1
	on p.id <> p1.id and p.description = p1.description ;

