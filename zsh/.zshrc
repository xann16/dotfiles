# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Basic environment variables setup
export VISUAL=nvim
export EDITOR=nvim
export BROWSER=firefox

export XDG_CONFIG_HOME=$HOME/.config
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
zinit light mrjohannchang/zsh-interactive-cd
zinit light fdellwing/zsh-bat

# Adding extra snippets (extra plugins from Oh My Zsh)
zinit snippet OMZP::pip

# Replay cached completions (as advised by zinit docs)
zinit cdreplay -q

# Load completions
autoload -U compinit && compinit

# If 'cd' is used without arguments use fzf to search through file hierarchy
#   Source: https://kaliex.co/supercharge-your-zsh-terminal-with-fzf-a-simple-guide/
function cd() {
    if [[ $# -gt 0 ]]; then
        builtin cd "$@"
    else
        local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && builtin cd "$dir"
    fi
}

# Setup history size and destination
if [[ -d $HOME/.config/zsh ]]; then
    HISTFILE=$HOME/.config/zsh/history;
else
    HISTFILE=$HOME/.zhistory
fi

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
setopt interactive_comments

# setting / unsetting of other options
setopt notify correctall nomatch globdots
setopt correctall
setopt auto_cd
unsetopt beep

# enable vim mode
bindkey -v

# Extra bindings for history search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# extra completion options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# extra clipboard copy tools
[[ ! -f $HOME/.config/zsh/cliptools.zsh ]] || source $HOME/.config/zsh/cliptools.zsh

# extra PATH additions
export PATH="/home/user/.local/bin:$PATH"


# --- ALIASES ---

# Automatically Expanding Global Aliases (Space key to expand)
#   references: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
    if [[ $LBUFFER =~ ' [a-zA-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}

zle -N globalias
bindkey " " globalias                 # space key to expand globalalias
# bindkey "^ " magic-space            # control-space to bypass completion
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches

[[ ! -f $HOME/.config/zsh/aliases.zsh ]] || source $HOME/.config/zsh/aliases.zsh


# --- OTHER TOOLS CUSTOM SETUP ---

# brew shell completion (MacOS-only)
if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# bat
export BAT_THEME=DarkNeon

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


# ----------------------------------------------------------------------

# --- FZF INTEGRATION ---
# Note: here at the end to ensure unbinging of Ctrl-G from vim mode to be used in fzf-git

# fzf integration with zsh
[[ ! -f $HOME/.config/fzf/fzf.zsh ]] || source $HOME/.config/fzf/fzf.zsh

# fzf-git tool setup
bindkey -r '^G'
[[ ! -f $HOME/.config/zsh/fzf-git.zsh ]] || source $HOME/.config/zsh/fzf-git.zsh

# extra preview for fzf widgets
#   source: https://www.youtube.com/watch?v=mmqDYw9C30I
FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --git {} | head -200'"

# -----------------------------------------------------------------------


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/p10k.zsh ]] || source $HOME/.config/zsh/p10k.zsh
