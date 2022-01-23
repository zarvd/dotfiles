# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source iff file exists
include() {
  [[ -f "$1" ]] && source "$1"
}

source $HOME/antigen.zsh

antigen use oh-my-zsh
antigen theme romkatv/powerlevel10k

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

include ~/.p10k.zsh

alias ls="exa"
alias vim="nvim"
alias k="kubectl"
alias sudo="sudo -E"
