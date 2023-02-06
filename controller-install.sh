# SSH-Keys
if [ ! -f $HOME/.ssh/id_rsa ]; then
  ssh-keygen
fi

# Set hostname
if [ "$HOSTNAME" != controller ]; then
  sudo hostnamectl set-hostname controller
fi

#Chapel Setup
# Prerequisites
sudo apt-get update -y
sudo apt-get install gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config cmake -y
sudo apt-get install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev -y
# Main Install
if [ ! -f chapel-1.29.0.tar.gz]; then
wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
tar xzf chapel-1.29.0.tar.gz
fi
cd $HOME/chapel-1.29.0
source util/setchplenv.bash
./configure
sudo make install
./util/printchplenv
export CHPL_COMM=gasnet
cd $CHPL_HOME
sudo make
chpl -o hello $CHPL_HOME/examples/hello6-taskpar-dist.chpl
export GASNET_SPAWNFN=S

echo 'export GASNET_SSH_SERVERS="host1 host2 host3 ..."'
echo './hello -nl 2'

# IP Address
echo "Subnet #: "  
read subnet  
ip addr | grep /$subnet | awk {'print $2'}
