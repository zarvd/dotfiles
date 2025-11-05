function fish_greeting
end

function fish_prompt
    # Value
    set --local return_code $status
    set --local cwd (prompt_pwd --full-length-dirs=3 --dir-length=3)
    set --local git_branch (fish_git_prompt)

    # Color
    set --local CWD_COLOR (set_color $fish_color_cwd)
    set --local GIT_BRANCH_COLOR (set_color $fish_color_operator --bold)
    set --local RETURN_CODE_COLOR (set_color $fish_color_status)
    set --local REMOTE_COLOR (set_color $fish_color_redirection)
    set --local END_COLOR (set_color normal)

    # Print
    if set --query SSH_CLIENT
        echo -n "["
        echo -n $REMOTE_COLOR
        echo -n REMOTE
        echo -n $END_COLOR
        echo -n "] "
    end
    if set --query HTTP_PROXY
        echo -n "["
        echo -n $REMOTE_COLOR
        echo -n PROXIED
        echo -n $END_COLOR
        echo -n "] "
    end
    echo -n $CWD_COLOR$cwd$END_COLOR
    echo -n $GIT_BRANCH_COLOR$git_branch$END_COLOR
    if [ $return_code != 0 ]
        printf " %s[%s]%s" $RETURN_CODE_COLOR $return_code $END_COLOR
    end
    echo -n " "
end
