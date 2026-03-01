.PHONY: all core runtime runtime-only agent agent-only clean list

PREFIX := dev
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: agent

core:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-core:latest \
		-f ./images/Dockerfile.core \
		.

runtime: core runtime-only
runtime-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-runtime:latest \
		-f ./images/Dockerfile.runtime \
		.

agent: runtime agent-only
agent-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-agent:latest \
		-f ./images/Dockerfile.agent \
		.

clean:
	docker rmi -f \
		$(PREFIX)-core:latest \
		$(PREFIX)-runtime:latest \
		$(PREFIX)-agent:latest \
		2>/dev/null || true

list:
	@docker images | grep "^$(PREFIX)-"
