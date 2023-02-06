# For Linux bash:
wget https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
tar xzf chapel-1.29.0.tar.gz
cd chapel-1.29.0
source util/setchplenv.bash
sudo make
./util/printchplenv
export CHPL_COMM=gasnet
sudo make
