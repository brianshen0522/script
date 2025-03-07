#!/bin/bash

# system log
echo "Enable ssh log"
sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/g' /etc/ssh/sshd_config
sed -i 's/#LogLevel INFO/LogLevel INFO/g' /etc/ssh/sshd_config

# Log in with the key only
echo "Set only key login"
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config

systemctl restart sshd.service

# Setting fail2ban
echo "Install fail2ban"
apt install fail2ban -y
systemctl enable fail2ban
systemctl start fail2ban

echo "Set ban rule"
sed -i 's/#bantime  = 10m/bantime  = 24h/g' /etc/fail2ban/jail.conf
sed -i 's/#findtime  = 10m/findtime  = 5m/g' /etc/fail2ban/jail.conf
systemctl reload fail2ban
