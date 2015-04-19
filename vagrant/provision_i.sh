#All the parameters that are set
user_to_run_mule="mule"
mule_ce_location="https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.6.1/mule-standalone-3.6.1.tar.gz"


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

##retrieving package of mule from the internet
wget ${mule_ce_location}

tar xzf mule-standalone-*
sudo useradd ${user_to_run_mule}
sudo mkdir /opt/mule
sudo chown -R ${user_to_run_mule}:${user_to_run_mule} /opt/mule
sudo mv mule-standalone-*/* /opt/mule/
sudo chown -R ${user_to_run_mule}:${user_to_run_mule} /opt/mule/

#Replacing the Run as user to mule
sudo sed -i -e 's|#RUN_AS_USER=|RUN_AS_USER='${user_to_run_mule}'|' /opt/mule/bin/mule

sudo cp ./containerisation/vagrant/mule_init.sh /etc/init.d/mule
chmod 755 /etc/init.d/mule
sudo chkconfig --add mule
sudo service mule start


