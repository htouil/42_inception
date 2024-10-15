#!/bin/bash

# modify the mariadb configuration file so that it accepts connections from any IP
sed -i "s/bind-address.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# start the mariadb server
service mariadb start
sleep 5

# create a new database
mysql -u root -p${DB_ROOT_PWD} <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS \`${DB_USER_NAME}\`@'%' IDENTIFIED BY '${DB_USER_PWD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER_NAME}\`@'%';
FLUSH PRIVILEGES;
EOF

# shutdown the mariadb server so that the previous modifications apply
mysqladmin -u root -p${DB_ROOT_PWD} shutdown


# start the mariadb server in the forground so that it keeps hanging and doesnt exit
mysqld --user=root
