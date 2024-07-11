if ! status is-interactive ||
        ! command --query rg
    exit
end

function _grep -w (which grep); command grep $argv; end

function grep -w rg; rg $argv; end
