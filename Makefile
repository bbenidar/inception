DATADIR := /Users/bbenidar/data
MARIADB_DIR := $(DATADIR)/mysql
WORDPRESS_DIR := $(DATADIR)/wordpress

all:
	mkdir -p $(MARIADB_DIR)
	mkdir -p $(WORDPRESS_DIR)
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean:
	@docker compose -f ./srcs/docker-compose.yml down --volumes --remove-orphans --rmi local

re: clean all

.PHONY: all re down clean
