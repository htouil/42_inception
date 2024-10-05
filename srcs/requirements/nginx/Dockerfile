FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

COPY ./conf/nx_config.sh /nx_config.sh

RUN chmod +x /nx_config.sh

ENTRYPOINT ["./nx_config.sh"]
