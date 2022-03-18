#!/usr/bin/env fish
set -l DIR (dirname (status --current-filename))
set -x DOTFILES (realpath (dirname $DIR))

################################################################################
# Load Configuration
################################################################################
# Some configurable variables are stored in install_env to make it easier to
# change settings

source "$DIR/install_env.fish"

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

function link_file -d "links a file keeping a backup"
	set old $argv[1]
	set new $argv[2]
	set backup $argv[3]

	if test -e $new
		set newf (readlink $new)
		if test "$newf" = "$old"
			success "skipped $old"
			return
		else
			mv $new $new.$backup
				and success moved $new to $new.$backup
				or abort "failed to backup $new to $new.$backup"
		end
	end
	mkdir -p (dirname $new)
		and ln -sf $old $new
		and success "linked $old to $new"
		or abort "could not link $old to $new"
end

################################################################################
# Remove old artifacts
################################################################################
# Remove symlinks from older versions of the tool that might be left behind
# These should not be files that might have been backed up
# (if they were, those backup files need additional logic to restore backup)

set oldPaths \
	"$HOME/Library/Application Support/iTerm2/DynamicProfiles/Visor.json" \
	"$HOME/Library/Application Support/iTerm2/DynamicProfiles/Default.json"

for p in $oldPaths
	if test -L $p; or test -e $p
		rm $p
			or abort "failed to remove old file"
	end
end

################################################################################
# Install Completions?
################################################################################

mkdir -p ~/.config/fish/completions/
	and success 'completions'
	or abort 'completions'

################################################################################
# Run installers
################################################################################

for installer in $DIR/install/*.fish
	info $installer
	source $installer
		and success $installer
		or abort $installer
end

################################################################################
# Install .symlinks
################################################################################
# Done last to avoid any issues if script exits early

for src in $DOTFILES/*/*.symlink
    link_file $src "$HOME/.$(basename $src .symlink)" backup
        or abort 'failed to link config file'
end


################################################################################
# Add fish to list of shells and set as default
################################################################################

if test (which fish) = $SHELL
	success 'dotfiles installed/updated!'
	exit 0
end

if ! grep (command -v fish) /etc/shells
	command -v fish | sudo tee -a /etc/shells
		and success 'added fish to /etc/shells'
		or abort 'setup /etc/shells'
	echo
end

chsh -s (which fish)
	and success set (fish --version) as the default shell
	or abort 'set fish as default shell'

success 'dotfiles installed/updated!'
