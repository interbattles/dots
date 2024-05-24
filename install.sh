#!/bin/bash

tar --skip-old-files -xvf gnome/extensions.tar.gz -C ~/.local/share/gnome-shell
tar --skip-old-files -xvf gnome/fonts.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/icons.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/themes.tar.gz -C ~/.local/share
tar --skip-old-files -xvf gnome/backgrounds.tar.gz -C ~/.local/share

stow -v base terminal