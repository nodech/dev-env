FROM dev-system:latest

USER dev

# Install nightly nvim for nvim12.
RUN cd $HOME && curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz -O
RUN cd $HOME && tar xzf $HOME/nvim-linux-x86_64.tar.gz && rm $HOME/nvim-linux-x86_64.tar.gz

ENV PATH="$HOME/nvim-linux-x86_64/bin:$PATH"

RUN git clone https://github.com/nodech/dotfiles /home/dev/dotfiles/

RUN mkdir -p /home/dev/.config/nvim
RUN cd /home/dev/dotfiles && make zsh
RUN cd /home/dev/dotfiles && make config
# RUN cd /home/dev/dotfiles && make nvim12

# RUN ~/.bin/chcolor.sh ayu-mirage

# RUN nvim --headless -c "call packager#install({ 'on_finish': 'quitall' })"
# RUN nvim --headless -c "PackagerInstall {'on_finish': 'quitall' }"
