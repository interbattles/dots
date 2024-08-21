#!/usr/bin/env fish

sudo pacman -S base-devel cmake --needed

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

# fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-noto-nerd noto-fonts-emoji --needed

# generate matugen defaults
test -d ~/.cache/matugen || matugen color hex FFFFFF

argparse 'm/minimal' -- $argv

if not test -n "$_flag_m" && not test -n "$_flag_minimal"
  echo 'installing extras :)'
  sudo pacman -S chromium keepassxc nemo rofi neovim adw-gtk-theme qt5ct nodejs --needed
  sudo pacman -S --asdeps npm --needed

  # paru > yay sorry
  if ! command -sq paru
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -sic
    cd -
  end

  # aur
  paru -S adwaita-qt5 bibata-cursor-theme-bin vesktop-bin --needed
  paru -S eww tiramisu-git --needed && eww open bar
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
