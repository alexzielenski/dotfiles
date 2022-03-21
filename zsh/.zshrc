# zshrc runs for interactive shells after zprofile
# inform helper scripts the shell without doing any crazy magic
# alternative to this is something complicated to detect in common_env.sh
shell="zsh"

if [[ $- == *i* ]]; then
	interactive=1
else
	interactive=0
fi

# use zsh's cancer to refer to relative file
# common_env defines $DOTFILES used everywhere else
source "$DOTFILES/profile/common_env.sh"

for rcfile in $DOTFILES/*/env_zsh.sh; do
	source $rcfile
done

if [[ -o login ]]; then
  source "$DOTFILES/profile/common_login.sh"
fi

source "$DOTFILES/profile/common_nonlogin.sh"

for rcfile in $DOTFILES/*/rc_zsh.sh; do
	source $rcfile
done
