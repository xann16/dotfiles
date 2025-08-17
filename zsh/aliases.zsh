# temp - to sort

alias clear='TERM=xterm-kitty /usr/bin/clear'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias lt='ls -lath'
alias lz='eza -laghm@ --git --icons=always --color=always'
alias lzt='eza --long --git --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=2'
alias lztt='eza --long --git --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=3'
alias lzttt='eza --long --git --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree --level=4'
alias lztx='eza --long --git --icons=always --color=always --no-filesize --no-time --no-user --no-permissions --tree'
alias icat='kitten icat'
if [[ "$OSTYPE" != darwin* ]]; then
    alias bat='batcat --color=always'
fi



# some proposals for standard aliases - TODO

# file shit
#alias rmrf='rm -rf '

# brew
#alias bi='HOMEBREW_NO_AUTO_UPDATE=1 brew install '

# git commands
#alias g=git
#alias gbl='branch -a'
#alias gcl='git clone '
#alias pp='git pull --rebase && git push'
#alias gpr='git pull-request -b '
#alias ga='git add .'
#alias gc='git commit -m '
#alias gagc='git add . && git commit -m '
#alias gbr='git browse'
#alias grb='git rebase -'
#alias gs='git status'
#alias gb='git checkout -b'
#alias grc='git rebase --continue'
#alias grs='git rebase --skip'
#alias grv='git remote -v'
#alias gp='git fetch -p'
#alias gcom='git checkout main'
#alias gcol='git checkout -'

# Hub commands
#alias -g gpr='git pull-request -b '
#alias -g gcr='git create'



# GLOBAL ALIASES
#   (working with Global Alias Expansiona - as defined in .zshrc)
# Ideas from:
#   - http://www.zzapper.co.uk/zshtips.html
#   - https://justingarrison.com/blog/2023-06-05-zsh-global-aliases/

# TODO - still some to check and verify

#alias -g ND='*(/om[1])' 	      # newest directory
#alias -g NF='*(.om[1])' 	      # newest file
#alias -g NE='2>|/dev/null'
#alias -g NO='&>|/dev/null'
#alias -g P='2>&1 | $PAGER'
#alias -g VV='| vim -R -'
#alias -g L='| less'
#alias -g M='| most'
alias -g C='| wc -l'
alias -g H='| head'
alias -g T='| tail'
alias -g GG='| grep'
alias -g G='| rg'
alias -g GJ='| rg --json'
alias -g D='| delta'
#alias -g LL="2>&1 | less"
#alias -g CA="2>&1 | cat -A"
#alias -g NE="2> /dev/null"
#alias -g NUL="> /dev/null 2>&1"
#alias -g J='| jq .'
#alias -g T="| tr -d '\n' "
alias -g XX="| xclip -selection clipboard"
