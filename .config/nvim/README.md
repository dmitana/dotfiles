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

1. Bind NVIM's configuration files using `-v $HOME/.config/nvim:/root/.nvim` when `docker run`.

1. Run `/root/.nvim/install_docker_container.sh`.

1. Launch nvim, execute PlugInstall, update the plugins, and exit.
    ```bash
    $ nvim
      :PackerCompile
      :PackerInstall
      :qa!
    ```
