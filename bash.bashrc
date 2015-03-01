[ -z "$PS1" ] && return
shopt -s checkwinsize
PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

clear
cd /
freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq | awk '{print $1/1000}'`
temp=`cat /sys/class/thermal/thermal_zone0/temp| awk '{print $1/1000}'`
wlan_ip=`ifconfig wlan0 | grep inet | cut -d: -f2 | cut -d " " -f1`
eth_ip=`ifconfig eth0 | grep inet | cut -d: -f2 | cut -d " " -f1`
kernel=`uname -a | awk '{print $3}'`
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
sleep 0.1
