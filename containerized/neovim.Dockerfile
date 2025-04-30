FROM debian:bookworm-slim

# Metadata
LABEL description="Neovim running with rbharadwaj9's dotfiles"
MAINTAINER "Rajiv Bharadwaj"

# Set image locale.
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Europe/Zurich

RUN apt update && apt -y install --no-install-recommends \
    curl \
    fzf \
    ripgrep \
    tree \
    git \
    xclip \
    python3 \
    python3-pip \
    nodejs \
    npm \
    tzdata \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    make \
    cmake \
    g++ \
    pkg-config \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/neovim/neovim /tmp/neovim && cd /tmp/neovim && make CMAKE_BUILD_TYPE=Release && make install && rm -rf /tmp/neovim

RUN git clone --depth=1 https://github.com/rbharadwaj9/dotfiles ~/repo/dotfiles \
        && cp ~/repo/dotfiles/.gitignore_global ~/.gitignore \
        && cp ~/repo/dotfiles/.gitconfig ~/.gitconfig \
        && cd ~/repo/dotfiles && ~/repo/dotfiles/symlink.sh

RUN nvim --headless +"Lazy install" +PlugInstall +MasonInstall +qall

RUN mkdir /root/workspace
WORKDIR /root/workspace

CMD ["nvim"]
