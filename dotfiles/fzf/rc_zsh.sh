test $interactive = 1 || return

ext=$shell
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.$ext ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.$ext"

source $DOTFILES/fzf/dot_fzf/shell/key-bindings.zsh
source $DOTFILES/fzf/dot_fzf/shell/completion.zsh
