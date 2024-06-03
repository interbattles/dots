if [[ $SUDO_USER != '' && $SUDO_USER != 'root' ]] then    
    HOME=/home/$SUDO_USER;
fi

ZSH_DISABLE_COMPFIX=true
zmodload -u zsh/compctl zsh/complete

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light z-shell/zsh-eza

zinit has'zoxide' light-mode for \
  z-shell/zsh-zoxide
zinit light z-shell/zsh-zoxide

zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# i'm not particularly sure what any of this does or how it works
# but in my specific setup it duplicates everything when i paste
# highlighting doesn't work after i paste now but oh well
# i spent 4+ hours trying to fix this ...

paste_init() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

paste_finish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init paste_init
zstyle :bracketed-paste-magic paste-finish paste_finish

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias cd=z
alias cat=bat
alias whatrepo='grep -E "^\[.*]" /etc/yum.repos.d/*'
# alias ls=eza # not needed anymore because of zsh-eza
