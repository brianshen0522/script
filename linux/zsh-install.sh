#!/bin/bash
cd "$HOME" || exit
sudo apt-get update
sudo apt install zsh curl -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
sudo chsh -s "$(which zsh)" "$(whoami)"

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' "$HOME/.zshrc"
sed -i 's/plugins=(git)/plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)/g' "$HOME/.zshrc"

if [ -x "$(command -v docker)" ]; then
    mkdir -p ~/.oh-my-zsh/completions
    docker completion zsh >~/.oh-my-zsh/completions/_docker
fi
