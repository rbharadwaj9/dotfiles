FROM debian:bookworm-slim

# Metadata
LABEL description="Neovim running with rbharadwaj9's dotfiles"
LABEL org.opencontainers.image.authors="rajiv.bharadwaj9@gmail.com"

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
    python3-venv \
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

WORKDIR /root/dotfiles

COPY . .

RUN ./symlink.sh

RUN nvim --headless +PlugInstall +"Lazy! install" +qall
RUN nvim --headless -E +'TSUpdateSync' +'sleep 30' +'quit' # TODO: Figure out how to remove the sleep and install in an event based fashion

RUN mkdir /root/workspace
WORKDIR /root/workspace

CMD ["nvim"]
