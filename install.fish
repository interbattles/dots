#!/usr/bin/env fish

sudo pacman -S base-devel --needed

echo "downloading submodules"
git submodule init
git submodule update

if ! command -sq cargo
    echo "installing rustup"

    sudo pacman -S rustup
    rustup toolchain install stable --profile minimal
end

set dependencies bat eza fd-find zoxide ripgrep starship matugen zellij
for dep in $dependencies
    echo "checking $dep"
    set command $dep

    switch $dep
        case ripgrep
            set command rg
        case fd-find
            set command fd
    end

    if ! command -sq $command
        echo "installing $dep"
        cargo install $dep
    end
end

echo "symlinking configurations"
stow configs misc

# ags setup
sudo pacman -S --needed nodejs npm gnome-bluetooth-3.0 power-profiles-daemon

if ! test -d configs/.config/ags/node_modules
    npm --prefix configs/.config/ags install configs/.config/ags
end

if ! npm list -g esbuild &>/dev/null
    sudo npm install -g esbuild
end

if ! npm list -g sass &>/dev/null
    sudo npm install -g sass
end

pgrep -x ags || ags
