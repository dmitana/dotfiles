# NVIM configuration

## Installation
1. Run `install.sh`.


2. Install packer (add to `install.sh`)
```bash
$ git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

3. LSPs have to be installed mannually (add to `install.sh`)
```bash
$ sudo npm i -g pyright (for python)
```

4. Launch nvim, compile and install packages, then exit nvim.
```bash
$ nvim
  :PackerCompile
  :PackerInstall
  :qa!
```

## Usage in a docker container
This will work only if a docker container will run under root user (without `-u $(id -u):$(id -g)`)

1. Bind NVIM's configuration files using `-v $HOME/.config/nvim:/root/.nvim -v $HOME/.config/coc:/root/.coc` when `docker run`.

2. Run `install_docker_container.sh`.

3. Launch nvim, execute PlugInstall, update the plugins, and exit.
```bash
$ nvim
  :PlugInstall
  :UpdateRemotePlugins
  :qa!
```




