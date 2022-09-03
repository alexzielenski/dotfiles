#!/usr/bin/env fish

set -l DIR (realpath (dirname (status --current-filename)))
set -x DOTFILES (realpath (dirname $DIR))

echo "Boostrapping dotfiles!"
echo $DIR
echo $DOTFILES

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
		else if test -l $new and not string match "^$DOTFILES/" "$newf"
			# Don't backup symlinks which pointed into here
			rm $new
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

# used to remove link files which formerly were installed by this scipt
function cleanup_old_link
	set old $argv[1]
	set new $argv[2]
	set backup $argv[3]

	if test -f $old
		abort "cleanup_old_link called with a non-broken link. this is a bug"
	end

	if test -e $new
		# Not interested in cleaning up live links
		return
	end

	# remove the symlink if it points into where we think it points
	if test -L $new
		set newf "$(readlink "$new")"

		if test "$newf" = $old
			rm $new
				and success "removed old symlink $newf -> $old"
				or abort "could not remove old symlink $new"

			# restore backup if it exists
			if test -e $new.$backup
				mv $new.$backup $new
					and success "restored backup $new.$backup -> $new"
					or abort "could not move $new.$backup to $new"
			end
		end
	end
end

################################################################################
# Remove old artifacts
################################################################################
# Remove symlinks from older versions of the tool that might be left behind

info "Cleaning up artifacts from previous bootstrap invocations"

cleanup_old_link "$DOTFILES/iterm2/Visor.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Visor.json" backup
cleanup_old_link "$DOTFILES/iterm2/Default.json" "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Default.json" backup
cleanup_old_link "$DOTFILES/profile/zshrc.symlink" "$HOME/.zshrc" backup
cleanup_old_link "$DOTFILES/profile/zshenv.symlink" "$HOME/.zshenv" backup
cleanup_old_link "$DOTFILES/profile/zprofile.symlink" "$HOME/.zprofile" backup

success "cleaned up artifacts"

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
