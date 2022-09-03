#!/usr/bin/env fish

fish_add_path --prepend $HOME/.cargo/bin

if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
end

rustup update 1> /dev/null
    or abort "install rust"
