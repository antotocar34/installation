#! /bin/bash

sudo pacman -Syu # Update everything

printf "Generating github ssh key.\n"
ssh-keygen -t rsa -f ${HOME}/.ssh/github -q -P ""
eval "$(ssh-agent -s)"
ssh-add ${HOME}/.ssh/github

printf "Installing github cli.\n"
sudo pacman -Syu --noconfirm github-cli
gh config set git_protocol ssh
gh auth login --web -s "delete_repo read:public_key write:public_key repo"
gh ssh-key add ~/.ssh/github.pub -t "${HOSTNAME}"
mv ~/.config/nixpkgs ~/.config/nixpkgs.old
gh repo clone antotocar34/dotfiles ~/.config/nixpkgs
printf "\nPlease run ./nix_install.sh.\n"
