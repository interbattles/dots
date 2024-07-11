if ! status is-interactive ||
        ! command --query fd
    exit
end

function _find -w (which find); command find $argv; end

function find -w fd; fd $argv; end
