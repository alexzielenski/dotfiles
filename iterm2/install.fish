#!/usr/bin/env fish
switch (uname)
case Darwin
	# Install Iterm
	if test_app "iTerm"
		info "iTerm already installed"
	else
		brew install --cask --quiet iterm2
			and success "install iterm2"
			or abort "install iterm2"
	end

    # Install Visor Profile
	set -l config $XDG_CONFIG_HOME
	if set -q config || test -z config
		set config "$HOME/.config"
	end

	link_file $DOTFILES/iterm2/Profiles.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/DotfilesDefault.json" backup

	# our profile as default from CLI
	defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "DotfilesDefault"

	# Unsure how to set iterm2 as default terminal from CLI
	

	# Set iterm theme to minimal
	# thanks justin0a0
	defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

	# Disable inactive split pane dim
	defaults write com.googlecode.iterm2 DimInactiveSplitPanes -int 0
end
