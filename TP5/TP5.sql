use producttest;

#1	Find all products ordered by “John Doe”.
select distinct p.*
from customer_t c join order_t o join order_line_t ol join product_t p
	on c.id = o.customer_id and o.id = ol.order_ID and ol.product_ID = p.id
where c.name = "John Doe";

#OR
select p.*
from product_t p join order_line_t ol join order_t o join customer_t c
	on p.id = ol.product_id and ol.order_id = o.id and o.customer_id = c.id
where c.name = "John Doe"; 

#2	Find customer who has ordered any products ordered by “John Doe”.
select distinct c.*
from customer_t c join order_t o join order_line_t ol join product_t p
	on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
where c.name <> "John Doe" and p.id in
	(select p.id
		from customer_t c join order_t o join order_line_t ol join product_t p
			on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
        where c.name = "John Doe");

#OR not work
select distinct c.*
from customer_t c join order_t o join order_line_t ol join product_t p
	on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
where p.id in (select id from product_john);

#3	Find customer who has ordered any products finished in “Natural Ash”.
select distinct c.*
from customer_t c join order_t o join order_line_t ol join product_t p
	on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
where p.finish = "Natural Ash";

#4	Find order that contains more than 2 products.
/* need to insert at least one more row to an order that containts two products 
because there is not any order that containts more than two products in the current database. */

insert into order_line_t values(101, 3000, 4);

select order_t.*
from order_t join
	(select order_id
		from order_line_t
        group by order_id
        having count(product_id) > 2) as o on order_t.id = o.order_id;

#OR
select *
from order_t
where id in
	(select order_id
		from order_line_t
        group by order_id
        having count(product_id) > 2);

#5	Find customer who has made more than 1 order.
select *
from customer_t
where id in
	(select customer_id
		from order_t
        group by customer_id
        having count(id) > 1);
        
 #6	Pair customer and his/her total number of orders.
 select *
 from customer_t c join (select customer_id, count(id) as totalnumberoforder
							from order_t
                            group by customer_id) as numorder
					on c.id = numorder.customer_id;

#7	Find the total number of unit of “office chair” sold in April, 2004.
select sum(quantity)
from order_t o join order_line_t ol join product_t p
	on o.id = ol.order_id and ol.product_id = p.id
where p.description like "%office chair%" and
	order_date between "2004-04-01" and "2004-04-30";
    
#8	Find the total cost of order made by “John Doe”.
select sum(quantity*standard_price)
from customer_t c join order_t o join order_line_t ol join product_t p
	on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
where c.name = "John Doe";

#9 Find the average cost of order made by “John Doe”.
select avg(t.total)
from (select o.id, sum(quantity*standard_price) as total
		from customer_t c join order_t o join order_line_t ol join product_t p
			on c.id = o.customer_id and o.id = ol.order_id and ol.product_id = p.id
		where c.name = "John Doe"
        group by o.id) as t;

#10	Find the order that contain all products made from cherry.
select *
from order_t o
where not exists	 #there is not any cherry product that is not in product list of order o.id
	(select id
		from product_t
        where finish like "%cherry%" and id not in #all product id finished in cherry
			(select ol.product_id
				from order_line_t ol
                where ol.order_id = o.id) #all product_id in order o.id
			);
            
#OR
select *
from order_t o1
where not exists (select *
					from order_t as o2, product_t as p2
                    where finish like '%cherry%' and o2.id = o1.id
						and not exists (select *
											from order_line_t
                                            where product_id = p2.id and order_id = o2.id));
        
#OR
select *
from order_t
where id not in (select distinct o.id
					from order_t o, product_t p
                    where finish like '%cherry%' and (o.id, p.id) not in
																	(select order_id, product_id from order_line_t));

#11	Find the customer who has ordered all kind of table lamp.
select *
from customer_t c
where not exists #There is not any table lamp product that is not in product list ordered by c.id
	(select id
		from product_t
        where description like "%table lamp%" and id not in #all product id with description table lamp
			(select ol.product_id
				from order_t o join order_line_t ol
					on o.id = ol.order_id
				where o.customer_id = c.id)	#all product_id ordered by c.id
			);

