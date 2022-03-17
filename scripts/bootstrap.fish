#!/usr/bin/env fish
set -l DIR (dirname (status --current-filename))
set -x DOTFILES "$HOME/dotfiles"

source "$DIR/install_env.fish"

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
# Link Dotfiles
################################################################################

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

for src in $DOTFILES/*/*.symlink
    link_file $src $HOME/.(basename $src .symlink) backup
        or abort 'failed to link config file'
end

# Symlink fisher plugin list into dotfiles
link_file $DOTFILES/fisher/plugins $__fish_config_dir/fish_plugins backup
	or abort plugins

# Hook into fish's startup sequence
link_file $DOTFILES/profile/fish.fish $HOME/.config/fish/conf.d/dotfile.fish backup
	or abort "fish config"

# link_file $DOTFILES/htop/htoprc $HOME/.config/htop/htoprc backup
# 	or abort htoprc
# link_file $DOTFILES/ssh/config.dotfiles $HOME/.ssh/config.dotfiles backup
# 	or abort ssh-config
# link_file $DOTFILES/ssh/rc $HOME/.ssh/rc backup
# 	or abort ssh-rc
# link_file $DOTFILES/kitty/kitty.conf $HOME/.config/kitty/kitty.conf backup
# 	or abort kitty
# link_file $DOTFILES/nvim/config $HOME/.config/nvim backup
# 	or abort nvim
# link_file $DOTFILES/yamllint/config $HOME/.config/yamllint/config backup
# 	or abort yamllint

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
