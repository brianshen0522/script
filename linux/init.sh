#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y vim ncdu lnav ssh sudo wget curl bat gpg tree git htop dnsutils cifs-utils tmux \
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
apt-get upgrade -y

unset DEBIAN_FRONTEND

## tmux setting

if [ ! -f  "/usr/share/doc/tmux/example_tmux.conf" ]; then
  echo "tmux example file isn't existed"
  exit 1
fi

cp /usr/share/doc/tmux/example_tmux.conf /home/user/.tmux.conf
chown user:user  /home/user/.tmux.conf

sed -i 's/set -g remain-on-exit on/#set -g remain-on-exit on/g'  /home/user/.tmux.conf
sed -i 's/set -g mouse on/#set -g mouse on/g'  /home/user/.tmux.conf
sed -i 's/unbind -n MouseDrag1Pane/#unbind -n MouseDrag1Pane/g'  /home/user/.tmux.conf
sed -i 's/unbind -Tcopy-mode MouseDrag1Pane/#unbind -Tcopy-mode MouseDrag1Pane/g'  /home/user/.tmux.conf

curl https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux | tee /etc/bash_completion.d/tmux > /dev/null
cp /home/user/.tmux.conf /root/
