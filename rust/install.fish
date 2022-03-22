#!/usr/bin/env fish

brew install -q rust
brew unlink -q rust

if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
end


replay source $DOTFILES/rust/rc.sh
rustup update 1> /dev/null
