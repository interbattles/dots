#!/bin/bash

echo "downloading submodules"
git submodule init
git submodule update

if ! command -v eza &> /dev/null
then
    echo "installing cargo"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

    cargo binstall bat eza fd-find mise
fi

echo "symlinking configurations"
stow git terminal zsh nvim