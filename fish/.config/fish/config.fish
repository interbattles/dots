if status is-interactive
    # Commands to run in interactive sessions can go here
    set hydro_color_pwd $fish_color_cwd
    set hydro_color_prompt $fish_color_command
    set hydro_color_duration $fish_color_end
    set hydro_color_git $fish_color_status
end

set fish_greeting
$HOME/.local/bin/mise activate fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
