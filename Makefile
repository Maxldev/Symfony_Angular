.PHONY: start stop php cc vendor-install help
.DEFAULT_GOAL: help

DOCKER_COMPOSE=docker compose
DOCKER_COMPOSE_EXEC=$(DOCKER_COMPOSE) exec
PHP_DOCKER_COMPOSE_EXEC=$(DOCKER_COMPOSE_EXEC) php
COMPOSER=$(PHP_DOCKER_COMPOSE_EXEC) composer
SYMFONY_CONSOLE=$(PHP_DOCKER_COMPOSE_EXEC) bin/console

start: ## Start docker container
	$(DOCKER_COMPOSE) up -d

stop: ## Stop docker container
	$(DOCKER_COMPOSE) stop

php: ## Connect to php container
	$(DOCKER_COMPOSE) exec php /bin/sh

cc: ## Cache clear Symfony
	$(SYMFONY_CONSOLE) cache:clear

vendor-install: ## Composer install
	$(COMPOSER) install

help: ## Command list
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[1;33m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

