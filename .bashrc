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

PS1="\u \! \W\$ "

PATH=/cygdrive/c/Users/raa0121/AppData/Roaming/cabal/bin:/usr/local/bin:/usr/bin:/sbin:$PATH

_uname=`uname -o`
if [ $_uname = "Cygwin" ] ; then
  LANG=ja_JP.UTF-8
  DISPLAY="localhost:0.0"
  export ANDROID_SDK_PATH=$HOME/android-sdk-windows
  export ANDROID_NDK_PATH=$HOME/android-ndk-r8b
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
elif [ $_uname = "Msys" ]; then
  LANG=ja_JP.sjis
  JLESSCHARSET="japanese-sjis"
  OUTPUT_CHARSET=sjis
  [[ -s $USERPROFILE/.pik/.pikrc ]] && source $USERPROFILE/.pik/.pikrc
fi
_vim=`which vim`
vim(){
    if [ $1 ] ; then
        $_vim $1
    else
        $_vim ~/.vimrc
    fi
}
_gvim=`which gvim`
gvim(){
    if [ $1 ] ; then
        $_gvim $1
    else
        $_gvim ~/.vimrc
    fi
}
