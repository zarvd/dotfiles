function confirm
    while true
        read --local --prompt 'Do you want to continue? [y/N] ' rv

        switch $rv
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

function repeat -d "Run a command every N seconds"
    set --local interval $argv[1]
    set --local command $argv[2..-1]

    if not string match -qr '^[1-9][0-9]*$' "$interval"
        echo "Error: The interval must be a positive integer."
        return 1
    end

    if test (count $command) -eq 0
        echo "Error: No command specified to execute."
        return 2
    end

    set --local yellow (set_color -o yellow)
    set --local white (set_color white)
    set --local reset_color (set_color normal)
    set --function i 0
    while true
        set i (math $i+1)
        set --local ts (date +"%T")
        if test $i -gt 1
            echo -------------------------
        end
        echo $white"Running "$yellow$command$reset_color$white" at "$ts "(#"$i")"$reset_color
        eval $command
        sleep $interval
    end
end
