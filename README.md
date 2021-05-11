# Dotfiles

## Prerequisites
* [Installed Arch Linux](https://github.com/dmitana/dotfiles-test/wiki/Arch-Linux-Setup) 

## Installation
1. Add `.dots` directory to the `.gitignore` file.
```bash
$ echo ".dots" >> .gitignore
```

2. Clone the repo.
```bash
# SSH
$ git clone --bare git@github.com:dmitana/dotfiles.git $HOME/.dots

# HTTPS
$ git clone --bare https://github.com/dmitana/dotfiles.git $HOME/.dots
```

3. Restart shell or define the alias in the current shell scope.
```bash
$ alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

# Add fetch line if you want behaviour as with a non-bare repository clone.
$ dots config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
```

4. Checkout the actual content from the bare repository to your `$HOME`. `$HOME` folder might already have some stock configuration files which would be overwritten by Git (e.g. `.vimrc`, `.zshrc`, ...).
```bash
# Back up the files if you care about them
$ mkdir -p .dots_backup && \
dots checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .dots-backup/{}

# Remove them if you don't care
$ dots checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} rm {}

# Checkout the actual content
$ dots checkout
```

5. Set the flag `showUntrackedFiles` to `no` on this specific (local) repository.
```bash
$ dots config --local status.showUntrackedFiles no
```

6. Install [zsh](.oh-my-zsh/custom).

7. Install [powerline](https://github.com/powerline/powerline) for tmux (based on [this answer](https://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin) and [doc](https://powerline.readthedocs.io/en/latest/overview.html)). Quick install (when fonts are already installed).
```bash
$ pip install --user powerline-status
```

Or on Arch simply.
```bash
$ yay -S powerline powerline-fonts
```

8. Install [nvim](.config/nvim).

### Optional
1. Use the predefined configurations for `X server`, `Udev udisks` and `SDDM`.
```bash
# Monitor and X input configuration
$ sudo ln -s ~/etc/xorg/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf
$ sudo ln -s ~/etc/xorg/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf

# Udev udisks configuration
$ sudo ln -s ~/etc/udev/99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules
$ sudo ln -s ~/etc/tmpfiles/media.conf /etc/tmpfiles.d/media.conf # set mount directory to the /media/$USER instead of /run/media/$USER

# SDDM configuration
$ sudo mkdir /etc/sddm.conf.d
$ sudo cp ~/etc/sddm/general.conf /etc/sddm.conf.d/general.conf
$ sudo ln -s ~/etc/sddm/xorg.conf /etc/sddm.conf.d/xorg.conf
$ sudo ln -s ~/etc/sddm/theme.conf /etc/sddm.conf.d/theme.conf
$ sudo cp ~/.config/awesome/theme/wallpapers/* /usr/share/sddm/themes/Sugar-Candy/Backgrounds # Copy custom wallpapers
$ sudo cp ~/etc/sddm/themes/Sugar-Candy/theme.conf.user /usr/share/sddm/themes/Sugar-Candy/theme.conf.user
$ sudo ln -sf ~/etc/sddm/scripts/Xsetup /usr/share/sddm/scripts/Xsetup
```

## TODO
- [ ] Customize the tmux's powerline.
