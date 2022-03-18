# only alias ls in interactive mode
if status --is-interactive
    alias ls="colorls"

    function tx
        colorls --sort-dirs --git-status --color --tree=$argv[1] $argv[2..-1]
    end

    alias t="tx 1"
    alias t2="tx 2"
    alias t3="tx 3"
end
