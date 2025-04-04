# Set $ZDOTDIR
export ZDOTDIR="$HOME/.config/zsh"

# Set $PATH
typeset -U PATH path
path=("$HOME/.local/bin" $(go env GOPATH)/bin $path)
export PATH

# Add zsh scripts to fpath
fpath=("$ZDOTDIR/zsh.d" $fpath)

# Default programs
export VISUAL="nvim"
export EDITOR="$VISUAL"
export BROWSER="google-chrome-stable"
export READER="zathura"

# Manpager using bat - a cat clone with wings
if command -v bat &> /dev/null; then
	# Arch
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	# Ubuntu
	# export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

# Enable the keyring for applications run through the terminal, such as SSH
if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi
