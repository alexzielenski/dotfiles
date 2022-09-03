set -x DOTFILES "$(chezmoi source-path)/dotfiles"
set -x DOTFILES_DATA "$HOME/dotfiles"

if test -f "$DOTFILES/profile/env.fish"
    source "$DOTFILES/profile/env.fish"
end