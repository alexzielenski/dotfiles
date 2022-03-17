set -x DOTFILES "$HOME/dotfiles"

if not type -q replay
    return
end

set -x shell "fish"

if status --is-login
    set -x isloginshell 1
else
    set -x isloginshell 0
end

replay source $HOME/dotfiles/profile/common.sh

for rcfile in $DOTFILES/*/rc_fish.fish
	source $rcfile
end
