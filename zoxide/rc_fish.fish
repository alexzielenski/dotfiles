test $interactive = 1
    or exit

if not type -q zoxide
    exit 0
end

zoxide init fish | source
