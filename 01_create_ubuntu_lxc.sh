#!/bin/bash -e

CONTAINER_NAME="$1"

while [ -z "$CONTAINER_NAME" ]
do
  read -p "Donnez le nom du nouveau conteneur: " CONTAINER_NAME
done

if [ $(sudo lxc-ls -1 | grep -c "^$CONTAINER_NAME$") == 1 ]
then
  echo "Un conteneur porte déja ce nom..."
else
  sudo lxc-create --template download --name "$CONTAINER_NAME" -- -d ubuntu -r xenial -a amd64
fi

sudo lxc-start -n "$CONTAINER_NAME"
sleep 5
sudo lxc-attach -n "$CONTAINER_NAME" -- apt update
sleep 5
sudo lxc-attach -n "$CONTAINER_NAME" -- apt -y upgrade
sudo lxc-attach -n "$CONTAINER_NAME" -- apt -y install openssh-server python sudo
sudo lxc-attach -n "$CONTAINER_NAME" -- adduser $USER
sudo lxc-attach -n "$CONTAINER_NAME" -- usermod -a -G sudo $USER

