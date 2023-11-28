#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get --assume-yes upgrade -y
apt-get --assume-yes install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git htop neofetch dnsutils cifs-utils tmux \
python3-pip
apt-get autoremove

if ! id -u user >/dev/null 2>&1; then
  adduser --disabled-password --gecos "" user
  echo user:" " | chpasswd
  adduser user sudo
else
  echo "user exists"
fi

timedatectl set-timezone Asia/Taipei
localectl set-locale LANG=en_US.UTF-8

apt-get install -y linux-headers-"$(uname -r)" || apt-get install -y linux-headers-amd64 || apt-get install -y linux-headers-generic
