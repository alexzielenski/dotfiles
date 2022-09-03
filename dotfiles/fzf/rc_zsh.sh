test $interactive = 1 || return

ext=$shell
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.$ext ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.$ext"
