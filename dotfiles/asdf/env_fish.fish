#!/usr/bin/env fish

set -l asdfPath "$DOTFILES/asdf/dot_asdf/asdf.fish"
if test -f $asdfPath
    source $asdfPath
end
