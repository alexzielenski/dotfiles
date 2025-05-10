#!/usr/bin/env fish

if test -z "$ASDF_DATA_DIR"
    # set data dir
    export ASDF_DATA_DIR="$HOME/.asdf"
end

set -gx PATH $ASDF_DATA_DIR/shims $PATH
