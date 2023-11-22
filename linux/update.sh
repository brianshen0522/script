#!/bin/bash
echo "sudo apt-get clean -y" > update.sh
echo "sudo apt-get update -y" >> update.sh
echo "sudo apt-get upgrade -y" >> update.sh
echo "sudo apt-get autopurge -y" >> update.sh

chmod +x update.sh
./update.sh
