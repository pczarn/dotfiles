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
export VISUAL=subl

shopt -s checkwinsize

# Source all files in ~/.sources/
function src() {
    local file
    for file in ~/.sources/*; do
        source "$file"
    done
}

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u"
    local __location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[m\]:\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/'"$__git_branch_color"'\\\\\1\/`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__location$__git_branch $__prompt_tail$__last_color "
}

#color_my_prompt
function prompt_command {
	pwd >> $PROMPT_DAEMON
	read line <$PROMPT_DAEMON
	export PS1="$line"
}

export PROMPT_DAEMON=`mktemp`
mkfifo $PROMPT_DAEMON
export PROMPT_COMMAND=prompt_command

#nohup ~/.prompt $PROMPT_DAEMON 0<&- &>/dev/null &
src
