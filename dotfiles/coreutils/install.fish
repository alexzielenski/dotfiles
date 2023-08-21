#!/usr/bin/env fish

switch (uname)
case Darwin
    brew install -q coreutils
    brew install -q gnu-sed
    brew install -q grep
case Linux
    # Do nothing. Should already have coreutils and sed?
case '*'
    abort 'unrecognized system: '(uname)
end
