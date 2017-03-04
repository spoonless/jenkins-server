#!/bin/bash -e

CONTAINER_NAME="$1"

while [ -z "$CONTAINER_NAME" ]
do
  read -p "Donnez le nom du nouveau conteneur: " CONTAINER_NAME
done

sudo lxc-attach -n $CONTAINER_NAME -- cat /home/tomcat8/jenkins/secrets/initialAdminPassword
