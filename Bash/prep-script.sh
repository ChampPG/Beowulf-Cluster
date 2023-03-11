#!/bin/bash

# Color Definitions:
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
end=$'\e[0m'
# End Color

echo "${yel} === Updating and Upgrading Machine === ${end}"
apt update -y
apt upgrade -y
echo "${grn} === Machine Updated and Upgraded === ${end}"
echo ""

echo "${yel} === Setting up openssh-server Machine === ${end}"
apt-get install -y open-vm-tools openssh-server
cat /dev/null > /var/log/wtmp 
cat /dev/null > /var/log/lastlog 
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -f /etc/ssh/ssh_host*
rm -f /etc/udev/rules.d/70-persistent-net.rules
cat << EOL | sudo tee /etc/rc.local
#!/bin/sh -e
test -f /etc/ssh/ssh_host_dsa_key || dpkg-reconfigure openssh-server
exit 0
EOL
echo "${grn} === openssh-server is setup === ${end}"
echo ""

echo "${yel} === Cleaning up Machine === ${end}"
apt-get clean
history -c
history -w
chmod +x /etc/rc.local
systemctl stop apt-daily-upgrade.timer
systemctl disable apt-daily-upgrade.timer
systemctl stop apt-daily.timer
systemctl disable apt-daily.timer
sudo apt autoremove -y
echo "${grn} === Machine Cleaned up === ${end}"
echo ""

read -p "Is this a virtual machine (y/n): " vm

if [ vm = y ]; then
    echo ""
    echo "${yel} === Removing Machine ID for DHCP === ${yel}"
    echo -n > /etc/machine-id
    sudo rm /var/lib/dbus/machine-id
    sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
    echo "remove git repo and then issue a shutdown - h now"
    echo ""
    echo "${grn} === Machine ID Removed === ${end}"
    echo ""
fi
