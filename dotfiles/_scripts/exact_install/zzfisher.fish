#!/usr/bin/env fish

if not type -q fisher
    curl -sL https://git.io/fisher | source
end

fisher update 1> /dev/null
    or abort "failed fisher update"
