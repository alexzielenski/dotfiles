# Symlinked to beginning of fish's conf.d directory
# Set PATH and such early on
set -x DOTFILES "$HOME/dotfiles"

if not type -q replay
    return
end

set -x shell "fish"

replay source "$HOME/dotfiles/profile/common_env.sh"

for rcfile in $DOTFILES/*/env_fish.fish
	source $rcfile
end