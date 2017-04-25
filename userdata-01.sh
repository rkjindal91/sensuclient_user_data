#################################
#				#
# -Following script will change	#
# name & address of client.json	#
# file located at 		#
# /etc/sensu/conf.d/		#
# -For error resolution	mail at	#
# mailrkjindal@gmail.com	#
#				#
#################################

#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
MYNAME=$(hostname)
sed -i "s/^\"name\"\:.*$/\"name\"\:\"$MYNAME\"\,/g" /etc/sensu/conf.d/client.json

MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
sed -i "s/^\"address\"\:.*$/\"address\"\:\"$MYIP\"\,/g" /etc/sensu/conf.d/client.json
