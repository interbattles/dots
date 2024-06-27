set fish_greeting

if status is-interactive
  fish_vi_key_bindings

  fish_config theme choose "Catppuccin Mocha"

  tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='12-hour format' --rainbow_prompt_separators=Round --powerline_prompt_heads=Round --powerline_prompt_tails=Round --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Many icons' --transient=Yes
end


set -g tide_character_color $fish_color_end
set -g tide_character_color_failure $fish_color_error

set -g tide_pwd_color_dirs $fish_color_cwd
set -g tide_pwd_color_anchors $fish_color_cwd_root

set -g tide_vi_mode_icon_default N
set -g tide_vi_mode_icon_replace R
set -g tide_left_prompt_items vi_mode $tide_left_prompt_items

#source $HOME/.cargo/env.fish
set -gx PATH "$HOME/.cargo/bin" $PATH
set -Ux EDITOR "nvim"
set -Ux TERMINAL "alacritty"

## bun
#set --export BUN_INSTALL "$HOME/.bun"
#set --export PATH $BUN_INSTALL/bin $PATH

abbr -a -- pacfzf pacman\ -Slq\ \|\ fzf\ --preview\ \'pacman\ -Si\ \{\}\'\ --layout=reverse
abbr -a -- pacfzinstalled pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'

fish_add_path "$HOME/.spicetify"
