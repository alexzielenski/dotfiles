#!/usr/bin/env fish

# fd is a more user friendly find
if not type -q fd
    cargo install fd --locked
end

# rg is a more user friendly grep
if not type -q rg
    cargo install rg --locked
end

# xh is a more user friendly httpie
if not type -q xh
    cargo install xh --locked
end
