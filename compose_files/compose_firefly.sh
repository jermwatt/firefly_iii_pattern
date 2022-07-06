#!/bin/bash

echo '                  **********                  '
echo '                  **********                  '
echo '*** FIREFLY-III DB BEGINNING STARTUP ***'
echo '*** FIREFLY-III APP BEGINNING STARTUP ***'
echo '*** FIREFLY-III FIDI BEGINNING STARTUP ***'
echo '                  **********                  '
echo '                  **********                  '


echo '---- STOPPING SERVICES ----'

# spin down services
docker-compose -f docker-compose-firefly.yml down 

echo '---- STOPPING NETWORK ----'

# spin down network
docker network rm firefly_network


echo '---- SPINNING UP NEW NETWORK ----'

# spin up new version of network
docker network create --attachable --driver=bridge --subnet=10.3.0.0/24 firefly_network
sleep 15

echo '---- GENERATING SERVICE IPs FOR COMPOSE FILES ----'
# FIREFLY_APP_IP=192.168.1.11
# echo FIREFLY_APP_IP=${FIREFLY_APP_IP} > .env

# FIREFLY_DB_IP=10.3.0.2
# echo FIREFLY_DB_IP=${FIREFLY_DB_IP} > .env


echo '---- STARTING SERVICES ----'
docker-compose -f docker-compose-firefly.yml up -d

