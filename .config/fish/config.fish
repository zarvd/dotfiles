## Custom Commands

function rebase
  set -l current_branch (git branch --show-current)
  set -l remotes (git remote)

  if contains "upstream" $remotes
    git fetch upstream master
    set -l target_branch "upstream/master"
  else
    git fetch origin master
    set -l target_branch "origin/master"
  end
  echo "Rebasing $current_branch on $target_branch"
  git checkout $current_branch
  git rebase -i $target_branch
end

## Settings

function fish_prompt
  # Value
  set -l return_code $pipestatus
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
  alias gd="git diff"
  alias gst="git status"
  alias gco="git checkout"
  alias ga="git add"
  alias gca="git commit -a"
  alias gp="git push"
  alias grbi="git rebase -i"
  alias grbc="git rebase --continue"
  alias grba="git rebase --abort"

  # Keybindings
  bind \cu backward-kill-line
end

function load_env
  if test -f "~/.env.fish"
    source ~/.env.fish
  end
end

load_env
setup_alias
