if [[ -o login ]]; then
  source "$DOTFILES/profile/common_login.sh"
fi

source "$DOTFILES/profile/common_nonlogin.sh"

for rcfile in $DOTFILES/*/rc_zsh.sh; do
	source $rcfile
done

for rcfile in $DOTFILES/*/rc.zsh; do
	source $rcfile
done
