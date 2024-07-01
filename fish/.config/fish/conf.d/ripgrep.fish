if ! status is-interactive ||
        ! command --query rg
    exit
end

alias ggrep='/bin/grep' # gnu grep (compatability)

alias grep='rg'
