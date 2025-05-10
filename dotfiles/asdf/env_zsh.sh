#!/usr/bin/env fish

# if asdf data dir not set
if [[ -z "$ASDF_DATA_DIR" ]]; then
    # set data dir
    set -gx ASDF_DATA_DIR "$HOME/.asdf"
end

# Add asdf shims to path
set -gx PATH $ASDF_DATA_DIR/shims $PATH
