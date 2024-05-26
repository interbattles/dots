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

echo "extracting themes"
tar --skip-old-files -xf gnome/extensions.tar.gz -C ~/.local/share/gnome-shell
tar --skip-old-files -xf gnome/fonts.tar.gz -C ~/.local/share
tar --skip-old-files -xf gnome/icons.tar.gz -C ~/.local/share
tar --skip-old-files -xf gnome/themes.tar.gz -C ~/.local/share
tar --skip-old-files -xf gnome/backgrounds.tar.gz -C ~/.local/share

echo "loading extensions"
dconf load /org/gnome/shell/extensions/ < gnome/extensions.conf
dconf load /org/gnome/desktop/interface/ < gnome/interface.conf

echo "symlinking configurations"
stow base terminal

echo "symlinking themes"
stow -d "$HOME/.local/share/themes/Gruvbox-Dark-BL-MOD" -t "$HOME/.config" -S gtk-4.0

mkdir -p ~/.themes
ln -t ~/.themes/ -s ~/.local/share/themes/*

echo "applying themes to flatpak"
flatpak --user override --filesystem="$HOME/.themes"
flatpak --user override --filesystem=xdg-config/gtk-4.0

echo "done!!!"
echo " >you may have to log out for some changes to apply"