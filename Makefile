
.DEFAULT_GOAL: help

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
