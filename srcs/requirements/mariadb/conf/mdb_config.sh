#!/bin/bash

# modify the mariadb configuration file so that it accepts connections from any IP
sed -i "s/bind-address.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# start the mariadb server
service mariadb start
sleep 5

# create a new database
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${DB_USER_NAME}\`@'%' IDENTIFIED BY '${DB_USER_PWD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER_NAME}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

# shutdown the mariadb server so that the previous modifications apply
mysqladmin -u root -p${DB_ROOT_PWD} shutdown
sleep 5

# start the mariadb server in the forground so that it keeps hanging and doesnt exit
mysqld --user=root
