set bin $argv[1]
set class $argv[2]

function i3
    i3-msg "[class=\"$class\"] $argv"
end
function await_window_toggle
    i3-msg -t subscribe -m "[\"window\"]" | while read -L msg
        set is_window (echo $msg | jq -r --arg class $class '.change == "new" and .container.window_properties.class == $class')
        if test "$is_window" = true
            toggle
            i3 scratchpad show
            exit
        end
    end
end
function cmd
    i3-msg "exec --no-startup-id $argv"
end


function toggle
    i3 scratchpad show || begin
        i3 move scratchpad
        return 1
    end
end

# show || begin
#     cmd $bin
# end

toggle || begin
    cmd "$bin"
    await_window_toggle
end
