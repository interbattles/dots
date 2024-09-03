#!/usr/bin/env fish

function query_package
    pacman -Qi $argv >/dev/null
end

function query_or_install
    for package in $argv
        if not query_package $package
            echo "installing missing package $package"
            sudo pacman -S $package --needed 1>/dev/null
            echo "installed $package"
        end
    end
end

function query_or_install_dep
    for package in $argv
        if not query_package $package
            echo "installing missing dependency $package"
            sudo pacman -S --asdeps $package --needed 1>/dev/null
            echo "installed dependency $package"
        end
    end
end

function query_or_install_aur
    for package in $argv
        if not query_package $package
            echo "installing aur package $package"
            begin
                mkdir -p "$HOME/.cache/aur/$package"
                and git clone "https://aur.archlinux.org/$package.git" "$HOME/.cache/aur/$package"
                and cd "$HOME/.cache/aur/$package"
                and makepkg -sic
                and echo "installed aur package $package"
            end; or exit 1
        end
    end
end

query_or_install base-devel cmake

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
    set command $dep

    switch $dep
        case ripgrep
            set command rg
        case fd-find
            set command fd
    end

    if ! command -sq $command
        echo "installing rust binary $dep"
        cargo install --quiet $dep
    end
end

echo "symlinking configurations"
stow configs misc

# fonts
query_or_install ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-emoji

# generate matugen defaults
test -d ~/.cache/matugen || matugen color hex FFFFFF

argparse m/minimal -- $argv

if not test -n "$_flag_m" && not test -n "$_flag_minimal"
    echo 'installing extras :)'
    query_or_install chromium keepassxc nemo rofi neovim adw-gtk-theme qt5ct nodejs

    query_or_install_dep npm

    # paru > yay sorry
    # if ! command -sq paru
    #   git clone https://aur.archlinux.org/paru.git /tmp/paru
    #   cd /tmp/paru
    #   makepkg -sic
    #   cd -
    # end

    # aur
    query_or_install_aur adwaita-qt5 bibata-cursor-theme-bin vesktop-bin
    query_or_install_aur eww tiramisu-git
    and eww open bar 1>/dev/null
else
    echo 'skipped extras :('
end


# sudo pacman -S --needed socat
# ags setup
# sudo pacman -S --needed nodejs npm gnome-bluetooth-3.0 power-profiles-daemon
# 
# if ! test -d configs/.config/ags/node_modules
#     npm --prefix configs/.config/ags install configs/.config/ags
# end
# 
# if ! npm list -g esbuild &>/dev/null
#     sudo npm install -g esbuild
# end
# 
# if ! npm list -g sass &>/dev/null
#     sudo npm install -g sass
# end

# vi: shiftwidth=4 tabstop=4
