#!/bin/bash

# system log
echo "Enable ssh log"
sudo apt install rsyslog -y
sudo sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/g' /etc/ssh/sshd_config
sudo sed -i 's/#LogLevel INFO/LogLevel INFO/g' /etc/ssh/sshd_config

# Log in with the key only
echo "Set only key login"
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

sudo systemctl restart sshd.service

# Setting fail2ban
echo "Install fail2ban"
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "Set ban rule"
sudo sed -i 's/#bantime  = 10m/bantime  = 24h/g' /etc/fail2ban/jail.conf
sudo sed -i 's/#findtime  = 10m/findtime  = 5m/g' /etc/fail2ban/jail.conf
sudo systemctl reload fail2ban
