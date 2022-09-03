#!/usr/bin/env fish

if type -q brew
    brew install cmake
        or abort "failed to install cmake"
end

if not type -q cmake
    abort "cmake not found. please install cmake"
end
