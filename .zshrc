source $HOME/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle z
antigen bundle gradle
antigen bundle rust

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme robbyrussell

antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls="exa"
alias vim="nvim"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bytedance/.sdkman"
[[ -s "/Users/bytedance/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bytedance/.sdkman/bin/sdkman-init.sh"
