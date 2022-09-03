#!/usr/bin/env fish

# The path to the global gitignore must be absolute so it cannot go in
# gitconfig as relative path. Write it into user's global gitconfig settings
git config --global core.excludesfile $DOTFILES/git/global.gitignore

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

	# Point user's ~/.gitconfig to include our dotfiles config
	git config --global include.path $DOTFILES/git/gitconfig
		or abort 'failed to setup git'
end

setup_gitconfig

if not type -q git-delta
	# Prettier git diff
	cargo install git-delta --locked
end
