FROM debian:bookworm-slim

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
        && cp ~/repo/dotfiles/.gitignore_global ~/.gitignore
        && cp ~/repo/dotfiles/.gitconfig ~/.gitconfig
        && ~/repo/dotfiles/symlink.sh

CMD ["nvim"]
