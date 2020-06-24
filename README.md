## Dotfiles

## Getting Started
1. Add `.dots` directory to the `.gitignore` file.
```bash
$ echo ".dots" >> .gitignore
```

2. Clone the repo.
```bash
# SSH
$ git clone --bare git@github.com:dmitana/dotfiles-test.git $HOME/.dots

# HTTPS
$ git clone --base https://github.com/dmitana/dotfiles-test.git $HOME/.dots
```

3. Restart shell or define the alias in the current shell scope.
```bash
$ alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
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

## Optional
1. Use predefined xorg configurations.
```bash
$ sudo ln -s ~/xorg_conf/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
```
