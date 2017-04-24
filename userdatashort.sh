#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
MYNAME=$(hostname)
echo -e '''{\n"rabbitmq":{\n"host":"54.173.204.175",\n"port":5672,\n"vhost":"/sensu",\n"user":"sensu",\n"password":"secret"\n}\n}''' | tee /etc/sensu/config.d/rabbitmq.json
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo -e '''{\n"client":{\n"name":"'''$MYNAME'''",\n"address":"'''$MYIP'''",\n"subscriptions":["ALL","HTTPD","two_core_system","SSHD","NODEJS"],\n"safe_mode":false\n}\n}''' | tee /etc/sensu/config.d/client.json
