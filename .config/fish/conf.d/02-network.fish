function get-lan-ip
    # Try using 'ip' command first (for Linux)
    if command -v ip >/dev/null 2>&1
        set --function lan_ip (ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '^127\.' | head -n 1)
        # If 'ip' is not available, try 'ifconfig' (for macOS and some Linux systems)
    else if command -v ifconfig >/dev/null 2>&1
        set --function lan_ip (ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '^127\.' | head -n 1)
        # If neither 'ip' nor 'ifconfig' is available
    else
        set --function lan_ip ""
    end

    if test -n "$lan_ip"
        echo "LAN IP: $lan_ip"
    else
        echo "Unable to retrieve LAN IP"
    end
end
