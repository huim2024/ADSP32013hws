# Introduction

Adam Duke\
Asst. Instructor, ADSP 32013\
Optimization and Simulation Methods\
University of Chicago

## Intro

This is a guide to launching development environments via Docker (i.e., workspaces), hosted locally or remotely, to model and solve optimization problems.

## Remote Hosted Workspace

1. Establish a [GitHub](https://github.com/) account
0. Create a workspace targeting this template repository or one of its derivaties from either of the below host dashboards

### Hosting via GitHub Codespaces

- Manage workspaces via [Codespaces Dashboard](https://github.com/codespaces)
- 180 free credits (core-hours) per month with GitHub Pro or [educational benefits](https://education.github.com/discount_requests/application)\
    *Options (cores / RAM / storage)*
    - 2 / 8GB / 32GB
    - 4 / 16GB / 32GB

### Hosting via Gitpod

- Manage workspaces via [Gitpod Dashboard](https://gitpod.io/workspaces)
- 200 free credits (core-hours) per month with an associated LinkedIn account\
    *Options (cores / RAM / storage)*
    - 4 / 8GB / 30GB
    - 8 / 16GB / 50GB

## Locally Hosted Workspace

### Prerequisite Local Host Installations
- [Git](https://www.git-scm.com/downloads)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [Docker Engine](https://docs.docker.com/engine/install/)
- [Microsoft VS Code](https://code.visualstudio.com/download)

### Provided Workspace Components
- Julia (1.6.7 LTS)
    - [GLPK](https://www.gnu.org/software/glpk/)
    - [Gurobi](https://www.gurobi.com/)
    - [HiGHS](https://highs.dev/)
    - [JuMP](https://jump.dev/JuMP.jl/stable/)
    - *...see `.requirements/Project.toml`*
- Python (3.12.3)
    - [Google OR-Tools](https://developers.google.com/optimization/introduction/python)
    - *...see `.requirements/pyproject.txt`*


### Instructions

1. Clone git repository
    ```sh
    git clone https://github.com/adam-m-duke/optimization-workspace-template.git
    ```

0. Open the directory `optimization-workspace-template` in VS Code

0. Install VS Code host extension (`CTRL`+`SHIFT`+`P`)
    - select `Extensions: Install Extensions`
    - search for `ms-vscode-remote.remote-containers`
    - install search result: Dev Containers (Microsoft)

0. Reopen VS Code in a container (`CTRL`+`SHIFT`+`P`)
    - select `Dev Containers: Reopen in Container` \
    *this will reload the VS Code window, build the Dockerfile, run the built image, and mount the directory into the running container*

0. Await automatic installation of VS Code extensions
    - reload window if prompted
    
0. Create notebook (`CTRL`+`SHIFT`+`P`)
    - select `Create: New Jupyter Notebook`

0. Attach kernel (`CTRL`+`SHIFT`+`P`)

    **Python**
    - select `Notebook: Select Notebook Kernel`
    - select `pyenv (Python 3.12.3)`

    **Julia**
    - select `Notebook: Select Notebook Kernel`
    - select `Julia lts channel` or `Julia 1.6.7`

## Optionally

### Gurobi&copy;

1. Obtain a Gurobi [Academic WLS License](https://www.gurobi.com/features/web-license-service/)
    - register account with @uchicago.edu email
    - generate WLS licence via a UChicago network or [VPN](https://cvpn.uchicago.edu)

0. Copy WLS license contents into ```$HOME/gurobi.lic```

    *example license file contents*
    ```sh
    WLSACCESSID=********
    WLSSECRET=********
    LICENSEID=********
    ```

## Validate

Run environmental python shell
```sh
source $HOME/pyenv/bin/activate
python -c 'import ortools; print("success")'
```

Run environmental julia shell
```sh
julia --project=$HOME/jlenv -e 'using JuMP; println("success")'
```

## Resources

#### Supported Solvers
- [ORTools](https://developers.google.com/optimization/lp/lp_advanced)
- [JuMP](https://jump.dev/JuMP.jl/stable/installation/#Supported-solvers)
