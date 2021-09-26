#! /bin/bash

sudo pacman -Syu || echo "Something went wrong" && exit 1 # Update everything

printf "\nGenerating github ssh key.\n"
ssh-keygen -t rsa -f ${HOME}/.ssh/github -q -P ""
eval "$(ssh-agent -s)"
ssh-add ${HOME}/.ssh/github

printf "\nInstalling github cli:\n"
sudo pacman -S --noconfirm github-cli
gh config set git_protocol ssh
printf "\nAuthenticating github cli:\n"
gh auth login --web -s "delete_repo read:public_key write:public_key repo"
printf"\nAdding ssh-key to github account\n"
gh ssh-key add ~/.ssh/github.pub -t "${HOSTNAME}"
mv ~/.config/nixpkgs ~/.config/nixpkgs.old 2> /dev/null
printf "\nCloning dotfiles...\n"
gh repo clone antotocar34/dotfiles ~/.config/nixpkgs
printf "Done!\nPlease run ./nix_install.sh.\n"
