#!/usr/bin/env fish

# Symlink fisher plugin list into dotfiles
link_file $DOTFILES/fisher/plugins $__fish_config_dir/fish_plugins backup
	or abort plugins

if type -q fisher
    fisher update
    exit 0
end

curl -sL https://git.io/fisher | source
fisher update
