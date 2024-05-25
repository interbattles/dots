#!/bin/bash

git submodule init
git submodule update

if ! command -v cargo &> /dev/null
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

    cargo binstall bat eza fd-find mise zoxide
fi

tar --skip-old-files -xvf gnome/extensions.tar.gz -C ~/.local/share/gnome-shell
tar --skip-old-files -xvf gnome/fonts.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/icons.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/themes.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/backgrounds.tar.gz -C ~/.local/share

dconf load /org/gnome/shell/extensions/ < gnome/extensions.conf
dconf load /org/gnome/desktop/interface/ < gnome/interface.conf

stow -v base terminal
