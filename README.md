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

## Use Scripts

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


## Manual Setup


### Client

1. `sudo hostnamectl set-hostname node<XX>` - Rename machine 

2. Configure /etc/hosts

![image](https://user-images.githubusercontent.com/71086240/217401785-763cd770-c948-4895-8aed-d5876997927c.png)

3. `ssh-keygen` - Generate SSH keys 
4. Install Prerequisites
   ```
   sudo apt-get update
   sudo apt-get install gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config cmake
   sudo apt-get install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev
   ```
5. `wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz` - wget Chapel-1.29.0.tar.gz
6. `tar xzf chapel-1.29.0.tar.gz` - untar ball Chapel-1.29.0 
7. `cd chapel-1.29.0` - Enter Chapel dir 
8. `source util/setchplenv.bash` - Set source 
9. `sudo make` - Compiler Chapel | Will take some time...
10. `./util/printchplenv` - Show current Chapel environment 
11. `export CHPL_HOME=/home/<user>/chapel-1.29.0.tar.gz` - Set CHPL_HOME
12. `export CHPL_COMM=gasnet` - Set CHPL_COMM 
13. `cd $CHPL_HOME` - Enter $CHPL_HOME 
14. `make` - Recompile
15. `chpl -o hello $CHPL_HOME/examples/hello6-taskpar-dist.chpl` - Make hello program
16. `export GASNET_SPAWNFN=S` - Set GASNET_SPAWNFN
17. `export GASNET_SSH_SERVERS="controller node1 node2 ..."` - Set GASNET_SSH_SERVER | Test without doing this step first as well. For this step make sure not to put the current node in the list

### Controller
