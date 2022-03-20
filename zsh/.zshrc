# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
