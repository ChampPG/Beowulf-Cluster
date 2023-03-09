#!/bin/bash

# Color Definitions:
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
end=$'\e[0m'
# End Color

# Set Vars:
$wulfhome = /home/wulf
$network = 192.168.1
$nameserver = 192.168.1.1
$gateway = 192.168.1.1
$subnet = 255.255.255.0

# Configuring Networking
echo "${yel} === Configure Networking === ${end}\n"

ip -br -c link show

read -p "Enter main adapter you would like to use: " adapter
read -p "Enter last octect of IP Address" ip

#TODO Make sure networking config is good

FILE="/etc/network/interfaces"
/bin/cat << EOM > $FILE
# The loopback network interface
auto lo
iface lo inet loopback
 
# The primary network interface
auto $adapter
iface $adapter inet static
 address $network.$ip
 netmask $subnet
 gateway $gateway
 dns-nameservers $nameserver
EOM

systemctl restart networking.service
systemctl status networking.service
echo ""
echo "${grn} === Networking Configured === ${end}\n"
echo ""

# Install Chapel Dependencies
echo "${yel} === Installing Chapel Dependencies === ${end}\n"

sudo apt-get install gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config cmake -y
sudo apt-get install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev -y
echo ""
echo "${grn} === Chapel Dependencies Installed === ${end}\n"
echo ""

# Main Install
echo "${yel} === Installing Chapel === ${end}\n"
if [ ! -f $wulfhome/chapel-1.29.0.tar.gz ]; then
    cd $wulfhome
    wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
    tar xzf chapel-1.29.0.tar.gz
fi
echo ""
echo "${grn} === Chapel Installed === ${end}\n"
echo ""