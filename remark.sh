docker exec -it qimai_mysql_master bash


mysql -u root -p123456
use mysql;
select Host, User, plugin, authentication_string from mysql.user\G;
update user set Host = '%' where User = 'root';
alter user 'qimai_slave_user'@'%' identified with mysql_native_password by '123456';
flush privileges;





docker exec -it qimai_mysql_slave bash
docker exec -it qimai_mysql_slave2 bash


docker exec qimai_mysql_slave sh -c 'mysql -u root -p123456 -e "SHOW SLAVE STATUS \G"'



grant replication slave on *.* to "qimai_slave_user"@"%" identified by "123456";