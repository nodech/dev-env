.PHONY: all core nodech-env runtime-only clean list

PREFIX := dev
NAME := nodech-env
DEBUG :=
DOCKER_ARGS :=

ifdef DEBUG
	DOCKER_ARGS += --no-cache --progress=plain
endif

all: $(NAME)

core:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-core:latest \
		-f ./images/Dockerfile.core \
		--label project=$(NAME)
		.

$(NAME): core $(NAME)-only
$(NAME)-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t $(PREFIX)-$(NAME):latest \
		-f ./images/Dockerfile.nodech \
		--label project=$(NAME)
		.

clean:
	docker rmi -f \
		$$(docker images --filter="label=project=$(NAME)" -q) \
		2> /dev/null

list:
	@docker images --filter="label=project=$(NAME)"
