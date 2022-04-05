# Do nothing
# zshrc runs for interactive shells after zprofile
# inform helper scripts the shell without doing any crazy magic
# alternative to this is something complicated to detect in common_env.sh
export shell="zsh"

if [[ $- == *i* ]]; then
	interactive=1
else
	interactive=0
fi

source "$DOTFILES/profile/common_env.sh"

eval "$(brew shellenv)"

for rcfile in $DOTFILES/*/env_zsh.sh; do
	source $rcfile
done
