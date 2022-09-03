#!/usr/bin/env fish

# fd is a more user friendly find
if not type -q fd
    cargo install fd-find --locked
        or abort "install fd"
end

# rg is a more user friendly grep
if not type -q rg
    cargo install rg --locked
        or abort "install rg"
end

# xh is a more user friendly httpie
if not type -q xh
    cargo install xh --locked
        or abort "install xh"
end
