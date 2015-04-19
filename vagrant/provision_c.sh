
#yum installs
sudo yum install dos2unix
yum install -y java-1.7.0-openjdk.x86_64
yum install -y mlocate
yum install -y telnet
yum install -y screen
yum install -y vim
yum install -y git

##cloning the repository for various files
git clone https://github.com/stevengonsalvez/containerisation.git

##switching off iptables
sudo chkconfig iptables off
sudo /etc/init.d/iptables stop

