.PHONY: all core nodech-env runtime-only clean list

PREFIX := dev
NAME := nodech/dev-env
LABEL := image-project=nodech-env
XDG_DATA_HOME := $(TARGET_DIR)/.local/share
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
		--label $(LABEL) \
		.

$(NAME): core $(NAME)-only
$(NAME)-only:
	docker build --network=host $(DOCKER_ARGS) \
		-t nodech/dev-env:latest \
		-f ./images/Dockerfile.nodech \
		--label $(LABEL) \
		.

$(XDG_DATA_HOME)/zsh/completions:
	mkdir -p $(XDG_DATA_HOME)/zsh/completions

nodzsh: $(XDG_DATA_HOME)/zsh/completions
	stow -v --target=$(XDG_DATA_HOME)/zsh/completions/ completions

unnodzsh:
	stow -D -v --target=$(XDG_DATA_HOME)/zsh/completions/ completions

clean:
	docker rmi -f \
		$$(docker images --filter="label=$(LABEL)" -q) \
		2> /dev/null

list:
	@docker images --filter="label=$(LABEL)"
