set -x BUN_INSTALL $HOME/.bun
set -x GOPATH $HOME/go
set -x RUBYHOME $HOME/.local/share/gem
set -x DOTNET_ROOT $HOME/.dotnet

fish_add_path -P $GOPATH/bin
fish_add_path -P $HOME/.cargo/bin
fish_add_path -P $BUN_INSTALL/bin
fish_add_path -P $RUBYHOME/ruby/3.3.0/bin
fish_add_path -P $DOTNET_ROOT

set fish_greeting
set -x EDITOR nvim

alias v=nvim

function check_init
    if command --query $argv[1]
        return 0
    else
        return 1
    end
end

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

if status is-interactive
    set -g fish_key_bindings fish_vi_key_bindings
    source ~/.cache/matugen/colors.fish

    set -x EMSDK_QUIET 1
    . ~/emsdk/emsdk_env.fish

    set zoxide_cmd cd
    alias v=nvim

    starship init fish | source
    if test "$TERM" = xterm-256color
        command cat ~/.cache/matugen/sequences
    end

    if check_init pyenv
        pyenv init - | source
    end
end

# vi: tabstop=4 shiftwidth=4
