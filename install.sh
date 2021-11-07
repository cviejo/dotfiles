#!/usr/bin/env bash

apt install curl neovim zsh tmux ranger fzf stow

stow zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
