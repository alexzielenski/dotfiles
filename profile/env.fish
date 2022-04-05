# Symlinked to beginning of fish's conf.d directory

# This runs the risk of not working when this file is a symlink.
# So don't make this file a symlink ok
#
# Don't worry about realpath not being available on macOS, since fish
# has a compatibility layer for that case.
set -x DOTFILES "$(dirname (dirname (realpath (status --current-filename))))"

if status --is-interactive
    set -x interactive 1
else
    set -x interactive 0
end

if not type -q replay
    return
end

set -x shell "fish"

replay "source $DOTFILES/profile/common_env.sh"

eval "$(brew shellenv)"

for rcfile in $DOTFILES/*/env_fish.fish
	source $rcfile
end
