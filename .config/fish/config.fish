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
    set -l end_color (set_color normal)

    # Print
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
    alias l="lsd -al"
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias .....="cd ../../../.."

    # Editor
    alias vim="nvim"

    # Kubernetes
    alias k="kubectl"

    # Python
    alias py="python"
    alias ipy="ipython"

    # Git
    alias gb="git branch"
    alias gd="git diff"
    alias gst="git status"
    alias gco="git checkout"
    alias ga="git add"
    alias gca="git commit -a"
    alias gp="git push"
    alias grbi="git rebase -i"
    alias grbc="git rebase --continue"
    alias grba="git rebase --abort"
    alias grhh="git reset --hard"

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
    set -gx http_proxy "http://127.0.0.1:7890"
    set -gx all_proxy "socks5://127.0.0.1:7890"
end

function unset_proxy
    set -e https_proxy
    set -e http_proxy
    set -e all_proxy
end
