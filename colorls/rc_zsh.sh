# only alias ls in interactive shells
if [[ $- == *i* ]]; then
    alias ls="colorls"

    function tx {
        colorls --sd --gs --tree=$1 "${@:2}"
    }

    alias t="tx 1"
    alias t2="tx 2"
    alias t3="tx 3"
fi
