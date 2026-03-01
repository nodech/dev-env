FROM archlinux:latest

ARG CFG_LOCALEGEN="en_US.UTF-8 UTF-8\nka_GE.UTF-8 UTF-8"
ARG CFG_LOCALE="LANG=en_US.UTF-8"

RUN echo -e "$CFG_LOCALEGEN" >> /etc/locale.gen \
    && locale-gen \
    && echo "$CFG_LOCALE" > /etc/locale.conf

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Core system setup
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
      base-devel \
      bat \
      ccache \
      curl \
      fd \
      fzf \
      git \
      harper \
      htop \
      jq \
      lsd \
      lua \
      neovim \
      nodejs \
      npm \
      openssh \
      python \
      ripgrep \
      rsync \
      rustup \
      sccache \
      stow \
      tmux \
      tree \
      tree-sitter \
      tree-sitter-cli \
      wl-clipboard \
      zoxide \
      zsh \
      && pacman -Scc --noconfirm

# Create dev user matching typical host UID (overridable at runtime)
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID dev && \
    useradd -m -u $UID -g $GID -s /bin/zsh dev

RUN npm i -g neovim
RUN mkdir /.TRASH && chown dev:dev /.TRASH

USER dev
WORKDIR /work

ENV TERM=screen-256color

SHELL ["/bin/zsh", "-c"]

CMD ["/bin/zsh"]
