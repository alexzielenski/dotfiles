#!/usr/bin/env fish

# Symlink fisher plugin list into dotfiles
link_file $DOTFILES/fisher/plugins $__fish_config_dir/fish_plugins backup
	or abort plugins

if not type -q fisher
    curl -sL https://git.io/fisher | source
end

fisher update 1> /dev/null
    or abort "failed fisher update"
