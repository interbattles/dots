if [[ $SUDO_USER != '' && $SUDO_USER != 'root' ]] then    
    HOME=/home/$SUDO_USER;
fi

. "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
