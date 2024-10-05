MD_DATA=/home/htouil/data/mariadb
WP_DATA=/home/htouil/data/wordpress

all: up

up:
	@mkdir -p  ${MD_DATA}
	@mkdir -p  ${WP_DATA}
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

start:
	@docker-compose -f ./srcs/docker-compose.yml start

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

clean:
	@docker-compose -f ./srcs/docker-compose.yml down  || true
	@docker-compose -f ./srcs/docker-compose.yml down -v --rmi all || true
	@(echo 123 | sudo rm -rf $(WP_DATA)) || true
	@(echo 123 | sudo rm -rf $(DB_DATA)) || true

re: clean all

.PHONY: all up down start stop clean re
