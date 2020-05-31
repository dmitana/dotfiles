# My Custom ZSH Configuration

This repository contains custom plugins, themes and .zshrc that I use.

## Installation

1. Install ZSH and Oh My Zsh from [here](https://github.com/robbyrussell/oh-my-zsh).
2. Replace `~/.oh-my-zsh/custom/` folder.
```bash
$ rm -r ~/.oh-my-zsh/custom/

# Use SSH or HTTPS
$ git clone git@github.com:dmitana/oh-my-zsh-custom.git ~/.oh-my-zsh/custom/
$ git clone https://github.com/dmitana/oh-my-zsh-custom.git ~/.oh-my-zsh/custom/
```
3. Clone custom plugins.
```bash
$ cd ~/.oh-my-zsh/custom/
$ git submodule init 
$ git submodule update
```
2. Use custom `.zshrc`. 
```bash
$ rm ~/.zshrc
$ ln -s ~/.oh-my-zsh/custom/.zshrc ~/.zshrc
```

3. Use custom `.tmux.conf`.
```bash
$ rm ~/.tmux.conf
# xclip is needed for copying in a scroll mode
$ sudo apt install xclip
$ ln -s ~/.oh-my-zsh/custom/.tmux.conf ~/.tmux.conf
```

4. Install [powerline](https://github.com/powerline/powerline) (based on [this answer](https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin) and [doc](https://powerline.readthedocs.io/en/latest/overview.html)). Quick install (when fonts are already installed and `~/.zshrc` and `~/.tmux.conf` are modified):
```bash
$ pip install --user powerline-status
```

Note: Powerline doesn't support NeoVim. Use vim-airline instead.

## Used Plugins
* [git](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#git)
* [docker](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#docker)
* [Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)
* [ZSH port of Fish history search (up arrow)](https://github.com/zsh-users/zsh-history-substring-search)
* [Fish shell like syntax highlighting for Zsh](https://github.com/zsh-users/zsh-syntax-highlighting)

## TODO
- [ ] Customize the powerline.
