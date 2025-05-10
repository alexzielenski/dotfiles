#!/usr/bin/env fish

set -x DOTFILES "$HOME/dotfiles"
set -x DOTFILES_DATA "$HOME/dotfiles"

echo "Boostrapping dotfiles!"

# Comma separated list of installer names to run
set FILTER_NAMES $argv[1]

if test -z "$FILTER_NAMES"
	echo "No filter names provided, running all installers"
else
	echo "Running only the following installers: $FILTER_NAMES"
	# Split the filter names into an array
	set FILTER_NAMES (string split ',' $FILTER_NAMES)
end

################################################################################
# Define Installation Framework
################################################################################
# Library functions used by the installers

function info
	echo [(set_color --bold) ' .. ' (set_color normal)] $argv
end

function user
	echo [(set_color --bold) ' ?? ' (set_color normal)] $argv
end

function success
	echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function warn
	echo [(set_color --bold yellow) ' !! ' (set_color normal)] $argv
end

function abort
	echo [(set_color --bold red) ABRT (set_color normal)] $argv
	exit 1
end

function on_exit -p %self
	#!TODO: Restore backups of all created links?
	if not contains $argv[3] 0
		echo [(set_color --bold red) FAIL (set_color normal)] "Couldn't setup dotfiles, please open an issue at https://github.com/alexzielenki/dotfiles"
	end
end

function test_app
	if test -d /Applications/$argv[1].app
		return 0
	end
	if test -d $HOME/Applications/$argv[1].app
		return 0
	end
	return  1
end

################################################################################
# Load Configuration
################################################################################
# Some configurable variables are stored in install_env to make it easier to
# change settings

source "$DOTFILES/install_env.fish"
	or abort "failed to load environment from $DOTFILES/install_env.fish"

################################################################################
# Run installers
################################################################################

# Update homebrew once then disable auto-update
# User is expected to install brew and chezmoi on their own
brew update
set -x HOMEBREW_NO_AUTO_UPDATE 1

for installer in $DOTFILES/_scripts/install/*.fish
	set name "$(basename $(dirname $installer))/$(basename $installer)"

	if test -n "$FILTER_NAMES"
		if not contains $name $FILTER_NAMES
			info "skipping $dname at $name"
			continue
		end
	end

	info "running $name..."
	source $installer
		and success $name
		or abort $name
end

################################################################################
# Add fish to list of shells and set as default
################################################################################

if ! grep --silent (command -v fish) /etc/shells
	warn "$(command -v fish) is not in the list of shells. You can add it with: echo \"$(command -v fish)\" | sudo tee -a /etc/shells"
end


if test (command -v fish) != $SHELL
	warn "$(command -v fish) is not the current shell. Set as default using: chsh -s $(command -v fish)"
end

success 'dotfiles installed/updated!'
