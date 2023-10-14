#!/bin/bash
###
 # @Author: Vincent Young
 # @Date: 2023-10-12 23:21:35
 # @LastEditors: Vincent Young
 # @LastEditTime: 2023-10-13 21:06:15
 # @FilePath: /Hysteria2/hy2.sh
 # @Telegram: https://t.me/missuo
 # 
 # Copyright © 2023 by Vincent, All Rights Reserved. 
### 
#!/bin/bash

show_menu() {
    echo "Choose an option:"
    echo "1. Install Hysteria 2"
    echo "2. Uninstall Hysteria 2"
    echo "3. Stop Hysteria 2"
    echo "4. Start Hysteria 2"
    echo "5. Restart Hysteria 2"
    echo "6. Enable auto-start at boot"
    echo "7. Disable auto-start at boot"
    echo "8. Update Hysteria 2"
    echo "9. Exit"
    read -p "Enter your choice: " CHOICE
}

install_hysteria() {
    if netstat -tuln | grep -q ":80 "; then
        echo "Port 80 is already in use. Exiting..."
        exit 1
    fi

    # Install Hysteria 2
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
    # Start Hysteria 2
    systemctl start hysteria-server.service
    systemctl enable hysteria-server.service
    
    # Wait for 20 seconds
    sleep 20

    # Check service status
    STATUS=$(systemctl is-active hysteria-server.service)
    if [ "$STATUS" == "active" ]; then
        clear
        echo "Hysteria 2 started successfully!"
        echo "Configuration details:"
        echo "Domain: $DOMAIN"
        echo "Port: $PORT"
        echo "Password: $PASSWORD"
    else
        echo "Failed to start Hysteria 2. Please check service status manually."
    fi
}

uninstall_hysteria() {
    bash <(curl -fsSL https://get.hy2.sh/) --remove
    rm -rf /etc/hysteria
    userdel -r hysteria
    rm -f /etc/systemd/system/multi-user.target.wants/hysteria-server.service
    rm -f /etc/systemd/system/multi-user.target.wants/hysteria-server@*.service
    systemctl daemon-reload
    echo "Hysteria 2 uninstalled!"
}

while true; do
    show_menu

    case $CHOICE in
        1) install_hysteria ;;
        2) uninstall_hysteria ;;
        3) systemctl stop hysteria-server.service ;;
        4) systemctl start hysteria-server.service ;;
        5) systemctl restart hysteria-server.service ;;
        6) systemctl enable hysteria-server.service ;;
        7) systemctl disable hysteria-server.service ;;
        8) bash <(curl -fsSL https://get.hy2.sh/) ;;
        9) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice!";;
    esac
done
