FROM archlinux:latest

# Core system setup
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
      base-devel \
      git \
      zsh \
      neovim \
      tmux \
      ripgrep \
      fd \
      fzf \
      curl \
      wget \
      openssh \
      && pacman -Scc --noconfirm

# Create dev user matching typical host UID (overridable at runtime)
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID dev && \
    useradd -m -u $UID -g $GID -s /bin/zsh dev

# Dotfiles setup (replace with your repo)
ARG DOTFILES_REPO=https://github.com/USER/dotfiles.git
RUN git clone --depth 1 $DOTFILES_REPO /home/dev/.dotfiles || true

USER dev
WORKDIR /work

RUN cd /home/nd/dev/nodech/dotfiles && \
    [ -f install.sh ] && sh install.sh || true

ENV TERM=screen-256color

CMD ["/bin/zsh"]
