# Bootstrap only: zsh reads this file just when ZDOTDIR is unset.
# All environment config lives in $ZDOTDIR/.zshenv.
export ZDOTDIR="$HOME/.config/zsh"
source "$ZDOTDIR/.zshenv"
