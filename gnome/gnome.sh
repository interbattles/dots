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