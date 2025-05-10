#!/usr/bin/env zsh

if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
    export ATUIN_CONFIG_DIR="$DOTFILES/atuin/config"
fi

function atuin_fullscreen_search() {
  _atuin_search --inline-height 0
}
zle -N atuin_fullscreen_search
bindkey '^R' atuin_fullscreen_search


# Up arrow = inline
function atuin_inline_search() {
  _atuin_up_search --inline-height 10
}
zle -N atuin_inline_search
bindkey '\e[A' atuin_inline_search
