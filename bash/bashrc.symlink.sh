# ~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color'
alias rm='rm -I'
alias ctl='sudo systemctl'

alias pm='sudo pacman'
alias pms='sudo pacman -S --color auto'
alias pmss='sudo pacman -Ss --color auto'
alias pmu='sudo pacman -Su'
alias pmuy='sudo pacman -Suy'
alias yas='yaourt -S'
alias yass='yaourt -Ss'
alias yuy='yaourt -Suy --aur --noconfirm'

PATH="$HOME/.gem/ruby/2.0.0/bin:$HOME/.gem/ruby/1.9.3/bin:$PATH"
export PATH

complete -o default -o nospace -F _systemctl ctl

export HISTFILESIZE=100000
export HISTCONTROL=ignoredups
HISTTIMEFORMAT="[%d/%m/%y %T] "

export EDITOR=nano
export VISUAL=vim

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
