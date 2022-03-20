# Hook to specify configuration for the DOTFILES rc startup scripts
# Possible values to customize here:
# DOTFILES_PROMPT: "p10k", "starship", "none"
# BREW_PREFIX: path to custom brew install location.
#
# Only exports/aliases should be in here
# This file is sourced first before brew is configured
# Use this to customize brew install location if needed
# export BREW_PREFIX="/usr/local/brew"
export DOTFILES_FISH_PROMPT="starship"
export DOTFILES_ZSH_PROMPT="starship"
