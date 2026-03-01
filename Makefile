all:
	@echo "Makefile needs your attention"

.PHONY: all system base base-only agent agent-only clean list

PREFIX := dev
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: editor agent runner

system:
	docker build --network=host $(DOCKER_ARGS) -t $(PREFIX)-system:latest ./system

base: system base-only
base-only:
	docker build --network=host $(DOCKER_ARGS) -t $(PREFIX)-base:latest ./base

agent: base agent-only
agent-only:
	docker build --network=host $(DOCKER_ARGS) -t $(PREFIX)-agent:latest ./agent

clean:
	docker rmi -f \
		$(PREFIX)-system:latest \
		$(PREFIX)-base:latest \
		$(PREFIX)-editor:latest \
		$(PREFIX)-agent:latest \
		$(PREFIX)-runner:latest \
		2>/dev/null || true

list:
	@docker images | grep "^$(PREFIX)-"
