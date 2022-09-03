#!/usr/bin/env fish

# Rebuild fzf from source if necessary
pushd $DOTFILES/fzf/dot_fzf

make
    or abort "failed to build fzf"

make install
    or abort "failed to install fzf"

popd

abort "Fzf temporarily disabled"

# brew install -q fzf

# set fzfPath (brew --prefix fzf)
# $fzfPath/install --xdg --completion --key-bindings --no-update-rc 1> /dev/null
