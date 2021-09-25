#! /bin/bash

# Install nix os
curl -L https://nixos.org/nix/install | sh

. ${HOME}/.nix-profile/etc/profile.d/nix.sh

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

mkdir -p ~/.test/trash
mv ~/.bashrc ~/.bash_profile ~/.config/kwinrulesrc ~/.config/kwinrc ~/.dir_colors ~/.test/trash
rmdir ~/Templates ~/Desktop ~/Public

nix-shell '<home-manager>' -A install

printf "\n"
echo """
Please run the following commands (at the same time if you wish :D):

./pacman_install.sh

. ${HOME}/.nix-profile/etc/profile.d/nix.sh && . ${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh && home-manager switch
"""
