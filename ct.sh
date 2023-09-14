#!/bin/bash
apt update
apt upgrade -y
apt install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git htop dnsutils cifs-utils linux-headers-$(uname -r) \
python3-pip

if ! id -u user >/dev/null 2>&1; then
  adduser --disabled-password --gecos "" user
  echo user:" " | chpasswd
  adduser user sudo
else
  echo "user exists"
fi


