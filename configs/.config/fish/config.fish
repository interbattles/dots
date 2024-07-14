set fish_greeting

if status is-interactive
    source ~/.cache/matugen/colors.fish
    set -g fish_key_bindings fish_vi_key_bindings
end

set EDITOR nvim
set zoxide_cmd cd

set -x STARSHIP_CONFIG ~/.cache/wal/starship.toml

fish_add_path -P $HOME/.cargo/bin

pyenv init - | source
starship init fish | source
