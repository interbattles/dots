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
stow ags fish git hypr nvim wal starship terminal tmux

# ags setup
if ! command -v paru&>/dev/null; then
  echo 'paru needed for aur installs'
  exit 1
fi
paru -S --needed gnome-bluetooth-3.0 power-profiles-daemon

if ! test -d ./ags/.config/ags/node_modules; then
  npm --prefix ./ags/.config/ags install ./ags/.config/ags
fi

if ! npm list -g esbuild &>/dev/null; then
  sudo npm install -g esbuild
fi

if ! npm list -g sass &>/dev/null; then
  sudo npm install -g sass
fi

pgrep -x ags || ags
