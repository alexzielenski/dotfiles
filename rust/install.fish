#!/usr/bin/env fish

if not type -q rustup
    if command -v cargo or
        command -v rustfmt or
        command -v rustc
        abort "Unsupported rust configuration. cargo is in PATH but not rustup? Please uninstall existing rust toolchain and rerun the script."
    end

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
end


replay source $DOTFILES/rust/rc.sh
rustup update
