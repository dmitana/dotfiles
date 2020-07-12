# NVIM configuration

## Installation
1. Run `install.sh`.

2. Launch nvim, execute PlugInstall, update the plugins, and exit.
```bash
$ nvim
  :PlugInstall
  :UpdateRemotePlugins
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

## TODO
- [ ] Folding.
- [ ] Fix neomux + vim-airline.
- [ ] Show warning when a parameter is missing in a docstring.
- [ ] Debugger.
- [ ] Cheatsheet for vim's and plugin's shortcuts.
