set fish_greeting

if status is-interactive
  fish_vi_key_bindings

  fish_config theme choose "Catppuccin Mocha"
end

#source $HOME/.cargo/env.fish
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx EDITOR "nvim"
set -gx TERMINAL "alacritty"

set -gx zoxide_cmd cd

## bun
#set --export BUN_INSTALL "$HOME/.bun"
#set --export PATH $BUN_INSTALL/bin $PATH

abbr -a -- pacfzf pacman\ -Slq\ \|\ fzf\ --preview\ \'pacman\ -Si\ \{\}\'\ --layout=reverse
abbr -a -- pacfzinstalled pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'

fish_add_path "$HOME/.spicetify"
