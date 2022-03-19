#!/usr/bin/env fish

asdfPath=$(brew --prefix asdf)"/libexec/asdf.sh"

if test -f "$asdfPath"; then
    source $asdfPath
fi

unset asdfPath
