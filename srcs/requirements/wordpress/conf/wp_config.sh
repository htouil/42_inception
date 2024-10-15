#!/bin/bash

# download the PHP archive for WP-CLI used to manage wordpress installation and give it executable
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mkdir -p /usr/local/bin/wp
mv wp-cli.phar wp
mv wp /usr/local/bin/wp

# wait for the mariadb server to first start properly
WP_INSTALL_LOGS="/var/log/wordpress_install.log"
: > ${WP_INSTALL_LOGS}

limit_time=$(( $(date +%s) + 20 ))
while [ $(date +%s) -lt $limit_time ]; do
	mysqladmin -h mariadb -u root -p$DB_ROOT_PWD ping > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "[========MARIADB IS UP AND RUNNING========]"
        break
	else
		echo "[========WAITING FOR MARIADB TO START...========]"
        sleep 1
	fi
done

if [ $(date +%s) -ge $limit_time ]; then
	echo "[========MARIADB IS NOT RESPONDING========]"
	exit 1
fi

# downaload wordpress core file and configurate it with admin infos, then create a new user
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress/

find /var/www/wordpress/ -type f -exec chmod 644 {} \;
find /var/www/wordpress/ -type d -exec chmod 755 {} \;

wp core download --path=/var/www/wordpress --allow-root
mv /wp-config.php /var/www/wordpress

PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
echo "env[DB_NAME] = \$DB_NAME
env[DB_USER_NAME] = \$DB_USER_NAME
env[DB_USER_PWD] = \$DB_USER_PWD
env[DB_HOST] = \$DB_HOST" >> "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

wp core install --url="$WP_DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --path=/var/www/wordpress --allow-root

wp user create "${WP_USER_NAME}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PWD}" --role=author --path=/var/www/wordpress --allow-root

# change PHP-FPM configuration from local socket to port 9000 so it can communicate with nginx
sed -i "s@/run/php/php${PHP_VERSION}-fpm.sock@9000@g" "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

mkdir -p /run/php

# start PHP-FPM in the forground to not exit
/usr/sbin/php-fpm${PHP_VERSION} -F

