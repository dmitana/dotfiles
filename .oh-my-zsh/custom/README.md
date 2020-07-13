# Oh My Zsh configuration 

## Installation
1. Install Zsh and make it your default shell.
```bash
$ yay -S zsh
$ chsh -s $(which zsh)
```

2. Log out and login back again to use your new default shell.

3. Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh).
```bash
$ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

4. Install [powerline fonts](https://github.com/powerline/fonts). A preferred way is `yay -S powerline-fonts-git`, but currently the package is [flagged as out-of-date from (2020-06-29)](https://aur.archlinux.org/packages/powerline-fonts-git/), so manual installation is needed.
```bash
$ git clone https://github.com/powerline/fonts.git --depth=1 powerline-fonts
$ cd powerline-fonts
$ ./install.sh
```

5. Clone custom plugins.
```bash
$ dots submodule init 
$ dots submodule update
```

## Used Plugins
* [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
* [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker)
* [docker-compose](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose)
* [Fish-like autosuggestions for zsh](https://github.com/zsh-users/zsh-autosuggestions)
* [ZSH port of Fish history search (up arrow)](https://github.com/zsh-users/zsh-history-substring-search)
* [Fish shell like syntax highlighting for Zsh](https://github.com/zsh-users/zsh-syntax-highlighting)
* [Additional completion definitions for Zsh.](https://github.com/zsh-users/zsh-completions)
