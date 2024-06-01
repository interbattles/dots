#!/bin/bash

echo "downloading submodules"
git submodule init
git submodule update

if ! command -v cargo &> /dev/null
then
    echo "installing cargo"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

    cargo binstall bat eza fd-find mise zoxide
fi

echo "symlinking configurations"
stow git terminal ohmyzsh nvim

mkdir -p ~/.themes
mkdir -p ~/.icons
ln -t ~/.themes/ -s ~/.local/share/themes/*
ln -t ~/.icons/ -s ~/.local/share/icons/*

echo "resetting flatpak theme"
flatpak --user override --reset

echo "applying themes to flatpak"
flatpak --user override --filesystem="$HOME/.themes" # compatability for some gnome apps
flatpak --user override --filesystem="$HOME/.icons"
flatpak --user override --filesystem="$HOME/.local/share/icons" # some apps seem to like this one more (vesktop) (￢_￢;)
flatpak --user override --filesystem="$HOME/.local/share/themes"

echo "done!!!"
echo " > you may have to log out for some changes to apply"
