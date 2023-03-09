#!/bin/bash

# Color Definitions:
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
end=$'\e[0m'
# End Color

# Set Vars:
$wulfhome = /home/wulf

echo "${yel} === Updating and Upgrading Machine === ${end}\n"
apt update -y
apt upgrade -y
echo ""
echo "${grn} === Machine Updated and Upgraded === ${end}\n"
echo ""

echo "${yel} === Creating wulf User === ${end}\n"
# Add user where the first argument is the password
adduser -m -p $1 wulf
echo ""
echo "${grn} === wulf User Created === ${end}\n"
echo ""

read -p "Is this a virtual machine (y/n): " vm

if [ vm = y ]; then
    echo ""
    echo "${yel} === Removing Machine ID for DHCP === ${yel}\n"
    echo -n > /etc/machine-id
    sudo rm /var/lib/dbus/machine-id
    sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
    echo "remove git repo and then issue a shutdown - h now"
    echo ""
    echo "${grn} === Machine ID Removed === ${end}\n"
    echo ""
fi