export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
export EDITOR=/usr/bin/vim
export LS_OPTIONS='--color=auto -h'

HISTFILESIZE=99999999
HISTSIZE=99999999
HISTCONTROL=ignoredups:ignorespace

umask 022
eval "`dircolors`"

freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq | awk '{print $1/1000}'`
temp=`cat /sys/class/thermal/thermal_zone0/temp| awk '{print $1/1000}'`
wlan_ip=`ifconfig wlan0 | grep inet | cut -d: -f2 | cut -d " " -f1`
eth_ip=`ifconfig eth0 | grep inet | cut -d: -f2 | cut -d " " -f1`
kernel=`uname -a | awk '{print $3}'`

alias ll='ls -Glah --color=auto'
alias cd..='cd ..'
alias cls='clear'
alias fetch='curl -O'

alias nas_mount='echo "Passwort eingeben" && read pass_samba && mount -t cifs //192.168.1.5/storage /storage -o uid=0,gid=0,username=storage,password="$pass_samba" && pass_samba=""'

if [ -n "$wlan_ip" ]; then
        alias nload='nload -u m U m -i 100000 -o 100000 wlan0'
fi
if [ -n "$eth_ip" ]; then
        alias nload='nload -u m U m -i 100000 -o 100000 eth0'
fi

alias ga='/usr/bin/git add'
alias gaf='/usr/bin/git add --force'
alias gb='/usr/bin/git branch -vvv'
alias gc='/usr/bin/git commit'
alias gd='/usr/bin/git diff'
alias gdc='/usr/bin/git diff --cached'
alias gdep='/usr/bin/git pull && /usr/bin/git push && cap deploy'
alias gdt='/usr/bin/git difftool'
alias gdw='/usr/bin/git diff --color-words'
alias gitx='gitg --all'
alias gl='/usr/bin/git lg'
alias gla='/usr/bin/git lg --all'
alias gm='/usr/bin/git mv'
alias go='/usr/bin/git checkout'
alias gob='/usr/bin/git checkout -b'
alias gpop='/usr/bin/git stash pop'
alias gpp='/usr/bin/git pull && /usr/bin/git push'
alias gpull='/usr/bin/git pull'
alias gpush='/usr/bin/git push'
alias gr='/usr/bin/git rm'
alias gs='/usr/bin/git status'
alias gstash='/usr/bin/git stash'
alias gstashdep='gstash && gpp && gpop && cap deploy'
alias gitcleanbranches="go master;git branch --merged|grep -v '^*'|xargs -n 1 git branch -d"

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
echo ""
echo "$(tput setaf 2)
           .~~.   .~~.
          '. \ ' ' / .'$(tput setaf 1)
           .~ .~~~..~.    $(tput sgr0)                   _                          _ $(tput setaf 1)
          : .~.'~'.~. :   $(tput sgr0)   ___ ___ ___ ___| |_ ___ ___ ___ _ _    ___|_|$(tput setaf 1)
         ~ (   ) (   ) ~  $(tput sgr0)  |  _| .'|_ -| . | . | -_|  _|  _| | |  | . | |$(tput setaf 1)
        ( : '~'.~.'~' : ) $(tput sgr0)  |_| |__,|___|  _|___|___|_| |_| |_  |  |  _|_|$(tput setaf 1)
         ~ .~ (   ) ~. ~  $(tput sgr0)              |_|                 |___|  |_|    $(tput setaf 1)
          (  : '~' :  )
           '~ .~~~. ~'
               '~'
$(tput sgr0)"
if [ -n "$wlan_ip" ]; then
        echo -e "      \033[1;33m IP-Adresse WLAN: \033[0m" $wlan_ip
fi
if [ -n "$eth_ip" ]; then
        echo -e "      \033[1;33m IP-Adresse LAN:  \033[0m" $eth_ip
fi
echo -e "      \033[1;33m Kernel:          \033[0m" $kernel
echo -e "      \033[1;33m CPU:             \033[0m" $freq" MHz ("$temp "°C)"
echo ""
