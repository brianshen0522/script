#!/bin/bash
echo "sudo apt clean -y" > update.sh
echo "sudo apt update -y" >> update.sh
echo "sudo apt upgrade -y" >> update.sh
echo "sudo apt autopurge -y" >> update.sh

chmod +x update.sh
export DEBIAN_FRONTEND=noninteractive
./update.sh
unset DEBIAN_FRONTEND
