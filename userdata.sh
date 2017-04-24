#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
echo "deb http://repos.sensuapp.org/apt xenial main" | sudo tee /etc/apt/sources.list.d/sensu.list
apt-get update && apt-get upgrade -y
apt-get install sensu -y
echo -e '''{\n"rabbitmq":{\n"host":"54.173.204.175",\n"port":5672,\n"vhost":"/sensu",\n"user":"sensu",\n"password":"secret"\n}\n}''' | sudo tee /etc/sensu/config.d/rabbitmq.json
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo -e '''{\n"client":{\n"name":"TestServer1",\n"address":"'''$MYIP'''",\n"subscriptions":["ALL","HTTPD","two_core_system","SSHD","NODEJS"],\n"safe_mode":false\n}\n}''' | sudo tee /etc/sensu/config.d/client.json

