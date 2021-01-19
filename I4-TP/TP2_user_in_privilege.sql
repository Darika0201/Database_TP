select database();	#show curent selected database.
select user();		#show current user.
SHOW GRANTS FOR acadmin;	#show privileges of user.
SELECT * from mysql.user;	#show users in the system and their global privileges.
SELECT * from mysql.db;		# show database privileges.
select * from mysql.tables_priv;	#show table table privileges.
select * from mysql.columns_priv;	#show column privileges.
select * from information_schema.processlist;		#show current connection to the server.
Flush privileges; 	#notify the server to reload the privilege when you change it by using insert, 
					#update or delete commands on privileges tables.
show privileges; 	#show list of privileges provided by mysql.



#1	Use your student ID number as user name to create a user, who can only access the server from localhost.
create user e20170053@localhost identified by 'Acadmin1234!';

#2	Make change to the user to make it be able to connect to the server from any host.
rename user e20170053@localhost to e20170053@'%';

#3	Set password Mpassword6 for the user.
set password for e20170053@'%' = 'Darika22!';

#4	Grant all privileges on database classicmodels to the user and make it be able to grant those privileges to other users.
GRANT ALL ON classicmodels.* TO e20170053@'%';

#5	Grant needed privileges to the user you have just created (student ID number) to make it able to create user and grant privileges to user.
GRANT CREATE USER, GRANT OPTION ON *.* TO e20170053@'%';

#6	Set this resource limits to user you have just created (student ID number):
#	• maximum simultaneous user connection is 2
#	MAX_USER_CONNECTIONS number_of_connection
#	• User can connect to the server at most 10 times per hour
#	MAX_CONNECTIONS_PER_HOUR number_of_connection

ALTER USER e20170053@'%' WITH MAX_USER_CONNECTIONS 2;
alter user e20170053@'%' with max_connections_per_hour 10;

#7. Logout from user acadmin. Login with the user you have just created (student ID number).
# -> Login to e20170053 pass 'Darika22!'

#14. Login as acadmin and drop user dara@yourhost.
drop user dara_e20170053@'%';
