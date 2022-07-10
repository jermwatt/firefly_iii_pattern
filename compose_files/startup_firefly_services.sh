#!/bin/bash

echo '                  **********                  '
echo '                  **********                  '
echo '*** NGINX BEGINNING STARTUP ***'
echo '*** FIREFLY-III DB BEGINNING STARTUP ***'
echo '*** FIREFLY-III APP BEGINNING STARTUP ***'
echo '*** FIREFLY-III FIDI BEGINNING STARTUP ***'
echo '                  **********                  '
echo '                  **********                  '


echo '---- STOPPING SERVICES ----'

# spin down services
docker-compose -f docker-compose-nginx.yml down 
docker-compose -f docker-compose-firefly.yml down 

echo '---- STOPPING NETWORK ----'
docker network rm firefly_network

echo '---- SPINNING UP NEW NETWORK ----'
docker network create --attachable --driver=bridge --subnet=10.2.0.0/24 firefly_network
sleep 15


echo '---- STARTING SERVICES ----'
docker-compose -f docker-compose-nginx.yml up -d
docker-compose -f docker-compose-firefly.yml up -d


