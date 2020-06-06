#! /bin/bash

if [ ! -f .env ]; then

   echo "Missing .env file"
   exit

fi

export $(cat .env | xargs)

NAME=docker_limit

rm /etc/systemd/system/$NAME.slice

systemctl daemon-reload
#systemctl start $NAME.slice
#systemctl restart docker_limit

rm /etc/docker/daemon.json

# The slice restriction should be loaded in here
systemctl restart docker
