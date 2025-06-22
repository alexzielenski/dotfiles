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

# Default BREW_PREFIX discovery:
if test -z "$BREW_PREFIX"; then
    if test -d "/opt/homebrew"; then
        export BREW_PREFIX="/opt/homebrew"
    elif test -d "/usr/local"; then
        export BREW_PREFIX="/usr/local"
    else
        echo "common_env.sh: could not determine BREW_PREFIX"
        exit 1
    fi
fi

source /dev/stdin < <($BREW_PREFIX/bin/brew shellenv sh 2>/dev/null)

for rcfile in $DOTFILES/*/env.sh; do
	source $rcfile
done
