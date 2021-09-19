#! /bin/bash
cat package_lists/pacman_install | tr "\n" " " | xargs sudo pacman --noconfirm -Syu
cat package_lists/yay_install | tr "\n" " " | xargs yay --noconfirm -Syu
cat package_lists/to_remove | tr "\n" " " | xargs sudo pacman --noconfirm -Rs
