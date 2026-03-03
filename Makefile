.PHONY: all core nodech-env runtime-only clean list

PREFIX := dev
NAME := nodech/dev-env
LABEL := nodech-env
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: $(NAME)

core:
	docker build --network=host $(DOCKER_ARGS) \
		-t nodech/dev-core:latest \
		-f ./images/Dockerfile.core \
		--label project=$(LABEL) \
		.

$(NAME): core $(NAME)-only
$(NAME)-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t nodech/dev-env:latest \
		-f ./images/Dockerfile.nodech \
		--label project=$(LABEL) \
		.

clean:
	docker rmi -f \
		$$(docker images --filter="label=project=$(LABEL)" -q) \
		2> /dev/null

list:
	@docker images --filter="label=project=$(LABEL)"
