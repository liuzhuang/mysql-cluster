
# echo '变量'
# dot='.*'
# echo "$dot\n"
# echo '----------------------------------------------------------------------------------------------------------------------------------'


# # 查看主库状态
# # docker exec qimai_mysql_master sh -c 'mysql -u root -p123456 -e "SHOW MASTER STATUS \G"'

# # 查看主库 server_id
# docker exec qimai_mysql_master sh -c 'mysql -u root -p123456 -e "select @@server_id as server_id;"'

# # 查看主库 server_id
# docker exec qimai_mysql_slave sh -c 'mysql -u root -p123456 -e "select @@server_id as server_id;"'

# # 查看主库 server_id
# docker exec qimai_mysql_slave2 sh -c 'mysql -u root -p123456 -e "select @@server_id as server_id;"'

mysql_user="qimai_slave_user" 
mysql_password="123456"
root_password="123456" 
master_container=qimai_mysql_master


# 在主服务器上添加数据库用户
# echo '在主服务器上添加数据库用户----------------------------------------------------------------------------------------------------------------------------------'
priv_stmt="GRANT REPLICATION SLAVE ON *.* TO "qimai_slave_user"@"%" IDENTIFIED BY "123456";"
docker exec $master_container sh -c 'export MYSQL_PWD='$root_password'; mysql -u root -e "$priv_stmt"'


# 更改 Slave 加密方式 
echo '\n更改 Slave 加密方式 ----------------------------------------------------------------------------------------------------------------------------------'
docker exec $master_container sh -c 'export MYSQL_PWD='$root_password'; mysql -u root -e "alter user "qimai_slave_user"@"%" identified with mysql_native_password by '123456';"'


# FLUSH PRIVILEGES
echo '\nFLUSH PRIVILEGES ----------------------------------------------------------------------------------------------------------------------------------'
docker exec $master_container sh -c 'export MYSQL_PWD='$root_password'; mysql -u root -e "FLUSH PRIVILEGES;"'





