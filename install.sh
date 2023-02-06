# For Linux bash:
git clone https://github.com/chapel-lang/chapel
tar xzf chapel-1.18.0.tar.gz
cd chapel-1.18.0
source util/setchplenv.bash
sudo make
./util/printchplenv
export CHPL_COMM=gasnet
sudo make
