# Set $PATH
typeset -U PATH path
path=("$HOME/.local/bin" $path)
export PATH

# Add TAB completion to chubin/cheat.sh
fpath=("$ZDOTDIR/zsh.d" $fpath)

# Default programs
export EDITOR="nvim"
export BROWSER="google-chrome-stable"
export READER="zathura"

# Manpager using bat - a cat clone with wings
if command -v bat &> /dev/null; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Enable the keyring for applications run through the terminal, such as SSH
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
