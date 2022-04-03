test $interactive = 1 || return

alias packages="brew leaves | xargs -n1 brew desc"
