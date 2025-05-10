#!/usr/bin/env zsh

if [[ -z "$ASDF_DATA_DIR" ]]; then
    # set data dir
    export ASDF_DATA_DIR="$HOME/.asdf"
fi

export PATH="$ASDF_DATA_DIR/shims:$PATH"
