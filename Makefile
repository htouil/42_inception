WP_DATA=/home/htouil/data/wordpress
MD_DATA=/home/htouil/data/mariadb

all: up

up:
	@mkdir -p  ${WP_DATA}
	@mkdir -p  ${MD_DATA}
	@docker-compose -f ./srcs/docker-compose.yml build
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

start:
	@docker-compose -f ./srcs/docker-compose.yml start

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

rebuild:
	@docker-compose -f ./srcs/docker-compose.yml down
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

clean:
	@docker-compose -f ./srcs/docker-compose.yml down -v --rmi all || true
	@docker system prune -f -a --volumes || true
	@sudo rm -rf $(WP_DATA)
	@sudo rm -rf $(MD_DATA)

re: clean all

.PHONY: all up down start stop rebuild clean re
