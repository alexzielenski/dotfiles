#!/usr/bin/env fish

brew install -q fzf

set fzfPath (brew --prefix fzf)
$fzfPath/install --xdg --completion --key-bindings --no-update-rc
