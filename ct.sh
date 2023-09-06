#!/bin/bash
apt update
apt upgrade -y
apt install vim ncdu lnav ssh sudo wget curl bat -y
adduser --disabled-password --gecos "" user
echo user:" " | chpasswd
adduser user sudo
