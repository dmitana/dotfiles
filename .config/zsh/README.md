# Zsh configuration 
My zsh configuration is based on [Luke Smith's](https://github.com/LukeSmithxyz/voidrice) configuration.

## Installation
1. Install Zsh and make it your default shell.
```bash
$ yay -S zsh
$ chsh -s $(which zsh)
```

2. Log out and login back again to use your new default shell.

3. Install [zplug](https://github.com/zplug/zplug) - a next-generation plugin manager for zsh.
Subsequently, source `~/.config/zsh/.zshrc` to install zsh's plugins.
```bash
$ yay -S zplug
$ source ~/.config/zsh/.zshrc
```

4. Install [powerline fonts](https://github.com/powerline/fonts). A preferred way is `yay -S powerline-fonts-git`, but currently the package is [flagged as out-of-date from (2020-06-29)](https://aur.archlinux.org/packages/powerline-fonts-git/), so manual installation is needed.
```bash
$ git clone https://github.com/powerline/fonts.git --depth=1 powerline-fonts
$ cd powerline-fonts
$ ./install.sh
```

## Used Plugins
* [Additional completion definitions for Zsh.](https://github.com/zsh-users/zsh-completions)
* [Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)
* [ZSH port of Fish history search (up arrow)](https://github.com/zsh-users/zsh-history-substring-search)
* [Fish shell like syntax highlighting for Zsh](https://github.com/zsh-users/zsh-syntax-highlighting)
