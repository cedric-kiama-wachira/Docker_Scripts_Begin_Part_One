#!/bin/bash

git clone https://github.com/dockersamples/example-voting-app.git
cd /home/ubuntu/docker_my_images/example-voting-app
cd vote

ls -l
total 20
-rw-rw-r-- 1 ubuntu ubuntu  735 Oct 24 17:21 Dockerfile
-rw-rw-r-- 1 ubuntu ubuntu 1346 Oct 24 17:21 app.py
-rw-rw-r-- 1 ubuntu ubuntu   21 Oct 24 17:21 requirements.txt
drwxrwxr-x 3 ubuntu ubuntu 4096 Oct 24 17:21 static
drwxrwxr-x 2 ubuntu ubuntu 4096 Oct 24 17:21 templates

# Build the image
docker build . -t voting-app

# Create the first container
docker run -p 50000:80 voting-app

# Create an a container based on Redis and name it redis, let it run in the background
docker run -d --name redis redis

# Start and Connect the Voting App to the Redis db using link option
docker run  -d -p 50000:80 --link redis:redis voting-app

# Setup Postgresql 15-Alpine and create a container instance called db
docker run -d --name=db -e POSTGRES_PASSWORD=postgres postgres:15-alpine

# Setup worker images
cd worker
docker build . -t worker-app

# Connect the worker to redis and postgresql DB
docker run -d --link redis:redis --link db:db worker-app

# Build the image and start the result app container by linking it to the postgres db
cd ../result
docker build . -t result-app
docker run -d -p 50001:80 --link db:db result-app


