#!/bin/bash

# Lista delle dipendenze dai repository
DEPS=(
    toilet
    nmap
    whois
    dnsutils
    hydra
    john
    hashcat
    sqlmap
    nikto
    wpscan
    metasploit-framework
    aircrack-ng
    maltego
)

echo "Aggiornamento lista pacchetti..."
sudo apt-get update

echo "Installazione dipendenze dai repository..."
for pkg in "${DEPS[@]}"; do
    echo "Installando $pkg..."
    sudo apt-get install -y "$pkg"
done

# Installazione manuale di SEToolkit
echo "Installazione manuale di Social-Engineer Toolkit (SET)..."
if [ ! -d "social-engineer-toolkit" ]; then
    cd 
    mkdir social-engineer-toolkit
    git clone https://github.com/trustedsec/social-engineer-toolkit.git
fi
cd social-engineer-toolkit || exit 1
sudo apt-get install -y python3-venv python3-pip
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
sudo python3 setup.py install
cd ..

echo "Installazione completata!"