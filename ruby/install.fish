#!/usr/bin/env fish
brew install -q rbenv

# install a ruby version
rbenv install 2.7.5 -s

# Save initial ruby version number
rbenv global 2.7.5

# initialize ruby for use in other install scripts
rbenv init - fish | source
