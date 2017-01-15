###
# Makefile

CONFIG = docker-compose.yml
DOCKER_COMPOSE = docker-compose -p$(USER) -f$(CONFIG)
NODE_SERVICE_NAME = app
PM2_CMD = npm run pm2
ECOSYSTEM = ecosystem.config.js

#####
# Executed when you run "make" cmd
# Simply run "start" tasks
all: start

#####
# Start containers (Also builds images, if there not exists)
start:
	$(DOCKER_COMPOSE) up -d

#####
# Stop containers (And also remove it)
stop:
	$(DOCKER_COMPOSE) kill
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) rm --force

#####
# List current running containers
list:
	$(DOCKER_COMPOSE) ps

#####
# Display current running containers logs (Press "Ctrl + c" to exit)
logs:
	$(DOCKER_COMPOSE) logs -f

#####
# Execute "start" tasks and run provisioning scripts
init: start
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) /bin/sh -ec '/entrypoint.sh'

#####
# Start new bash terminal inside the app Container
ssh:
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) bash

#####
# Remove stopped container
clean-container:
	$(DOCKER_COMPOSE) rm --force

#####
# Start pm2 process
pm2-start:
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) /bin/sh -ec '$(PM2_CMD) start $(ECOSYSTEM)'

#####
# Stop pm2 process
pm2-stop:
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) /bin/sh -ec '$(PM2_CMD) stop $(ECOSYSTEM)'

#####
# Delete pm2 process
pm2-rm:
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) /bin/sh -ec '$(PM2_CMD) delete $(ECOSYSTEM)'

#####
# List pm2 process
pm2-list:
	$(DOCKER_COMPOSE) run $(NODE_SERVICE_NAME) /bin/sh -ec '$(PM2_CMD) list'
