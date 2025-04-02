## Helpers

function confirm
    while true
        read -l -P 'Do you want to continue? [y/N] ' rv

        switch $rv
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

## Custom Commands

function rebase
    set -l current_branch (git branch --show-current)
    set -l remotes (git remote)

    set -f remote origin
    if contains upstream $remotes
        set -f remote upstream
    end
    echo Rebasing $current_branch on $remote/master

    if confirm
        git fetch $remote master
        git checkout $current_branch
        git rebase -i $remote/master
    end
end

function repeat -d "Run a command every N seconds"
    set -l interval $argv[1]
    set -l command $argv[2..-1]

    if not string match -qr '^[1-9][0-9]*$' "$interval"
        echo "Error: The interval must be a positive integer."
        return 1
    end

    if test (count $command) -eq 0
        echo "Error: No command specified to execute."
        return 2
    end

    set -l yellow (set_color -o yellow)
    set -l white (set_color white)
    set -l reset_color (set_color normal)
    set i 0
    while true
        set i (math $i+1)
        set -l ts (date +"%T")
        if test $i -gt 1
          echo "-------------------------"
        end
        echo $white"Running "$yellow$command$reset_color$white" at "$ts "(#"$i")"$reset_color
        eval $command
        sleep $interval
    end
end

function get_lan_ip
    # Try using 'ip' command first (for Linux)
    if command -v ip >/dev/null 2>&1
        set lan_ip (ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '^127\.' | head -n 1)
    # If 'ip' is not available, try 'ifconfig' (for macOS and some Linux systems)
    else if command -v ifconfig >/dev/null 2>&1
        set lan_ip (ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '^127\.' | head -n 1)
    # If neither 'ip' nor 'ifconfig' is available
    else
        set lan_ip ""
    end

    if test -n "$lan_ip"
        echo "LAN IP: $lan_ip"
    else
        echo "Unable to retrieve LAN IP"
    end
end

## Settings

function fish_greeting
end

function fish_prompt
    # Value
    set -l return_code $status
    set -l cwd (prompt_pwd --full-length-dirs=3 --dir-length=3)
    set -l git_branch (fish_git_prompt)

    # Color
    set -l cwd_color (set_color $fish_color_cwd)
    set -l git_branch_color (set_color $fish_color_operator --bold)
    set -l return_code_color (set_color $fish_color_status)
    set -l remote_color (set_color $fish_color_redirection)
    set -l end_color (set_color normal)

    # Print
    if set -q SSH_CLIENT
      echo -n "["
      echo -n $remote_color
      echo -n "REMOTE"
      echo -n $end_color
      echo -n "] "
    end
    if set -q HTTP_PROXY
      echo -n "["
      echo -n $remote_color
      echo -n "PROXIED"
      echo -n $end_color
      echo -n "] "
    end
    echo -n $cwd_color$cwd$end_color
    echo -n $git_branch_color$git_branch$end_color
    if [ $return_code != 0 ]
        printf " %s[%s]%s" $return_code_color $return_code $end_color
    end
    echo -n " "
end

function setup_alias
    # OS
    alias ls="lsd"
    alias tree="lsd --tree"
    alias l="lsd -al --group-directories-first"
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias .....="cd ../../../.."
    alias ......="cd ../../../../.."

    # Editor
    alias vim="nvim"

    # Kubernetes
    alias k="kubectl"

    # Python
    alias py="python"
    alias ipy="ipython"

    # Git
    alias g="git"
    alias gb="git branch"
    alias gd="git diff"
    alias gst="git status"
    alias gco="git checkout"
    alias ga="git add"
    alias gc="git commit"
    alias gca="git commit -a"
    alias gp="git push"
    alias gsta="git stash"
    alias gstp="git stash pop"
    alias grbi="git rebase -i"
    alias grbc="git rebase --continue"
    alias grba="git rebase --abort"
    alias grhh="git reset --hard"
    alias ggc="git gc --aggressive --prune=now"

    # Keybindings
    bind \cu backward-kill-line
end

function load_env
    source ~/.env.fish
end

load_env
setup_alias

function set_proxy
    set -gx https_proxy "http://127.0.0.1:7890"
    set -gx HTTPS_PROXY "http://127.0.0.1:7890"
    set -gx http_proxy "http://127.0.0.1:7890"
    set -gx HTTP_PROXY "http://127.0.0.1:7890"
    set -gx all_proxy "socks5://127.0.0.1:7890"
    set -gx ALL_PROXY "socks5://127.0.0.1:7890"
end

function unset_proxy
    set -e https_proxy
    set -e HTTPS_PROXY
    set -e http_proxy
    set -e HTTP_PROXY
    set -e all_proxy
    set -e ALL_PROXY
end

function load_fish_functions
    set -l func_dir ~/.config/fish/func
    
    if test -d $func_dir
        for func_file in $func_dir/*.fish
            if test -f $func_file
                source $func_file
                echo "Loaded function file: "(basename $func_file)
            end
        end
    else
        echo "Function directory not found: $func_dir"
    end
end

# Load all fish function files
load_fish_functions
