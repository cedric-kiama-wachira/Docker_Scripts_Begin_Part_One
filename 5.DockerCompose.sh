#!/bin/bash

docker run -d --name=redis redis
docker rub -d --name=db postgres:9.4
docker run -d --name=vote -p 5000:80 voting-app
docker run -d --name=result -p 5001:80 result-app
docker run -d --name=worker worker

# Adding links to facilitate communication between Voting App and Redis

docker run -d --name=vote -p 5000:80 --link redis:redis voting-app

# Adding links to facilitate communication between Result ting App and Postgresql

docker run -d --name=result -p 5001:80 --link db:db result-app

# Adding links to facilitate communication between the worker application and the redis plus Postgresql DB

docker run -d --link db:db --link redis:redis --name=worker worker

vi Docker-Compose.yaml # Version 1 File

redis:
    image: redis
db:
    image: postgres:9.4
vote:
    image: voting-app
    ports:
        - 5000:80
    links:
        - redis
result:
    image: result-app
    ports: 
        - 5001:80
    links:
        - db
worker:
    image: worker
    links:
        - redis
        - db

vi Docker-Compose.yaml # Version 2 File

version: 2
services:
    redis:
        image: redis
    db:
        image: postgres:9.4
    vote:
        image: voting-app
        ports:
            - 5000:80
        links:
            - redis
    result:
        image: result-app
        ports: 
            - 5001:80
        links:
            - db
    worker:
        image: worker
        links:
            - redis
            - db



