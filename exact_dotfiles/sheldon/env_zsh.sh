if ! type "sheldon" &> /dev/null;then
    return
fi

# export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export SHELDON_CONFIG_DIR="$DOTFILES/sheldon"
eval "$(sheldon source)"
