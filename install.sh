#! /bin/bash

# Install nix os
curl -L https://nixos.org/nix/install | sh

. ${HOME}/.nix-profile/etc/profile.d/nix.sh

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

mkdir -p ~/.test/trash
mv ~/.bashrc ~/.bash_profile ~/.config/kwinrulesrc ~/.config/kwinrc ~/.dir_colors ~/.test/trash
rmdir ~/Templates ~/Desktop

nix-shell '<home-manager>' -A install

printf "Generating github ssh key.\n"
ssh-keygen -t rsa -f ${HOME}/.ssh/github -q -P ""
eval "$(ssh-agent -s)"
ssh-add ${HOME}/.ssh/github

printf "Installing github cli.\n"
sudo pacman -Syu --noconfirm github-cli
gh config set git_protocol ssh
gh auth login -s "delete_repo read:public_key write:public_key repo"
gh ssh-key add ~/.ssh/github.pub -t "${HOSTNAME}"
mv ~/.config/nixpkgs ~/.config/nixpkgs.old
gh repo clone antotocar34/dotfiles ~/.config/nixpkgs


printf "\n"
echo """
Please run the following commands:

sudo pacman --noconfirm -Syu base-devel binutils yay bash-completion kitty rofi vifm gcc-libs poetry flameshot xf86-input-wacom kcm-wacomtablet whatsapp-for-linux noto-fonts-emoji
yay -Syu neovim-nightly
sudo pacman --noconfirm -Rs yakuake okular konversation kate kcalc spectacle manjaro-hello

. ${HOME}/.nix-profile/etc/profile.d/nix.sh
. ${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh
home manager switch
"""
