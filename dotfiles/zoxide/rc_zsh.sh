if command -v zoxide &> /dev/null
then
    # Must be called AFTER compinit for working completions
    # As of writing our current zsh config doesnt use completions
    export _ZO_FZF_OPTS='--scheme=path --tiebreak=end,chunk,index --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --select-1'
    eval "$(zoxide init zsh)"
fi
