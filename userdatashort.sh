#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
MYNAME=$(hostname)
echo '''{\n"rabbitmq":{\n"host":"<<PUBLIC_IP_SENSUMASTER>>",\n"port":5672,\n"vhost":"/sensu",\n"user":"<<USERNAME>>",\n"password":"<<PASSWORD>>"\n}\n}''' | tee /etc/sensu/conf.d/rabbitmq.json
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo '''{\n"client":{\n"name":"'''$MYNAME'''",\n"address":"'''$MYIP'''",\n"subscriptions":["ALL"],\n"safe_mode":false\n}\n}''' | tee /etc/sensu/conf.d/client.json
