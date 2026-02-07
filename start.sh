#!/bin/bash 
#Create new docker network
sudo docker network create n8n_network
#Build the container
sudo docker-compose up --build -d
