# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#stty -ixon

# unlimit stacksize for large aray in user mode
#ulimit -s unlimited

# set aliases
alias ls='ls -F --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -a --color=auto'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias use_pacman='ps aux | grep pacman'

# user file-creation mask
umask 022

#if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

export EDTOR=vim

PS1="\u \! \W\$ "

PATH=$PATH

DISPLAY="localhost:0.0"

LANG=ja_JP.UTF8


