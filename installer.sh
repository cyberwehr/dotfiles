#!/bin/sh
read -p "Bitte den neuen Hostnamen eingeben: " hostname
echo > /etc/bash.bashrc
echo $hostname > /etc/hostname
wget --no-check-certificate -O /root/.bashrc https://raw.githubusercontent.com/tz0/dotfiles/master/nas.bashrc
apt-get update
apt-get -y upgrade
apt-get -y install htop nload unzip zip nmap curl mtr
reboot
