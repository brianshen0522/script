#!/bin/bash
apt update
apt upgrade -y
apt install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git htop dnsutils cifs-utils linux-headers-$(uname -r) \
python3-pip
adduser --disabled-password --gecos "" user
echo user:" " | chpasswd
adduser user sudo
