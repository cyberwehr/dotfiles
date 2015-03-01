export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
export EDITOR=/usr/bin/vim
export LS_OPTIONS='--color=auto -h'

HISTFILESIZE=99999999
HISTSIZE=99999999
HISTCONTROL=ignoredups:ignorespace

umask 022
eval "`dircolors`"

eth_ip=`ifconfig eth0 | grep inet | cut -d: -f2 | cut -d " " -f1`
kernel=`uname -a | awk '{print $3}'`

alias ll='ls -Glah --color=auto'
alias cd..='cd ..'
alias cls='clear'
alias fetch='curl -O'

if [ -n "$wlan_ip" ]; then
        alias nload='nload -u m U m -i 100000 -o 100000 wlan0'
fi
if [ -n "$eth_ip" ]; then
        alias nload='nload -u m U m -i 100000 -o 100000 eth0'
fi

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' kann nicht entpackt werden." ;;
        esac
    else
        echo "'$1' ist keine gültige Datei."
    fi
}

[ -z "$PS1" ] && return
shopt -s checkwinsize
PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'

cd /
clear
