#!/usr/bin/env fish

set -l fonts \
    "font-meslo-lg-nerd-font" \
    "font-hack-nerd-font"

for font in $fonts
    brew install --cask --quiet --quiet $font
        and success "install font $font"
        or abort "install font $font"
end
