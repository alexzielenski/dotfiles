#!/usr/bin/env fish

brew install -q rust
brew unlink -q rust

if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
end


fish_add_path --prepend --global $HOME/.cargo/bin
rustup update 1> /dev/null
