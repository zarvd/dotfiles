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
