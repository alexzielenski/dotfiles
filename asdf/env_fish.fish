#!/usr/bin/env fish

set -l asdfPath (brew --prefix asdf)"/libexec/asdf.fish"
if test -f asdfPath
    source $asdfPath
end
