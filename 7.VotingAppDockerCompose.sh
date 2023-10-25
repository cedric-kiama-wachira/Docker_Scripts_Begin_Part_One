#!/bin/bash

# Install Docker Compose
Ok

# Check the running state of all containers and stop them

# Add Images

cat > docker-compose.yml

redis:
    image: redis
db:
    image: postgres:15-alpine
vote:
    image: voting-app
worker:
    image: worker-app
result:
    image: result-app

# Add port mapping
cat > docker-compose.yml

redis:
    image: redis
db:
    image: postgres:15-alpine
vote:
    image: voting-app
    ports:
        - 50000:80
worker:
    image: worker-app
result:
    image: result-app
    ports:
        -   50001:80

# Add links 

cat > docker-compose.yml
redis:
    image: redis:latest
db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
vote:
    image: voting-app
    ports:
        - 50000:80
    links:
        - redis
worker:
    image: worker-app
    depends_on:
      redis:
        condition: service_healthy 
      db:
        condition: service_healthy 
result:
    image: result-app
    ports:
        -   50001:80
    depends_on:
      db:
        condition: service_healthy


# Docker Compose

services:
  redis:
    image: redis:alpine
  clickcounter:
    image: kodekloud/click-counter
    ports:
    - 8085:5000
version: '3.0'

docker compose up -d 