FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php php-fpm php-mysql mariadb-client iputils-ping

COPY ./conf/wp_config.sh /wp_config.sh

COPY ./tools/wp-config.php /

RUN chmod +x /wp_config.sh

ENV PATH="${PATH}:/usr/local/bin/wp"

ENTRYPOINT ["./wp_config.sh"]