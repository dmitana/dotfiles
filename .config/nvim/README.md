# My Custom NVIM Configuration

This repository contains custom NVIM configuration that I use.

## Installation

1. Clone this repository.
```bash
# Use SSH or HTTPS
$ git clone git@github.com:dmitana/nvim-custom.git ~/.nvim/
$ git clone https://github.com/dmitana/nvim-custom.git ~/.nvim/
```

2. Run `install.sh`.

3. Install the NeoVim Python module.
```bash
$ pip3 install --user neovim
```

3. Install nodejs when necessary (for coc.nvim plugin)
```bash
$ curl -sL install-node.now.sh/lts | bash
```

4. Launch nvim, execute PlugInstall, update the plugins, and exit.
```bash
$ nvim
$ :PlugInstall
$ :UpdateRemotePlugins
$ :q!
$ :q!
```

5. Create the symbolic link for the `coc-snippets` extension.
```bash
$ ln -s ~/.nvim/coc/ultisnips/python.snippets ~/.config/coc/ultisnips/python.snippets
```

## Usage in a docker container
This will work only if a docker container will run under root user (without `-u $(id -u):$(id -g)`)

1. Bind NVIM's configuration files using `-v $HOME/.config/nvim:/root/.nvim -v $HOME/.config/coc:/root/.coc` when `docker run`.

2. Run `install_docker_container.sh`.

3. Launch nvim, execute PlugInstall, update the plugins, and exit.
```bash
$ nvim
$ :PlugInstall
$ :UpdateRemotePlugins
$ :qa!
```

## TODO
- [ ] Folding.
- [ ] Fix neomux + vim-airline.
- [ ] Show warning when a parameter is missing in a docstring.
- [ ] Debugger.
- [ ] Cheatsheet for vim's and plugin's shortcuts.

## FIXME
