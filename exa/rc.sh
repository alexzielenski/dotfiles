exaPrefix="exa --icons --color=always --git --group-directories-first"
tx="$exaPrefix --long --no-permissions --no-user --no-time --no-filesize --tree --level"

alias t="$tx 1"
alias tt="$tx 2"
alias ttt="$tx 3"
alias tttt="$tx 4"

if [[ $interactive == 1 ]];then
    alias ls="$exaPrefix"
fi

unset exaPrefix
unset tx


extensionStyles=(
    '*.xyz=37;41'
    '*.ts=34'
)

for i in $extensionStyles;do
#   export LS_COLORS=$i:$LS_COLORS
    echo $i
done

attrStyles=(
    "da=1;34"
)

for i in $attrStyles;do
#   export EXA_COLORS=$i:$EXA_COLORS
    echo $i
done
