#!/usr/bin/env fish

set -l toolchain 1.90.0

fish_add_path --prepend $HOME/.cargo/bin

if not type -q rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- --default-toolchain $toolchain --no-modify-path -y
end

fish_add_path --prepend $HOME/.cargo/bin

rustup toolchain install $toolchain 1> /dev/null
    or abort "install rust $toolchain toolchain"

rustup default $toolchain 1> /dev/null
    or abort "set default rust toolchain"
