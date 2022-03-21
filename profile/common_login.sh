test $interactive = 1 || return
test ${DOTFILES_DISABLE_WELCOME:-0} = 0 || return

echo "Welcome to $shell!"
