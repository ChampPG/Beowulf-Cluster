if [ $0 = "yes" ]; then
  # SSH-Keys
  if [ ! -f $HOME/.ssh/id_rsa ]; then
    ssh-keygen
  fi

  # Set hostname
  echo "Node #: "  
  read node
  if [ "$HOSTNAME" != beowulf$node ]; then
    sudo hostnamectl set-hostname node$node
  fi

  # Prerequisites
  sudo apt-get update -y
  sudo apt-get install gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config cmake -y
  sudo apt-get install llvm-dev llvm clang libclang-dev libclang-cpp-dev libedit-dev -y

  #Chapel Setup
  if [ ! -f $HOME/chapel-1.29.0.tar.gz ]; then
    wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
    tar xzf chapel-1.29.0.tar.gz
  fi

  cd chapel-1.29.0
  source util/setchplenv.bash
  sudo make
  ./util/printchplenv

  export CHPL_COMM=gasnet
  sudo make

  # IP Address
  echo "Subnet #: "  
  read subnet  
  ip addr | grep /$subnet | awk {'print $1'}
 elif [ $0 = "no" ]; then
 
   export CHPL_COMM=gasnet
   sudo make
   
 else
  echo "wrong usage not ./client-installer [yes|no]"
