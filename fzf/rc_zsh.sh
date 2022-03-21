test $interactive = 1 || exit

ext=$shell
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.$ext ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.$ext"
