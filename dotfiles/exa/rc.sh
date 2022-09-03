test $interactive = 1 || return

alias lx='exa --icons --color-scale --color=always --git --group-directories-first'


alias l='lx -l'
alias ll='l --git'
alias td='ll --tree --git-ignore --no-permissions --no-user --no-time --no-filesize --level'
alias t='td 1'
alias tt='td 2'
alias ttt='td 3'
alias tttt='td 4'

# extensionStyles=(
#     '*.xyz=37;41'
#     '*.ts=34'
# )

# for i in $extensionStyles;do
# #   export LS_COLORS=$i:$LS_COLORS
#     echo $i
# done

# attrStyles=(
#     'da=1;34'
# )

# for i in $attrStyles;do
# #   export EXA_COLORS=$i:$EXA_COLORS
#     echo $i
# done
