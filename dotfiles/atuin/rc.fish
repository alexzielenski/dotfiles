if test -n "$ATUIN_CONFIG_DIR"
    set -gx ATUIN_CONFIG_DIR $DOTFILES/atuin/ATUIN_CONFIG_DIR
end
atuin init fish | source
