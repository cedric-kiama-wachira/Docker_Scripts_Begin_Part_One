#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo docker run hello-world

sudo usermod -aG docker $USER

newgrp docker

docker run hello-world


sudo systemctl enable docker.service
sudo systemctl enable containerd.service

docker run docker/whalesay cowsay boo

docker run nginx

docker images -a
docker images -qa
docker rmi $(docker images -qa)


docker run redis

# Tagging
docker run redis:4.0

#Map container port to OS port
docker run -p server_port_number:conrainer_port_number

# Map directories on container and host
docker run -v /Path/To/Local/File/System/Or/Directory:/Path/To/Conatainer/File/System/Or/Directory mysql

# Get details of a container in Json Format
docker inspect  container_name

# Get log information for a container
docker logs container_name

# Advanced options
docker run ubuntu cat /etc/*release*
docker run ubuntu cat /etc/*release*

docker run ubuntu:18.04 cat /etc/*release*

docker run -d ubuntu:18.04 sleep 60

docker attach using_contianer_id

docker run jenkins/jenkins

docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins

sudo mkdir /opt/my-jenkins-data

docker run -p 8080:8080 -p 50000:50000 -v /opt/my-jenkins-data jenkins/jenkins

docker run -p 8080:8080 -p 50000:50000 -v /opt/my-jenkins-data -u root jenkins/jenkins

docker ps

docker start conatiner_id

# Creating my own images - Flask Web Application
1. OS Installation
2. Update apt repo
3. Install dependencies using apt
4. Install python dependencies using PIP
5. Copy Source Code to OPT
6. Run the webserver using flask

vi DockerfileWebServer
#Instruction Argument - Formats

# Manually testing everything before running the instruction docker file
docker run-p 8080:8080 -it ubuntu:20.04 bash
apt update && apt upgrade -y && apt -y install python3-setuptools python3-dev python3-pip  default-libmysqlclient-dev build-essential
pip3 install flask
pip3 install flask-mysql


cat > app.py
import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Welcome!"

@app.route('/how are you')
def hello():
    return 'I am good, how about you?'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080

vi Dockerfile

FROM ubuntu:20.04
RUN apt update && apt upgrade -y && apt -y install python3-setuptools python3-dev python3-pip  default-libmysqlclient-dev build-essential
RUN pip3 install flask
RUN pip3 install flask-mysql
COPY app.py /opt/
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080

# Build the Image and give it a name
docker build . -t my-simple-web-app-image

# Run a container using the existing image, port map it and give it a name
docker run -it -p 8080:8080 --name my-simple-web-app-container my-simple-web-app-image

# Push my docker image to the repository
docker build . -t cedrickiama/my-simple-web-app-image
docker login 
Username: cedrickiama
Password: 
docker push cedrickiama/my-simple-web-app-image

# Mysql Db Image and Container Creation
docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db mysql


Exercise


FROM ubuntu:20.04
RUN apt update && apt upgrade -y && apt -y install build-essential mariadb-server
docker run --detach  -it -p3307:3306 --name AppDB --env MARIADB_USER=appuser --env MARIADB_PASSWORD=appuser123 --env MARIADB_ROOT_PASSWORD=root123  mariadb:latest

docker build Dockerfile -t cedrickiama/my-flask-app
docker run -it mariadb -h 172.31.21.195 -p 3306:3306 -uroot -proot123

docker history container_id


