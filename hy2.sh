#!/bin/bash
###
 # @Author: Vincent Young
 # @Date: 2023-10-12 23:21:35
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-10-12 23:25:33
 # @FilePath: /Hysteria2/hy2.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 

## Install Hysteria 2
bash <(curl -fsSL https://get.hy2.sh/)

# Prompt the user for inputs with default values
read -p "Enter the port (default: 8443): " PORT
read -p "Enter the domain: " DOMAIN
read -p "Enter the password (default: Hy2Best2024@): " PASSWORD

# Set default values if not provided by the user
PORT=${PORT:-8443}
PASSWORD=${PASSWORD:-Hy2Best2024@}

# Create the config file
cat << EOF > /etc/hysteria/config.yaml
listen: :$PORT

acme:
  domains:
    - $DOMAIN
  email: test@sharklasers.com

auth:
  type: password
  password: $PASSWORD
  
masquerade:
  type: proxy
  proxy:
    url: https://bing.com
    rewriteHost: true
EOF

echo "Config file created!"

## Start Hysteria 2
systemctl start hysteria-server.service
systemctl enable Hysteria-server.service