# Setup history size and destination
HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Globbing options
setopt extendedglob
setopt nomatch
setopt globdots

# setting / unsetting of other options
setopt notify correctall nomatch globdots
setopt correctall
unsetopt beep

# enable vim mode
bindkey -v

# extra completion options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# extra PATH additions
export PATH="/home/user/.local/bin:$PATH"


# --- GENERAL ALIASES ---

alias clear='TERM=xterm-kitty /usr/bin/clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lah'

# --- OTHER TOOLS CUSTOM SETUP ---

# tmuxifier
export PATH="$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.scripts/tmuxifier"
eval "$(tmuxifier init -)"

# colored gcc warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/user/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/user/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/user/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/user/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

