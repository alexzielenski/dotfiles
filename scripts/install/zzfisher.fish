#!/usr/bin/env fish

if type -q fisher
    fisher update
    exit 0
end

curl -sL https://git.io/fisher | source
fisher update
