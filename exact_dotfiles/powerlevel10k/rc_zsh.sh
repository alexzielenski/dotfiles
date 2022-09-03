test $interactive = 1 || return

if ! test "$DOTFILES_ZSH_PROMPT" = "p10k"; then
  return
fi

# To customize prompt, run `p10k configure` or edit p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh
