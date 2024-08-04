if [[ -z "$DOTFILES" ]]; then
    echo "common_env.sh: could not determine DOTFILES dir"
    exit 1
fi

if [[ -z "${shell}" ]]; then
    echo "common_env.sh: 'shell' envar is not defined. it must be defined before sourcing this file."
    exit 1
fi

if test -f "$DOTFILES/config.sh"; then
    source $DOTFILES/config.sh
fi

source /dev/stdin < <(brew shellenv)

for rcfile in $DOTFILES/*/env.sh; do
	source $rcfile
done
