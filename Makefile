all:
	@echo "Makefile needs your attention"

.PHONY: all system base editor agent runner clean list

PREFIX := dev
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: editor agent runner

system:
	docker build --network=host $(DOCKER_ARGS) -t $(PREFIX)-system:latest ./system

base: system
	docker build --network=host $(DOCKER_ARGS) -t $(PREFIX)-base:latest ./base

clean:
	docker rmi -f $(PREFIX)-editor:latest $(PREFIX)-agent:latest $(PREFIX)-runner:latest $(PREFIX)-base:latest 2>/dev/null || true

list:
	@docker images | grep "^$(PREFIX)-"
