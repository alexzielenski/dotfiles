if command -v zoxide &> /dev/null
then
    # Must be called AFTER compinit for working completions
    # As of writing our current zsh config doesnt use completions
    eval "$(zoxide init zsh)"
fi
