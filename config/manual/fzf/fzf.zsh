# FZF insists on not having a dedicated config file, but rather using
# environment variables. These are added and then sourced by the main .zshrc
# file in order to reduce clutter in that file.

# Find command
export FZF_DEFAULT_COMMAND="fd --type=file --hidden --no-ignore --exclude=.git --exclude=.cache"

# Default options
export FZF_DEFAULT_OPTS="
    --no-scrollbar
    --info=inline-right
    --preview-window=up:60%:border-bottom
    --preview='bat {}'
"

# Color scheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
    --color=dark
    --color=fg:-1,bg:-1,hl:#9fe6b1,fg+:-1,bg+:-1,hl+:#fac38c
    --color=info:#6aa9d9,prompt:#f0a8d7,pointer:#6aa9d9,marker:#ff87d7,spinner:#ff87d7
"
