fish_add_path -P $HOME/.cargo/bin

if status is-interactive
  set fish_greeting
  set -g fish_key_bindings fish_vi_key_bindings

  source ~/.cache/matugen/colors.fish

  set EDITOR nvim
  set zoxide_cmd cd

  alias v=nvim
  
  starship init fish | source
  pyenv init - | source
  source /opt/asdf-vm/asdf.fish
end
