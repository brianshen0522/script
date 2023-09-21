#!/bin/bash
apt update
apt upgrade -y
apt install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git htop neofetch dnsutils cifs-utils \
python3-pip

apt install linux-headers-$(uname -r) 

if ! id -u user >/dev/null 2>&1; then
  adduser --disabled-password --gecos "" user
  echo user:" " | chpasswd
  adduser user sudo
else
  echo "user exists"
fi
