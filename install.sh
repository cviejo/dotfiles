#!/usr/bin/env bash

if [ $(uname) != 'Darwin' ]; then
  apt update
  apt install curl
fi

curl -L https://nixos.org/nix/install | sh

nix-env -i zsh tmux neovim ranger fzf

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
