#!/usr/bin/env fish

set asdfPath (brew --prefix asdf)"/libexec/asdf.fish"
if test -f asdfPath
    source $asdfPath
end
set -u asdfPath
