#!/bin/bash

# generate a self-signed SSL Certificate
mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MO/ST=TET/L=MT/O=42/OU=42/CN=${WP_DOMAIN_NAME}/UID=${WP_ADMIN_NAME}"

# create the /www/wordpress directory and give its ownership to www-data needed by nginx
mkdir -p /var/www/wordpress/
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress/

find /var/www/wordpress/ -type f -exec chmod 644 {} \;
find /var/www/wordpress/ -type d -exec chmod 755 {} \;


# add a server configuration to the nginx.conf file to serve a site supported by SSL and PHP
echo "server {

		listen 443 ssl;
		
		ssl_certificate  /etc/nginx/ssl/inception.crt;
		ssl_certificate_key /etc/nginx/ssl/inception.key;
		ssl_protocols TLSv1.3;

		root /var/www/wordpress;
		server_name ${WP_DOMAIN_NAME};
		index index.php;

		location ~ \.php$ {
			include snippets/fastcgi-php.conf;
			fastcgi_pass wordpress:9000;
		}
	}" >> /etc/nginx/conf.d/nginx.conf

# echo "server {
# 		listen 443 ssl;
# 		server_name inception;

# 		ssl_certificate /etc/nginx/certs/cert.csr;
# 		ssl_certificate_key /etc/nginx/certs/cert.key;
# 		ssl_protocols TLSv1.2 TLSv1.3;

# 		root /var/www/html;
# 		index index.php;

# 		location ~ [^/]\.php(/|$) {
# 			try_files $uri =404;
# 			fastcgi_pass wordpress:9000;
# 			include fastcgi_params;
# 			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
# 		}
# 	}" >> /etc/nginx/conf.d/nginx.conf

# run nginx in the forground
nginx -g "daemon off;"
