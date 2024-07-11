#!/bin/bash

echo "downloading submodules"
git submodule init
git submodule update

if ! command -v cargo &>/dev/null; then
	echo "installing rustup"

  pacman -S rustup
  rustup toolchain install stable --profile minimal
fi

dependencies=("bat" "eza" "fd-find" "zoxide" "ripgrep" "starship")
for dep in ${dependencies[@]}; do
	echo "checking $dep"
	command=$dep

	if [ "$dep" = "ripgrep" ]; then
		command="rg"
	elif [ "$dep" = "fd-find" ]; then
		command="fd"
	fi

	if ! command -v $command &>/dev/null; then
		echo "installing $dep"
		cargo install $dep
	fi
done

echo "symlinking configurations"
stow ags fish git hyprland nvim pywal starship terminal tmux

# ags setup
if ! command -v yay &>/dev/null; then
  echo 'yay needed for aur installs'
  exit 1
fi
yay -S --needed gnome-bluetooth-3.0 power-profiles-daemon

npm --prefix ./ags/.config/ags install ./ags/.config/ags

if ! command -v esbuild &>/dev/null; then
  sudo npm install -g esbuild
fi

if ! command -v sass &>/dev/null; then
  sudo npm install -g sass
fi

ags
