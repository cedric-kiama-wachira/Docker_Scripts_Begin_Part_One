#!/bin/bash

# Setup 4 nodes 
# On the node to manage the cluster
docker swam init
# On the three remaining nodes
docker swam join --token 

# Alternative to using
docker run my-web-service

# We can use below
docker service create  --replicas=3 my-web-service

