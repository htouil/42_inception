FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install mariadb-server -y

COPY ./conf/mdb_config.sh /mdb_config.sh

RUN chmod +x /mdb_config.sh

EXPOSE 3306

ENTRYPOINT ["./mdb_config.sh"]
