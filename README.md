## Getting Started

1. 
```bash
$ echo ".cfg" >> .gitignore
```

2.
```bash
$ git clone --bare <git-repo-url> $HOME/.cfg
```

3. Restart shell or define the alias in the current shell scope.
```bash
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

4. Checkout the actual content from the bare repository to your `$HOME`.
```bash
$ config checkout
```

5. Set the flag `showUntrackedFiles` to `no` on this specific (local) repository.
```bash
$ config config --local status.showUntrackedFiles no
```

## Optional
1. Use predefined xorg configurations.
```bash
$ sudo ln -s ~/xorg_conf/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
```
