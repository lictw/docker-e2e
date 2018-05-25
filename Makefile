
SPEED := 0

NAME := web-application
VERSION := latest

DOCKER_COMPOSE_FILE := docker-compose.yml
DOCKER_COMPOSE_TEST_FILE := docker-compose.test.yml

DOCKER_COMPOSE_COMMAND := docker-compose -f $(DOCKER_COMPOSE_FILE)
DOCKER_COMPOSE_TEST_COMMAND := $(DOCKER_COMPOSE_COMMAND) -f $(DOCKER_COMPOSE_TEST_FILE) -p test

.DEFAULT_GOAL := test
.PHONY: build clean test

build:
	@ docker build -t $(NAME):$(VERSION) web-application

clean:
	@ docker stop $$(docker ps -q) || true
	@ docker system prune -f

test:
	@ $(DOCKER_COMPOSE_TEST_COMMAND) build
	@ $(DOCKER_COMPOSE_TEST_COMMAND) run robot; CODE=$$?; \
	$(DOCKER_COMPOSE_TEST_COMMAND) rm -s -f; exit $$CODE

test-local:
	@ robot -v SPEED:$(SPEED) --outputdir tests/results tests/local.robot
