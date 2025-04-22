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

# Enabling shell integration with fzf (to be updated for newer fzf versions)
# eval "$(fzf --zsh)"      # <- does not work with fzf v0.29
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey '^R' fzf-history-widget  # Ctrl-R to fuzzy search through history

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

# extra PATH additions
export PATH="/home/user/.local/bin:$PATH"


# ALIASES

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

source $HOME/.zaliases


# EXTRA CLIPBOARD COPY TOOLS
#   taken from Oh My Zsh plugins - see:
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copybuffer/copybuffer.plugin.zsh
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copyfile/copyfile.plugin.zsh
#     - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/copypath/copypath.plugin.zsh

# Copyies the active line from the command line buffer onto the system clipboard
xxbuf () {
  if builtin which xclip &>/dev/null; then
    printf "%s" "$BUFFER" | xclip -selection clipboard
  else
    zle -M "xclip not found"
  fi
}
zle -N xxbuf
bindkey '^O' xxbuf

# Copies the contents of a given file to the system or X Windows clipboard
function xxfile {
  emulate -L zsh
  xclip -selection clipboard $1
}

# Copies the path of given directory or file to the system or X Windows clipboard
#   (copies current directory if no parameter is provided)
function xxpath {
  # If no argument passed, use current directory
  local file="${1:-.}"
  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"
  # Copy the absolute path without resolving symlinks (if clipcopy fails, exit the function with an error)
  print -n "${file:a}" | xclip -selection clipboard || return 1
  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

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
