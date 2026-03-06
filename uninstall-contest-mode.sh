#!/bin/bash

echo "Uninstalling contest mode..."

# Reset firewall rules (important if contest mode was enabled)
echo "Resetting iptables..."
sudo iptables -F
sudo iptables -P OUTPUT ACCEPT

# Remove contest command
if [ -f /usr/local/bin/contest ]; then
    echo "Removing /usr/local/bin/contest..."
    sudo rm /usr/local/bin/contest
else
    echo "contest command not found."
fi

# Ask if user wants to remove dnsutils
read -p "Do you want to remove dnsutils? (y/n): " choice

if [ "$choice" = "y" ]; then
    echo "Removing dnsutils..."
    sudo apt remove -y dnsutils
    sudo apt autoremove -y
fi

echo ""
echo "Contest mode uninstalled successfully!"
