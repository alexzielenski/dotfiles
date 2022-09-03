#!/usr/bin/env fish

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

if test -f "$DOTFILES/env.sh"
    replay "source $DOTFILES/env.sh"
end

# Profile next

if not type -q replay
    echo "env.fish: replay package is not installed"
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
