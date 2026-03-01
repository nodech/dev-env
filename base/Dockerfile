FROM dev-system:latest

# Install nightly nvim for nvim12.
RUN cd $HOME && curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz -O
RUN cd $HOME && tar xzf $HOME/nvim-linux-x86_64.tar.gz && rm $HOME/nvim-linux-x86_64.tar.gz
RUN mkdir $HOME/.bin && ln -s $HOME/nvim-linux-x86_64/bin/nvim $HOME/.bin/nvim

# Setup dotfiles
RUN git clone https://github.com/nodech/dotfiles $HOME/dotfiles/
RUN mkdir -p $HOME/.config
RUN cd $HOME/dotfiles && make zsh
RUN cd $HOME/dotfiles && make config
RUN cd $HOME/dotfiles && make nvim

# Setup neovim
RUN $HOME/nvim-linux-x86_64/bin/nvim --headless -c 'qall'
RUN cd $HOME/.local/share/nvim/site/pack/core/opt/blink.cmp && cargo build --release
