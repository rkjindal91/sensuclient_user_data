#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
echo "deb http://repos.sensuapp.org/apt xenial main" | sudo tee /etc/apt/sources.list.d/sensu.list
apt-get update && apt-get upgrade -y
apt-get install sensu -y
echo -e '''{\n"rabbitmq":{\n"host":"54.173.204.175",\n"port":5672,\n"vhost":"/sensu",\n"user":"sensu",\n"password":"secret"\n}\n}''' | sudo tee /etc/sensu/config.d/rabbitmq.json
