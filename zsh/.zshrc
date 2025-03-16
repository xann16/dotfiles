# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic environment variables setup
export VISUAL=nvim
export EDITOR=nvim
export BROWSER=google-chrome # to be replaced by firefox (or sth else)

export REPOS=$HOME/repos
export DOTFILES=$HOME/.dotfiles


# Home directory for zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"

# If zinit is not cloned, do so
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$ZINIT_HOME"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# Source initialization script for zinit
source "$ZINIT_HOME/zinit.zsh"

# Adding zsh plugins via zinit
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-auto-notify
zinit light MichaelAquilina/zsh-you-should-use

# Adding extra snippets (extra plugins from Oh My Zsh)
zinit snippet OMZP::git

# Replay cached completions (as advised by zinit docs)
zinit cdreplay -q

# Load completions
autoload -U compinit && compinit

# Enabling shell integration with fzf (to be updated for newer fzf versions)
# eval "$(fzf --zsh)"      # <- does not work with fzf v0.29
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

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

# Jump to editor (vim) to edit command line
bindkey '^e' edit-command-line

# Extra bindings for history search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# extra completion options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# extra PATH additions
export PATH="/home/user/.local/bin:$PATH"


# --- GENERAL ALIASES ---

alias clear='TERM=xterm-kitty /usr/bin/clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias lt='ls -lath'
alias lx='exa -laghm@ --icons --color=always'

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
