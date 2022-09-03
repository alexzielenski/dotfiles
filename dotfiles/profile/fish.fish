# Symlinked from .config/fish/config.fish

if not type -q replay
    echo "fish.fish: replay package is not installed"
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<