.PHONY: all core runtime runtime-only clean list
.PHONY: agents \
	agent-codex agent-codex-only \
	agent-claude agent-claude-only \
	agent-opencode  agent-opencode-only

PREFIX := dev
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: agents

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

agent-codex: runtime agent-codex-only
agent-codex-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-agent-codex:latest \
		-f ./images/Dockerfile.agent-codex \
		.

agent-claude: runtime agent-claude-only
agent-claude-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-agent-claude:latest \
		-f ./images/Dockerfile.agent-claude \
		.

agent-opencode: runtime agent-opencode-only
agent-opencode-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-agent-opencode:latest \
		-f ./images/Dockerfile.agent-opencode \
		.

agents: runtime agent-codex-only agent-claude-only agent-opencode
agents-only: agent-codex-only agent-claude-only agent-opencode

clean:
	docker rmi -f \
		$$(docker images --filter="label=project=nodech-env" -q) \
		2> /dev/null

list:
	@docker images --filter="label=project=nodech-env"
