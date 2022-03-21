test $interactive = 1 || return

if not type -q starship
    # starship not installed. exit silently
    return
end

if not test "$DOTFILES_FISH_PROMPT" = "starship"
    return
end

# Point STARSHIP_CONFIG to our dotfiles
set -x STARSHIP_CONFIG "$DOTFILES/starship/config.toml"

# Start prompt
starship init fish | source
