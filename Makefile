NAME = inception

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

VOLUMES_FOLDER = /home/ataboada/data

.PHONY: help up down logs status clean

all: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  up        Build and start the containers"
	@echo "  down      Stop and remove the containers"
	@echo "  status    Show the status of the containers, images, volumes and networks"
	@echo "  clean     Remove all the containers, images and volumes"

up: mkdirs
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) up --build

down:
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) down

status:
	@echo "\n--------------------------------------- CONTAINERS -------------------------------------\n"
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) ps -a
	@echo "\n--------------------------------------- IMAGES -----------------------------------------\n"
	@docker images
	@echo "\n--------------------------------------- VOLUMES ----------------------------------------\n"
	@docker volume ls
	@echo "\n--------------------------------------- NETWORKS ---------------------------------------\n"
	@docker network ls
	@echo "\n"

clean:
	@docker rm -f $$(docker ps -a -q) || true
	@docker rmi -f $$(docker images -q) || true
	@docker volume rm $$(docker volume ls -q) || true
	@sudo rm -rf $(VOLUMES_FOLDER)
	@docker network rm inception_inception || true

mkdirs:
	@sudo mkdir -p $(VOLUMES_FOLDER)/mariadb
	@sudo mkdir -p $(VOLUMES_FOLDER)/wordpress