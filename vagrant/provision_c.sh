###### parameters defined for the script
nexus_ce_location= "http://download.sonatype.com/nexus/oss/nexus-2.11.0-bundle.tar.gz"
user_to_run_nexus="nexus"
directory_for_nexus_store="/srv/nexus/main-repo"



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

## adding jenkins repository - jenkins runs on port 8080
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins

sudo chkconfig jenkins on
sudo service jenkins start/stop/restart


nexus_install

#### Installation of nexus function
nexus_install(){

sudo useradd ${user_to_run_nexus}
#Create nexis basedir and change to it
sudo mkdir /usr/lib/nexus-oss

wget ${nexus_ce_location}
sudo tar xvzf nexus-2.*-bundle.tar.gz nexus-2*/
sudo mv  nexus-2.11.0-0* /usr/lib/nexus-oss


sudo ln -s /usr/lib/nexus-oss/nexus-2* /usr/lib/nexus-oss/nexus
sudo chown -R ${user_to_run_nexus}:${user_to_run_nexus} /usr/lib/nexus-oss

sudo mkdir -p ${directory_for_nexus_store}

#Set owner user and group
sudo chown -R nexus:nexus /srv/nexus/main-repo
sudo sed -i -e 's|nexus-work=${bundleBasedir}/../sonatype-work/nexus|nexus-work='${directory_for_nexus_store}'|' /usr/lib/nexus-oss/nexus/conf/nexus.properties

# RUn Nexus as a service - runs on port 8081
# copy init.d sctipt to proper place
sudo cp /usr/lib/nexus-oss/nexus/bin/nexus /etc/init.d/nexus
sudo chmod 777 /etc/init.d/nexus
 
#replace default location
sudo sed -i "s/NEXUS_HOME=\"..\"/NEXUS_HOME=\"\/usr\/lib\/nexus-oss\/nexus\"/g" /etc/init.d/nexus
 
#Set PID dir
sudo sed -i "s/#PIDDIR=\".\"/PIDDIR=\"\/var\/run\"/g" /etc/init.d/nexus
#Set RUN_AS user to nexus
sudo sed -i "s/#RUN_AS_USER=/RUN_AS_USER=nexus/g" /etc/init.d/nexus
#now register the new script
sudo chkconfig --add nexus

# full permission for the script to create 
sudo chmod -R 777 /var/run


#start the nexus service
sudo service nexus start


}