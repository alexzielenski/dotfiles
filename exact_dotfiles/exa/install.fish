#!/usr/bin/env fish

if not type -q exa
    cargo install exa --locked
        or abort "install exa"
end
