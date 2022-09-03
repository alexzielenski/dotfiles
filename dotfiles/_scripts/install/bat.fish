#!/usr/bin/env fish

if not type -q bat
    cargo install bat --locked
        or abort "install bat"
end
