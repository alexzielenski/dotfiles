set -x DOTFILES "$HOME/dotfiles"

if not type -q replay
    exit 0
end

replay $HOME/dotfiles/profile/common_env.sh

if status --is-login
    replay $HOME/dotfiles/profile/common_login.sh
end

replay $HOME/dotfiles/profile/common_nonlogin.sh

for rcfile in $DOTFILES/*/rc_fish.fish
	source $rcfile
end
