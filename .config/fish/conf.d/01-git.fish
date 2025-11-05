function git-rebase
    set --local current_branch (git branch --show-current)
    set --local remotes (git remote)

    set --local remote origin
    if contains upstream $remotes
        set remote upstream
    end
    echo Rebasing $current_branch on $remote/master

    if confirm
        git fetch $remote master
        git checkout $current_branch
        git rebase -i $remote/master
    end
end
