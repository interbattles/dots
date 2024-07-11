if ! status is-interactive ||
        ! command --query eza
    exit
end

set eza_params '--git' '--icons' '--group-directories-first' '-F' '-g' 

# function gls; /bin/ls; end
# 
# function ls; eza $eza_params $argv; end
# function l; eza --git-ignore $eza_params $argv; end
# function ll; eza --all --header --long $eza_params $argv; end
# function llm; eza --all --header --long --sort=modified $eza_params $argv; end
# function lx; eza -lbhHigUmuSa@ $argv; end
# function lt; eza --tree $eza_params $argv; end
# function tree; eza --tree $eza_params $argv; end
# function la; eza -lbhHigUmuSa $argv; end

abbr gls -- /bin/ls 
abbr ls -- eza $eza_params
abbr l -- eza --git-ignore $eza_params
abbr ll -- eza --all --header --long $eza_params
abbr llm -- eza --all --header --long --sort=modified $eza_params
abbr lx -- eza -lbhHigUmuSa@
abbr lt -- eza --tree $eza_params
abbr tree -- eza --tree $eza_params
abbr la -- eza -lbhHigUmuSa
