#!/usr/bin/env fish

if not status --is-interactive
    return
end

if type -q colorls
    alias ls="colorls"
end
