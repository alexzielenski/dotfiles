#!/usr/bin/env fish
brew install -q rbenv

brew upgrade ruby-build

# install a ruby version
rbenv install 2.7.5 -s
rbenv rehash

# Save initial ruby version number
rbenv global 2.7.5

# initialize ruby for use in other install scripts
rbenv init - fish | source
