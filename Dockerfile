# Use the ubuntu:lunar image on linux/amd64 platform
FROM --platform=linux/amd64 ubuntu:lunar

# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Create a directory for mounting
WORKDIR /csc4100

# Install necessary tools for development
# https://stackoverflow.com/questions/66808788/docker-can-you-cache-apt-get-package-installs
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        gcc binutils git gdb nasm neovim python3 python3-venv python3-pip g++ make cmake nodejs npm wget curl

# Neovim Copilot
RUN git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim

# Setup python3 venv
RUN python3 -m venv .venv
ENV VIRTUAL_ENV /csc4100/.venv
ENV PATH /csc4100/.venv/bin:$PATH

# Install gdbgui
RUN python3 -m pip install gdbgui

# Command to run when the container starts
CMD ["bash"]
