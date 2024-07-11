if ! status is-interactive ||
        ! command --query fd
    exit
end

alias gfind='/bin/find' # gnu find (compatability)

alias find='fd'
