#!/usr/bin/env fish

asdfPath="$DOTFILES/asdf/dot_asdf/asdf.sh"

if test -f "$asdfPath"; then
    source $asdfPath
fi
