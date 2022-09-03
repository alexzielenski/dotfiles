test $interactive = 1 || return

if not type -q zoxide
    exit 0
end

zoxide init fish | source
