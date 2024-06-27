#!/bin/bash

echo "downloading submodules"
git submodule init
git submodule update

if ! command -v cargo &>/dev/null; then
	echo "installing rustup"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
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
stow ags fish git hyprland nvim starship terminal tmux
