# general
alias ai='sudo apt install -y'
alias bi='brew install'
alias clear='TERM=xterm-kitty /usr/bin/clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias icat='kitten icat'
alias rmf='rm -rf'

# directory listing
alias ls='ls --color=auto'
alias ll='ls -lah'
alias lt='ls -lath'
alias lz='eza -laghm --git --icons=always --color=always --group-directories-first'
alias lzs='eza -laghm --git --icons=always --color=always --group-directories-first --total-size'
alias lzt='eza --long --all --git --group-directories-first --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=2'
alias lztt='eza --long -all --git --group-directories-first --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=3'
alias lzttt='eza --long --all --git --group-directories-first --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=4'
alias lztx='eza --long --all --git --group-directories-first --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree'

# bat and cat 
if [[ "$OSTYPE" != darwin* ]]; then
    alias bat='batcat --color=always'
fi
alias catt='bat --paging=never --color=always'
alias batt='bat --paging=never --color=always'

# git commands
alias gcl='git clone'
alias gbls='git branch -a'
alias gbc='git switch -c'
alias gch='git checkout'
alias gchm='git checkout main'
alias ga='git add .'
alias gaf='git add'
alias gaa='git add --all'
alias gac='git add . && git commit -m'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gull='git pull'
alias gush='git push'
alias grem='git remote -v'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --decorate'
alias gg='git log --oneline --graph --decorate --all'
alias gls='git log --stat'
alias gll='git log'


# GLOBAL ALIASES
#   (working with Global Alias Expansiona - as defined in .zshrc)
# Ideas from:
#   - http://www.zzapper.co.uk/zshtips.html
#   - https://justingarrison.com/blog/2023-06-05-zsh-global-aliases/

# replace alias with newest directory or file, respectively
alias -g ND='*(/om[1])'
alias -g NF='*(.om[1])'

# appending redirection to /dev/null
alias -g NE='2> /dev/null'
alias -g NO='&> /dev/null'
alias -g EO="> /dev/null 2>&1"

# piping to common output formatting or editing tools
alias -g C='| wc -l'
alias -g H='| head -n'
alias -g T='| tail -n '
alias -g V='| vim -R -'
alias -g VV="2>&1 | vim -R -"
alias -g L='| less'
alias -g LL="2>&1 | less"
alias -g M='| more'
alias -g MM="2>&1 | more"

# searching and filtering tools
alias -g GG='| grep'
alias -g G='| rg'
alias -g GJ='| rg --json'
alias -g D='| delta'

# copying to clipboard (platform-dependent)
if [[ "$OSTYPE" == darwin* ]]; then
    alias -g X='| pbcopy'
else
    alias -g X='| xclip -selection clipboard'
fi
