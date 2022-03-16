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
	link_file $DOTFILES/iterm2/Visor.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Visor.json" backup
        or abort 'failed to link visor profile'

	# Install Default Profile
	link_file $DOTFILES/iterm2/Default.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Default.json" backup
        or abort 'failed to link Default profile'

	# Unsure how to set our profile as default from CLI
	# Unsure how to set iterm2 as default terminal from CLI
end
