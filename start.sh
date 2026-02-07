#!/bin/bash
#Create new docker network
docker network inspect n8n_network >/dev/null 2>&1 || docker network create n8n_network
#Build the container
docker-compose up --build -d
