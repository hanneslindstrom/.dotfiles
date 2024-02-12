# -----------------------------------------------------------------------------
# Paths

export XDG_CONFIG_HOME=$DOTFILES/config/xdg
export XDG_DATA_HOME=$DOTFILES/data

export ZSH=$XDG_DATA_HOME/oh-my-zsh/oh-my-zsh
export ZSH_CUSTOM=$XDG_DATA_HOME/oh-my-zsh/custom
export ZSH_COMPDUMP=$HOME/.cache/zsh/.zcompdump-$HOST

# -----------------------------------------------------------------------------
# Plugins

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(zsh-autosuggestions zsh-syntax-highlighting vi-mode)

# -----------------------------------------------------------------------------
# Key mappings

# Enable vi mode.
bindkey -v

# Go to normal mode (vi-mode) using kk.
bindkey -M viins 'kk' vi-cmd-mode

# Better history walking.
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Better searching through history.
bindkey -M vicmd "/" history-incremental-pattern-search-backward
bindkey -M vicmd "?" history-incremental-pattern-search-forward
bindkey -M vicmd "n" vi-repeat-search
bindkey -M vicmd "N" vi-rev-repeat-search

# Clearing the screen and Tmux scollback buffer.
clear-scrollback-and-screen () {
  zle clear-screen
  tmux clear-history
}
zle -N clear-scrollback-and-screen
bindkey -v '^[c' clear-scrollback-and-screen

# -----------------------------------------------------------------------------
# Options

ZSH_THEME="robbyrussell"

# Use _ and -  interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Use different cursor types for different modes (vi-mode).
VI_MODE_SET_CURSOR=true

# Same visual mode cursor as in vim.
VI_MODE_CURSOR_VISUAL=2

# Let the cursor clarify the mode.
MODE_INDICATOR=" "

# 10ms for key sequences for speedier normal mode entry.
KEYTIMEOUT=1

# Don't want to add certain aliased commands to our history (e.g. 'clear').
HIST_IGNORE_SPACE="true"

# Don't like annoying beeps..
unsetopt BEEP

# -----------------------------------------------------------------------------
# Finish

source $ZSH/oh-my-zsh.sh
