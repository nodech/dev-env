all:
	@echo "Makefile needs your attention"

.PHONY: all base editor agent runner clean list

PREFIX := dev

all: editor agent runner

base:
	docker build --network=host -t $(PREFIX)-base:latest ./base

editor: base
	docker build --network=host -t $(PREFIX)-editor:latest ./editor

agent: base
	docker build --network=host -t $(PREFIX)-agent:latest ./agent

runner: base
	docker build --network=host -t $(PREFIX)-runner:latest ./runner

clean:
	docker rmi -f $(PREFIX)-editor:latest $(PREFIX)-agent:latest $(PREFIX)-runner:latest $(PREFIX)-base:latest 2>/dev/null || true

list:
	@docker images | grep "^$(PREFIX)-"
