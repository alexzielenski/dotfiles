if command -v atuin > /dev/null
    atuin init fish | source

    set -x ATUIN_CONFIG_DIR $DOTFILES/atuin/config
end

function atuin_fullscreen_search
    atuin search --inline-height 0
end
bind \cr atuin_fullscreen_search  # Ctrl+R

function atuin_inline_search
    atuin search --inline-height 10
end
bind \eA atuin_inline_search      # Up arrow
