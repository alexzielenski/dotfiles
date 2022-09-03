#!/usr/bin/env fish

switch (name)
case Darwin
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
case Linux
    warn "Can't install fonts onto linux"
case '*'
    abort 'unrecognized system: '(uname)
end
