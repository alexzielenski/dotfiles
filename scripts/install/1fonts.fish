#!/usr/bin/env fish

# Tap repository of fonts
brew tap homebrew/cask-fonts
    and success "tap homebrew/cask-fonts"
    or abort "tap homebrew/cask-fonts"

# Install font
if brew ls --versions $TerminalFontSlug --cask > /dev/null
    # The package is installed
    info "$TerminalFontSlug already installed"
else
    # The package is not installed
    brew install --quiet --cask --quiet $TerminalFontSlug
        and success "install font $TerminalFontSlug"
        or abort "install font $TerminalFontSlug"
end
