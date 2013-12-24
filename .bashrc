
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# set aliases
alias ll='ls -la'
alias la='ls -a'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
set meta-flag on
set convert-meta off
set output-meta on

# user file-creation mask
umask 022

export EDTOR=vim
PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
WIN_PATH=$PATH
PATH=/usr/local/bin/:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
PROMPT_COMMAND='echo -ne "\033]0;[UTF-8] ${USER}@${HOSTNAME%%.*} :${PWD/#$HOME/~}\007"'

_uname=`uname -o`
if [ $_uname = "Cygwin" ] ; then
  export LANG=ja_JP.UTF-8
  DISPLAY="localhost:0.0"
  export ANDROID_SDK_PATH=$HOME/android-sdk-windows
  export ANDROID_NDK_PATH=$HOME/android-ndk-r8b
  export PATH="$ANDROID_SDK_PATH/platform-sdk-windows:~/.rbenv/bin:$PATH:$WIN_PATH"
  eval "$(rbenv init -)"
elif [ $_uname = "Msys" ]; then
  LANG=ja_JP.sjis
  JLESSCHARSET="japanese-sjis"
  OUTPUT_CHARSET=sjis
  export PATH="$PATH:$WIN_PATH"
  [[ -s $USERPROFILE/.pik/.pikrc ]] && source $USERPROFILE/.pik/.pikrc
elif [ $HOSTNAME = "ryo" ] || [ $HOSTNAME = "nakako" ]; then
  export LANG=ja_JP.UTF-8
  export PATH=$WIN_PATH
fi
