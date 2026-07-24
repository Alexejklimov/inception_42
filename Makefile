NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	DATA_PATH := /Users/$(USER)/data
else
	DATA_PATH := /home/$(USER)/data
endif

all: folders up

folders:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

up: folders
	DATA_PATH=$(DATA_PATH) $(COMPOSE) up -d --build

down:
	- DATA_PATH=$(DATA_PATH) $(COMPOSE) down

clean:
	- DATA_PATH=$(DATA_PATH) $(COMPOSE) down --remove-orphans

fclean: clean
	- docker system prune -a --volumes -f
	- rm -rf $(DATA_PATH)

re: fclean all

.PHONY: all up down clean fclean re folders
