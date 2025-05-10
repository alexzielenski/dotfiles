if command -v atuin > /dev/null
    atuin init fish | source

    set -x ATUIN_CONFIG_DIR $DOTFILES/atuin/config
end

# # Ctrl+R full screen
# bind \cr 'atuin search -i --inline-height 0'

# # Up arrow inline
# bind \e\[A 'atuin search --inline'
