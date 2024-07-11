if ! status is-interactive ||
        ! command --query bat
    exit
end

function _cat -w (which cat); command cat $argv; end # gnu cat (compatability)

function cat -w bat; bat $argv; end
