exaPrefix="exa --icons --color=always --git --group-directories-first"
tx="$exaPrefix --tree --level"

alias t="$tx 1"
alias tt="$tx 2"
alias ttt="$tx 3"
alias tttt="$tx 4"

if [[ $interactive == 1 ]];then
    alias ls="$exaPrefix"
fi

unset exaPrefix
unset tx
