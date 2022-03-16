#!/usr/bin/env fish

git config --global core.excludesfile ~/dotfiles/global.gitignore

# Set up git username and email
function setup_gitconfig
	# if there is no user.email, we'll assume it's a new machine/setup and ask it
	if test -z (git config --global --get user.email)
		user 'What is your github author name?'
		read user_name
		user 'What is your github author email?'
		read user_email

		test -n $user_name
			or echo "please inform the git author name"
		test -n $user_email
			or abort "please inform the git author email"

		git config --global user.name $user_name
			and git config --global user.email $user_email
			or abort 'failed to setup git user name and email'
	end

	# include the gitconfig.local file
	# finally make git knows this is a managed config already, preventing later
	# overrides by this script
	git config --global include.path ~/dotfiles/git/gitconfig
		or abort 'failed to setup git'
end

setup_gitconfig

# Prettier git diff
brew install -q git-delta
