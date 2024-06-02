if [[ $SUDO_USER != '' && $SUDO_USER != 'root' ]] then    
    HOME=/home/$SUDO_USER;
fi

ZSH_DISABLE_COMPFIX=true
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  fzf
  zoxide
  zsh-eza
  zzcomplete
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zui/zui.plugin.zsh

# i'm not particularly sure what any of this does or how it works
# but in my specific setup it duplicates everything when i paste
# highlighting doesn't work after i paste now but oh well
# i spent 4+ hours trying to fix this ...

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
paste_init() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

paste_finish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init paste_init
zstyle :bracketed-paste-magic paste-finish paste_finish

# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias cd=z
alias cat=bat
alias whatrepo='grep -E "^\[.*]" /etc/yum.repos.d/*'
# alias ls=eza # not needed anymore because of zsh-eza

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(mise activate zsh)"
