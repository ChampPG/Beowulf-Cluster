#!/bin/bash

# Color Definitions:
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
end=$'\e[0m'
# End Color

echo "${yel}=== Installing Ansible ===${end}\n"
sudo apt install sshpass python3-paramiko git -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
echo ""

echo "${yel}=== Setting up Config ===${end}\n"
cat >> ~/.ansible.cfg << EOF                                                               
[defaults]
host_key_checking = false
EOF
echo ""

echo "${grn}=== Ansible Version ===${end}\n"
ansible --version
echo ""

echo "${grn}=== Config Check Below ===${end}\n"
cat ~/.ansible.cfg
echo ""

read -p "Press enter to continue or ctrl+c if something looks wrong:" enter



