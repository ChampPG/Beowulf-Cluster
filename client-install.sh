# SSH-Keys
if [ ! -f $HOME/.ssh/id_rsa ]; then
  ssh-keygen
fi

# Set hostname
echo "Node #: "  
read node
if [ "$HOSTNAME" != node$node ]; then
  sudo hostnamectl set-hostname node$node
fi

#Chapel Setup
wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
tar xzf chapel-1.29.0.tar.gz
cd chapel-1.29.0
source util/setchplenv.bash
sudo make
./util/printchplenv

# IP Address
echo "Subnet #: "  
read subnet  
ip addr | grep /$subnet | awk {'print $1'}
