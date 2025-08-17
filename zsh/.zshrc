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

# Custom path environment variables
export XDG_CONFIG_HOME=$HOME/.config
export REPOS=$HOME/repos
export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.scripts

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
zinit ice depth=1; zinit light romkatv/powerlevel10k    # visual prompt customization and theming
zinit light zsh-users/zsh-syntax-highlighting           # syntax highlighting for zsh
zinit light zsh-users/zsh-completions                   # additional zsh completions
zinit light zsh-users/zsh-autosuggestions               # fish-like auto-suggestions
zinit light Aloxaf/fzf-tab                              # replaces default completion selection with fzf
zinit light MichaelAquilina/zsh-auto-notify             # auto-notify on command completion
zinit light mrjohannchang/zsh-interactive-cd            # extra integration of cd command with fzf
zinit light fdellwing/zsh-bat                           # bat (improved cat) integration for zsh

# Adding extra snippets (extra plugins from Oh My Zsh)
zinit snippet OMZP::pip                                 # extra completions and syggestions for PIP

# Set zsh-completions directory from Homebrew if available
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Load completions
autoload -Uz compinit && compinit

# Replay cached completions (as advised by zinit docs)
zinit cdreplay -q

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

setopt appendhistory            # Append to the history file, don't overwrite it
setopt sharehistory             # Share history across all sessions
setopt hist_ignore_space        # Ignore commands that start with a space (usable for sensitive inputs)
setopt hist_ignore_all_dups     # Ignore and do not save duplicate commands in history (same below)
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Globbing options
setopt extendedglob             # Enable extended globbing features
setopt nomatch                  # Print error on unmatched glob patterns
setopt globdots                 # Include hidden files in globbing patterns
setopt interactive_comments     # Allow comments starting with '#' in interactive mode

# Setting / unsetting of other options
setopt notify                   # Immediately report status of background jobs
setopt correctall               # Improved correction capabilities
setopt auto_cd                  # Automatically change to a directory when typing its name
unsetopt beep                   # Disable terminal bell sound

# Enabling vim mode
bindkey -v

# Extra bindings for history search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Extra completion options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Extra clipboard copy tools
[[ ! -f $HOME/.config/zsh/cliptools.zsh ]] || source $HOME/.config/zsh/cliptools.zsh

# Extra PATH additions
export PATH="$HOME/.local/bin:$HOME/.scripts/bin:$PATH"


# --- ALIASES ---

# Automatically Expanding Global Aliases (Space key to expand)
#   - reference: http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
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

# Load aliases from a separate file
[[ ! -f $HOME/.config/zsh/aliases.zsh ]] || source $HOME/.config/zsh/aliases.zsh


# --- OTHER TOOLS CUSTOM SETUP ---

# Hombrew shell setup and completions (MacOS-only)
if [[ "$OSTYPE" == darwin* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setting color theme for bat tool
export BAT_THEME=DarkNeon

# Initializing tmuxifier (tool for managing tmux sessions)
export PATH="$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.scripts/tmuxifier"
eval "$(tmuxifier init -)"

# Colored GCC warnings and errors (inherited from default bash setup on Ubuntu)
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# --- CONDA SETUP ---

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# --- FZF INTEGRATION ---
# Note: here at the end to ensure unbinging of Ctrl-G from vim mode to be used in fzf-git

# Sourcing fzf script for integration with zsh
[[ ! -f $HOME/.config/fzf/fzf.zsh ]] || source $HOME/.config/fzf/fzf.zsh

# Setup of fzf-git tool 
bindkey -r '^G'
[[ ! -f $HOME/.config/zsh/fzf-git.zsh ]] || source $HOME/.config/zsh/fzf-git.zsh

# Enabling preetier preview for fzf widgets using bat and eza
#   source: https://www.youtube.com/watch?v=mmqDYw9C30I
FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --git {} | head -200'"

# -----------------------------------------------------------------------


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/p10k.zsh ]] || source $HOME/.config/zsh/p10k.zsh
