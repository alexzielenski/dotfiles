export DOTFILES=$HOME/dotfiles

# Figure out what shell we are under
if [[ -z "${shell}" ]]; then
    if [[ ! -z "${BASH}" ]]; then
        shell="bash"
    else
        shellstring=$(ps -ocomm= -p $$)
        if grep -q "zsh" <<< "$shellstring"; then
            shell="zsh"
        fi

        unset shellstring
    fi

    if [[ -z "${shell}" ]]; then
        echo "$BASH_SOURCE: could not identify shell"
        exit 1
    fi
fi

if test -f "$HOME/dotfiles/config.sh"; then
    source $HOME/dotfiles/config.sh
fi

# Add brew prefix to PATH
if [[ -z "$BREW_PREFIX" ]]; then
    if type "brew" >/dev/null 2>&1; then
        export BREW_PREFIX=$(brew --prefix)
    fi
fi

if [[ -z "$BREW_PREFIX" ]]; then
    echo "$BASH_SOURCE: could not locate brew. Do you need to export a custom BREW_PREFIX in $DOTFILES/config.sh ?"
    exit 1
else
    export PATH=$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH
    export MANPATH=$BREW_PREFIX/share/man:$MANPATH
fi

# Add Go-built binaries to PATH
export PATH=$HOME/go/bin:$PATH

if test -f "$DOTFILES/env.sh"; then
    source $DOTFILES/env.sh
fi
