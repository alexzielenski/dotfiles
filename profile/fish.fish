# Symlinked from config.fish
set -x DOTFILES "$HOME/dotfiles"

if not type -q replay
    return
end

set -x shell "fish"

if status --is-login
  replay source "$DOTFILES/profile/common_login.sh"
end

replay source "$DOTFILES/profile/common_nonlogin.sh"

for rcfile in $DOTFILES/*/rc_fish.fish
	source $rcfile
end
