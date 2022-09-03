#!/usr/bin/env fish

set -x DOTFILES "$(chezmoi source-path)/dotfiles"
set -x DOTFILES_DATA "$HOME/dotfiles"

echo "Boostrapping dotfiles!"

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

function install_package
	if [ (uname) != Darwin ]
		sudo apt-get install $argv[1] 
			or abort "failed to install $argv[1]"
	else
		brew install $argv[1]
    end
end

################################################################################
# Load Configuration
################################################################################
# Some configurable variables are stored in install_env to make it easier to
# change settings

source "$DOTFILES/install_env.fish"
	or abort "failed to load environment"

################################################################################
# Run installers
################################################################################

for installer in $DOTFILES/_scripts/install/*.fish
	set name "$(basename $(dirname $installer))/$(basename $installer)"
	info "running $name..."
	source $installer
		and success $name
		or abort $name
end

success 'dotfiles installed/updated!'
