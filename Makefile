.DEFAULT_GOAL: help

ifneq (,$(shell which podman-compose 2>/dev/null))
COMPOSE ?= podman-compose
endif
ifneq (,$(shell which docker-compose 2>/dev/null))
COMPOSE ?= docker-compose
endif
ifeq (,$(COMPOSE))
COMPOSE ?= false
endif

.PHONY: help
help:  ## Print out the help content
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ General
node_modeles:
	npm run install

.PHONY: run
run: node_modeles  ## Run the application
	npm run start

.PHONY: build
build: node_modeles  ## Build the documentation
	npm run build

.PHONY: lint
lint: node_modeles  ## Run linter
	npm run lint

.PHONY: watch
watch: node_modeles  ## Watch for changes
	npm run watch

.PHONY: compose-build
compose-build:  ## Build containers from docker-compose
	$(COMPOSE) build

.PHONY: compose-up
compose-up:  ## Start containers locally
	$(COMPOSE) up

.PHONY: compose-down
compose-down:  ## Tear down containers locally
	$(COMPOSE) down

.PHONY: compose-clean
compose-clean:
	$(COMPOSE) down --volumes --remove-orphans
