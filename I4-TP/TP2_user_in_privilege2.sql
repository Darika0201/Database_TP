#8	Create a user called dara with password Darapassword123, who can access from any host.
CREATE USER dara_e20170053@'%' IDENTIFIED BY 'Dara@22!';

#9	Grant the privilege select, update, delete on table classicmodels.products to dara.
# Ex :	grant all on mydb.mytbl to dara_e20170053@'%';

grant select, update, delete on classicmodels.products to dara_e20170053@'%';

#10	Revoke the privilege update on table classicmodels.products from dara.
revoke update on classicmodels.products from dara_e20170053@'%';

#11. Grant the privilege select, update on columns productLine of table classicmodels.productLines to dara.

#grant select, update on classicmodels.productlines to dara_e20170053@'%';

grant select(productline), update(productline) on classicmodels.productlines to dara_e20170053@'%';

#12. Revoke the privilege update on column productLine of table classicmodels.productLines from dara.
#revoke update 
#on classicmodels.productlines 
#from dara_e20170053@'%';

revoke update(productline)
on classicmodels.productlines
from dara_e20170053@'%';

#13. Connect to the server as dara and try to delete one record from table
#	classicmodels.productLines. Explain the result of this operation.
grant delete on classicmodels.productlines to dara_e20170053@'%';

#14. Login as acadmin and drop user dara@yourhost.

