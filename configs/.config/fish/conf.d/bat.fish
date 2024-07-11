if ! status is-interactive ||
        ! command --query bat
    exit
end

alias gcat='/bin/cat' # gnu cat (compatability)

alias cat='bat'
