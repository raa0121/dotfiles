
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# set aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
set meta-flag on
set convert-meta off
set output-meta on

# user file-creation mask
umask 022

export EDITOR=vim

host=`hostname -s`
case $host in
  "nakako")   color="31";;
  "yumeko")   color="32";;
esac

PS1='\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[${color}m\]\h:\[\033[33;1m\]\w\[\033[m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
[[ -z $USER ]] && export USER=$USERNAME

_uname=`uname -o`
if [ $_uname = "Cygwin" ] ; then
  WIN_PATH=$PATH
  PATH=/usr/local/bin/:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
  export LANG=ja_JP.UTF-8
  DISPLAY="localhost:0.0"
  [[ -s $HOME/android-sdk-windows ]] && export ANDROID_SDK_PATH=$HOME/android-sdk-windows
  [[ -s $HOME/android-ndk-r8b ]] && export ANDROID_NDK_PATH=$HOME/android-ndk-r8b
  export PATH="$ANDROID_SDK_PATH/platform-sdk-windows:~/.rbenv/bin:$PATH:$WIN_PATH"
  eval "$(rbenv init -)"
elif [ $_uname = "Msys" ]; then
  export LANG=ja_JP.sjis
  export JLESSCHARSET="japanese-sjis"
  export OUTPUT_CHARSET=sjis
  WIN_PATH=$PATH
  PATH=/usr/local/bin/:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
  export PATH="$PATH:/c/MinGW/bin:/c/MinGW/mingw32/bin:$WIN_PATH"
  [[ -s $USERPROFILE/.pik/.pikrc ]] && source $USERPROFILE/.pik/.pikrc
elif [ $HOSTNAME = "ryo" ] || [ $HOSTNAME = "nakako" ]; then
  export LANG=ja_JP.UTF-8
  export PATH=$HOME/bin:$PATH
fi
