#!/bin/bash

# Color Definitions:
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
end=$'\e[0m'
# End Color

# Set Vars:
username="wulf"
userhome="/home/$username"
network=192.168.1
nameserver=192.168.1.1
gateway=192.168.1.1
subnet=255.255.255.0
networkfile="/etc/network/interfaces"


read "Is this device the controller [y/n]" controllervar

if [ $contollervar = y ]; then

echo "${yel}=== Set Hostname to controller ===${end}"
hostnamectl set-hostname "controller"
echo "${grn}=== Hostname Set to controller ===${end}"

echo "${yel}=== Installing Ansible ===${end}"
sudo apt install sshpass python3-paramiko git -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
echo ""

echo "${yel}=== Setting up Config ===${end}"
cat >> ~/.ansible.cfg < EOF                                                               
[defaults]
host_key_checking = false
EOF
echo ""

echo "${grn}=== Ansible Version ===${end}"
ansible --version
echo ""

echo "${grn}=== Config Check Below ===${end}"
cat ~/.ansible.cfg
echo ""
fi

read "What node number is this [x]: " nodenum

echo "${yel}=== Set Hostname to node0$nodenum ===${end}"
hostnamectl set-hostname "node$nodenum"
echo "${grn}=== Hostname Set to node0$nodenum ===${end}"

echo "${yel} === Creating $username User === ${end}"
# Add user where the first argument is the password
useradd -m "$username"
echo "$username:$1" | sudo chpasswd
echo ""
echo "${grn} === $username User Created === ${end}"
echo ""

echo "${yel} === Adding $username User to Sudo Group === ${end}"
# Add user where the first argument is the password
usermod -aG sudo $username
echo ""
echo "${grn} === Added wulf User to Sudo Group === ${end}"
echo ""

read -p "Do you want to setup networking [y/n]: " networking

if [ $networking = 'y' ]
then
# Configuring Networking
echo "${yel} === Configure Networking === ${end}"

ip -br -c link show

read -p "Enter main adapter you would like to use: " adapter
read -p "Enter last octect of IP Address" ip

#TODO Make sure networking config is good

/bin/cat > $networkfile << EOM

source /etc/network/interfaces.d/*

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
echo "${grn} === Networking Configured === ${end}"
echo ""
fi

# Install Chapel Dependencies
echo "${yel} === Installing Chapel Dependencies === ${end}"

sudo apt-get install gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config cmake -y
sudo apt-get install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev -y
echo ""
echo "${grn} === Chapel Dependencies Installed === ${end}"
echo ""

# Main Install
echo "${yel} === Installing Chapel === ${end}"
if [ ! -f $userhome/chapel-1.29.0.tar.gz ]; then
    cd $userhome
    wget "https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz"
    tar xzf chapel-1.29.0.tar.gz
fi
echo ""
echo "${grn} === Chapel Installed === ${end}"
echo ""
