if ! status is-interactive ||
        ! command --query eza
    exit
end

set eza_params '--git' '--icons' '--group-directories-first' '-F' '-g' 

function _ls -w (which ls); command ls $argv; end

function ls -w eza; eza $eza_params $argv; end
function l -w eza; eza --git-ignore $eza_params $argv; end
function ll -w eza; eza --all --header --long $eza_params $argv; end
function llm -w eza; eza --all --header --long --sort=modified $eza_params $argv; end
function lx -w eza; eza -lbhHigUmuSa@ $argv; end
function lt -w eza; eza --tree $eza_params $argv; end
function tree -w eza; eza --tree $eza_params $argv; end
function la -w eza; eza -lbhHigUmuSa $argv; end
