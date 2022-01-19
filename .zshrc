# source iff file exists
include() {
  [[ -f "$1" ]] && source "$1"
}

source $HOME/antigen.zsh

antigen use oh-my-zsh
antigen theme robbyrussell

plugins=(
  git pip lein z gradle rust kubectl 
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
)

for plugin in ${plugins[@]}; do
  antigen bundle ${plugin}
done

antigen apply

# fzf for mac
include ~/.fzf.zsh

# fzf for archlinux
include /usr/share/fzf/key-bindings.zsh
include /usr/share/fzf/completion.zsh

alias ls="exa"
alias vim="nvim"
alias k="kubectl"
alias sudo="sudo -E"
