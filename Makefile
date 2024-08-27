NAME = inception

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

VOLUMES_FOLDER = /home/ataboada/data

.PHONY: help up down status clean mkdirs prune

all: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  up         Build and start the containers"
	@echo "  down       Stop and remove the containers"
	@echo "  down_c     Stop and remove the conatiners, images and volumes"
	@echo "  status     Show the status of the containers, images, volumes and networks"
	@echo "  clean      Remove all the containers, images and volumes"
	@echo "  prune      Cleans up the docker system"
	@echo "  nginx      Access the nginx container"
	@echo "  wordpress  Access the wordpress container"
	@echo "  mariadb    Access the mariadb container"

up: mkdirs
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) up --build

down:
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) down

down_c:
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) down
	@docker rmi -f $$(docker images -q) || true
	@docker volume rm $$(docker volume ls -q) || true
	@sudo rm -rf $(VOLUMES_FOLDER)

status:
	@echo "\n--------------------------------------- CONTAINERS -------------------------------------\n"
	@docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) ps
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

prune:
	@sudo docker system prune -a --volumes

nginx:
	docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) exec nginx bash

wordpress:
	docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) exec wordpress bash

mariadb:
	docker-compose -p $(NAME) -f $(DOCKER_COMPOSE_FILE) exec mariadb bash

mkdirs:
	@sudo mkdir -p $(VOLUMES_FOLDER)/mariadb
	@sudo mkdir -p $(VOLUMES_FOLDER)/wordpress
