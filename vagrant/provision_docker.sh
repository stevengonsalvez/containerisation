sudo yum install -y docker

sudo service docker start
sudo chkconfig docker on
sudo docker pull centos

##### list the docker images
sudo docker images

###### to login to docker bash
docker run -i -t centos /bin/bash
