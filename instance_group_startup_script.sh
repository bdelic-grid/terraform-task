#!/bin/bash

NAME=$(curl -H "Metadata-Flavor: Google" "http://169.254.169.254/computeMetadata/v1/instance/name")
IP=$(curl -H "Metadata-Flavor: Google" "http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/ip")
echo "<h1>Name: ${NAME} </h1> <p>IP: ${IP} </p>" > /var/www/html/index.html