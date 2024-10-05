#!/bin/bash

# download the PHP archive for WP-CLI used to manage wordpress installation and give it executable
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mkdir -p /usr/local/bin/wp
mv wp-cli.phar /usr/local/bin/wp/wp

# wait for the mariadb server to first start properly
WP_INSTALL_LOGS="/var/log/wordpress_install.log"
: > ${WP_INSTALL_LOGS}

limit_time=$(( $(date +%s) + 20 ))
while [ $(date +%s) -lt $limit_time ]; do
	mysqladmin -h mariadb -u root -p$DB_ROOT_PWD ping > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "[========MARIADB IS UP AND RUNNING========]" >> ${WP_INSTALL_LOGS}
        break
	else
		echo "[========WAITING FOR MARIADB TO START...========]" >> ${WP_INSTALL_LOGS}
        sleep 1
	fi
done

if [ $(date +%s) -ge $limit_time ]; then
	echo "[========MARIADB IS NOT RESPONDING========]" >> ${WP_INSTALL_LOGS}
	exit 1
fi

# downaload wordpress core file and configurate it with admin infos, then create a new user
wp core download --allow-root --path=/var/www/wordpress
wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER_NAME" --dbpass="$DB_USER_PWD" --allow-root
wp core install --url="$WP_DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PWD}" --role=author --allow-root

# change PHP-FPM configuration from local socket to port 9000 so it can communicate with nginx
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
sed -i "s@/run/php/php${PHP_VERSION}-fpm.sock@9000@g" "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"
# sleep 60

mkdir -p /run/php

# start PHP-FPM in the forground to not exit
/usr/sbin/php-fpm${PHP_VERSION} -F
