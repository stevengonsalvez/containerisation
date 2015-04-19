
#yum installs
sudo yum install dos2unix
sudo yum install -y java-1.7.0-openjdk.x86_64
sudo yum install -y mlocate
sudo yum install -y telnet
sudo yum install -y screen
sudo yum install -y vim
sudo yum install -y git
sudo yum update -y

##cloning the repository for various files
git clone https://github.com/stevengonsalvez/containerisation.git

##switching off iptables
sudo chkconfig iptables off
sudo /etc/init.d/iptables stop
sudo service firewalld stop

###alternatively we could just add firewall rules
##firewall-cmd --zone=public --add-port=8080/tcp --permanent
##firewall-cmd --zone=public --add-service=http --permanent
##firewall-cmd --reload

## adding jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins

sudo chkconfig jenkins on
sudo service jenkins start/stop/restart


