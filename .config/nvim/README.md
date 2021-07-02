# NVIM configuration

## Installation
1. Run `install.sh`.

1. Launch nvim, compile and install packages, then exit nvim.
    ```bash
    $ nvim
      :PackerCompile
      :PackerInstall
      :qa!
    ```

## Usage in a docker container
This will work only if a docker container will run under root user (without `-u $(id -u):$(id -g)`)

1. Bind NVIM's configuration files.
    ```
    # docker run
    -v $HOME/.config/nvim:/root/.nvim

    # docker-compose
    volumes:
      - $HOME/.config/nvim:/root/.nvim
    ```

1. Set `TERM` env var for better colors support.
    ```bash
    # docker run
    docker exec -it -e TERM CONTAINER CMD

    # docker-compose
    docker-compose -e TERM exec SERVICE CMD
    ```

1. Run `/root/.nvim/install_docker_container.sh`.

1. Launch nvim, compile and install packages, then exit nvim.
    ```bash
    $ nvim
      :PackerCompile
      :PackerInstall
      :qa!
    ```
