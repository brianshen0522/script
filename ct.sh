#!/bin/bash
apt update
apt upgrade -y
apt install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git dnsutils cifs-utils \
python3-pip
adduser --disabled-password --gecos "" user
echo user:" " | chpasswd
adduser user sudo
