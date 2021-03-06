export EDITOR="vim"

export PATH=/usr/local/bin:/usr/bin:$PATH

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gp="git pull --rebase"
alias gmmro="git merge master -s recursive -X ours"
alias v="vim"
alias bake="bundle exec rake"
alias bails="bundle exec rails"
alias be="bundle exec"
alias r="r --no-save"
alias R="r --no-save"
alias testit="bundle exec rake test"
alias news="cd ~/capture_repos/capture-news/"
alias places="cd ~/capture_repos/capture-places/"
alias ka="~/exa/target/exa"

cd() { builtin cd "$@"; ls; }

export HISTCONTROL=erasedups  # Removes duplicate entires
export HISTSIZE=10000  # Increase command history
shopt -s histappend  # Ensures all history is saved
PROMPT_COMMAND='history -a' #Record history at every command

# set color for howdoi
set HOWDOI_COLORIZE on

#Bash Completion for git
test -f ~/.git-completion.bash && . $_


set completion-ignore-case on

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
export -f parse_git_branch
export PS1="\W \[\033[33m\]\$(parse_git_branch)\[\033[00m\]\[\033[00m\] "

export R_HISTFILE=~/.Rhistory

[ -f ~/.bashrc_local ] && . ~/.bashrc_local
[ -f ~/.bash_profile.local ] && . ~/.bash_profile.local

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.ec2/profile" ]] && source "$HOME/.ec2/profile" # Load EC2 API tools

# colored man pages
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

# sourcing plugins for bash
source ~/dotfiles/.plugins/.extract

# load rbenv on load of shell
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
