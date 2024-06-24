FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

################################################################################
# System
RUN apt-get update \
    && apt-get install -yq \
        curl \
        git \
        git-lfs \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

################################################################################
# User
ARG USERNAME=gitpod
RUN useradd $USERNAME -lm -G sudo -d /home/$USERNAME -s /bin/bash -p "$(openssl passwd -6 $USERNAME)" -u 33333
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME

################################################################################
# Python
RUN sudo apt update \
    && sudo apt install -y python3 python3-pip python3-venv \
    && sudo apt clean \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/*

COPY --chown=$USERNAME:$USERNAME .devcontainer/env/pyenv.txt .
RUN python3 -m venv pyenv \
    && pyenv/bin/pip install -r pyenv.txt \
    && rm pyenv.txt \
    && pyenv/bin/python -m ipykernel install --user --name pyenv

################################################################################
# Julia
ENV JULIA_PROJECT=/home/$USERNAME/jlenv
COPY --chown=$USERNAME:$USERNAME .devcontainer/env/jlenv.toml jlenv/Project.toml
RUN curl -fsSL https://install.julialang.org | sh -s -- \
        --yes \
        --default-channel=lts \
        --path=$HOME/julia \
    && sudo ln -s $HOME/julia/bin/julia /usr/local/bin/julia \
    && julia -e 'using Pkg; Pkg.resolve(); Pkg.instantiate()'

################################################################################
# Gurobi
ARG GUROBI_URL="https://packages.gurobi.com/11.0/gurobi11.0.2_linux64.tar.gz"
RUN curl -fsSL $GUROBI_URL -o gurobi.tar.gz \
    && mkdir gurobi \
    && tar -xvf gurobi.tar.gz -C gurobi --strip-components 2 \
    && rm gurobi.tar.gz \
    && sudo ln -s $HOME/gurobi /opt/gurobi
ENV GUROBI_HOME="/opt/gurobi"
ENV PATH="${PATH}:${GUROBI_HOME}/bin"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"

ENTRYPOINT [ "bash" ]