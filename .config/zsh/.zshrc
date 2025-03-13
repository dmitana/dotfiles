# Turn off all beeps
unsetopt BEEP

# Enable colors
autoload -U colors && colors

# Load version control information and format it
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats "%{$fg[blue]%}%s(%{$fg[red]%}%b%{$fg[blue]%}) "
precmd() { vcs_info }
setopt prompt_subst

# Change prompt
local ret_status="%(?:%{$fg_bold[green]%}$:%{$fg_bold[red]%}$)"
PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[magenta]%}%M %{$fg[cyan]%}%~%{$fg[red]%}] ${vcs_info_msg_0_}${ret_status}%{$reset_color%}%b '

# Create cache directory
local cache_dir="$HOME/.cache/zsh"
[ ! -d "$cache_dir" ] && mkdir "$cache_dir"

# Enable history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$cache_dir/history"

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zmodload zsh/complist
compinit
_comp_options+=(globdots)  # Include hidden files

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
	 [[ $1 = 'block' ]]; then
	echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
	   [[ ${KEYMAP} == viins ]] ||
	   [[ ${KEYMAP} = '' ]] ||
	   [[ $1 = 'beam' ]]; then
	echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins # Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

# Yank to the system clipboard in the vi mode
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -i
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use vifm to switch directories and bind it to ctrl-o
vicd() {
    local dst="$(command vifm --choose-dir - .)"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}
bindkey -s '^o' 'vicd\n'

# Load aliases
local aliasrc_file="$HOME/.config/shell/aliasrc"
[ -f "$aliasrc_file" ] && source "$aliasrc_file"

# Fzf key bindings and completion
local fzf_key_bindings_file="/usr/share/fzf/key-bindings.zsh"
local fzf_completion_file="/usr/share/fzf/completion.zsh"
local ubuntu_fzf="$HOME/.fzf.zsh"
[ -f "$fzf_key_bindings_file" ] && source "$fzf_key_bindings_file"
[ -f "$fzf_completion_file" ] && source "$fzf_completion_file"
[ -f "$ubuntu_fzf" ] && source "$ubuntu_fzf"

# ===== Plugins =====
# Source zplug (only one file will be sourced)
local arch_zplug_init_file="/usr/share/zsh/scripts/zplug/init.zsh"
local ubuntu_zplug_init_file="/usr/share/zplug/init.zsh"
[ -f "$arch_zplug_init_file" ] && source "$arch_zplug_init_file"
[ -f "$ubuntu_zplug_init_file" ] && source "$ubuntu_zplug_init_file"

# Declare plugins
zplug "zsh-users/zsh-completions"  # Additional completion definitions for Zsh.
zplug "zsh-users/zsh-autosuggestions"  # Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-history-substring-search"  # ZSH port of Fish history search (up arrow)
zplug "zsh-users/zsh-syntax-highlighting"  # Fish shell like syntax highlighting for Zsh.

# Install plugins that are not installed
if ! zplug check; then
    zplug install
fi

# Source plugins and add commands to the $PATH
zplug load

# ===== Plugins configuration =====
# --- zsh-autosuggestions plugin ---
bindkey '^ ' autosuggest-accept

# --- zsh-history-substring-search plugin ---
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
