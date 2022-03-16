if not type -q starship
    # starship not installed. exit silently
    return
end

# Point STARSHIP_CONFIG to our dotfiles
set -x STARSHIP_CONFIG "$DOTFILES/starship/config.toml"

# Start prompt
starship init fish | source
