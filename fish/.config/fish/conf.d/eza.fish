if ! status is-interactive ||
        ! command --query eza
    exit
end

set eza_params '--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale'

alias gls='/bin/ls' # gnu ls (compatability)

alias ls='eza $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'
alias tree='eza --tree $eza_params'

alias la='eza -lbhHigUmuSa'
alias lsa='eza -lbhHigUmuSa' # muscle memory lol
