#!/usr/bin/env fish

switch (uname)
case Darwin
    brew install --quiet --quiet $TerminalFontSlug
        and success "install font $TerminalFontSlug"
        or abort "install font $TerminalFontSlug"
case Linux
    warn "Can't install fonts onto linux"
case '*'
    abort 'unrecognized system: '(uname)
end
