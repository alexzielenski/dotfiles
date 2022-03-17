# only alias ls in interactive shells
if [[ $- == *i* ]]; then
    alias ls="colorls"
fi
