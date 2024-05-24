export ZSH_CUSTOM="$HOME/dots/zsh"

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$HOME/.scripts/bin:$PATH"

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  zoxide
  zsh-syntax-highlighting 
  zsh-autosuggestions
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

alias cd=z
alias ls=eza
alias cat=bat