#!/bin/bash

echo "Installing prerequisites..."

sudo apt update
sudo apt install -y dnsutils

echo "Creating contest command..."

sudo tee /usr/local/bin/contest > /dev/null << 'EOF'
#!/bin/bash

ALLOWED_DOMAINS=("codeforces.com" "atcoder.jp" "hackerrank.com")

enable() {

echo "Enabling contest mode..."

sudo iptables -F
sudo iptables -P OUTPUT DROP

# allow localhost
sudo iptables -A OUTPUT -o lo -j ACCEPT

# allow DNS
sudo iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

for domain in "${ALLOWED_DOMAINS[@]}"; do

    ips=$(dig +short $domain)

    for ip in $ips; do
        sudo iptables -A OUTPUT -d $ip -j ACCEPT
    done

done

echo "Contest mode enabled"

}

disable() {

echo "Disabling contest mode..."

sudo iptables -F
sudo iptables -P OUTPUT ACCEPT

echo "Contest mode disabled"

}

status() {

sudo iptables -L OUTPUT | grep policy

}

case "$1" in
on)
enable
;;
off-admin)
disable
;;
status)
status
;;
*)
echo "Usage:"
echo "contest on"
echo "contest off"
echo "contest status"
;;
esac
EOF

sudo chmod +x /usr/local/bin/contest

echo ""
echo "Setup completed!"
#echo ""
#echo "Commands available:"
#echo "contest on"
#echo "contest off"
#echo "contest status"
