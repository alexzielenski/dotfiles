set -x DOTFILES "$HOME/dotfiles"

if not type -q replay
    echo "~/dotfiles/profile/fish.fish: replay is not installed?"
    exit 0
end

set -x shell "fish"

replay source $HOME/dotfiles/profile/common_env.sh

if status --is-login
    replay source $HOME/dotfiles/profile/common_login.sh
end

replay source $HOME/dotfiles/profile/common_nonlogin.sh

for rcfile in $DOTFILES/*/rc_fish.fish
	source $rcfile
end
