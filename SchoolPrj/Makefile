include ./srcs/.env

DOCKER_SRCS := ./srcs
DOCKER_COMPOSE := /docker-compose.yml

WORDPRESS_VOL := $(VOLUME_PATH)/web
MARIADB_VOL := $(VOLUME_PATH)/database

DOCKER_COMPOSE_CMD := docker compose -f $(DOCKER_SRCS)$(DOCKER_COMPOSE) 


all: setup build 

setup:
	@echo "Creating volumes directory"
	mkdir -p $(MARIADB_VOL)
	mkdir -p $(WORDPRESS_VOL)

build:
	@echo "Building and starting containers"
	$(DOCKER_COMPOSE_CMD) up --build

up:
	@echo "Starting containers"
	$(DOCKER_COMPOSE_CMD) up


start:
	@echo "Starting containers"
	$(DOCKER_COMPOSE_CMD) start

stop:
	@echo "Stopping containers"
	$(DOCKER_COMPOSE_CMD) stop

down:
	@echo "Stopping and removing containers, networks, images, volumes, and named volumes"
	$(DOCKER_COMPOSE_CMD) down -v

clean:
	@echo "Removing all Docker containers, images, and networks"
	docker rm -f $$(docker ps -aq); docker rmi -f $$(docker images -aq); docker network rm $$(docker network ls -q) 2>/dev/null

clearmounts:
	@echo "Clearing volume mounts"
	rm -rf $(WORDPRESS_VOL)/* && rm -rf $(MARIADB_VOL)/*



