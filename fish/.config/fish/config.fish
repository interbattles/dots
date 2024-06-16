if status is-interactive
    set fish_greeting

    fish_config theme choose Catppuccin\ Mocha

    set hydro_color_pwd $fish_color_cwd
    set hydro_color_prompt $fish_color_command
    set hydro_color_duration $fish_color_end
    set hydro_color_git $fish_color_status
end

#source $HOME/.cargo/env.fish
set -gx PATH "$HOME/.cargo/bin" $PATH

$HOME/.cargo/bin/mise activate fish | source

## bun
#set --export BUN_INSTALL "$HOME/.bun"
#set --export PATH $BUN_INSTALL/bin $PATH

abbr -a -- pacfzf pacman\ -S\ \$\(pacman\ -Slq\ \|\ fzf\ --preview\ \'pacman\ -Si\ \{\}\'\ --layout=reverse\)
abbr -a -- pacfzinstalled pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\'

fish_add_path /home/devin/.spicetify
