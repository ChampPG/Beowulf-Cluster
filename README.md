# Beowulf-Cluster
Beowulf-Cluster Documentation

## Goals
* Learn more about Chapel and parallel computing 
* Make scripts to setup client and controller install scripts

## Progress
- [ ] client-install.sh
- [ ] controller-install.sh
- [ ] Have connectivity between nodes and controller
- [ ] Figure out multinode configuration
- [ ] Test benchmark
- [ ] Make weather prediction application
- [ ] Have fully running weather prediction

## Prerequisites

### Networking
* 6 Static IP's

### Devices
* 6 Updated Debian machine

### OS Config
* sudo user

## Environment

### Controller

* OS: Debian 11
* Number of Nodes: 1
* Hosts file to contain nodes

### Nodes

* OS: Debian 11
* Number of Nodes: 5
* Host file to contain other nodes and controller

## Usage

### client-install.sh

1. Be in the a users home directory.
2. `wget https://raw.githubusercontent.com/ChampPG/Beowulf-Cluster/main/client-install.sh`
3. `chmod +x client-install.sh`
4. `./client-install.sh`
    * If you already have ssh-keys generated This won't pop up
    * Configure SSH-Keys how you would like
    * Enter

![image](https://user-images.githubusercontent.com/71086240/216885081-5d06b142-e1be-4c0c-9ff0-d5ee041f5b13.png)

### controller-install.sh

1. Be in the a users home directory.
2. `wget https://raw.githubusercontent.com/ChampPG/Beowulf-Cluster/main/controller-install.sh`
3. `chmod +x controller-install.sh`
4. `./controller-install.sh`
    * If you already have ssh-keys generated This won't pop up
    * Configure SSH-Keys how you would like
    * Enter

![image](https://user-images.githubusercontent.com/71086240/216885081-5d06b142-e1be-4c0c-9ff0-d5ee041f5b13.png)

5. Now script will update debian and install Chapel Prerequisites.
