# https://github.com/caarlos0/dotfiles.fish/blob/master/fzf/install.fish
# export FZF_DEFAULT_OPTS="--color=bg+:#1e1e1e,bg:#000000,spinner:green,hl:#FF0000 --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"

# https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#b3b3b3,bg:#000000,hl:#1f6feb
 --color=fg+:#ffffff,bg+:#222222,hl+:#a5d6ff
 --color=info:#484f58,prompt:#8957e5,pointer:#af5fff
 --color=marker:#56d364,spinner:#ff9bce,header:#db61a2
 --ansi'

export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
