source "$HOME/dotfiles/profile/common_env.sh"

if [ $isloginshell -eq 1 ]; then
  source "$DOTFILES/profile/common_login.sh"
fi

source "$DOTFILES/profile/common_nonlogin.sh"
