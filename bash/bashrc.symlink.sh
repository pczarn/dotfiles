# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color'
alias rm='rm -I'
alias ctl='sudo systemctl'
alias tmux='tmux -2'

alias pm='sudo pacman'
alias pms='sudo pacman -S --color auto'
alias pmss='sudo pacman -Ss --color auto'
alias pmu='sudo pacman -Su'
alias pmuy='sudo pacman -Suy'
alias yas='yaourt -S'
alias yass='yaourt -Ss'
alias yuy='yaourt -Suy --aur --noconfirm'

_completion_loader systemctl
complete -o default -o nospace -F _systemctl systemctl ctl

_completion_loader pacman
complete -o default -o nospace -F _pacman pm
PATH="$HOME/.gem/ruby/2.0.0/bin:$HOME/.gem/ruby/1.9.3/bin:$PATH"
export PATH

export TERM=xterm-256color

export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
HISTTIMEFORMAT="[%d/%m/%y %T] "

# Sorry, nano
export EDITOR=vim
export VISUAL=$EDITOR

export CHROMIUM_USER_FLAGS=--enable-print-preview

shopt -s checkwinsize

# Source all files in ~/.sources/
function src() {
    local file
    for file in ~/.sources/*; do
        source "$file"
    done
}

export PROMPT_COMMAND='export PS1=$(~/.prompt.lua)'
src

LD_LIBRARY_PATH=$HOME/Desktop/rust/x86_64-unknown-linux-gnu/stage1/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

# Add RVM to PATH for scripting
PATH=$HOME/.gem/ruby/2.0.0/bin:$HOME/.gem/ruby/1.9.3/bin:$PATH:$HOME/bin:$HOME/.rvm/bin
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
