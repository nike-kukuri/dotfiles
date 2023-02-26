#!/bin/bash

set syntax enable
set number
set shiftwidth=4
set tabstop=4
set cindent
set autoindent
alias c='clear'

# default:cyan / root:red
if [ $UID -eq 0 ]; then
    PS1="\[\033[31m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
else
    PS1="\[\033[36m\]\u@\h\[\033[00m\]:\[\033[01m\]\w\[\033[00m\]\\$ "
fi

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'


alias tmux-split='~/.scripts/tmux.sh'

GREETING='.bashrc source Completed!!'
MYNAME='Keita Yamasoto'
NOW=`date +'%Y/%m/%d %H:%M:%S'`
echo "${MYNAME}_$NOW> $GREETING" >> bashrc_update.log

stty stop undef


. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
