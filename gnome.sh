#!/bin/bash

echo "extracting themes"
tar --keep-newer-files -xaf gnome/extensions.tar.gz -C ~/.local/share/gnome-shell
tar --keep-newer-files -xaf gnome/fonts.tar.gz -C ~/.local/share
tar --keep-newer-files -xaf gnome/icons.tar.gz -C ~/.local/share
tar --keep-newer-files -xaf gnome/themes.tar.gz -C ~/.local/share
tar --keep-newer-files -xaf gnome/backgrounds.tar.gz -C ~/.local/share

echo "loading extensions"
dconf load /org/gnome/shell/extensions/ < gnome/extensions.conf
dconf load /org/gnome/desktop/interface/ < gnome/interface.conf