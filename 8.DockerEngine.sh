#!/bin/bash
docker run --cpus=.5 ubuntu
docker run --memory=100m ubuntu

# Volume Mounting for  using an existing volume created with docker and non existing in the common volume location
docker volume create data_volume
docker run -v data_volume:/var/lib//mysql mysql

docker run -v data_volume:/var/lib//mysql mysql

# Bind mounting using an already existing full direcotory pasth  with installation already done
docker run --mount type=bind, source=/data/mysql, target =/var/lib/mysql mysql

# Creating our own non docker default network
docker network ls
docker network create --driver bridge --subnet 182.18.0.0/16 custom-isolated-network
docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network
docker network inspect wp-mysql-network

docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db --network wp-mysql-network mysql:5.6

docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql

docker login 

# Docker Repository
# Run: 
docker pull nginx:latest 
# then 
docker image tag nginx:latest localhost:5000/nginx:latest 
#and finally push it using 
docker push localhost:5000/nginx:latest.
#We will use the same steps for the second image 
docker pull httpd:latest 
# and then 
docker image tag httpd:latest localhost:5000/httpd:latest 
# and finally push it using 
docker push localhost:5000/httpd:latest

docker run -d -p 5000:5000 --restart=always --name my-registry registry:2

docker image prune -a

