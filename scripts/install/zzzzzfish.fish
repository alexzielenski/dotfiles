#!/usr/bin/env fish

# Hook into fish's startup sequence
link_file $DOTFILES/profile/fish.fish $HOME/.config/fish/config.fish backup
link_file $DOTFILES/profile/env.fish $HOME/.config/fish/conf.d/0dotfilesenv.fish backup

# Set initial fish configuration
set -U fish_greeting
